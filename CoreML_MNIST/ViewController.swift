//
//  ViewController.swift
//  CoreML_MNIST
//
//  Created by Pedro Velmovitsky on 18/07/17.
//  Copyright © 2017 velmovitsky. All rights reserved.
//

import UIKit
import CoreML
import Vision
import ImageIO

class ViewController: UIViewController {
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var inputImage: CIImage!
    
    
    @IBOutlet weak var tempImageView: UIImageView!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBAction func takePicture(_ sender: Any) {
    // Get image from view
        UIGraphicsBeginImageContext(tempImageView.frame.size)
        tempImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else { fatalError("no image from drawing") }
        classificationLabel.text = "Analyzing image"
        guard let ciImage = CIImage(image: img)
            else { fatalError("can't create CIImage from UIImage") }
        
//        let orientation = CGImagePropertyOrientation(rawValue: img.imageOrientation.rawValue)
        inputImage = ciImage.applyingOrientation(Int32(img.imageOrientation.rawValue))
        
        
        
        
         UIGraphicsEndImageContext()
        // MARK: Uncomment this code to save photo to photo album
        // UIImageWriteToSavedPhotosAlbum(img!, nil, nil, nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Do any additional setup after loading the view.
        tempImageView.layer.borderWidth = 1
        tempImageView.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first as? UITouch {
            lastPoint = touch.location(in: self.view)
        }
    }
    // Allow the drawing of lines in the image view
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x,y: toPoint.y))
        
        
        context!.setLineCap(CGLineCap.round)
        context!.setLineWidth(brushWidth)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
        context!.setBlendMode(CGBlendMode.normal)
        
        context!.strokePath()
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first as? UITouch {
            let currentPoint = touch.location(in: view)
            drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        
        if !swiped {
            // draw a single point
            drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
    
    


}

