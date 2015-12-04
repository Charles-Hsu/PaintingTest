//
//  DrawingLineView.swift
//  PaintingTest
//
//  Created by Charles Hsu on 12/2/15.
//  Copyright © 2015 Rodrigo Pélissier. All rights reserved.
//

import UIKit


let kDefaultLineColor = UIColor.redColor()
let kDefaultLineWidth: CGFloat = 10.0
let kDefaultLineAlpha: CGFloat = 1.0

class DrawingLineView: UIView
{
    var lineColor: UIColor!
    var lineWidth: CGFloat!
    var lineAlpha: CGFloat!
    
    var originalFrameYPos: CGFloat!

    var image: UIImage!
    var backgroundImage: UIImage!
    var undoSteps: Int!
    
    private var currentPoint: CGPoint!
    private var previousPoint1: CGPoint!
    private var previousPoint2: CGPoint!
    
    private var currentTool: DrawingLineTool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }

    func loadImage(image: UIImage)
    {
        
    }
    
    func loadImageData(imageData: NSData)
    {
        
    }
    
    func clear()
    {
        
    }
    
    func canUndo() -> Bool {
        return true
    }
    
    func undoLastestStep()
    {
        
    }
    
    func canRedo() -> Bool
    {
        return true
    }
    
    func redoLatestStep()
    {
        
    }
    
    func commitAdnDiscardToolStack()
    {
        
    }
    
    func configure()
    {
        print("\(__FUNCTION__)")

        self.backgroundColor = UIColor.clearColor()
        self.originalFrameYPos = self.frame.origin.y;
        
        self.lineColor = UIColor.whiteColor()
        self.lineWidth = 10.0
        self.lineAlpha = 1.0

    }

    func prev_image() -> UIImage
    {
        return self.backgroundImage
    }

    func setPrev_image(prev_image: UIImage)
    {
        self.backgroundImage = prev_image
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        if let currentTool = self.currentTool {
            currentTool.draw()
        }
    }

    func updateCacheImage(redraw: Bool)
    {
        
        print(bounds.size)
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        
        if redraw {
            
        }
        else {
            if let image = self.image {
                image.drawAtPoint(CGPoint.zero)
            }
            self.currentTool?.draw()
        }
        
        // store the image
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        
        
        UIGraphicsEndImageContext()
    }
    
    func finishDrawing()
    {
        self.setNeedsDisplay()
    
        // update the image
        self.updateCacheImage(false)
        
        // clear the redo queue
//        [self.bufferArray removeAllObjects];
        
        // call the delegate
        
        //    if ([self.delegate respondsToSelector:@selector(drawingView:didEndDrawUsingTool:)]) {
        //        NSLog(@"%@", self.delegate);
        //        [self.delegate drawingView:self didEndDrawUsingTool:self.currentTool];
        //    }
        
        // clear the current tool
        //self.currentTool = nil
    }

    // MARK: - Touch Methods
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        
        print("\(__FUNCTION__)")
        
        // add the first touch
        let touch = touches.first
        previousPoint1 = touch!.previousLocationInView(self)
        currentPoint = touch!.locationInView(self)
        
        // init the bezier path
        self.currentTool = DrawingLineTool()
        self.currentTool!.lineWidth = kDefaultLineWidth
        self.currentTool!.lineColor = kDefaultLineColor
        self.currentTool!.lineAlpha = kDefaultLineAlpha
        
//        [self.pathArray addObject:self.currentTool];
        self.currentTool!.setInitialPoint(currentPoint)
        
        // call the delegate
//        if ([self.delegate respondsToSelector:@selector(drawingView:willBeginDrawUsingTool:)]) {
//            [self.delegate drawingView:self willBeginDrawUsingTool:self.currentTool];
//        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        // save all the touches in the path
        let touch = touches.first
        
        previousPoint2 = previousPoint1;
        previousPoint1 = touch!.previousLocationInView(self)
        currentPoint = touch!.locationInView(self)
        
        self.currentTool!.moveFromPoint(previousPoint1, toPoint: currentPoint)
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        // make sure a point is recorded
        self.touchesMoved(touches, withEvent: event)
        self.finishDrawing()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?)
    {
        // make sure a point is recorded
        self.touchesEnded(touches!, withEvent: event)
    }
    
}
