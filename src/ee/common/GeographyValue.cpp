/* This file is part of VoltDB.
 * Copyright (C) 2008-2018 VoltDB Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with VoltDB.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "common/GeographyValue.hpp"

using namespace std;
using namespace voltdb;

inline int GeographyValue::compareWith(const GeographyValue& rhs) const {
    /* Do floating-point comparisons only as a last resort to help
     * avoid issues with floating-point math.  It doesn't really
     * matter how we do our comparison as long as we produce a
     * deterministic order.
     *
     *   1. First compare number of loops (polygons with fewer loops sort as smaller).
     *   2. If the number of loops are the same, compare the number
     *        of vertices in each loop.  The polygon with first loop
     *        containing fewer vertices will sort as smaller.
     *   3. Finally, if all loops have the same number of vertices, sort on the
     *        points themselves (which will involve doing floating-point comparison)
     */

    Polygon lhsPoly;
    lhsPoly.initFromGeography(*this);

    Polygon rhsPoly;
    rhsPoly.initFromGeography(rhs);

    if (lhsPoly.num_loops() < rhsPoly.num_loops()) {
        return VALUE_COMPARE_LESSTHAN;
    }

    if (lhsPoly.num_loops() > rhsPoly.num_loops()) {
        return VALUE_COMPARE_GREATERTHAN;
    }

    // number of loops are the same.
    // compare on number of vertices in each loop
    for (int i = 0; i < lhsPoly.num_loops(); ++i) {
        S2Loop* lhsLoop = lhsPoly.loop(i);
        S2Loop* rhsLoop = rhsPoly.loop(i);

        if (lhsLoop->num_vertices() < rhsLoop->num_vertices()) {
            return VALUE_COMPARE_LESSTHAN;
        }

        if (lhsLoop->num_vertices() > rhsLoop->num_vertices()) {
            return VALUE_COMPARE_GREATERTHAN;
        }
    }

    // Each loop has the same number of vertices.
    // Compare the vertices themselves.
    for (int i = 0; i < lhsPoly.num_loops(); ++i) {
        S2Loop* lhsLoop = lhsPoly.loop(i);
        S2Loop* rhsLoop = rhsPoly.loop(i);

        for (int j = 0; j < lhsLoop->num_vertices(); ++j) {
            const GeographyPointValue lhsVert(lhsLoop->vertex(j));
            const GeographyPointValue rhsVert(rhsLoop->vertex(j));
            int cmp = lhsVert.compareWith(rhsVert);
            if (cmp != VALUE_COMPARE_EQUAL) {
                return cmp;
            }
        }
    }

    return VALUE_COMPARE_EQUAL;
}


inline void GeographyValue::hashCombine(std::size_t& seed) const {

    if (isNull()) {
        // Treat a null as a polygon with zero loops
        boost::hash_combine(seed, 0);
        return;
    }

    Polygon poly;
    poly.initFromGeography(*this);

    int numLoops = poly.num_loops();
    boost::hash_combine(seed, numLoops);
    for (int i = 0; i < numLoops; ++i) {
        S2Loop* loop = poly.loop(i);
        for (int j = 0; j < loop->num_vertices(); ++j) {
            const S2Point& v = loop->vertex(j);
            boost::hash_combine(seed, v.x());
            boost::hash_combine(seed, v.y());
            boost::hash_combine(seed, v.z());
        }
    }
}

inline std::string GeographyValue::toString() const {
    std::ostringstream oss;

    if (isNull()) {
        oss << "null polygon";
    }
    else {
        Polygon poly;
        poly.initFromGeography(*this);
        int numLoops = poly.num_loops();
        oss << "polygon with "
            << numLoops << " loops with vertex counts";
        for (int i = 0; i < numLoops; ++i) {
            oss << " " << poly.loop(i)->num_vertices()
                << " (depth=" << poly.loop(i)->depth() << ")";
        }
    }

    return oss.str();
}

inline std::string GeographyValue::toWKT() const {
    assert(!isNull());

    Polygon poly;
    poly.initFromGeography(*this);
    int numLoops = poly.num_loops();
    assert (numLoops > 0);
    GeographyPointValue point;

    std::ostringstream oss;
    oss << "POLYGON (";
    // Note that we need to reverse the order of holes,
    // but not of shells.
    bool is_shell = true;
    // capture all the loops
    for (int i = 0; i < numLoops; ++i) {
        const S2Loop *loop = poly.loop(i);
        const int numVertices = loop->num_vertices();
        assert(numVertices >= 3); // each loop will be composed of at least 3 vertices. This does not include repeated end vertex
        oss << "(";
        // Capture the first point first.  This is always
        // First, even if this is a hole or a shell.
        point = GeographyPointValue(loop->vertex(0));
        oss << point.formatLngLat() << ", ";
        int startIdx = (is_shell ? 1 : numVertices-1);
        int endIdx   = (is_shell ? numVertices : 0);
        int delta    = (is_shell ? 1 : -1);
        for (int j = startIdx; j != endIdx; j += delta) {
            point = GeographyPointValue(loop->vertex(j));
            oss << point.formatLngLat() << ", ";
        }
        // repeat the first vertex to close the loop
        point = GeographyPointValue(loop->vertex(0));
        oss << point.formatLngLat() << ")";
        // last loop?
        if (i < numLoops -1) {
            oss << ", " ;
        }
        is_shell = false;
    }
    oss << ")";

    return oss.str();
}

template<class Deserializer>
inline void GeographyValue::deserializeFrom(Deserializer& input,
                                       char* storage,
                                       int32_t length)
{
    SimpleOutputSerializer output(storage, length);
    Polygon::copyViaSerializers(output, input);
}

template<class Serializer>
inline void GeographyValue::serializeTo(Serializer& output) const
{
	Decoder decoder(m_data, m_length);
	ReferenceSerializeInputLE input(m_data, m_length);
	S2Polygon polygon;
	if（polygon.Decode(&decoder)）

    Polygon::copyViaSerializers(output, input);
}


const int8_t INCOMPLETE_ENCODING_FROM_JAVA = 0;
const int8_t COMPLETE_ENCODING = 1;

const std::size_t BOUND_SERIALIZED_SIZE =
    sizeof(int8_t)  // encoding version
    + (sizeof(double) * 4); // 2 corners of bounding box, as min/max lat/lng


template<class Deserializer>
static inline void initBoundFromBuffer(S2LatLngRect *bound, Deserializer& input)
{
    input.readByte(); // encoding version

    double latLo = input.readDouble();
    double latHi = input.readDouble();
    double lngLo = input.readDouble();
    double lngHi = input.readDouble();
    *bound = S2LatLngRect(R1Interval(latLo, latHi), S1Interval(lngLo, lngHi));
}

template<class Serializer>
static inline void saveBoundToBuffer(const S2LatLngRect *bound, Serializer& output)
{
    output.writeByte(COMPLETE_ENCODING);
    output.writeDouble(bound->lat().lo());
    output.writeDouble(bound->lat().hi());
    output.writeDouble(bound->lng().lo());
    output.writeDouble(bound->lng().hi());
}

template<class Serializer, class Deserializer>
static inline void copyBoundViaSerializers(Serializer& output, Deserializer& input) {
    output.writeByte(input.readByte()); // encoding version
    for (int i = 0; i < 4; ++i) {
        output.writeDouble(input.readDouble());
    }
}

template<class Deserializer>
static inline void skipBound(Deserializer& input)
{
    input.readByte();
    input.readDouble();
    input.readDouble();
    input.readDouble();
    input.readDouble();
}




inline std::size_t Loop::serializedLength(int32_t numVertices) {
    return
        sizeof(int8_t) + // encoding version
        sizeof(int32_t) + // num vertices
        (numVertices * 3 * sizeof(double)) + // vertices
        sizeof(int8_t) + // origin inside
        sizeof(int32_t) + // depth
        BOUND_SERIALIZED_SIZE;
}

template<class Serializer, class Deserializer>
inline void Loop::copyViaSerializers(Serializer& output, Deserializer& input) {
    output.writeByte(input.readByte()); // encoding version
    int numVertices = input.readInt();
    output.writeInt(numVertices);
    for (int i = 0; i < numVertices; ++i) {
        output.writeDouble(input.readDouble());
        output.writeDouble(input.readDouble());
        output.writeDouble(input.readDouble());
    }

    output.writeByte(input.readByte()); // origin inside
    int32_t depth = input.readInt();
    output.writeInt(depth);

    copyBoundViaSerializers(output, input);
}

template<class Deserializer>
inline void Loop::pointArrayFromBuffer(Deserializer& input, std::vector<S2Point>* points)
{
    input.readByte(); // encoding version
    int numVertices = input.readInt();
    for (int i = 0; i < numVertices; ++i) {
        double x = input.readDouble();
        double y = input.readDouble();
        double z = input.readDouble();
        points->push_back(S2Point(x, y, z));
    }
    input.readByte(); // origin inside
    input.readInt();  // depth

    skipBound(input);
}

template<class Deserializer>
inline void Loop::initFromBuffer(Deserializer& input, bool doRepairs)
{
    input.readByte();

    num_vertices_ = input.readInt();

    S2Point *src = reinterpret_cast<S2Point*>(
                            const_cast<char*>(
                                    input.getRawPointer(num_vertices() * sizeof(S2Point))));
    int8_t origin_inside = input.readByte();
    int32_t thedepth = input.readInt();
    S2LatLngRect bound;
    initBoundFromBuffer(&bound, input);
    // Do this before doing (potentially) the inversions.
    /*
     * If we are going to do repairs, potentially,
     * we want to take command of our own vertices.
     */
    if (doRepairs) {
        set_owns_vertices(true);
        set_origin_inside(origin_inside);
        set_depth(thedepth);
        set_rect_bound(bound);
        Init(src, num_vertices());
        // If this loop is already normalized, this
        // will not do anything.  If it is not it will
        // invert the loop.
        Normalize();
    } else {
        // Point these vertices at the vertices
        // in the tuple.  This loop does not
        // own these vertices, so we won't delete
        // them when the loop is reaped.
        assert (!owns_vertices());
        set_vertices(src);
        set_origin_inside(origin_inside);
        set_depth(thedepth);
        set_rect_bound(bound);
    }
    assert(depth() >= 0);
}

template<class Serializer>
void Loop::saveToBuffer(Serializer& output) const {
    output.writeByte(COMPLETE_ENCODING); // encoding version
    output.writeInt(num_vertices());
    output.writeBinaryString(vertices(), sizeof(*(vertices())) * num_vertices());
    output.writeBool(origin_inside());
    assert(depth() >= 0);
    output.writeInt(depth());

    S2LatLngRect bound = GetRectBound();
    saveBoundToBuffer(&bound, output);
}

inline std::size_t Polygon::serializedLengthNoLoops() {
    return
        sizeof(int8_t) + // encoding version
        sizeof(int8_t) + // owns loops
        sizeof(int8_t) + // has holes
        sizeof(int32_t) + // num loops
        BOUND_SERIALIZED_SIZE;
}

inline std::size_t Polygon::serializedLength() {
    std::size_t answer = serializedLengthNoLoops();
    answer += SpaceUsed();
    return answer;
}

template<class Serializer, class Deserializer>
inline void Polygon::copyViaSerializers(Serializer& output, Deserializer& input)
{
    int8_t version = input.readByte();

    if (version == COMPLETE_ENCODING) {
        output.writeByte(COMPLETE_ENCODING);
        output.writeByte(input.readByte()); // ownsLoops
        output.writeByte(input.readByte()); // has holes

        int32_t numLoops = input.readInt();
        output.writeInt(numLoops);
        for (int i = 0; i < numLoops; ++i) {
            Loop::copyViaSerializers(output, input);
        }

        copyBoundViaSerializers(output, input);
    }
    else {
        assert (version == INCOMPLETE_ENCODING_FROM_JAVA);

        // This is a serialized polygon from Java, which won't have
        // proper bounding boxes defined.  Grab the vertices, build
        // the loops, and instantiate a polygon, which will
        // create the bounding boxes.

        input.readByte(); // owns loops
        input.readByte(); // has holes

        std::vector<std::unique_ptr<S2Loop> > loops;
        int32_t numLoops = input.readInt();
        loops.reserve(numLoops);
        for (int i = 0; i < numLoops; ++i) {
            std::vector<S2Point> points;
            Loop::pointArrayFromBuffer(input, &points);
            loops.push_back(std::unique_ptr<S2Loop>(new S2Loop()));
            loops.back()->Init(points);
        }

        skipBound(input);

        Polygon poly;
        // Don't do any orientation repairs here.
        poly.InitNested(loops);
        poly.saveToBuffer(output);
    }
}

inline void Polygon::initFromGeography(const GeographyValue& geog, bool doRepairs)
{

    ReferenceSerializeInputLE input(geog.data(), geog.length());
    initFromBuffer(input, doRepairs);
}

template<class Deserializer>
inline void Polygon::initFromBuffer(Deserializer& input, bool doRepairs)
{
    input.readByte(); // encoding version

    ClearLoops();

    //set_owns_loops(input.readBool());
    //set_has_holes(input.readBool());
    int numLoops = input.readInt();

    std::vector<std::unique_ptr<S2Loop> > loops;
    loops.reserve(numLoops);
    int num_vertices = 0;
    for (int i = 0; i < numLoops; ++i) {
    	Loop *loop = new Loop;
        loop->initFromBuffer(input, doRepairs);
        num_vertices += loop->num_vertices();
        loops.push_back(loop);
    }

    num_vertices_ = num_vertices;

    S2LatLngRect bound;
    initBoundFromBuffer(&bound, input);
    set_rect_bound(bound);
    // If we are asked to do repairs we want to
    // reinitialize the polygon.  The depths of
    // loops may have changed.
    if (doRepairs) {
        CalculateLoopDepths();
    }
}

template<class Serializer>
void Polygon::saveToBuffer(Serializer& output) const {
    output.writeByte(COMPLETE_ENCODING); // encoding version
    output.writeBool(owns_loops());
    output.writeBool(has_holes());
    output.writeInt(loops().size());
    for (int i = 0; i < num_loops(); ++i) {
        static_cast<const Loop*>(loop(i))->saveToBuffer(output);
    }

    S2LatLngRect bound = GetRectBound();
    saveBoundToBuffer(&bound, output);
}