//
//  File.swift
//  
//
//  Created by Matt Casanova on 4/7/20.
//

import simd

public extension simd_float2 {
    var angle: Float { get { atan2(y, x) } }
    var u: Float {
        get { x }
        set { x = newValue }
    }
    var v: Float {
        get { y }
        set { y = newValue }
    }
    
    init(angle: Float) {
        self.init(cos(angle), sin(angle))
    }
    
    init(simd3: simd_float3) {
        self.init(simd3.x, simd3.y)
    }
    
    mutating func set(_ x: Float = 0, _ y: Float = 0) {
        self.x = x
        self.y = y
    }
    
    mutating func set(u: Float, v: Float) {
         self.x = u
         self.y = v
     }
    
    mutating func set(angle: Float) {
        self.x = cos(angle)
        self.y = sin(angle)
    }
    
    mutating func set(repeating: Float) {
          self.x = repeating
          self.y = repeating
      }
    
    func to3D(_ z: Float = 0) -> simd_float3 {
        return simd_float3(x, y, z)
    }
    
    func to4D(z: Float, w: Float) -> simd_float4 {
        return simd_float4(x, y, z, w)
    }
    
}


public func simd_epsilon_equal(lhs: simd_float2, rhs: simd_float2) -> Bool {
    let diff = simd_abs(lhs - rhs)
    return diff.x < epsilon && diff.y < epsilon
}

