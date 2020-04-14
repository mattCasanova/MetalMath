//
//  File.swift
//  
//
//  Created by Matt Casanova on 4/13/20.
//

import simd

public extension simd_float3 {
    var r: Float {
        get { x }
        set { x = newValue }
    }
    var g: Float {
        get { y }
        set { y = newValue }
    }
    var b: Float {
        get { z }
        set { x = newValue }
    }
    
    mutating func set(_ x: Float = 0, _ y: Float = 0, _ z: Float = 0) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    mutating func set(r: Float, g: Float, b: Float) {
        self.x = r
        self.y = g
        self.z = b
    }
    
    mutating func set(repeating: Float) {
           self.x = repeating
           self.y = repeating
           self.z = repeating
       }
}

public func simd_epsilon_equal(lhs: simd_float3, rhs: simd_float3) -> Bool {
    let diff = simd_abs(lhs - rhs)
    return diff.x < epsilon && diff.y < epsilon && diff.z < epsilon
}
