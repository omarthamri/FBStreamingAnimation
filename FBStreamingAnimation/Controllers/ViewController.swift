//
//  ViewController.swift
//  FBStreamingAnimation
//
//  Created by MACBOOK PRO RETINA on 22/11/2018.
//  Copyright © 2018 MACBOOK PRO RETINA. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var secondsSinceLastGeneration = 10
    let stop = false
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo(from: "no-excuses-best-motivational-video.mp4")
        tick()
    }
    
    func tick() {
       // secondsSinceLastGeneration += 1
        if  secondsSinceLastGeneration >= 10 {
            (0...10).forEach{ (_) in
            GenerateAnimateViews()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            self.tick()
        })
    }
    
    func GenerateAnimateViews() {
        let chosenImage = drand48() > 0.5 ? #imageLiteral(resourceName: "like") : #imageLiteral(resourceName: "love")
        let imageView = UIImageView(image: chosenImage)
        imageView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = CreateBezierPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.isRemovedOnCompletion = false
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
    }

    private func playVideo(from file:String) {
        let file = file.components(separatedBy: ".")
        
        guard let path = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
            debugPrint( "\(file.joined(separator: ".")) not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2)
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
}

func CreateBezierPath() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 200))
    let randomY = 200 + drand48() * 300
    path.addCurve(to: CGPoint(x: UIScreen.main.bounds.width, y: 200), controlPoint1: CGPoint(x: UIScreen.main.bounds.width / 4, y: CGFloat(100 - randomY)), controlPoint2: CGPoint(x: UIScreen.main.bounds.width / 2, y: CGFloat(300 + randomY)))
    return path
}


