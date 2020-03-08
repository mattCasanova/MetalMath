//
//  File.swift
//  
//
//  Created by Matt Casanova on 3/8/20.
//

#import "Intersect.h"
#import "Vector2D.h"
#import "GameMath.h"

#import <GLKit/GLKMath.h>


@implementation Intersect

+ (bool) point:(const Vector2D* _Nonnull)point vsCircle:(const Vector2D* _Nonnull)center withRadius:(float)radius {
  return [point distanceSquaredTo:center] - (radius * radius) <= GameMath.epsilon;
}

+ (bool) point:(const Vector2D* _Nonnull)point vsAABB:(const Vector2D* _Nonnull)center withWidth:(float)width andHeight:(float)height {
  float halfWidth = width / 2.f;
  float halfHeight = height / 2.f;
  
  //Move point into AABB space, ie, treat aabb as if it were at the origin
  Vector2D* pointInAABBSpace = [point subtract:center];
  
  //If the new point is inside the rect, it is intersecting
  return pointInAABBSpace.x > -halfWidth && pointInAABBSpace.x < halfWidth && pointInAABBSpace.y > -halfHeight && pointInAABBSpace.y < halfHeight;
}

+ (bool) point:(const Vector2D* _Nonnull)point vsLineSegmentStartingAt:(const Vector2D* _Nonnull)start andEndingAt:(const Vector2D* _Nonnull)end {
  
  Vector2D* lineVector = [end subtract:start];
  Vector2D* pointToLineVector = [point subtract:start];
  
  float crossZ = [lineVector crossZ:pointToLineVector];
  
  if (crossZ > GameMath.epsilon)
    return false;
  
  Vector2D* normalizedLineVector = [lineVector normalize];
  
  float projectedLength = [pointToLineVector dot:normalizedLineVector];
  return projectedLength < 0 || (projectedLength * projectedLength) > lineVector.lengthSquared;
}

+ (bool) circle:(const Vector2D* _Nonnull)center1 withRadius:(float)radius1 vsCircle:(const Vector2D* _Nonnull)center2 withRadius:(float)radius2 {
  return [Intersect point:center1 vsCircle:center2 withRadius:radius1 + radius2];
}

+ (bool) circle:(const Vector2D* _Nonnull)circleCenter withRadius:(float)radius vsAABB:(const Vector2D* _Nonnull)aabbCenter withWidth:(float)width andHeight:(float)height {
  /* We are given full width and height, but we only need half width/height */
  float halfWidth = width / 2.0f;
  float halfHeight = height / 2.0f;
  
  /* Move the point into AABB space.  Shift the point and it likethe AABB is at the origin
   * This way the the calculation only needs half size and no offsets
   */
  Vector2D* pointInAABBSpace = [circleCenter subtract:aabbCenter];
  
  /* Find the closest point on the rect */
  Vector2D* closestPointOnAABB = [[Vector2D alloc] init];
  closestPointOnAABB.x = [GameMath clampFloat:pointInAABBSpace.x betweenLow:-halfWidth andHigh:halfWidth];
  closestPointOnAABB.y = [GameMath clampFloat:pointInAABBSpace.y betweenLow:-halfHeight andHigh:halfHeight];
  
  /* Check if we are in the AABB */
  if (pointInAABBSpace.x < halfWidth && pointInAABBSpace.x > -halfWidth && pointInAABBSpace.y < halfHeight && pointInAABBSpace.y > -halfHeight) {
    return true;
  }
  
  float distanceSquared = [pointInAABBSpace distanceSquaredTo:closestPointOnAABB];
  return distanceSquared < (radius * radius);
}

+ (bool) circle:(const Vector2D* _Nonnull)center withRadius:(float)radius vsLineSegmentStartingAt:(const Vector2D* _Nonnull)start andEndingAt:(const Vector2D* _Nonnull)end {
  
  Vector2D* lineVector = [end subtract:start];
  Vector2D* pointToLineVector = [center subtract:start];
  
  Vector2D* normalizedLineVector = [lineVector normalize];
  
  float projectedLength = [pointToLineVector dot:normalizedLineVector];
  
  float startCheckLength = projectedLength + radius;
  float endCheckLength = projectedLength - radius;
  
  if (startCheckLength < 0 || (endCheckLength * endCheckLength) > lineVector.lengthSquared) {
    return false;
  }
  
  float pointToLineLengthSquared = [pointToLineVector lengthSquared];
  
  //Use pathagorean theorem to get length of third side and compare with radius
  return pointToLineLengthSquared - (projectedLength * projectedLength) < (radius * radius);
}

+ (bool) aabb:(const Vector2D* _Nonnull)center1 withWidth:(float)width1 andHeight:(float)height1 vsAABB:(const Vector2D* _Nonnull)center2 withWidth:(float)width2 andHeight:(float)height2 {
  return [Intersect point:center1 vsAABB:center2 withWidth:width1 + width2 andHeight:height1 + height2];
}

@end
