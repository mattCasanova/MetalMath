import XCTest
@testable import MetalMath

final class MetalMathTests: XCTestCase {
    
    func testRadianToDegree() {
        XCTAssertEqual(Math.toDegree(2.1355), 2.1355 * 180 / Math.pi)
        XCTAssertEqual(Math.toDegree(Math.pi), Math.pi * 180 / Math.pi)
        XCTAssertEqual(Math.toDegree(Math.piOverTwo), Math.piOverTwo * 180 / Math.pi)
        XCTAssertEqual(Math.toDegree(Math.twoPi), Math.twoPi * 180 / Math.pi)
    }
    
    func testDegreeToRadian() {
        XCTAssertEqual(Math.toRadian(90), 90 * Math.pi / 180)
        XCTAssertEqual(Math.toRadian(60), 60 * Math.pi / 180)
        XCTAssertEqual(Math.toRadian(30), 30 * Math.pi / 180)
        XCTAssertEqual(Math.toRadian(15), 15 * Math.pi / 180)
    }
    
    func testRadianToDegreeAndBack() {
        let result = 2.5 * (Math.pi / 180) * (180 / Math.pi)
        
        XCTAssertEqual(Math.pi, Math.toRadian(Math.toDegree(Math.pi)))
        XCTAssertEqual(Math.piOverTwo, Math.toRadian(Math.toDegree(Math.piOverTwo)))
        XCTAssertEqual(Math.piOverSix, Math.toRadian(Math.toDegree(Math.piOverSix)))
        XCTAssertEqual(result, Math.toRadian(Math.toDegree(2.5)))
    }
    
    func testClampEdge() {
        XCTAssertEqual(Math.floatClamp(3.5, low: 1.0, high: 2.5), 2.5)
        XCTAssertEqual(Math.floatClamp(0.25, low: 1, high: 2.5), 1.0)
        XCTAssertEqual(Math.floatClamp(5.0, low: 1.25, high: 10.25), 5)
        XCTAssertEqual(Math.floatClamp(-10.0, low: -20.0, high: -15.0), -15.0)
        
        XCTAssertEqual(Math.intClamp(5, low: 1, high: 10), 5)
        XCTAssertEqual(Math.intClamp(2, low: 3, high: 4), 3)
        XCTAssertEqual(Math.intClamp(-1, low: -3, high: -2), -2)
        XCTAssertEqual(Math.intClamp(-1, low: -3, high: 3), -1)
        
    }
    
    func testWrapEdge() {
        XCTAssertEqual(Math.floatWrapEdge(3.5, low: 1.0, high: 2.5), 1.0)
        XCTAssertEqual(Math.floatWrapEdge(0.25, low: 1, high: 2.5), 2.5)
        XCTAssertEqual(Math.floatWrapEdge(5.0, low: 1.25, high: 10.25), 5)
        XCTAssertEqual(Math.floatWrapEdge(-10.0, low: -20.0, high: -15.0), -20.0)
        
        XCTAssertEqual(Math.intWrapEdge(5, low: 1, high: 10), 5)
        XCTAssertEqual(Math.intWrapEdge(2, low: 3, high: 4), 4)
        XCTAssertEqual(Math.intWrapEdge(-1, low: -3, high: -2), -3)
        XCTAssertEqual(Math.intWrapEdge(-1, low: -3, high: 3), -1)
    }
    
    func testWrap() {
        XCTAssertEqual(Math.floatWrap(3.5, low: 1.0, high: 2.5), 2.0)
        XCTAssertEqual(Math.floatWrap(0.25, low: 1, high: 2.5), 1.75)
        XCTAssertEqual(Math.floatWrap(5.0, low: 1.25, high: 10.25), 5)
        XCTAssertEqual(Math.floatWrap(-12.5, low: -20.25, high: -15.0), -17.75)
        XCTAssertEqual(Math.floatWrap(18.5, low: 5.5, high: 10.5), 8.5)
        
        XCTAssertEqual(Math.intWrap(5, low: 1, high: 10), 5)
        XCTAssertEqual(Math.intWrap(2, low: 3, high: 5), 4)
        XCTAssertEqual(Math.intWrap(-1, low: -7, high: -2), -6)
        XCTAssertEqual(Math.intWrap(-1, low: -3, high: 3), -1)
        XCTAssertEqual(Math.intWrap(18, low: 5, high: 10), 8)
    }
    
    func testIsInRange() {
        XCTAssertEqual(Math.floatis(inRangeFloat: 3.5, low: 1.0, high: 2.5), false)
        XCTAssertEqual(Math.is(inRangeFloat: 1.5, low: 1.0, high: 2.5), true)
        XCTAssertEqual(Math.is(inRangeFloat: 1.0, low: 1.0, high: 2.5), true)
        XCTAssertEqual(Math.is(inRangeFloat: 2.5, low: 1.0, high: 2.5), true)
        XCTAssertEqual(Math.is(inRangeFloat: 3.5, low: 1.0, high: 2.5), false)
        
        XCTAssertEqual(Math.is(inRangeInt: 1, low: 0, high: 20), true)
        XCTAssertEqual(Math.is(inRangeInt: 21, low: 0, high: 20), false)
        XCTAssertEqual(Math.is(inRangeInt: -1, low: 0, high: 20), false)
        XCTAssertEqual(Math.is(inRangeInt: 0, low: 0, high: 20), true)
        XCTAssertEqual(Math.is(inRangeInt: 20, low: 0, high: 20), true)
    }
    
    func testIsEqual() {
        XCTAssertEqual(Math.isEqualFloat(<#T##x: Float##Float#>, y: <#T##Float#>)(1.0, 1.001), false)
        XCTAssertEqual(isFloatEqual(1.00001, 1.0), false)
        XCTAssertEqual(isFloatEqual(1.0000099, 1.0), true)
        
        XCTAssertEqual(isFloatEqual(254.55555, 254.555551), true)
        XCTAssertEqual(isFloatEqual(254.55555, 254.55554), false)
    }
    /*
     
     func testIsPowerOfTwo() {
     XCTAssertTrue(isPowerOfTwo(2))
     XCTAssertTrue(isPowerOfTwo(16))
     XCTAssertTrue(isPowerOfTwo(64))
     XCTAssertTrue(isPowerOfTwo(2048))
     XCTAssertTrue(isPowerOfTwo(4096))
     XCTAssertTrue(isPowerOfTwo(8192))
     
     XCTAssertFalse(isPowerOfTwo(-2))
     XCTAssertFalse(isPowerOfTwo(3))
     XCTAssertFalse(isPowerOfTwo(6))
     XCTAssertFalse(isPowerOfTwo(-0))
     XCTAssertFalse(isPowerOfTwo(8191))
     XCTAssertFalse(isPowerOfTwo(4095))
     }
     
     func testNextPowerOfTwo() {
     XCTAssertEqual(nextPowerOfTwo(2), 4)
     XCTAssertEqual(nextPowerOfTwo(3), 4)
     XCTAssertEqual(nextPowerOfTwo(4), 8)
     XCTAssertEqual(nextPowerOfTwo(5), 8)
     XCTAssertEqual(nextPowerOfTwo(6), 8)
     XCTAssertEqual(nextPowerOfTwo(7), 8)
     XCTAssertEqual(nextPowerOfTwo(8), 16)
     
     let max32 = (1 << 32)
     XCTAssertEqual(nextPowerOfTwo(max32 - 5), max32)
     
     let max33 = (1 << 33)
     XCTAssertEqual(nextPowerOfTwo(max33 - 10), max33)
     }
     
     */
    
    static var allTests = [
        ("testRadianToDegree", testRadianToDegree),
        ("testDegreeToRadian", testDegreeToRadian),
        ("testRadianToDegreeAndBack", testRadianToDegreeAndBack),
        ("testClampEdge", testClampEdge),
        ("testWrapEdge", testWrapEdge),
        ("testWrap", testWrap),
        ("testIsInRange", testIsInRange),
    ]
}
