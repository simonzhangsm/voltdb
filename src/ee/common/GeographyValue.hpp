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

#ifndef EE_COMMON_GEOGRAPHY_VALUE_HPP
#define EE_COMMON_GEOGRAPHY_VALUE_HPP

#include <memory>
#include <sstream>
#include <vector>

#include "boost/foreach.hpp"
#include "boost/functional/hash.hpp"

#include "common/serializeio.h"
#include "common/value_defs.h"
#include "GeographyPointValue.hpp"
#include "s2/s2loop.h"
#include "s2/s2polygon.h"

using namespace std;
namespace voltdb {

class GeographyValue;

/**
 * A subclass of S2Loop that allows instances to be initialized from
 * the EE's serializer classes.
 */
class Loop : public S2Loop {
public:

    Loop() : S2Loop()
    {
    }

    template<class Deserializer>
    void initFromBuffer(Deserializer& input, bool doRepairs = false);

    template<class Serializer>
    void saveToBuffer(Serializer& output) const;

    template<class Serializer, class Deserializer>
    static void copyViaSerializers(Serializer& output, Deserializer& input);

    template<class Deserializer>
    static void pointArrayFromBuffer(Deserializer& input, std::vector<S2Point>* points);

    static std::size_t serializedLength(int32_t numVertices);
};

/**
 * A subclass of S2Polygon that allows instances to be initialized from
 * the EE's serializer classes.
 */
class Polygon : public S2Polygon {
public:

    Polygon() : S2Polygon()
    {
    }

    void initFromGeography(const GeographyValue& geog, bool doRepairs = false);

    template<class Deserializer>
    void initFromBuffer(Deserializer& input, bool doRepairs = false);

    template<class Serializer>
    void saveToBuffer(Serializer& output) const;

    template<class Serializer, class Deserializer>
    static void copyViaSerializers(Serializer& output, Deserializer& input);

    static std::size_t serializedLengthNoLoops();

    std::size_t serializedLength();

    double getDistance(const GeographyPointValue &point) {
        const S2Point s2Point = point.toS2Point();
        S1Angle distanceRadians = S1Angle(Project(s2Point), s2Point);
        return distanceRadians.radians();
    }
};

/**
 * A class for representing instances of geo-spatial geographies.
 * (Currently only polygons can be represented here.)
 *
 * Note that variable length data in the EE is typically prefixed with
 * a 4-byte integer that is the length of the data in bytes.  The
 * pointer accepted by the constructor here should be to the start of
 * the data just after the length.
 */
class GeographyValue {
public:

    /** Constructor for a null geography */
    GeographyValue()
    {
    }

    GeographyValue(const char* data, int32_t length)
        : m_data(data)
        , m_length(length)
    {
    }

    bool isNull() const
    {
        return m_data == nullptr;
    }

    const char* data() const
    {
        return m_data;
    }

    int32_t length() const
    {
        return m_length;
    }

    /**
     * Do a comparison with another geography (polygon).
     */
    int compareWith(const GeographyValue& rhs) const;

    /**
     * Serialize this geography
     */
    template<class Serializer>
    void serializeTo(Serializer& output) const;

    /**
     * Populate a pointer to storage with the bytes that represent a
     * geography.  Note that the caller has already read the
     * length-prefix that accompanies variable-length data and sized
     * the target storage appropriately.
     */
    template<class Deserializer>
    static void deserializeFrom(Deserializer& input,
                                char* storage,
                                int32_t length);

    /**
     * Hash this geography value (used for hash aggregation where a
     * geography is group by key).
     */
    void hashCombine(std::size_t& seed) const;

    /**
     * Produce a human-readable summary of this geography
     */
    std::string toString() const;
    // returns wkt representation for given polygon:
    // "POLYGON ((<Longitude> <Latitude>, <Longitude> <Latitude> .. <Longitude> <Latitude>)[,(..), (..),..(..)])"
    std::string toWKT() const;

private:
    const char* m_data{nullptr};
    int32_t m_length{0};
};

/**
 * A class similar to ReferenceSerializeOutput, except that it doesn't
 * do any byte-swapping.
 */
class SimpleOutputSerializer {
public:
    SimpleOutputSerializer(char* const buffer, std::size_t size)
        : m_buffer(buffer)
        , m_size(size)
        , m_cursor(buffer)
    {
    }

    ~SimpleOutputSerializer()
    {
        // make sure we consumed everything we expected to.
        assert(m_buffer + m_size == m_cursor);
    }

    void writeByte(int8_t byte) {
        writeNative(byte);
    }

    void writeBool(bool val) {
        writeNative(static_cast<int8_t>(val));
    }

    void writeInt(int32_t val) {
        writeNative(val);
    }

    void writeDouble(double val) {
        writeNative(val);
    }

    void writeBinaryString(const void* value, size_t length) {
        ::memcpy(m_cursor, value, length);
        m_cursor += length;
    }

    std::string toString() const {
        std::ostringstream oss;
        oss << "SimpleOutputSerializer with buffer size " << m_size
            << ", current offset = " << (m_cursor - m_buffer);
        return oss.str();
    }

private:

    template<typename T>
    void writeNative(T val) {
        assert(m_cursor - m_buffer < m_size);
        reinterpret_cast<T*>(m_cursor)[0] = val;
        m_cursor += sizeof(T);
    }

    char* const m_buffer{nullptr};
    const std::size_t m_size{0};

    char* m_cursor{nullptr};
};

} // end namespace voltdb

#endif // EE_COMMON_GEOGRAPHY_VALUE_HPP
