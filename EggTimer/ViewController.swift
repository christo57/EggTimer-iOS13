//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    
    var player: AVAudioPlayer!
    
    var hardness = ""
    var secondsRemaining = 60

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        if player != nil && player.isPlaying {
            player.stop()
        }
        
        hardness = sender.currentTitle!
        secondsRemaining = eggTimes[hardness]!
        
        titleLabel.text = hardness
        progressBar.progress = 0.0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
    }
    
    @objc func updateTimer(){
        
        let fullTime = eggTimes[hardness]!
        let prog = Float((fullTime-secondsRemaining))/Float(fullTime)
        print(prog)
        progressBar.progress = prog
        
        if secondsRemaining > 0 {
            print("\(secondsRemaining) seconds.")
            secondsRemaining -= 1
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
    
}
