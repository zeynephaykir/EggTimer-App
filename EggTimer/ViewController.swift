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
    @IBOutlet weak var timerLabel: UILabel!
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard":  7]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var audioPlayer: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate() // Invalidate any existing timer
        let hardness = sender.currentTitle! // Soft,Medium,Hard
        totalTime = eggTimes[hardness]!     // Setting total time based on hardness
        
        progressBar.progress = 0.0
        secondsPassed = 0
        timerLabel.text = hardness
        
        //Start a timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
     }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
        } else {
            timer.invalidate()
            // Update the label text to "Done"
            timerLabel.text = "Your egg is done!"
            playSound()     // instead of function below can be used too 
            /*
             let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
             player = try! AVAudioPlayer(contentsOf: url!)
             player.play()
             */
        }
    }
    
    func playSound() {
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch let error {
                print("Error playing sound: \(error.localizedDescription)")
            }
    }
    
}
