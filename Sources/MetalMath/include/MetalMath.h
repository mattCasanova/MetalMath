//
//  MetalMath.h
//  LiquidMetal
//
//  Created by Matt Casanova on 2/9/20.
//  Copyright © 2020 Matt Casanova. All rights reserved.
//

#ifndef MetalMath
#define MetalMath

#import <Foundation/Foundation.h>

@interface Math: NSObject

@property (class, nonatomic, readonly) float epsilon;
@property (class, nonatomic, readonly) float piOverSix;
@property (class, nonatomic, readonly) float piOverFour;
@property (class, nonatomic, readonly) float piOverThree;
@property (class, nonatomic, readonly) float piOverTwo;
@property (class, nonatomic, readonly) float pi;
@property (class, nonatomic, readonly) float twoPi;


+ (float)     toRadian:(float) degree;
+ (float)     toDegree:(float) radian;


+ (float)     floatClamp:(float)value low:(float)low high:(float)high;
+ (float)     floatWrap:(float)value low:(float)low high:(float)high;
+ (float)     floatWrapEdge:(float)value low:(float)low high:(float)high;
+ (bool)      floatIsInRange:(float)value low:(float)low high:(float)high;
+ (bool)      floatIsEqual:(float)x y:(float)y;

+ (NSInteger) intClamp:(NSInteger)value low:(NSInteger)low high:(NSInteger)high;
+ (NSInteger) intWrap:(NSInteger)value low:(NSInteger)low high:(NSInteger)high;
+ (NSInteger) intWrapEdge:(NSInteger)value low:(NSInteger)low high:(NSInteger)high;
+ (bool)      intIsInRange:(NSInteger)value low:(NSInteger)low high:(NSInteger)high;

+ (bool)      isPowerOfTwo:(NSInteger) x;
+ (NSInteger) nextPowerOfTwo:(NSInteger) x;


@end




#endif /* MetalMath */
