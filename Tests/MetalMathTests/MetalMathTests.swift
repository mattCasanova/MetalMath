import XCTest
import simd
@testable import MetalMath

final class MathTests: XCTestCase {

    // MARK: - Constants & Conversions

    func testRadianToDegree() {
        XCTAssertTrue(isFloatEqual(radianToDegree(pi), 180))
        XCTAssertTrue(isFloatEqual(radianToDegree(piOverTwo), 90))
        XCTAssertTrue(isFloatEqual(radianToDegree(0), 0))
    }

    func testDegreeToRadian() {
        XCTAssertTrue(isFloatEqual(degreeToRadian(180), pi))
        XCTAssertTrue(isFloatEqual(degreeToRadian(90), piOverTwo))
        XCTAssertTrue(isFloatEqual(degreeToRadian(0), 0))
    }

    // MARK: - Clamp / Wrap / Range

    func testClamp() {
        XCTAssertEqual(clamp(value: 5, low: 0, high: 10), 5)
        XCTAssertEqual(clamp(value: -1, low: 0, high: 10), 0)
        XCTAssertEqual(clamp(value: 15, low: 0, high: 10), 10)
    }

    func testWrapEdge() {
        XCTAssertEqual(wrapEdge(value: 5, low: 0, high: 10), 5)
        XCTAssertEqual(wrapEdge(value: -1, low: 0, high: 10), 10)
        XCTAssertEqual(wrapEdge(value: 11, low: 0, high: 10), 0)
    }

    func testWrap() {
        XCTAssertEqual(wrap(value: 5, low: 0, high: 10), 5)
        XCTAssertEqual(wrap(value: 12, low: 0, high: 10), 2)
        XCTAssertEqual(wrap(value: -3, low: 0, high: 10), 7)
    }

    func testIsInRange() {
        XCTAssertTrue(isInRange(value: 5, low: 0, high: 10))
        XCTAssertTrue(isInRange(value: 0, low: 0, high: 10))
        XCTAssertTrue(isInRange(value: 10, low: 0, high: 10))
        XCTAssertFalse(isInRange(value: -1, low: 0, high: 10))
        XCTAssertFalse(isInRange(value: 11, low: 0, high: 10))
    }

    func testIsFloatEqual() {
        XCTAssertTrue(isFloatEqual(1.0, 1.0))
        XCTAssertTrue(isFloatEqual(1.0, 1.0 + epsilon * 0.5))
        XCTAssertFalse(isFloatEqual(1.0, 2.0))
    }

    // MARK: - Power of Two

    func testIsPowerOfTwo() {
        XCTAssertTrue(isPowerOfTwo(1))
        XCTAssertTrue(isPowerOfTwo(2))
        XCTAssertTrue(isPowerOfTwo(64))
        XCTAssertTrue(isPowerOfTwo(1024))
        XCTAssertFalse(isPowerOfTwo(0))
        XCTAssertFalse(isPowerOfTwo(3))
        XCTAssertFalse(isPowerOfTwo(100))
    }

    func testNextPowerOfTwo() {
        XCTAssertEqual(nextPowerOfTwo(1), 2)
        XCTAssertEqual(nextPowerOfTwo(3), 4)
        XCTAssertEqual(nextPowerOfTwo(5), 8)
        XCTAssertEqual(nextPowerOfTwo(100), 128)
    }
}

final class SimdFloat2Tests: XCTestCase {

    func testAngle() {
        let v = simd_float2(1, 0)
        XCTAssertTrue(isFloatEqual(v.angle, 0))

        let v2 = simd_float2(0, 1)
        XCTAssertTrue(isFloatEqual(v2.angle, piOverTwo))
    }

    func testInitFromAngle() {
        let v = simd_float2(angle: 0)
        XCTAssertTrue(isFloatEqual(v.x, 1))
        XCTAssertTrue(isFloatEqual(v.y, 0))
    }

    func testTextureCoordinateAliases() {
        var v = simd_float2(0.5, 0.75)
        XCTAssertEqual(v.u, 0.5)
        XCTAssertEqual(v.v, 0.75)
        v.u = 0.1
        v.v = 0.9
        XCTAssertEqual(v.x, 0.1)
        XCTAssertEqual(v.y, 0.9)
    }

    func testTo3D() {
        let v = simd_float2(1, 2)
        let v3 = v.to3D(3)
        XCTAssertEqual(v3, simd_float3(1, 2, 3))
    }

    func testEpsilonEqual() {
        let a = simd_float2(1, 2)
        let b = simd_float2(1, 2)
        let c = simd_float2(1, 3)
        XCTAssertTrue(simd_epsilon_equal(lhs: a, rhs: b))
        XCTAssertFalse(simd_epsilon_equal(lhs: a, rhs: c))
    }
}

final class SimdFloat3Tests: XCTestCase {

    func testXYSwizzle() {
        let v = simd_float3(1, 2, 3)
        XCTAssertEqual(v.xy, simd_float2(1, 2))
    }

    func testRGBAccess() {
        var v = simd_float3(0.1, 0.2, 0.3)
        XCTAssertEqual(v.r, 0.1)
        XCTAssertEqual(v.g, 0.2)
        XCTAssertEqual(v.b, 0.3)
        v.b = 0.9
        XCTAssertEqual(v.z, 0.9)
    }

    func testTo4D() {
        let v = simd_float3(1, 2, 3)
        XCTAssertEqual(v.to4D(4), simd_float4(1, 2, 3, 4))
    }
}

final class SimdFloat4x4Tests: XCTestCase {

    func testIdentity() {
        let mtx = simd_float4x4(1)
        XCTAssertEqual(mtx[0], simd_float4(1, 0, 0, 0))
        XCTAssertEqual(mtx[1], simd_float4(0, 1, 0, 0))
        XCTAssertEqual(mtx[2], simd_float4(0, 0, 1, 0))
        XCTAssertEqual(mtx[3], simd_float4(0, 0, 0, 1))
    }

    func testMakeScale2D() {
        let mtx = simd_float4x4.makeScale2D(simd_float2(2, 3))
        XCTAssertEqual(mtx[0][0], 2)
        XCTAssertEqual(mtx[1][1], 3)
        XCTAssertEqual(mtx[2][2], 1)
        XCTAssertEqual(mtx[3][3], 1)
    }

    func testMakeTranslate2D() {
        let mtx = simd_float4x4.makeTranslate2D(simd_float3(5, 10, 0))
        XCTAssertEqual(mtx[3], simd_float4(5, 10, 0, 1))
    }

    func testMakeRotate2D() {
        let mtx = simd_float4x4.makeRotate2D(piOverTwo)
        XCTAssertTrue(isFloatEqual(mtx[0][0], cos(piOverTwo)))
        XCTAssertTrue(isFloatEqual(mtx[0][1], sin(piOverTwo)))
        XCTAssertTrue(isFloatEqual(mtx[1][0], -sin(piOverTwo)))
        XCTAssertTrue(isFloatEqual(mtx[1][1], cos(piOverTwo)))
    }

    func testSetToZero() {
        var mtx = simd_float4x4(1)
        mtx.setToZero()
        for col in 0..<4 {
            for row in 0..<4 {
                XCTAssertEqual(mtx[col][row], 0)
            }
        }
    }
}

final class IntersectTests: XCTestCase {

    func testPointCircle() {
        let center = simd_float2(0, 0)
        XCTAssertTrue(Intersect.pointCircle(point: simd_float2(0, 0), circle: center, radius: 1))
        XCTAssertTrue(Intersect.pointCircle(point: simd_float2(1, 0), circle: center, radius: 1))
        XCTAssertFalse(Intersect.pointCircle(point: simd_float2(2, 0), circle: center, radius: 1))
    }

    func testPointAABB() {
        let center = simd_float2(0, 0)
        XCTAssertTrue(Intersect.pointAABB(point: simd_float2(0, 0), center: center, width: 2, height: 2))
        XCTAssertTrue(Intersect.pointAABB(point: simd_float2(1, 1), center: center, width: 2, height: 2))
        XCTAssertFalse(Intersect.pointAABB(point: simd_float2(2, 0), center: center, width: 2, height: 2))
    }

    func testCircleCircle() {
        XCTAssertTrue(Intersect.circleCircle(
            center1: simd_float2(0, 0), center2: simd_float2(1, 0), radius1: 1, radius2: 1))
        XCTAssertFalse(Intersect.circleCircle(
            center1: simd_float2(0, 0), center2: simd_float2(5, 0), radius1: 1, radius2: 1))
    }

    func testCircleAABB() {
        // Circle overlapping the AABB
        XCTAssertTrue(Intersect.circleAABB(
            circleCenter: simd_float2(1.5, 0), radius: 1,
            aabbCenter: simd_float2(0, 0), width: 2, height: 2))
        // Circle center inside the AABB
        XCTAssertTrue(Intersect.circleAABB(
            circleCenter: simd_float2(0, 0), radius: 0.5,
            aabbCenter: simd_float2(0, 0), width: 2, height: 2))
        // Circle far away
        XCTAssertFalse(Intersect.circleAABB(
            circleCenter: simd_float2(5, 0), radius: 1,
            aabbCenter: simd_float2(0, 0), width: 2, height: 2))
    }

    func testAABBvsAABB() {
        XCTAssertTrue(Intersect.aabbAABB(
            center1: simd_float2(0, 0), width1: 2, height1: 2,
            center2: simd_float2(1, 0), width2: 2, height2: 2))
        XCTAssertFalse(Intersect.aabbAABB(
            center1: simd_float2(0, 0), width1: 2, height1: 2,
            center2: simd_float2(5, 0), width2: 2, height2: 2))
    }
}
