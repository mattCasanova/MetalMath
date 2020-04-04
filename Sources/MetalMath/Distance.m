//
//  File.swift
//  
//
//  Created by Matt Casanova on 3/8/20.
//

#import "Distance.h"
#import "Vector2D.h"
#import "MetalMath.h"

#import <GLKit/GLKMath.h>


@implementation Distance

+ (float) fromPoint:(const Vector2D* _Nonnull)point toCircle:(const Vector2D* _Nonnull)center withRadius:(float)radius {
  return [point distanceTo:center] - radius;
}

+ (float) fromPoint:(const Vector2D* _Nonnull)point toAABB:(const Vector2D* _Nonnull)center withWidth:(float)width andHeight:(float)height {
  /* We are given full width and height, but we only need half width/height */
  float halfWidth = width / 2.0f;
  float halfHeight = height / 2.0f;
  
  /* Move the point into AABB space.  Shift the point and it likethe AABB is at the origin
   * This way the the calculation only needs half size and no offsets
   */
  
  Vector2D* pointInAABBSpace = [point subtract:center];
  
  /* Find the closest point on the rect */
  Vector2D* closestPointOnAABB = [[Vector2D alloc] init];
  closestPointOnAABB.x = [Math floatClamp:pointInAABBSpace.x low:-halfWidth high:halfWidth];
  closestPointOnAABB.y = [Math floatClamp:pointInAABBSpace.y low:-halfHeight high:halfHeight];
  
  float distance = [pointInAABBSpace distanceTo:closestPointOnAABB];
  
  /* Check if we are in the AABB */
  if (pointInAABBSpace.x < halfWidth && pointInAABBSpace.x > -halfWidth && pointInAABBSpace.y < halfHeight && pointInAABBSpace.y > -halfHeight) {
    distance *= -1;
  }
  
  return distance;
  
}

+ (float) fromPoint:(const Vector2D* _Nonnull)point toLineSegmentStartingAt:(const Vector2D* _Nonnull)start andEndingAt:(const Vector2D* _Nonnull)end {
  
  Vector2D* lineVector = [end subtract:start];
  Vector2D* vectorToPoint = [point subtract:start];
  
  float lineLengthSquared = lineVector.lengthSquared;
  
  //If the line length is very small, we consider it a point
  if (lineLengthSquared <= (Math.epsilon * Math.epsilon))
    return [vectorToPoint length];
  
  
  //If the line is more than a point, we project the point onto the line, and get length of projected vector
  Vector2D* normalizedLineVector = [lineVector normalize];
  
  float projectedLength = [vectorToPoint dot:normalizedLineVector];
  
  //Check if the closest point is the start (projected length is negative) or end (longer than lineLength_
  if (projectedLength <= 0.f)
    return [vectorToPoint length];
  else if (projectedLength * projectedLength >= lineLengthSquared)
    return [point distanceTo:end];
  
  //If we are here, the point is within the line segment, so use pythagorean theorem to get unknown side of the triange
  float distanceToLineSquared = [vectorToPoint lengthSquared] - (projectedLength * projectedLength);
  
  //Account for floating point error
  if (distanceToLineSquared < 0.f || fabsf(distanceToLineSquared) <= Math.epsilon)
    return 0.f;
  
  return sqrtf(distanceToLineSquared);
}

+ (float) fromCircle:(const Vector2D* _Nonnull)center1 withRadius:(float)radius1 toCircle:(const Vector2D* _Nonnull)center2 withRadius:(float)radius2 {
  return [Distance fromPoint:center1 toCircle:center1 withRadius:radius1 + radius2];
}

+ (float) fromCircle:(const Vector2D* _Nonnull)circleCenter withRadius:(float)radius toAABB:(const Vector2D* _Nonnull)aabbCenter withWidth:(float)width andHeight:(float)height {
  return [Distance fromPoint:circleCenter toAABB:aabbCenter withWidth:width andHeight:height] - radius;
}

+ (float) fromCircle:(const Vector2D* _Nonnull)center withRadius:(float)radius toLineSegmentStartingAt:(const Vector2D* _Nonnull)start andEndingAt:(const Vector2D* _Nonnull)end {
  return [Distance fromPoint:center toLineSegmentStartingAt:start andEndingAt:end] - radius;
}

+ (float) fromAABB:(const Vector2D* _Nonnull)center1 withWidth:(float)width1 andHeight:(float)height1 toAABB:(const Vector2D* _Nonnull)center2 withWidth:(float)width2 andHeight:(float)height2 {
  return [Distance fromPoint:center1 toAABB:center2 withWidth:width1 + width2 andHeight:height1 + height2];
}

@end
