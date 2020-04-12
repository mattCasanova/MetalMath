//
//  Intersect.swift
//  
//
//  Created by Matt Casanova on 4/4/20.
//

import MetalTypes

public class Intersect {
    /**
     
     */
    public static func pointCircle(point: Vector2D, circle: Vector2D, radius: Float) -> Bool {
        return point.distanceSquared(to: circle) - (radius * radius) < epsilon
    }
    /**
     
     */
    public static func pointAABB(point: Vector2D, center: Vector2D, width: Float, height: Float) -> Bool {
        let halfWidth = width / 2
        let halfHeight = height / 2
        
        //Move point into AABB space, ie, treat aabb as if it were at the origin
        let adjustedPoint = point - center
        
        //If the new point is inside the rect, it is intersecting
        return adjustedPoint.x > -halfWidth &&
            adjustedPoint.x < halfWidth &&
            adjustedPoint.y > -halfHeight &&
            adjustedPoint.y < halfHeight
    }
    /**
     
     */
    public static func pointLineSegment(point: Vector2D, start: Vector2D, end: Vector2D) -> Bool {
        let lineVector = end - start
        let pointLineVector = point - start
        
        //If the sin of the angle between the two vectors in greater than zero, we know the point isn't on the line
        if abs(lineVector.crossZ(pointLineVector)) > epsilon{
            return false
        }
        
        let projectedLength = pointLineVector.dot(lineVector.normalize())
        return projectedLength > 0 && (projectedLength*projectedLength) <= lineVector.lengthSquared
    }
    /**
     
     */
    public static func circleCircle(center1: Vector2D, center2: Vector2D, radius1: Float, radius2: Float) -> Bool {
        return pointCircle(point: center1, circle: center2, radius: radius1 + radius2)
    }
    /**
     
     */
    public static func circleAABB(circleCenter: Vector2D, radius: Float, aabbCenter: Vector2D, width: Float, height: Float) -> Bool {
        /* We are given full width and height, but we only need half width/height */
        let halfWidth = width / 2
        let halfHeight = height / 2
        
        /* Move the point into AABB space.  Shift the point and it likethe AABB is at the origin
         * This way the the calculation only needs half size and no offsets
         */
        let adjustedPoint = circleCenter - aabbCenter
        
        /* Find the closest point on the rect */
        let closestPoint = Vector2D(
            clamp(value: adjustedPoint.x, low: -halfWidth, high: halfWidth),
            clamp(value: adjustedPoint.y, low: -halfHeight, high: halfHeight)
        )
        
        if adjustedPoint.x < halfWidth &&
            adjustedPoint.x > -halfWidth &&
            adjustedPoint.y < halfHeight &&
            adjustedPoint.y > -halfHeight {
            
            return true
        }
        
        return adjustedPoint.distanceSquared(to: closestPoint) < (radius*radius)
    }
    /**
     
     */
    public static func circleLineSegment(center: Vector2D, radius: Float, start: Vector2D, end: Vector2D) -> Bool {
        let lineVector = end - start
        let pointLineVector = center - start
        
        let projectedLength = pointLineVector.dot(lineVector.normalize())
        
        let adjustedStartLength = projectedLength + radius
        let adjustedEndLength = projectedLength - radius
        
        if adjustedStartLength < 0 || (adjustedEndLength*adjustedEndLength) > lineVector.lengthSquared {
            return false
        }
        
        let pointLineLengthSquared = pointLineVector.lengthSquared
        
        //Use pathagorean theorem to get length of third side and compare with radius
        return (pointLineLengthSquared - (projectedLength*projectedLength)) < (radius*radius)
    }
    /**
     
     */
    public static func aabbAABB(center1: Vector2D, width1: Float, height1: Float, center2: Vector2D, width2: Float, height2: Float) -> Bool {
        return Intersect.pointAABB(point: center1, center: center2, width: width1 + width2, height: height1 + height2)
    }
    
}
