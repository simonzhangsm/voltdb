/* This file is part of VoltDB.
 * Copyright (C) 2008-2013 VoltDB Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */
package org.voltcore.zk;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

import org.apache.zookeeper_voltpatches.CreateMode;
import org.apache.zookeeper_voltpatches.KeeperException.NoNodeException;
import org.apache.zookeeper_voltpatches.WatchedEvent;
import org.apache.zookeeper_voltpatches.Watcher;
import org.apache.zookeeper_voltpatches.Watcher.Event.EventType;
import org.apache.zookeeper_voltpatches.ZooDefs.Ids;
import org.apache.zookeeper_voltpatches.ZooKeeper;
import org.apache.zookeeper_voltpatches.data.Stat;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.voltcore.messaging.HostMessenger;

public class TestZK extends ZKTestBase {

    private final int NUM_AGREEMENT_SITES = 8;

    @Before
    public void setUp() throws Exception {
        setUpZK(NUM_AGREEMENT_SITES);
    }

    @After
    public void tearDown() throws Exception {
        tearDownZK();
    }

    public void failSite(int site) throws Exception {
        m_messengers.get(site).shutdown();
        m_messengers.set(site, null);
    }

    public void recoverSite(int site) throws Exception {
        HostMessenger.Config config = new HostMessenger.Config();
        int recoverPort = config.internalPort + NUM_AGREEMENT_SITES - 1;
        config.internalPort += site;
        int clientPort = m_ports.next();
        config.zkInterface = "127.0.0.1:" + clientPort;
        m_siteIdToZKPort.put(site, clientPort);
        config.networkThreads = 1;
        config.coordinatorIp = new InetSocketAddress( recoverPort );
        HostMessenger hm = new HostMessenger(config);
        hm.start();
        m_messengers.set(site, hm);
    }

    @Test
    public void testBasic() throws Exception {
        ZooKeeper zk = getClient(0);
        zk.create("/foo", new byte[1], Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);

        ZooKeeper zk2 = getClient(1);
        Stat stat = new Stat();
        assertEquals( 1, zk2.getData("/foo", false, stat).length);
        zk2.setData("/foo", new byte[4], stat.getVersion());

        assertEquals( 4, zk.getData("/foo", false, stat).length);
        zk.delete("/foo", -1);

        zk2.create("/bar", new byte[6], Ids.OPEN_ACL_UNSAFE, CreateMode.EPHEMERAL_SEQUENTIAL);
        zk.create("/bar", new byte[7], Ids.OPEN_ACL_UNSAFE, CreateMode.EPHEMERAL_SEQUENTIAL);

        ZooKeeper zk3 = getClient(2);
        List<String> children = zk3.getChildren("/", false);
        System.out.println(children);
        assertEquals(4, children.size());
        assertTrue(children.contains("zookeeper"));
        assertTrue(children.contains("bar0000000003"));
        assertTrue(children.contains("bar0000000004"));
        assertTrue(children.contains("core"));

        zk.close();
        zk2.close();
        m_clients.clear(); m_clients.add(zk3);

        children = zk3.getChildren("/", false);
        System.out.println(children);
        assertEquals(2, children.size());
        assertTrue(children.contains("zookeeper"));
        assertTrue(children.contains("core"));
    }

    @Test
    public void testFailure() throws Exception {
        ZooKeeper zk = getClient(1);
        zk.create("/foo", new byte[0], Ids.OPEN_ACL_UNSAFE, CreateMode.EPHEMERAL);
        assertEquals(zk.getData("/foo", false, null).length, 0);
        System.out.println("Created node");
        failSite(0);
        assertEquals(zk.getData("/foo", false, null).length, 0);
    }

    @Test
    public void testFailureKillsEphemeral() throws Exception {
        ZooKeeper zk = getClient(0);
        zk.create("/foo", new byte[0], Ids.OPEN_ACL_UNSAFE, CreateMode.EPHEMERAL);
        assertEquals(zk.getData("/foo", false, null).length, 0);
        failSite(0);
        zk = getClient(1);
        try {
            zk.getData("/foo", false, null);
        } catch (NoNodeException e) {
            return;
        }
        fail();
    }

    @Test
    public void testRecovery() throws Exception {
        ZooKeeper zk = getClient(0);
        zk.create("/foo", new byte[0], Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
        failSite(0);
        zk.close();
        for (int ii = 1; ii < NUM_AGREEMENT_SITES; ii++) {
            zk = getClient(ii);
            assertEquals(zk.getData("/foo", false, null).length, 0);
        }
        recoverSite(0);
        assertEquals(zk.getData("/foo", false, null).length, 0);
        zk = getClient(0);
        assertEquals(zk.getData("/foo", false, null).length, 0);
    }

    @Test
    public void testWatches() throws Exception {
        ZooKeeper zk = getClient(0);
        ZooKeeper zk2 = getClient(1);
        final Semaphore sem = new Semaphore(0);
        zk.exists("/foo", new Watcher() {
            @Override
            public void process(WatchedEvent event) {
                if (event.getType() == EventType.NodeCreated) {
                    sem.release();
                    System.out.println(event);
                }
            }
        });
        zk2.create("/foo", new byte[0], Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
        sem.tryAcquire(5, TimeUnit.SECONDS);

        zk.create("/foo2", new byte[0], Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);

        zk2.exists("/foo2", new Watcher() {
            @Override
            public void process(WatchedEvent event) {
                if (event.getType() == EventType.NodeDeleted) {
                    sem.release();
                    System.out.println(event);
                }
            }
        });

        zk.delete("/foo2", -1);
        sem.acquire();
    }

    @Test
    public void testNullVsZeroLengthData() throws Exception {
        ZooKeeper zk = getClient(0);
        zk.create("/foo", new byte[0], Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
        zk.create("/bar", null, Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
        assertEquals(null, zk.getData("/bar", false, null));
        assertTrue(zk.getData("/foo", false, null).length == 0);
    }

    @Test
    public void testSessionExpireAndRecovery() throws Exception {
        ZooKeeper zk = getClient(0);
        zk.create("/foo", null, Ids.OPEN_ACL_UNSAFE, CreateMode.EPHEMERAL);
        failSite(1);
        recoverSite(1);
        for (int ii = 2; ii < 8; ii++) {
            failSite(ii);
        }
        failSite(0);
        zk = getClient(1);
        assertNull(zk.exists("/foo", false));
    }

    @Test
    public void testSortSequentialNodes() {
        ArrayList<String> nodes = new ArrayList<String>();
        nodes.add("/a/b/node0000012345");
        nodes.add("/a/b/node0000000000");
        nodes.add("/a/b/node0000010234");
        nodes.add("/a/b/node0000000234");
        Collections.sort(nodes);

        Iterator<String> iter = nodes.iterator();
        assertEquals("/a/b/node0000000000", iter.next());
        assertEquals("/a/b/node0000000234", iter.next());
        assertEquals("/a/b/node0000010234", iter.next());
        assertEquals("/a/b/node0000012345", iter.next());
    }

    @Test
    public void testLeaderElection() throws Exception {
        ZooKeeper zk = getClient(0);
        ZooKeeper zk2 = getClient(1);
        ZooKeeper zk3 = getClient(2);

        zk.create("/election", new byte[0], Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);

        LeaderElector elector1 = new LeaderElector(zk, "/election", "node", null, null);
        LeaderElector elector2 = new LeaderElector(zk2, "/election", "node", null, null);
        LeaderElector elector3 = new LeaderElector(zk3, "/election", "node", null, null);
        elector1.start(true);
        elector2.start(true);
        elector3.start(true);

        assertTrue(elector1.isLeader());
        assertFalse(elector2.isLeader());
        assertFalse(elector3.isLeader());

        elector1.shutdown();
        elector2.shutdown();
        elector3.shutdown();

        zk.close();
        zk2.close();
        zk3.close();
    }

    @Test
    public void testLeaderFailover() throws Exception {
        ZooKeeper zk = getClient(0);
        ZooKeeper zk2 = getClient(1);
        ZooKeeper zk3 = getClient(2);

        zk.create("/election", new byte[0], Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);

        final Semaphore sem2 = new Semaphore(0);
        LeaderNoticeHandler r2 = new LeaderNoticeHandler() {
            @Override
            public void becomeLeader() {
                sem2.release();
            }

            @Override
            public void noticedTopologyChange(boolean added, boolean removed) {}
        };
        final Semaphore sem3 = new Semaphore(0);
        LeaderNoticeHandler r3 = new LeaderNoticeHandler() {
            @Override
            public void becomeLeader() {
                sem3.release();
            }

            @Override
            public void noticedTopologyChange(boolean added, boolean removed) {}
        };

        LeaderElector elector1 = new LeaderElector(zk, "/election", "node", new byte[0], null);
        LeaderElector elector2 = new LeaderElector(zk2, "/election", "node", new byte[0], r2);
        LeaderElector elector3 = new LeaderElector(zk3, "/election", "node", new byte[0], r3);
        elector1.start(true);
        elector2.start(true);
        elector3.start(true);

        assertTrue(elector1.isLeader());
        assertFalse(elector2.isLeader());
        assertFalse(elector3.isLeader());

        // 2 should become the leader
        elector1.shutdown();
        assertTrue(sem2.tryAcquire(5, TimeUnit.SECONDS));
        assertTrue(elector2.isLeader());
        assertEquals(0, sem3.availablePermits());

        // 3 should become the leader now
        elector2.shutdown();
        assertTrue(sem3.tryAcquire(5, TimeUnit.SECONDS));
        assertTrue(elector3.isLeader());

        elector3.shutdown();
    }

    @Test
    public void testLeaderFailoverHarder() throws Exception {
        // as above but put multiple failed nodes between the new and previous?
        ZooKeeper zk = getClient(0);
        ZooKeeper zk2 = getClient(1);
        ZooKeeper zk3 = getClient(2);
        ZooKeeper zk4 = getClient(3);

        zk.create("/election", new byte[0], Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);

        final Semaphore sem2 = new Semaphore(0);
        LeaderNoticeHandler r2 = new LeaderNoticeHandler() {
            @Override
            public void becomeLeader() {
                sem2.release();
            }

            @Override
            public void noticedTopologyChange(boolean added, boolean removed) {}
        };
        final Semaphore sem3 = new Semaphore(0);
        LeaderNoticeHandler r3 = new LeaderNoticeHandler() {
            @Override
            public void becomeLeader() {
                sem3.release();
            }

            @Override
            public void noticedTopologyChange(boolean added, boolean removed) {}
        };
        final Semaphore sem4 = new Semaphore(0);
        LeaderNoticeHandler r4 = new LeaderNoticeHandler() {
            @Override
            public void becomeLeader() {
                sem4.release();
            }

            @Override
            public void noticedTopologyChange(boolean added, boolean removed) {}
        };

        LeaderElector elector1 = new LeaderElector(zk, "/election", "node", new byte[0], null);
        LeaderElector elector2 = new LeaderElector(zk2, "/election", "node", new byte[0], r2);
        LeaderElector elector3 = new LeaderElector(zk3, "/election", "node", new byte[0], r3);
        LeaderElector elector4 = new LeaderElector(zk4, "/election", "node", new byte[0], r4);
        elector1.start(true);
        elector2.start(true);
        elector3.start(true);
        elector4.start(true);

        assertTrue(elector1.isLeader());
        assertFalse(elector2.isLeader());
        assertFalse(elector3.isLeader());
        assertFalse(elector4.isLeader());

        // 4 should become the leader
        elector3.shutdown();
        elector2.shutdown();
        elector1.shutdown();


        assertTrue(sem4.tryAcquire(5, TimeUnit.SECONDS));
        assertTrue(elector4.isLeader());

        // cleanup.
        elector4.shutdown();
    }

    @Test
    public void testLeaderFailoverHoles() throws Exception {
        // as above but put multiple failed nodes between the new and previous?
        ZooKeeper zk0 = getClient(0);
        ZooKeeper zk1 = getClient(1);
        ZooKeeper zk2 = getClient(2);
        ZooKeeper zk3 = getClient(3);
        ZooKeeper zk4 = getClient(4);
        ZooKeeper zk5 = getClient(5);
        ZooKeeper zk6 = getClient(6);
        ZooKeeper zk7 = getClient(7);

        zk0.create("/election", new byte[0], Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);

        final Semaphore sem1 = new Semaphore(0);
        LeaderNoticeHandler r1 = new LeaderNoticeHandler() {
            @Override
            public void becomeLeader() {
                sem1.release();
            }

            @Override
            public void noticedTopologyChange(boolean added, boolean removed) {
            }
        };
        final Semaphore sem7 = new Semaphore(0);
        LeaderNoticeHandler r7 = new LeaderNoticeHandler() {
            @Override
            public void becomeLeader() {
                sem7.release();
            }

            @Override
            public void noticedTopologyChange(boolean added, boolean removed) {
            }
        };

        LeaderElector elector0 = new LeaderElector(zk0, "/election", "node", new byte[0], null);
        LeaderElector elector1 = new LeaderElector(zk1, "/election", "node", new byte[0], r1);
        LeaderElector elector2 = new LeaderElector(zk2, "/election", "node", new byte[0], null);
        LeaderElector elector3 = new LeaderElector(zk3, "/election", "node", new byte[0], null);
        LeaderElector elector4 = new LeaderElector(zk4, "/election", "node", new byte[0], null);
        LeaderElector elector5 = new LeaderElector(zk5, "/election", "node", new byte[0], null);
        LeaderElector elector6 = new LeaderElector(zk6, "/election", "node", new byte[0], null);
        LeaderElector elector7 = new LeaderElector(zk7, "/election", "node", new byte[0], r7);

        elector0.start(true);
        elector1.start(true);
        elector2.start(true);
        elector3.start(true);
        elector4.start(true);
        elector5.start(true);
        elector6.start(true);
        elector7.start(true);

        assertTrue(elector0.isLeader());
        assertFalse(elector1.isLeader());
        assertFalse(elector2.isLeader());
        assertFalse(elector3.isLeader());
        assertFalse(elector4.isLeader());
        assertFalse(elector5.isLeader());
        assertFalse(elector6.isLeader());
        assertFalse(elector7.isLeader());

        // 4 should become the leader
        elector6.shutdown();
        elector4.shutdown();
        elector2.shutdown();
        elector0.shutdown();

        assertTrue(sem1.tryAcquire(5, TimeUnit.SECONDS));
        assertTrue(elector1.isLeader());
        assertFalse(elector3.isLeader());
        assertFalse(elector5.isLeader());
        assertFalse(elector7.isLeader());

        elector5.shutdown();
        elector3.shutdown();
        elector1.shutdown();
        assertTrue(sem7.tryAcquire(5, TimeUnit.SECONDS));
        assertTrue(elector7.isLeader());

        // cleanup.
        elector7.shutdown();
    }


    @Test
    public void testNonLeaderFailure() throws Exception {
        ZooKeeper zk = getClient(0);
        ZooKeeper zk2 = getClient(1);
        ZooKeeper zk3 = getClient(2);

        zk.create("/election", new byte[0], Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);

        final Semaphore sem3 = new Semaphore(0);
        LeaderNoticeHandler r3 = new LeaderNoticeHandler() {
            @Override
            public void becomeLeader() {
                sem3.release();
            }

            @Override
            public void noticedTopologyChange(boolean added, boolean removed) {}
        };

        LeaderElector elector1 = new LeaderElector(zk, "/election", "node", new byte[0], null);
        LeaderElector elector2 = new LeaderElector(zk2, "/election", "node", new byte[0], null);
        LeaderElector elector3 = new LeaderElector(zk3, "/election", "node", new byte[0], r3);
        elector1.start(true);
        elector2.start(true);
        elector3.start(true);

        assertTrue(elector1.isLeader());
        assertFalse(elector2.isLeader());
        assertFalse(elector3.isLeader());

        // 1 is still the leader
        elector2.shutdown();
        assertTrue(elector1.isLeader());
        assertFalse(elector3.isLeader());

        // 3 should become the leader now
        elector1.shutdown();
        assertTrue(sem3.tryAcquire(5, TimeUnit.SECONDS));
        assertTrue(elector3.isLeader());
        assertEquals(0, sem3.availablePermits());

        elector3.shutdown();
    }

    @Test
    public void testMassiveNode() throws Exception {
        ZooKeeper zk = getClient(0);
//        byte bytes[] = new byte[50331648];
        byte bytes[] = new byte[40000000];
        zk.create("/bar", null, Ids.OPEN_ACL_UNSAFE, CreateMode.EPHEMERAL);
        zk.create("/foo", bytes, Ids.OPEN_ACL_UNSAFE, CreateMode.EPHEMERAL);
        zk.getData("/foo", false, null);
    }

    @Test
    public void testRecursivelyDelete() throws Exception
    {
        ZooKeeper zk = getClient(0);
        zk.create("/a", null, Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
        zk.create("/a/b", null, Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
        zk.create("/a/b/c", null, Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);

        ZKUtil.deleteRecursively(zk, "/a");
        assertNull(zk.exists("/a", false));
    }
}
