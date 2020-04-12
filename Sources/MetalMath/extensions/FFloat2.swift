//
//  File.swift
//  
//
//  Created by Matt Casanova on 4/7/20.
//

import simd
public struct FFLoat2 {
    public let data: simd_float2
    
    public init() {
        data = simd_float2()
    }
    
    public init(x: Float, y: Float) {
        data = simd_float2(x, y)
    }
    
    public var length: Float { get { simd_length(data) } }
    
    public func project(vec: FFLoat2) -> FFLoat2 {
        let n = simd_project(data, vec.data)
        return FFLoat2(x: n.x, y: n.y)
    }
    
    public func distanceSquared(p: FFLoat2) -> Float {
        return simd_length_squared(data - p.data)
    }
}

public extension simd_float2 {
    var length: Float { get { simd_length(self) } }
    
    func project(vec: simd_float2) -> simd_float2 {
        return simd_project(self, vec)
    }
    
    func distanceSquared(p: simd_float2) -> Float {
        return simd_length_squared(self - p)
    }
    
}

