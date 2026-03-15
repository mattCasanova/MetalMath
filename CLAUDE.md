# MetalMath

Swift math library providing SIMD vector/matrix extensions and collision detection for Metal-based 2D game engines.

## Project Overview

- **Language:** Swift (migrated from Objective-C in April 2020)
- **Package Manager:** Swift Package Manager
- **Dependencies:** None (leaf dependency)
- **Consumers:** [LiquidMetal2D](https://github.com/mattCasanova/LiquidMetal2D) game engine

## What's In It

- **Math utilities** (`Math.swift`) — constants (pi, epsilon), clamp, wrap, degree/radian conversion, power-of-two checks
- **SIMD extensions** (`extensions/`) — helpers on `simd_float2`, `simd_float3`, `simd_float4`, `simd_float4x4` (2D transforms, perspective projection)
- **Intersection testing** (`Intersect.swift`) — point/circle/AABB/line segment collision detection
- **Circle protocol** (`shapes/Circle.swift`)

## Build & Test

```bash
swift build
swift test
```

## Known Issues

- `swift-tools-version` is 5.1, needs bumping to 6.0 for modern Swift
- Tests reference a deleted `FFLoat2` type (leftover from when custom types were split to MetalTypes, then replaced by SIMD). Tests won't compile until this is cleaned up.

## History

Originally contained custom Vector2D/Vector3D/Transform2D types. In April 2020, those were split to a separate MetalTypes repo, then MetalMath was refactored to use Apple's built-in SIMD types instead. MetalTypes is now unused and can be ignored.
