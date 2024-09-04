//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var labelUpdate: UILabel!
    
    @IBOutlet weak var cookProgressBar: UIProgressView!
    
    let eggCookTimes = ["Soft": 5, "Medium": 7, "Hard": 10]
    var cookTimeRemaining = 0;
    var cookTimeElapsed = 0;
    
    var timer = Timer();
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        print(sender.titleLabel?.text ?? "No Egg")
        timer.invalidate();
        cookTimeRemaining = 0;
        cookTimeElapsed = 0;
        if (eggCookTimes[(sender.titleLabel?.text ?? "No Egg")] != 0) {
            let eggCookTime = eggCookTimes[(sender.titleLabel?.text ?? "Error")] ?? 0
            print("Cook time is \(String(describing: eggCookTime)) mins")
            cookTimeRemaining = eggCookTime
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(cookTimer(_:)), userInfo: [eggCookTime], repeats: true)
        }
    }
    
    //timer code
    @objc func cookTimer(_ timer: Timer) {
        if let userInfo = timer.userInfo as? [Any] {
            if var cookTime = userInfo[0] as? Int
            {
                if cookTimeRemaining != 0 {
                    cookTimeRemaining -= 1
                    cookTimeElapsed += 1
                    cookProgressBar.progress = Float(cookTimeElapsed) / Float(cookTime)
                    print(cookProgressBar.progress)
                    labelUpdate.text = "\(cookTimeRemaining) seconds remaining!"
                    if cookTimeRemaining == 0 {
                        cookProgressBar.progress = 1.0
                        guard let url = Bundle.main.url(forResource: "alarm_sound.mp3", withExtension: "mp3") else { return }
                        do {
                            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                            try AVAudioSession.sharedInstance().setActive(true)
                        } catch let error { print(error)}
                        player?.play()
                        labelUpdate.text = "Done Cooking, still hungry?"
                        timer.invalidate()
                    }
                } else {
                    timer.invalidate()
                }
            }
        }
    }

}
