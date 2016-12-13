file -inlinebatch END_OF_DROP_BATCH

DROP PROCEDURE Initialize                      IF EXISTS;
DROP PROCEDURE Results                         IF EXISTS;
DROP PROCEDURE Vote                            IF EXISTS;
DROP PROCEDURE ContestantWinningStates         IF EXISTS;
DROP PROCEDURE GetStateHeatmap                 IF EXISTS;
DROP VIEW  v_votes_by_phone_number             IF EXISTS;
DROP VIEW  v_votes_by_contestant_number        IF EXISTS;
DROP VIEW  v_votes_by_contestant_number_state  IF EXISTS;
DROP TABLE contestants                         IF EXISTS;
DROP TABLE votes                               IF EXISTS;
DROP TABLE area_code_state                     IF EXISTS;

END_OF_DROP_BATCH

-- Tell sqlcmd to batch the following commands together,
-- so that the schema loads quickly.
file -inlinebatch END_OF_BATCH

-- contestants table holds the contestants numbers (for voting) and names
CREATE TABLE contestants
(
  contestant_number integer     NOT NULL
, contestant_name   varchar(50) NOT NULL
, CONSTRAINT PK_contestants PRIMARY KEY
  (
    contestant_number
  )
);

-- votes table holds every valid vote.
--   voters are not allowed to submit more than <x> votes, x is passed to client application
CREATE TABLE votes
(
  phone_number       bigint     NOT NULL
, state              varchar(2) NOT NULL
, contestant_number  integer    NOT NULL
);

PARTITION TABLE votes ON COLUMN phone_number;

-- Map of Area Codes and States for geolocation classification of incoming calls
CREATE TABLE area_code_state
(
  area_code smallint   NOT NULL
, state     varchar(2) NOT NULL
, CONSTRAINT PK_area_code_state PRIMARY KEY
  (
    area_code
  )
);

-- rollup of votes by phone number, used to reject excessive voting
CREATE VIEW v_votes_by_phone_number
(
  phone_number
, num_votes
)
AS
   SELECT phone_number
        , COUNT(*)
     FROM votes
 GROUP BY phone_number
;

-- rollup of votes by contestant and state for the heat map and results
CREATE VIEW v_votes_by_contestant_number_state
(
  contestant_number
, state
, num_votes
)
AS
   SELECT contestant_number
        , state
        , COUNT(*)
     FROM votes
 GROUP BY contestant_number
        , state
;


create table t0 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t0_idx1 on t0(a,c); create index t0_idx2 on t0(a,d);
create table t1 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t1_idx1 on t1(a,c); create index t1_idx2 on t1(a,d);
create table t2 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t2_idx1 on t2(a,c); create index t2_idx2 on t2(a,d);
create table t3 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t3_idx1 on t3(a,c); create index t3_idx2 on t3(a,d);
create table t4 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t4_idx1 on t4(a,c); create index t4_idx2 on t4(a,d);
create table t5 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t5_idx1 on t5(a,c); create index t5_idx2 on t5(a,d);
create table t6 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t6_idx1 on t6(a,c); create index t6_idx2 on t6(a,d);
create table t7 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t7_idx1 on t7(a,c); create index t7_idx2 on t7(a,d);
create table t8 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t8_idx1 on t8(a,c); create index t8_idx2 on t8(a,d);
create table t9 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t9_idx1 on t9(a,c); create index t9_idx2 on t9(a,d);
create table t10 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t10_idx1 on t10(a,c); create index t10_idx2 on t10(a,d);
create table t11 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t11_idx1 on t11(a,c); create index t11_idx2 on t11(a,d);
create table t12 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t12_idx1 on t12(a,c); create index t12_idx2 on t12(a,d);
create table t13 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t13_idx1 on t13(a,c); create index t13_idx2 on t13(a,d);
create table t14 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t14_idx1 on t14(a,c); create index t14_idx2 on t14(a,d);
create table t15 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t15_idx1 on t15(a,c); create index t15_idx2 on t15(a,d);
create table t16 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t16_idx1 on t16(a,c); create index t16_idx2 on t16(a,d);
create table t17 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t17_idx1 on t17(a,c); create index t17_idx2 on t17(a,d);
create table t18 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t18_idx1 on t18(a,c); create index t18_idx2 on t18(a,d);
create table t19 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t19_idx1 on t19(a,c); create index t19_idx2 on t19(a,d);
create table t20 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t20_idx1 on t20(a,c); create index t20_idx2 on t20(a,d);
create table t21 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t21_idx1 on t21(a,c); create index t21_idx2 on t21(a,d);
create table t22 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t22_idx1 on t22(a,c); create index t22_idx2 on t22(a,d);
create table t23 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t23_idx1 on t23(a,c); create index t23_idx2 on t23(a,d);
create table t24 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t24_idx1 on t24(a,c); create index t24_idx2 on t24(a,d);
create table t25 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t25_idx1 on t25(a,c); create index t25_idx2 on t25(a,d);
create table t26 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t26_idx1 on t26(a,c); create index t26_idx2 on t26(a,d);
create table t27 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t27_idx1 on t27(a,c); create index t27_idx2 on t27(a,d);
create table t28 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t28_idx1 on t28(a,c); create index t28_idx2 on t28(a,d);
create table t29 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t29_idx1 on t29(a,c); create index t29_idx2 on t29(a,d);
create table t30 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t30_idx1 on t30(a,c); create index t30_idx2 on t30(a,d);
create table t31 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t31_idx1 on t31(a,c); create index t31_idx2 on t31(a,d);
create table t32 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t32_idx1 on t32(a,c); create index t32_idx2 on t32(a,d);
create table t33 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t33_idx1 on t33(a,c); create index t33_idx2 on t33(a,d);
create table t34 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t34_idx1 on t34(a,c); create index t34_idx2 on t34(a,d);
create table t35 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t35_idx1 on t35(a,c); create index t35_idx2 on t35(a,d);
create table t36 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t36_idx1 on t36(a,c); create index t36_idx2 on t36(a,d);
create table t37 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t37_idx1 on t37(a,c); create index t37_idx2 on t37(a,d);
create table t38 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t38_idx1 on t38(a,c); create index t38_idx2 on t38(a,d);
create table t39 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t39_idx1 on t39(a,c); create index t39_idx2 on t39(a,d);
create table t40 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t40_idx1 on t40(a,c); create index t40_idx2 on t40(a,d);
create table t41 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t41_idx1 on t41(a,c); create index t41_idx2 on t41(a,d);
create table t42 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t42_idx1 on t42(a,c); create index t42_idx2 on t42(a,d);
create table t43 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t43_idx1 on t43(a,c); create index t43_idx2 on t43(a,d);
create table t44 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t44_idx1 on t44(a,c); create index t44_idx2 on t44(a,d);
create table t45 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t45_idx1 on t45(a,c); create index t45_idx2 on t45(a,d);
create table t46 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t46_idx1 on t46(a,c); create index t46_idx2 on t46(a,d);
create table t47 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t47_idx1 on t47(a,c); create index t47_idx2 on t47(a,d);
create table t48 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t48_idx1 on t48(a,c); create index t48_idx2 on t48(a,d);
create table t49 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t49_idx1 on t49(a,c); create index t49_idx2 on t49(a,d);
create table t50 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t50_idx1 on t50(a,c); create index t50_idx2 on t50(a,d);
create table t51 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t51_idx1 on t51(a,c); create index t51_idx2 on t51(a,d);
create table t52 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t52_idx1 on t52(a,c); create index t52_idx2 on t52(a,d);
create table t53 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t53_idx1 on t53(a,c); create index t53_idx2 on t53(a,d);
create table t54 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t54_idx1 on t54(a,c); create index t54_idx2 on t54(a,d);
create table t55 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t55_idx1 on t55(a,c); create index t55_idx2 on t55(a,d);
create table t56 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t56_idx1 on t56(a,c); create index t56_idx2 on t56(a,d);
create table t57 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t57_idx1 on t57(a,c); create index t57_idx2 on t57(a,d);
create table t58 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t58_idx1 on t58(a,c); create index t58_idx2 on t58(a,d);
create table t59 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t59_idx1 on t59(a,c); create index t59_idx2 on t59(a,d);
create table t60 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t60_idx1 on t60(a,c); create index t60_idx2 on t60(a,d);
create table t61 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t61_idx1 on t61(a,c); create index t61_idx2 on t61(a,d);
create table t62 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t62_idx1 on t62(a,c); create index t62_idx2 on t62(a,d);
create table t63 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t63_idx1 on t63(a,c); create index t63_idx2 on t63(a,d);
create table t64 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t64_idx1 on t64(a,c); create index t64_idx2 on t64(a,d);
create table t65 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t65_idx1 on t65(a,c); create index t65_idx2 on t65(a,d);
create table t66 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t66_idx1 on t66(a,c); create index t66_idx2 on t66(a,d);
create table t67 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t67_idx1 on t67(a,c); create index t67_idx2 on t67(a,d);
create table t68 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t68_idx1 on t68(a,c); create index t68_idx2 on t68(a,d);
create table t69 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t69_idx1 on t69(a,c); create index t69_idx2 on t69(a,d);
create table t70 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t70_idx1 on t70(a,c); create index t70_idx2 on t70(a,d);
create table t71 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t71_idx1 on t71(a,c); create index t71_idx2 on t71(a,d);
create table t72 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t72_idx1 on t72(a,c); create index t72_idx2 on t72(a,d);
create table t73 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t73_idx1 on t73(a,c); create index t73_idx2 on t73(a,d);
create table t74 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t74_idx1 on t74(a,c); create index t74_idx2 on t74(a,d);
create table t75 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t75_idx1 on t75(a,c); create index t75_idx2 on t75(a,d);
create table t76 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t76_idx1 on t76(a,c); create index t76_idx2 on t76(a,d);
create table t77 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t77_idx1 on t77(a,c); create index t77_idx2 on t77(a,d);
create table t78 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t78_idx1 on t78(a,c); create index t78_idx2 on t78(a,d);
create table t79 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t79_idx1 on t79(a,c); create index t79_idx2 on t79(a,d);
create table t80 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t80_idx1 on t80(a,c); create index t80_idx2 on t80(a,d);
create table t81 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t81_idx1 on t81(a,c); create index t81_idx2 on t81(a,d);
create table t82 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t82_idx1 on t82(a,c); create index t82_idx2 on t82(a,d);
create table t83 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t83_idx1 on t83(a,c); create index t83_idx2 on t83(a,d);
create table t84 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t84_idx1 on t84(a,c); create index t84_idx2 on t84(a,d);
create table t85 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t85_idx1 on t85(a,c); create index t85_idx2 on t85(a,d);
create table t86 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t86_idx1 on t86(a,c); create index t86_idx2 on t86(a,d);
create table t87 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t87_idx1 on t87(a,c); create index t87_idx2 on t87(a,d);
create table t88 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t88_idx1 on t88(a,c); create index t88_idx2 on t88(a,d);
create table t89 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t89_idx1 on t89(a,c); create index t89_idx2 on t89(a,d);
create table t90 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t90_idx1 on t90(a,c); create index t90_idx2 on t90(a,d);
create table t91 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t91_idx1 on t91(a,c); create index t91_idx2 on t91(a,d);
create table t92 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t92_idx1 on t92(a,c); create index t92_idx2 on t92(a,d);
create table t93 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t93_idx1 on t93(a,c); create index t93_idx2 on t93(a,d);
create table t94 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t94_idx1 on t94(a,c); create index t94_idx2 on t94(a,d);
create table t95 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t95_idx1 on t95(a,c); create index t95_idx2 on t95(a,d);
create table t96 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t96_idx1 on t96(a,c); create index t96_idx2 on t96(a,d);
create table t97 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t97_idx1 on t97(a,c); create index t97_idx2 on t97(a,d);
create table t98 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t98_idx1 on t98(a,c); create index t98_idx2 on t98(a,d);
create table t99 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t99_idx1 on t99(a,c); create index t99_idx2 on t99(a,d);
create table t100 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t100_idx1 on t100(a,c); create index t100_idx2 on t100(a,d);
create table t101 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t101_idx1 on t101(a,c); create index t101_idx2 on t101(a,d);
create table t102 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t102_idx1 on t102(a,c); create index t102_idx2 on t102(a,d);
create table t103 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t103_idx1 on t103(a,c); create index t103_idx2 on t103(a,d);
create table t104 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t104_idx1 on t104(a,c); create index t104_idx2 on t104(a,d);
create table t105 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t105_idx1 on t105(a,c); create index t105_idx2 on t105(a,d);
create table t106 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t106_idx1 on t106(a,c); create index t106_idx2 on t106(a,d);
create table t107 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t107_idx1 on t107(a,c); create index t107_idx2 on t107(a,d);
create table t108 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t108_idx1 on t108(a,c); create index t108_idx2 on t108(a,d);
create table t109 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t109_idx1 on t109(a,c); create index t109_idx2 on t109(a,d);
create table t110 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t110_idx1 on t110(a,c); create index t110_idx2 on t110(a,d);
create table t111 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t111_idx1 on t111(a,c); create index t111_idx2 on t111(a,d);
create table t112 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t112_idx1 on t112(a,c); create index t112_idx2 on t112(a,d);
create table t113 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t113_idx1 on t113(a,c); create index t113_idx2 on t113(a,d);
create table t114 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t114_idx1 on t114(a,c); create index t114_idx2 on t114(a,d);
create table t115 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t115_idx1 on t115(a,c); create index t115_idx2 on t115(a,d);
create table t116 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t116_idx1 on t116(a,c); create index t116_idx2 on t116(a,d);
create table t117 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t117_idx1 on t117(a,c); create index t117_idx2 on t117(a,d);
create table t118 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t118_idx1 on t118(a,c); create index t118_idx2 on t118(a,d);
create table t119 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t119_idx1 on t119(a,c); create index t119_idx2 on t119(a,d);
create table t120 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t120_idx1 on t120(a,c); create index t120_idx2 on t120(a,d);
create table t121 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t121_idx1 on t121(a,c); create index t121_idx2 on t121(a,d);
create table t122 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t122_idx1 on t122(a,c); create index t122_idx2 on t122(a,d);
create table t123 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t123_idx1 on t123(a,c); create index t123_idx2 on t123(a,d);
create table t124 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t124_idx1 on t124(a,c); create index t124_idx2 on t124(a,d);
create table t125 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t125_idx1 on t125(a,c); create index t125_idx2 on t125(a,d);
create table t126 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t126_idx1 on t126(a,c); create index t126_idx2 on t126(a,d);
create table t127 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t127_idx1 on t127(a,c); create index t127_idx2 on t127(a,d);
create table t128 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t128_idx1 on t128(a,c); create index t128_idx2 on t128(a,d);
create table t129 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t129_idx1 on t129(a,c); create index t129_idx2 on t129(a,d);
create table t130 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t130_idx1 on t130(a,c); create index t130_idx2 on t130(a,d);
create table t131 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t131_idx1 on t131(a,c); create index t131_idx2 on t131(a,d);
create table t132 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t132_idx1 on t132(a,c); create index t132_idx2 on t132(a,d);
create table t133 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t133_idx1 on t133(a,c); create index t133_idx2 on t133(a,d);
create table t134 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t134_idx1 on t134(a,c); create index t134_idx2 on t134(a,d);
create table t135 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t135_idx1 on t135(a,c); create index t135_idx2 on t135(a,d);
create table t136 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t136_idx1 on t136(a,c); create index t136_idx2 on t136(a,d);
create table t137 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t137_idx1 on t137(a,c); create index t137_idx2 on t137(a,d);
create table t138 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t138_idx1 on t138(a,c); create index t138_idx2 on t138(a,d);
create table t139 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t139_idx1 on t139(a,c); create index t139_idx2 on t139(a,d);
create table t140 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t140_idx1 on t140(a,c); create index t140_idx2 on t140(a,d);
create table t141 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t141_idx1 on t141(a,c); create index t141_idx2 on t141(a,d);
create table t142 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t142_idx1 on t142(a,c); create index t142_idx2 on t142(a,d);
create table t143 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t143_idx1 on t143(a,c); create index t143_idx2 on t143(a,d);
create table t144 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t144_idx1 on t144(a,c); create index t144_idx2 on t144(a,d);
create table t145 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t145_idx1 on t145(a,c); create index t145_idx2 on t145(a,d);
create table t146 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t146_idx1 on t146(a,c); create index t146_idx2 on t146(a,d);
create table t147 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t147_idx1 on t147(a,c); create index t147_idx2 on t147(a,d);
create table t148 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t148_idx1 on t148(a,c); create index t148_idx2 on t148(a,d);
create table t149 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t149_idx1 on t149(a,c); create index t149_idx2 on t149(a,d);
create table t150 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t150_idx1 on t150(a,c); create index t150_idx2 on t150(a,d);
create table t151 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t151_idx1 on t151(a,c); create index t151_idx2 on t151(a,d);
create table t152 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t152_idx1 on t152(a,c); create index t152_idx2 on t152(a,d);
create table t153 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t153_idx1 on t153(a,c); create index t153_idx2 on t153(a,d);
create table t154 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t154_idx1 on t154(a,c); create index t154_idx2 on t154(a,d);
create table t155 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t155_idx1 on t155(a,c); create index t155_idx2 on t155(a,d);
create table t156 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t156_idx1 on t156(a,c); create index t156_idx2 on t156(a,d);
create table t157 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t157_idx1 on t157(a,c); create index t157_idx2 on t157(a,d);
create table t158 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t158_idx1 on t158(a,c); create index t158_idx2 on t158(a,d);
create table t159 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t159_idx1 on t159(a,c); create index t159_idx2 on t159(a,d);
create table t160 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t160_idx1 on t160(a,c); create index t160_idx2 on t160(a,d);
create table t161 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t161_idx1 on t161(a,c); create index t161_idx2 on t161(a,d);
create table t162 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t162_idx1 on t162(a,c); create index t162_idx2 on t162(a,d);
create table t163 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t163_idx1 on t163(a,c); create index t163_idx2 on t163(a,d);
create table t164 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t164_idx1 on t164(a,c); create index t164_idx2 on t164(a,d);
create table t165 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t165_idx1 on t165(a,c); create index t165_idx2 on t165(a,d);
create table t166 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t166_idx1 on t166(a,c); create index t166_idx2 on t166(a,d);
create table t167 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t167_idx1 on t167(a,c); create index t167_idx2 on t167(a,d);
create table t168 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t168_idx1 on t168(a,c); create index t168_idx2 on t168(a,d);
create table t169 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t169_idx1 on t169(a,c); create index t169_idx2 on t169(a,d);
create table t170 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t170_idx1 on t170(a,c); create index t170_idx2 on t170(a,d);
create table t171 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t171_idx1 on t171(a,c); create index t171_idx2 on t171(a,d);
create table t172 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t172_idx1 on t172(a,c); create index t172_idx2 on t172(a,d);
create table t173 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t173_idx1 on t173(a,c); create index t173_idx2 on t173(a,d);
create table t174 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t174_idx1 on t174(a,c); create index t174_idx2 on t174(a,d);
create table t175 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t175_idx1 on t175(a,c); create index t175_idx2 on t175(a,d);
create table t176 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t176_idx1 on t176(a,c); create index t176_idx2 on t176(a,d);
create table t177 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t177_idx1 on t177(a,c); create index t177_idx2 on t177(a,d);
create table t178 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t178_idx1 on t178(a,c); create index t178_idx2 on t178(a,d);
create table t179 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t179_idx1 on t179(a,c); create index t179_idx2 on t179(a,d);
create table t180 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t180_idx1 on t180(a,c); create index t180_idx2 on t180(a,d);
create table t181 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t181_idx1 on t181(a,c); create index t181_idx2 on t181(a,d);
create table t182 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t182_idx1 on t182(a,c); create index t182_idx2 on t182(a,d);
create table t183 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t183_idx1 on t183(a,c); create index t183_idx2 on t183(a,d);
create table t184 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t184_idx1 on t184(a,c); create index t184_idx2 on t184(a,d);
create table t185 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t185_idx1 on t185(a,c); create index t185_idx2 on t185(a,d);
create table t186 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t186_idx1 on t186(a,c); create index t186_idx2 on t186(a,d);
create table t187 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t187_idx1 on t187(a,c); create index t187_idx2 on t187(a,d);
create table t188 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t188_idx1 on t188(a,c); create index t188_idx2 on t188(a,d);
create table t189 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t189_idx1 on t189(a,c); create index t189_idx2 on t189(a,d);
create table t190 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t190_idx1 on t190(a,c); create index t190_idx2 on t190(a,d);
create table t191 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t191_idx1 on t191(a,c); create index t191_idx2 on t191(a,d);
create table t192 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t192_idx1 on t192(a,c); create index t192_idx2 on t192(a,d);
create table t193 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t193_idx1 on t193(a,c); create index t193_idx2 on t193(a,d);
create table t194 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t194_idx1 on t194(a,c); create index t194_idx2 on t194(a,d);
create table t195 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t195_idx1 on t195(a,c); create index t195_idx2 on t195(a,d);
create table t196 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t196_idx1 on t196(a,c); create index t196_idx2 on t196(a,d);
create table t197 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t197_idx1 on t197(a,c); create index t197_idx2 on t197(a,d);
create table t198 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t198_idx1 on t198(a,c); create index t198_idx2 on t198(a,d);
create table t199 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t199_idx1 on t199(a,c); create index t199_idx2 on t199(a,d);
create table t200 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t200_idx1 on t200(a,c); create index t200_idx2 on t200(a,d);
create table t201 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t201_idx1 on t201(a,c); create index t201_idx2 on t201(a,d);
create table t202 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t202_idx1 on t202(a,c); create index t202_idx2 on t202(a,d);
create table t203 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t203_idx1 on t203(a,c); create index t203_idx2 on t203(a,d);
create table t204 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t204_idx1 on t204(a,c); create index t204_idx2 on t204(a,d);
create table t205 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t205_idx1 on t205(a,c); create index t205_idx2 on t205(a,d);
create table t206 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t206_idx1 on t206(a,c); create index t206_idx2 on t206(a,d);
create table t207 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t207_idx1 on t207(a,c); create index t207_idx2 on t207(a,d);
create table t208 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t208_idx1 on t208(a,c); create index t208_idx2 on t208(a,d);
create table t209 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t209_idx1 on t209(a,c); create index t209_idx2 on t209(a,d);
create table t210 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t210_idx1 on t210(a,c); create index t210_idx2 on t210(a,d);
create table t211 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t211_idx1 on t211(a,c); create index t211_idx2 on t211(a,d);
create table t212 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t212_idx1 on t212(a,c); create index t212_idx2 on t212(a,d);
create table t213 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t213_idx1 on t213(a,c); create index t213_idx2 on t213(a,d);
create table t214 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t214_idx1 on t214(a,c); create index t214_idx2 on t214(a,d);
create table t215 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t215_idx1 on t215(a,c); create index t215_idx2 on t215(a,d);
create table t216 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t216_idx1 on t216(a,c); create index t216_idx2 on t216(a,d);
create table t217 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t217_idx1 on t217(a,c); create index t217_idx2 on t217(a,d);
create table t218 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t218_idx1 on t218(a,c); create index t218_idx2 on t218(a,d);
create table t219 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t219_idx1 on t219(a,c); create index t219_idx2 on t219(a,d);
create table t220 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t220_idx1 on t220(a,c); create index t220_idx2 on t220(a,d);
create table t221 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t221_idx1 on t221(a,c); create index t221_idx2 on t221(a,d);
create table t222 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t222_idx1 on t222(a,c); create index t222_idx2 on t222(a,d);
create table t223 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t223_idx1 on t223(a,c); create index t223_idx2 on t223(a,d);
create table t224 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t224_idx1 on t224(a,c); create index t224_idx2 on t224(a,d);
create table t225 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t225_idx1 on t225(a,c); create index t225_idx2 on t225(a,d);
create table t226 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t226_idx1 on t226(a,c); create index t226_idx2 on t226(a,d);
create table t227 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t227_idx1 on t227(a,c); create index t227_idx2 on t227(a,d);
create table t228 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t228_idx1 on t228(a,c); create index t228_idx2 on t228(a,d);
create table t229 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t229_idx1 on t229(a,c); create index t229_idx2 on t229(a,d);
create table t230 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t230_idx1 on t230(a,c); create index t230_idx2 on t230(a,d);
create table t231 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t231_idx1 on t231(a,c); create index t231_idx2 on t231(a,d);
create table t232 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t232_idx1 on t232(a,c); create index t232_idx2 on t232(a,d);
create table t233 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t233_idx1 on t233(a,c); create index t233_idx2 on t233(a,d);
create table t234 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t234_idx1 on t234(a,c); create index t234_idx2 on t234(a,d);
create table t235 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t235_idx1 on t235(a,c); create index t235_idx2 on t235(a,d);
create table t236 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t236_idx1 on t236(a,c); create index t236_idx2 on t236(a,d);
create table t237 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t237_idx1 on t237(a,c); create index t237_idx2 on t237(a,d);
create table t238 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t238_idx1 on t238(a,c); create index t238_idx2 on t238(a,d);
create table t239 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t239_idx1 on t239(a,c); create index t239_idx2 on t239(a,d);
create table t240 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t240_idx1 on t240(a,c); create index t240_idx2 on t240(a,d);
create table t241 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t241_idx1 on t241(a,c); create index t241_idx2 on t241(a,d);
create table t242 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t242_idx1 on t242(a,c); create index t242_idx2 on t242(a,d);
create table t243 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t243_idx1 on t243(a,c); create index t243_idx2 on t243(a,d);
create table t244 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t244_idx1 on t244(a,c); create index t244_idx2 on t244(a,d);
create table t245 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t245_idx1 on t245(a,c); create index t245_idx2 on t245(a,d);
create table t246 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t246_idx1 on t246(a,c); create index t246_idx2 on t246(a,d);
create table t247 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t247_idx1 on t247(a,c); create index t247_idx2 on t247(a,d);
create table t248 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t248_idx1 on t248(a,c); create index t248_idx2 on t248(a,d);
create table t249 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t249_idx1 on t249(a,c); create index t249_idx2 on t249(a,d);
create table t250 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t250_idx1 on t250(a,c); create index t250_idx2 on t250(a,d);
create table t251 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t251_idx1 on t251(a,c); create index t251_idx2 on t251(a,d);
create table t252 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t252_idx1 on t252(a,c); create index t252_idx2 on t252(a,d);
create table t253 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t253_idx1 on t253(a,c); create index t253_idx2 on t253(a,d);
create table t254 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t254_idx1 on t254(a,c); create index t254_idx2 on t254(a,d);
create table t255 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t255_idx1 on t255(a,c); create index t255_idx2 on t255(a,d);
create table t256 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t256_idx1 on t256(a,c); create index t256_idx2 on t256(a,d);
create table t257 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t257_idx1 on t257(a,c); create index t257_idx2 on t257(a,d);
create table t258 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t258_idx1 on t258(a,c); create index t258_idx2 on t258(a,d);
create table t259 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t259_idx1 on t259(a,c); create index t259_idx2 on t259(a,d);
create table t260 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t260_idx1 on t260(a,c); create index t260_idx2 on t260(a,d);
create table t261 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t261_idx1 on t261(a,c); create index t261_idx2 on t261(a,d);
create table t262 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t262_idx1 on t262(a,c); create index t262_idx2 on t262(a,d);
create table t263 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t263_idx1 on t263(a,c); create index t263_idx2 on t263(a,d);
create table t264 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t264_idx1 on t264(a,c); create index t264_idx2 on t264(a,d);
create table t265 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t265_idx1 on t265(a,c); create index t265_idx2 on t265(a,d);
create table t266 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t266_idx1 on t266(a,c); create index t266_idx2 on t266(a,d);
create table t267 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t267_idx1 on t267(a,c); create index t267_idx2 on t267(a,d);
create table t268 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t268_idx1 on t268(a,c); create index t268_idx2 on t268(a,d);
create table t269 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t269_idx1 on t269(a,c); create index t269_idx2 on t269(a,d);
create table t270 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t270_idx1 on t270(a,c); create index t270_idx2 on t270(a,d);
create table t271 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t271_idx1 on t271(a,c); create index t271_idx2 on t271(a,d);
create table t272 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t272_idx1 on t272(a,c); create index t272_idx2 on t272(a,d);
create table t273 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t273_idx1 on t273(a,c); create index t273_idx2 on t273(a,d);
create table t274 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t274_idx1 on t274(a,c); create index t274_idx2 on t274(a,d);
create table t275 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t275_idx1 on t275(a,c); create index t275_idx2 on t275(a,d);
create table t276 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t276_idx1 on t276(a,c); create index t276_idx2 on t276(a,d);
create table t277 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t277_idx1 on t277(a,c); create index t277_idx2 on t277(a,d);
create table t278 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t278_idx1 on t278(a,c); create index t278_idx2 on t278(a,d);
create table t279 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t279_idx1 on t279(a,c); create index t279_idx2 on t279(a,d);
create table t280 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t280_idx1 on t280(a,c); create index t280_idx2 on t280(a,d);
create table t281 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t281_idx1 on t281(a,c); create index t281_idx2 on t281(a,d);
create table t282 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t282_idx1 on t282(a,c); create index t282_idx2 on t282(a,d);
create table t283 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t283_idx1 on t283(a,c); create index t283_idx2 on t283(a,d);
create table t284 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t284_idx1 on t284(a,c); create index t284_idx2 on t284(a,d);
create table t285 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t285_idx1 on t285(a,c); create index t285_idx2 on t285(a,d);
create table t286 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t286_idx1 on t286(a,c); create index t286_idx2 on t286(a,d);
create table t287 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t287_idx1 on t287(a,c); create index t287_idx2 on t287(a,d);
create table t288 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t288_idx1 on t288(a,c); create index t288_idx2 on t288(a,d);
create table t289 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t289_idx1 on t289(a,c); create index t289_idx2 on t289(a,d);
create table t290 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t290_idx1 on t290(a,c); create index t290_idx2 on t290(a,d);
create table t291 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t291_idx1 on t291(a,c); create index t291_idx2 on t291(a,d);
create table t292 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t292_idx1 on t292(a,c); create index t292_idx2 on t292(a,d);
create table t293 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t293_idx1 on t293(a,c); create index t293_idx2 on t293(a,d);
create table t294 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t294_idx1 on t294(a,c); create index t294_idx2 on t294(a,d);
create table t295 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t295_idx1 on t295(a,c); create index t295_idx2 on t295(a,d);
create table t296 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t296_idx1 on t296(a,c); create index t296_idx2 on t296(a,d);
create table t297 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t297_idx1 on t297(a,c); create index t297_idx2 on t297(a,d);
create table t298 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t298_idx1 on t298(a,c); create index t298_idx2 on t298(a,d);
create table t299 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t299_idx1 on t299(a,c); create index t299_idx2 on t299(a,d);
create table t300 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t300_idx1 on t300(a,c); create index t300_idx2 on t300(a,d);
create table t301 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t301_idx1 on t301(a,c); create index t301_idx2 on t301(a,d);
create table t302 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t302_idx1 on t302(a,c); create index t302_idx2 on t302(a,d);
create table t303 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t303_idx1 on t303(a,c); create index t303_idx2 on t303(a,d);
create table t304 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t304_idx1 on t304(a,c); create index t304_idx2 on t304(a,d);
create table t305 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t305_idx1 on t305(a,c); create index t305_idx2 on t305(a,d);
create table t306 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t306_idx1 on t306(a,c); create index t306_idx2 on t306(a,d);
create table t307 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t307_idx1 on t307(a,c); create index t307_idx2 on t307(a,d);
create table t308 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t308_idx1 on t308(a,c); create index t308_idx2 on t308(a,d);
create table t309 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t309_idx1 on t309(a,c); create index t309_idx2 on t309(a,d);
create table t310 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t310_idx1 on t310(a,c); create index t310_idx2 on t310(a,d);
create table t311 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t311_idx1 on t311(a,c); create index t311_idx2 on t311(a,d);
create table t312 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t312_idx1 on t312(a,c); create index t312_idx2 on t312(a,d);
create table t313 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t313_idx1 on t313(a,c); create index t313_idx2 on t313(a,d);
create table t314 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t314_idx1 on t314(a,c); create index t314_idx2 on t314(a,d);
create table t315 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t315_idx1 on t315(a,c); create index t315_idx2 on t315(a,d);
create table t316 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t316_idx1 on t316(a,c); create index t316_idx2 on t316(a,d);
create table t317 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t317_idx1 on t317(a,c); create index t317_idx2 on t317(a,d);
create table t318 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t318_idx1 on t318(a,c); create index t318_idx2 on t318(a,d);
create table t319 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t319_idx1 on t319(a,c); create index t319_idx2 on t319(a,d);
create table t320 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t320_idx1 on t320(a,c); create index t320_idx2 on t320(a,d);
create table t321 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t321_idx1 on t321(a,c); create index t321_idx2 on t321(a,d);
create table t322 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t322_idx1 on t322(a,c); create index t322_idx2 on t322(a,d);
create table t323 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t323_idx1 on t323(a,c); create index t323_idx2 on t323(a,d);
create table t324 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t324_idx1 on t324(a,c); create index t324_idx2 on t324(a,d);
create table t325 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t325_idx1 on t325(a,c); create index t325_idx2 on t325(a,d);
create table t326 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t326_idx1 on t326(a,c); create index t326_idx2 on t326(a,d);
create table t327 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t327_idx1 on t327(a,c); create index t327_idx2 on t327(a,d);
create table t328 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t328_idx1 on t328(a,c); create index t328_idx2 on t328(a,d);
create table t329 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t329_idx1 on t329(a,c); create index t329_idx2 on t329(a,d);
create table t330 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t330_idx1 on t330(a,c); create index t330_idx2 on t330(a,d);
create table t331 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t331_idx1 on t331(a,c); create index t331_idx2 on t331(a,d);
create table t332 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t332_idx1 on t332(a,c); create index t332_idx2 on t332(a,d);
create table t333 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t333_idx1 on t333(a,c); create index t333_idx2 on t333(a,d);
create table t334 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t334_idx1 on t334(a,c); create index t334_idx2 on t334(a,d);
create table t335 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t335_idx1 on t335(a,c); create index t335_idx2 on t335(a,d);
create table t336 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t336_idx1 on t336(a,c); create index t336_idx2 on t336(a,d);
create table t337 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t337_idx1 on t337(a,c); create index t337_idx2 on t337(a,d);
create table t338 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t338_idx1 on t338(a,c); create index t338_idx2 on t338(a,d);
create table t339 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t339_idx1 on t339(a,c); create index t339_idx2 on t339(a,d);
create table t340 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t340_idx1 on t340(a,c); create index t340_idx2 on t340(a,d);
create table t341 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t341_idx1 on t341(a,c); create index t341_idx2 on t341(a,d);
create table t342 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t342_idx1 on t342(a,c); create index t342_idx2 on t342(a,d);
create table t343 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t343_idx1 on t343(a,c); create index t343_idx2 on t343(a,d);
create table t344 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t344_idx1 on t344(a,c); create index t344_idx2 on t344(a,d);
create table t345 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t345_idx1 on t345(a,c); create index t345_idx2 on t345(a,d);
create table t346 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t346_idx1 on t346(a,c); create index t346_idx2 on t346(a,d);
create table t347 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t347_idx1 on t347(a,c); create index t347_idx2 on t347(a,d);
create table t348 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t348_idx1 on t348(a,c); create index t348_idx2 on t348(a,d);
create table t349 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t349_idx1 on t349(a,c); create index t349_idx2 on t349(a,d);
create table t350 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t350_idx1 on t350(a,c); create index t350_idx2 on t350(a,d);
create table t351 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t351_idx1 on t351(a,c); create index t351_idx2 on t351(a,d);
create table t352 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t352_idx1 on t352(a,c); create index t352_idx2 on t352(a,d);
create table t353 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t353_idx1 on t353(a,c); create index t353_idx2 on t353(a,d);
create table t354 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t354_idx1 on t354(a,c); create index t354_idx2 on t354(a,d);
create table t355 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t355_idx1 on t355(a,c); create index t355_idx2 on t355(a,d);
create table t356 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t356_idx1 on t356(a,c); create index t356_idx2 on t356(a,d);
create table t357 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t357_idx1 on t357(a,c); create index t357_idx2 on t357(a,d);
create table t358 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t358_idx1 on t358(a,c); create index t358_idx2 on t358(a,d);
create table t359 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t359_idx1 on t359(a,c); create index t359_idx2 on t359(a,d);
create table t360 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t360_idx1 on t360(a,c); create index t360_idx2 on t360(a,d);
create table t361 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t361_idx1 on t361(a,c); create index t361_idx2 on t361(a,d);
create table t362 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t362_idx1 on t362(a,c); create index t362_idx2 on t362(a,d);
create table t363 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t363_idx1 on t363(a,c); create index t363_idx2 on t363(a,d);
create table t364 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t364_idx1 on t364(a,c); create index t364_idx2 on t364(a,d);
create table t365 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t365_idx1 on t365(a,c); create index t365_idx2 on t365(a,d);
create table t366 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t366_idx1 on t366(a,c); create index t366_idx2 on t366(a,d);
create table t367 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t367_idx1 on t367(a,c); create index t367_idx2 on t367(a,d);
create table t368 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t368_idx1 on t368(a,c); create index t368_idx2 on t368(a,d);
create table t369 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t369_idx1 on t369(a,c); create index t369_idx2 on t369(a,d);
create table t370 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t370_idx1 on t370(a,c); create index t370_idx2 on t370(a,d);
create table t371 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t371_idx1 on t371(a,c); create index t371_idx2 on t371(a,d);
create table t372 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t372_idx1 on t372(a,c); create index t372_idx2 on t372(a,d);
create table t373 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t373_idx1 on t373(a,c); create index t373_idx2 on t373(a,d);
create table t374 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t374_idx1 on t374(a,c); create index t374_idx2 on t374(a,d);
create table t375 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t375_idx1 on t375(a,c); create index t375_idx2 on t375(a,d);
create table t376 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t376_idx1 on t376(a,c); create index t376_idx2 on t376(a,d);
create table t377 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t377_idx1 on t377(a,c); create index t377_idx2 on t377(a,d);
create table t378 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t378_idx1 on t378(a,c); create index t378_idx2 on t378(a,d);
create table t379 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t379_idx1 on t379(a,c); create index t379_idx2 on t379(a,d);
create table t380 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t380_idx1 on t380(a,c); create index t380_idx2 on t380(a,d);
create table t381 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t381_idx1 on t381(a,c); create index t381_idx2 on t381(a,d);
create table t382 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t382_idx1 on t382(a,c); create index t382_idx2 on t382(a,d);
create table t383 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t383_idx1 on t383(a,c); create index t383_idx2 on t383(a,d);
create table t384 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t384_idx1 on t384(a,c); create index t384_idx2 on t384(a,d);
create table t385 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t385_idx1 on t385(a,c); create index t385_idx2 on t385(a,d);
create table t386 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t386_idx1 on t386(a,c); create index t386_idx2 on t386(a,d);
create table t387 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t387_idx1 on t387(a,c); create index t387_idx2 on t387(a,d);
create table t388 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t388_idx1 on t388(a,c); create index t388_idx2 on t388(a,d);
create table t389 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t389_idx1 on t389(a,c); create index t389_idx2 on t389(a,d);
create table t390 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t390_idx1 on t390(a,c); create index t390_idx2 on t390(a,d);
create table t391 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t391_idx1 on t391(a,c); create index t391_idx2 on t391(a,d);
create table t392 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t392_idx1 on t392(a,c); create index t392_idx2 on t392(a,d);
create table t393 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t393_idx1 on t393(a,c); create index t393_idx2 on t393(a,d);
create table t394 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t394_idx1 on t394(a,c); create index t394_idx2 on t394(a,d);
create table t395 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t395_idx1 on t395(a,c); create index t395_idx2 on t395(a,d);
create table t396 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t396_idx1 on t396(a,c); create index t396_idx2 on t396(a,d);
create table t397 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t397_idx1 on t397(a,c); create index t397_idx2 on t397(a,d);
create table t398 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t398_idx1 on t398(a,c); create index t398_idx2 on t398(a,d);
create table t399 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t399_idx1 on t399(a,c); create index t399_idx2 on t399(a,d);
create table t400 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t400_idx1 on t400(a,c); create index t400_idx2 on t400(a,d);
create table t401 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t401_idx1 on t401(a,c); create index t401_idx2 on t401(a,d);
create table t402 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t402_idx1 on t402(a,c); create index t402_idx2 on t402(a,d);
create table t403 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t403_idx1 on t403(a,c); create index t403_idx2 on t403(a,d);
create table t404 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t404_idx1 on t404(a,c); create index t404_idx2 on t404(a,d);
create table t405 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t405_idx1 on t405(a,c); create index t405_idx2 on t405(a,d);
create table t406 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t406_idx1 on t406(a,c); create index t406_idx2 on t406(a,d);
create table t407 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t407_idx1 on t407(a,c); create index t407_idx2 on t407(a,d);
create table t408 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t408_idx1 on t408(a,c); create index t408_idx2 on t408(a,d);
create table t409 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t409_idx1 on t409(a,c); create index t409_idx2 on t409(a,d);
create table t410 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t410_idx1 on t410(a,c); create index t410_idx2 on t410(a,d);
create table t411 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t411_idx1 on t411(a,c); create index t411_idx2 on t411(a,d);
create table t412 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t412_idx1 on t412(a,c); create index t412_idx2 on t412(a,d);
create table t413 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t413_idx1 on t413(a,c); create index t413_idx2 on t413(a,d);
create table t414 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t414_idx1 on t414(a,c); create index t414_idx2 on t414(a,d);
create table t415 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t415_idx1 on t415(a,c); create index t415_idx2 on t415(a,d);
create table t416 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t416_idx1 on t416(a,c); create index t416_idx2 on t416(a,d);
create table t417 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t417_idx1 on t417(a,c); create index t417_idx2 on t417(a,d);
create table t418 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t418_idx1 on t418(a,c); create index t418_idx2 on t418(a,d);
create table t419 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t419_idx1 on t419(a,c); create index t419_idx2 on t419(a,d);
create table t420 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t420_idx1 on t420(a,c); create index t420_idx2 on t420(a,d);
create table t421 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t421_idx1 on t421(a,c); create index t421_idx2 on t421(a,d);
create table t422 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t422_idx1 on t422(a,c); create index t422_idx2 on t422(a,d);
create table t423 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t423_idx1 on t423(a,c); create index t423_idx2 on t423(a,d);
create table t424 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t424_idx1 on t424(a,c); create index t424_idx2 on t424(a,d);
create table t425 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t425_idx1 on t425(a,c); create index t425_idx2 on t425(a,d);
create table t426 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t426_idx1 on t426(a,c); create index t426_idx2 on t426(a,d);
create table t427 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t427_idx1 on t427(a,c); create index t427_idx2 on t427(a,d);
create table t428 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t428_idx1 on t428(a,c); create index t428_idx2 on t428(a,d);
create table t429 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t429_idx1 on t429(a,c); create index t429_idx2 on t429(a,d);
create table t430 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t430_idx1 on t430(a,c); create index t430_idx2 on t430(a,d);
create table t431 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t431_idx1 on t431(a,c); create index t431_idx2 on t431(a,d);
create table t432 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t432_idx1 on t432(a,c); create index t432_idx2 on t432(a,d);
create table t433 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t433_idx1 on t433(a,c); create index t433_idx2 on t433(a,d);
create table t434 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t434_idx1 on t434(a,c); create index t434_idx2 on t434(a,d);
create table t435 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t435_idx1 on t435(a,c); create index t435_idx2 on t435(a,d);
create table t436 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t436_idx1 on t436(a,c); create index t436_idx2 on t436(a,d);
create table t437 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t437_idx1 on t437(a,c); create index t437_idx2 on t437(a,d);
create table t438 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t438_idx1 on t438(a,c); create index t438_idx2 on t438(a,d);
create table t439 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t439_idx1 on t439(a,c); create index t439_idx2 on t439(a,d);
create table t440 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t440_idx1 on t440(a,c); create index t440_idx2 on t440(a,d);
create table t441 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t441_idx1 on t441(a,c); create index t441_idx2 on t441(a,d);
create table t442 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t442_idx1 on t442(a,c); create index t442_idx2 on t442(a,d);
create table t443 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t443_idx1 on t443(a,c); create index t443_idx2 on t443(a,d);
create table t444 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t444_idx1 on t444(a,c); create index t444_idx2 on t444(a,d);
create table t445 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t445_idx1 on t445(a,c); create index t445_idx2 on t445(a,d);
create table t446 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t446_idx1 on t446(a,c); create index t446_idx2 on t446(a,d);
create table t447 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t447_idx1 on t447(a,c); create index t447_idx2 on t447(a,d);
create table t448 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t448_idx1 on t448(a,c); create index t448_idx2 on t448(a,d);
create table t449 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t449_idx1 on t449(a,c); create index t449_idx2 on t449(a,d);
create table t450 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t450_idx1 on t450(a,c); create index t450_idx2 on t450(a,d);
create table t451 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t451_idx1 on t451(a,c); create index t451_idx2 on t451(a,d);
create table t452 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t452_idx1 on t452(a,c); create index t452_idx2 on t452(a,d);
create table t453 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t453_idx1 on t453(a,c); create index t453_idx2 on t453(a,d);
create table t454 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t454_idx1 on t454(a,c); create index t454_idx2 on t454(a,d);
create table t455 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t455_idx1 on t455(a,c); create index t455_idx2 on t455(a,d);
create table t456 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t456_idx1 on t456(a,c); create index t456_idx2 on t456(a,d);
create table t457 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t457_idx1 on t457(a,c); create index t457_idx2 on t457(a,d);
create table t458 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t458_idx1 on t458(a,c); create index t458_idx2 on t458(a,d);
create table t459 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t459_idx1 on t459(a,c); create index t459_idx2 on t459(a,d);
create table t460 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t460_idx1 on t460(a,c); create index t460_idx2 on t460(a,d);
create table t461 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t461_idx1 on t461(a,c); create index t461_idx2 on t461(a,d);
create table t462 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t462_idx1 on t462(a,c); create index t462_idx2 on t462(a,d);
create table t463 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t463_idx1 on t463(a,c); create index t463_idx2 on t463(a,d);
create table t464 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t464_idx1 on t464(a,c); create index t464_idx2 on t464(a,d);
create table t465 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t465_idx1 on t465(a,c); create index t465_idx2 on t465(a,d);
create table t466 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t466_idx1 on t466(a,c); create index t466_idx2 on t466(a,d);
create table t467 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t467_idx1 on t467(a,c); create index t467_idx2 on t467(a,d);
create table t468 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t468_idx1 on t468(a,c); create index t468_idx2 on t468(a,d);
create table t469 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t469_idx1 on t469(a,c); create index t469_idx2 on t469(a,d);
create table t470 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t470_idx1 on t470(a,c); create index t470_idx2 on t470(a,d);
create table t471 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t471_idx1 on t471(a,c); create index t471_idx2 on t471(a,d);
create table t472 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t472_idx1 on t472(a,c); create index t472_idx2 on t472(a,d);
create table t473 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t473_idx1 on t473(a,c); create index t473_idx2 on t473(a,d);
create table t474 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t474_idx1 on t474(a,c); create index t474_idx2 on t474(a,d);
create table t475 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t475_idx1 on t475(a,c); create index t475_idx2 on t475(a,d);
create table t476 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t476_idx1 on t476(a,c); create index t476_idx2 on t476(a,d);
create table t477 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t477_idx1 on t477(a,c); create index t477_idx2 on t477(a,d);
create table t478 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t478_idx1 on t478(a,c); create index t478_idx2 on t478(a,d);
create table t479 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t479_idx1 on t479(a,c); create index t479_idx2 on t479(a,d);
create table t480 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t480_idx1 on t480(a,c); create index t480_idx2 on t480(a,d);
create table t481 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t481_idx1 on t481(a,c); create index t481_idx2 on t481(a,d);
create table t482 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t482_idx1 on t482(a,c); create index t482_idx2 on t482(a,d);
create table t483 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t483_idx1 on t483(a,c); create index t483_idx2 on t483(a,d);
create table t484 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t484_idx1 on t484(a,c); create index t484_idx2 on t484(a,d);
create table t485 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t485_idx1 on t485(a,c); create index t485_idx2 on t485(a,d);
create table t486 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t486_idx1 on t486(a,c); create index t486_idx2 on t486(a,d);
create table t487 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t487_idx1 on t487(a,c); create index t487_idx2 on t487(a,d);
create table t488 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t488_idx1 on t488(a,c); create index t488_idx2 on t488(a,d);
create table t489 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t489_idx1 on t489(a,c); create index t489_idx2 on t489(a,d);
create table t490 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t490_idx1 on t490(a,c); create index t490_idx2 on t490(a,d);
create table t491 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t491_idx1 on t491(a,c); create index t491_idx2 on t491(a,d);
create table t492 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t492_idx1 on t492(a,c); create index t492_idx2 on t492(a,d);
create table t493 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t493_idx1 on t493(a,c); create index t493_idx2 on t493(a,d);
create table t494 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t494_idx1 on t494(a,c); create index t494_idx2 on t494(a,d);
create table t495 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t495_idx1 on t495(a,c); create index t495_idx2 on t495(a,d);
create table t496 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t496_idx1 on t496(a,c); create index t496_idx2 on t496(a,d);
create table t497 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t497_idx1 on t497(a,c); create index t497_idx2 on t497(a,d);
create table t498 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t498_idx1 on t498(a,c); create index t498_idx2 on t498(a,d);
create table t499 (a integer not null, b varchar(10), c integer, d smallint, e integer, primary key(a, b)); create index t499_idx1 on t499(a,c); create index t499_idx2 on t499(a,d);


END_OF_BATCH

-- Update classes from jar so that the server will know about classes
-- but not procedures yet.
-- This command cannot be part of a DDL batch.
LOAD CLASSES voter-procs.jar;

-- The following CREATE PROCEDURE statements can all be batched.
file -inlinebatch END_OF_2ND_BATCH

-- stored procedures
CREATE PROCEDURE FROM CLASS voter.Initialize;
CREATE PROCEDURE FROM CLASS voter.Results;
CREATE PROCEDURE PARTITION ON TABLE votes COLUMN phone_number FROM CLASS voter.Vote;
CREATE PROCEDURE FROM CLASS voter.ContestantWinningStates;
CREATE PROCEDURE FROM CLASS voter.GetStateHeatmap;

END_OF_2ND_BATCH
