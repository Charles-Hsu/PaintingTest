//
//  DrawingLineTool.swift
//  PaintingTest
//
//  Created by Charles Hsu on 12/2/15.
//  Copyright © 2015 Rodrigo Pélissier. All rights reserved.
//

import UIKit

class DrawingLineTool: NSObject
{
    var lineColor = UIColor.blackColor()
    var lineAlpha: CGFloat! = 1.0
    var lineWidth: CGFloat! = 3.0
    
    private var firstPoint: CGPoint!
    private var lastPoint: CGPoint!

    func setInitialPoint(firstPoint: CGPoint)
    {
        self.firstPoint = firstPoint
    }
    
    func moveFromPoint(startPoint: CGPoint, toPoint endPoint: CGPoint)
    {
        self.lastPoint = endPoint
    }
    
    func draw()
    {
        let c = UIGraphicsGetCurrentContext()
        
        // set the line properties
        CGContextSetStrokeColorWithColor(c, self.lineColor.CGColor)
        CGContextSetLineCap(c, CGLineCap.Round)
        CGContextSetLineWidth(c, self.lineWidth)
        CGContextSetAlpha(c, self.lineAlpha)
        
        // draw the line
        CGContextMoveToPoint(c, self.firstPoint.x, self.firstPoint.y)
        CGContextAddLineToPoint(c, self.lastPoint.x, self.lastPoint.y)
        CGContextStrokePath(c)
    }
}
