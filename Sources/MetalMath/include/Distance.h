//
//  File.swift
//  
//
//  Created by Matt Casanova on 3/7/20.
//


#ifndef Distance_h
#define Distance_h

#import <Foundation/Foundation.h>

@class Vector2D;

@interface Distance: NSObject


+ (float) fromPoint:(const Vector2D* _Nonnull)point toCircle:(const Vector2D* _Nonnull)center withRadius:(float)radius;
+ (float) fromPoint:(const Vector2D* _Nonnull)point toAABB:(const Vector2D* _Nonnull)center withWidth:(float)width andHeight:(float)height;
+ (float) fromPoint:(const Vector2D* _Nonnull)point toLineSegmentStartingAt:(const Vector2D* _Nonnull)start andEndingAt:(const Vector2D* _Nonnull)end;
//+ (float) fromPoint:(const Vector2D* _Nonnull)point tolineWithNormal:(const Vector2D* _Nonnull)normal andPoint:(const Vector2D* _Nonnull)point;
//+ (float) fromPoint:(const Vector2D* _Nonnull)point toRay:(const Vector2D* _Nonnull)rayVector withStartingPoint:(const Vector2D* _Nonnull)point;
+ (float) fromCircle:(const Vector2D* _Nonnull)center1 withRadius:(float)radius1 toCircle:(const Vector2D* _Nonnull)center2 withRadius:(float)radius2;
+ (float) fromCircle:(const Vector2D* _Nonnull)circleCenter withRadius:(float)radius toAABB:(const Vector2D* _Nonnull)aabbCenter withWidth:(float)width andHeight:(float)height;
+ (float) fromCircle:(const Vector2D* _Nonnull)center withRadius:(float)radius toLineSegmentStartingAt:(const Vector2D* _Nonnull)start andEndingAt:(const Vector2D* _Nonnull)end;
+ (float) fromAABB:(const Vector2D* _Nonnull)center1 withWidth:(float)width1 andHeight:(float)height1 toAABB:(const Vector2D* _Nonnull)center2 withWidth:(float)width2 andHeight:(float)height2;
@end




#endif /* Distance_h */
