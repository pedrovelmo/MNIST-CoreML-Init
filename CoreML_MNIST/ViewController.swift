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
        
        let orientation = CGImagePropertyOrientation(rawValue: UInt32(img.imageOrientation.rawValue))
        inputImage = ciImage.applyingOrientation((orientation?.rawValue as? Int32)!)
        
         UIGraphicsEndImageContext()
        // MARK: Uncomment this code to save photo to photo album
        // UIImageWriteToSavedPhotosAlbum(img!, nil, nil, nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

