//
//  ViewController.swift
//  FBLiveStreamAnimation
//
//  Created by Puneet on 08/08/17.
//  Copyright © 2017 PuneetGupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let curvedView = CurvedView(frame: view.frame)
//        curvedView.backgroundColor = .yellow
//        view.addSubview(curvedView)

        
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    func handleTap() {
        (0...10).forEach { (_) in
            generateAnimatedViews()
        }
    }
    
    fileprivate func generateAnimatedViews() {
        
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "ha") : #imageLiteral(resourceName: "thumbsUp")
        let imageView = UIImageView(image: image)
        //let imageView1 = UIImageView(image: #imageLiteral(resourceName: "thumbsUp"))
        let dimension = 20 + drand48() * 10
        
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        //imageView1.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        imageView.layer.add(animation, forKey: nil)
        //imageView1.layer.add(animation, forKey: nil)
        
        view.addSubview(imageView)
        //view.addSubview(imageView1)

        
    }
    

}

func customPath() -> UIBezierPath {
    let path = UIBezierPath()
    
    path.move(to: CGPoint(x: 0, y: 200))
    
    let endPoint = CGPoint(x: 450, y: 200)
    //path.addLine(to: endPoint)
    
    let randomYShift = 200 + drand48() * 300
    let cp1 = CGPoint(x: 100, y: 100 - randomYShift)
    let cp2 = CGPoint(x: 200, y: 300 + randomYShift)
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
    
}

class CurvedView: UIView {
    override func draw(_ rect: CGRect) {
        
        let path = customPath()
        path.lineWidth = 3
        path.stroke()
        
    }
}

