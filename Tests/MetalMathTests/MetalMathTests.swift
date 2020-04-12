import XCTest

//@testable import MetalTypes
@testable import MetalMath


final class MetalMathTests: XCTestCase {
    func test() {
        let max = 30_000_000
        
        /*
        timeIt(name: "GL") {
            let vector1 = Vector2D(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            let vector2 = Vector2D(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            
            for _ in 0..<max {
                let v = vector1.projectOn(to: vector2)
                
                if (v.length == vector1.length) {
                    print("Same")
                }
            }
        }*/
        
        timeIt(name: "SIMD Vec") {
            let first = FFLoat2(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            let second = FFLoat2(x: Float.random(in: 0...1), y: Float.random(in: 0...1))
            
            for _ in 0..<max {
                let v = first.project(vec: second)
                
                if (v.length == first.length) {
                    print("Same")
                }
            }
        }
        
        
    }
    
    static var allTests = [
        ("test", test),
    ]
}

func timeIt(name: String, _ exec: () -> Void) {
    print(name)
    let start = CACurrentMediaTime()
    
    exec()
    
    let end = CACurrentMediaTime()
    print(end - start)
    print()
}
