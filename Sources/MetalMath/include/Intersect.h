//
//  File.swift
//  
//
//  Created by Matt Casanova on 3/8/20.
//

#ifndef Intersect_h
#define Intersect_h

#import <Foundation/Foundation.h>

@class Vector2D;

@interface Intersect: NSObject


+ (bool) point:(const Vector2D* _Nonnull)point vsCircle:(const Vector2D* _Nonnull)center withRadius:(float)radius;
+ (bool) point:(const Vector2D* _Nonnull)point vsAABB:(const Vector2D* _Nonnull)center withWidth:(float)width andHeight:(float)height;
+ (bool) point:(const Vector2D* _Nonnull)point vsLineSegmentStartingAt:(const Vector2D* _Nonnull)start andEndingAt:(const Vector2D* _Nonnull)end;
//+ (bool) doesPoint:(const Vector2D* _Nonnull)point andLineWithNormal:(const Vector2D* _Nonnull)normal andPoint:(const Vector2D* _Nonnull)point;
//+ (bool) doesPoint:(const Vector2D* _Nonnull)point andRay:(const Vector2D* _Nonnull)rayVector withStartingPoint:(const Vector2D* _Nonnull)point;
+ (bool) circle:(const Vector2D* _Nonnull)center1 withRadius:(float)radius1 vsCircle:(const Vector2D* _Nonnull)center2 withRadius:(float)radius2;
+ (bool) circle:(const Vector2D* _Nonnull)circleCenter withRadius:(float)radius vsAABB:(const Vector2D* _Nonnull)aabbCenter withWidth:(float)width andHeight:(float)height;
+ (bool) circle:(const Vector2D* _Nonnull)center withRadius:(float)radius vsLineSegmentStartingAt:(const Vector2D* _Nonnull)start andEndingAt:(const Vector2D* _Nonnull)end;
+ (bool) aabb:(const Vector2D* _Nonnull)center1 withWidth:(float)width1 andHeight:(float)height1 vsAABB:(const Vector2D* _Nonnull)center2 withWidth:(float)width2 andHeight:(float)height2;
@end




#endif /* Intersect_h */
