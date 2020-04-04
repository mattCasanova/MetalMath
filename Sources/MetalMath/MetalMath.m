//
//  GameMath.m
//  LiquidMetal
//
//  Created by Matt Casanova on 2/9/20.
//  Copyright © 2020 Matt Casanova. All rights reserved.
//

#import "MetalMath.h"

@implementation Math

static const float EPSILON              = 0.00001f;
static const float PI                   = 3.14159265358979f;
static const float PI_OVER_SIX          = PI / 6;
static const float PI_OVER_FOUR         = PI / 4;
static const float PI_OVER_THREE        = PI / 3;
static const float PI_OVER_TWO          = 1.5707963267949f;
static const float TWO_PI               = 6.28318530717959f;

static const float TO_RADIAN_CONVERSION = PI / 180;
static const float TO_DEGREE_CONVERSION = 180 / PI;

/*! The smallest value between two floats*/
+ (float) epsilon     { return EPSILON;       }

+ (float) pi          { return PI;            }
+ (float) piOverSix   { return PI_OVER_SIX;   }
+ (float) piOverFour  { return PI_OVER_FOUR;  }
+ (float) piOverThree { return PI_OVER_THREE; }
+ (float) piOverTwo   { return PI_OVER_TWO;   }
+ (float) twoPi       { return TWO_PI;        }


/*! The conversion factor of degree to Radian*/
+ (float) toRadian:(float) degree { return degree * TO_RADIAN_CONVERSION; }
/*! The conversion factor of radian to degree*/
+ (float) toDegree:(float) radian { return radian * TO_DEGREE_CONVERSION; }

/******************************************************************************/
/*!
  If x is smaller than low, x equals low. If x is larger than high, x equals
  high. Otherwise x is unchanged.
   
  \param value
  The value to clamp.
   
  \param low
  The lowest possible value to clamp to.
   
  \param high
  The highest possible value to clamp to.
   
  \return
  A number between low and high (inclusive).
*/
/******************************************************************************/
+ (float) floatClamp:(float)value low:(float)low high:(float)high {
    if (value < low)
        return low;
    else if (value > high)
        return high;
    
    return value;
}
/******************************************************************************/
/*!
 Wraps the given value around the range from low to high. Will wrap
 multiple times if needed.
 
 \param value
 The value to wrap.
 
 \param low
 The lowest possible value to wrap.
 
 \param high
 The highest possible value to wrap.
 
 \return
 A number between low and high (inclusive).
 */
/******************************************************************************/
+ (float) floatWrap:(float)value low:(float)low high:(float)high {
    if (value < low)
        return [Math floatWrap:(high + value - low) low:low high:high];
    else if (value > high)
        return [Math floatWrap:(low + value - high) low:low high:high];
    
    return value;
}
/******************************************************************************/
/*!
 If x is lower than low, x is set to high. If x is higher than high, x is
 set to low.  Otherwise x is unchanged.
 
 \param value
 The value to wrap.
 
 \param low
 The lowest possible value to wrap.
 
 \param high
 The highest possible value to wrap.
 
 \return
 A number between low and high (inclusive).
 */
/******************************************************************************/
+ (float) floatWrapEdge:(float)value low:(float)low high:(float)high {
    if (value < low)
        return high;
    else if (value > high)
        return low;
    
    return value;
}
/******************************************************************************/
/*!
 Returns true if x is in the range of low and high (inclusive).
 
 \param value
 The number to check.
 
 \param low
 The lowest number in the range.
 
 \param high
 The highest number in the range.
 
 \return
 True if x is in the range, false otherwise.
 */
/******************************************************************************/
+ (bool) floatIsInRange:(float)value low:(float)low high:(float)high {
    return (value >= low && value <= high);
}
/******************************************************************************/
/*!
 Tests if two variables are equal within an EPSILON value.
 
 \param x
 The first number to check.
 
 \param y
 The second number to check.
 
 \return
 True if the values are equal within EPSILON, false otherwise.
 */
/******************************************************************************/
+ (bool) floatIsEqual:(float)x y:(float)y {
    return (fabsf(x - y) < Math.epsilon);
}
/******************************************************************************/
/*!
  If x is smaller than low, x equals low. If x is larger than high, x equals
  high. Otherwise x is unchanged.
   
  \param value
  The value to clamp.
   
  \param low
  The lowest possible value to clamp to.
   
  \param high
  The highest possible value to clamp to.
   
  \return
  A number between low and high (inclusive).
*/
/******************************************************************************/
+ (NSInteger) intClamp:(NSInteger)value low:(NSInteger)low high:(NSInteger)high {
    if (value < low)
        return low;
    else if (value > high)
        return high;

    return value;
}
/******************************************************************************/
/*!
 Wraps the given value around the range from low to high. Will wrap
 multiple times if needed.
 
 \param value
 The value to wrap.
 
 \param low
 The lowest possible value to wrap.
 
 \param high
 The highest possible value to wrap.
 
 \return
 A number between low and high (inclusive).
 */
/******************************************************************************/
+ (NSInteger) intWrap:(NSInteger)value low:(NSInteger)low high:(NSInteger)high {
    if (value < low)
        return [Math intWrap:(high + value - low) low:low high:high];
    else if (value > high)
        return [Math intWrap:(low + value - high) low:low high:high];
    
    return value;
}
/******************************************************************************/
/*!
 If x is lower than low, x is set to high. If x is higher than high, x is
 set to low.  Otherwise x is unchanged.
 
 \param value
 The value to wrap.
 
 \param low
 The lowest possible value to wrap.
 
 \param high
 The highest possible value to wrap.
 
 \return
 A number between low and high (inclusive).
 */
/******************************************************************************/
+ (NSInteger) intWrapEdge:(NSInteger)value low:(NSInteger)low high:(NSInteger)high {
    if (value < low)
        return high;
    else if (value > high)
        return low;
    
    return value;
}
/******************************************************************************/
/*!
 Returns true if x is in the range of low and high (inclusive).
 
 \param value
 The number to check.
 
 \param low
 The lowest number in the range.
 
 \param high
 The highest number in the range.
 
 \return
 True if x is in the range, false otherwise.
 */
/******************************************************************************/
+ (bool) intIsInRange:(NSInteger)value low:(NSInteger)low high:(NSInteger)high {
    return (value >= low && value <= high);
}
/******************************************************************************/
/*!
 Test if a given integer is a power of two or not. This only works for positive
 non zero numbers.
 
 \param x
 The number to check.
 
 \return
 True if the number is a power of two.  false otherwise.
 */
/******************************************************************************/
+ (bool) isPowerOfTwo:(NSInteger) x {
    /*make sure it is a positive number
     Then, since a power of two only has one bit turned on, if we subtract 1 and
     then and them together no bits should be turned on.*/
    return ((x > 0) && !(x & (x - 1)));
}
/******************************************************************************/
/*!
 Given a number x.  This function will return the next largest power of two.
 
 \param x
 The number to get the next largest power of two.
 
 \return
 The next largest power of two.
 */
/******************************************************************************/
+ (NSInteger) nextPowerOfTwo:(NSInteger) x {
    /*Turn on all of the bits lower than the highest on bit.  Then add one.  It
     will be a power of two.*/
    /*--x;*/
    x |= x >> 1;
    x |= x >> 2;
    x |= x >> 4;
    x |= x >> 8;
    x |= x >> 16;
    ++x;
    return x;
}



@end
