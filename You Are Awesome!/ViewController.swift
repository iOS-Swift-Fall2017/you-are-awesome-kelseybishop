//
//  ViewController.swift
//  You Are Awesome!
//
//  Created by Kelsey Bishop on 8/28/17.
//  Copyright © 2017 Kelsey Bishop. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
//MARK: -Properties
    
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var awesomeImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    var awesomePlayer = AVAudioPlayer()
    var index = -1
    var imageNumber = -1
    let numberOfImages = 3
    let numberOfSounds = 3
    var soundNumber = -1
  
    
    // This code executes when the view controller loads
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func nonRepeatingRandomNumber(lastNumber: Int, maxValue: Int) -> Int{
    var newIndex = -1
    repeat{
        newIndex = Int(arc4random_uniform(UInt32(maxValue)))
    } while lastNumber == newIndex
        return newIndex
        
    }
    
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        // Can we load in the file called soundName?
        if let sound = NSDataAsset(name: soundName){
            // check if sound.data is a sound file
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                // if sound.data is not a valid audio file
                print("ERROR: data is \(soundName) couldn't be played as a sound.")
            }
        } else {
            // if reading in the NSDataAsset didn't work, tell the user / report the error.
            print("ERROR: file\(soundName) didn't load.")
        }
    }
    
    @IBAction func soundSwitchPressed(_ sender: UISwitch) {
        if !soundSwitch.isOn && soundNumber != -1 {
            // stop playing
            awesomePlayer.stop()
        }
    }
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {
       
        let messages = ["You Are Fantastic!",
                        "You Are Great!",
                        "You Are Amazing",
                        "When the Genius Bar needs help, they call you!",
                        "You Brighten My Day!",
                        "You are Da Bomb!",
                        "I can't wait to use your app!",
                        "Fabulous? That's you!"]
        
        // Show a message
        index = nonRepeatingRandomNumber(lastNumber: index, maxValue: messages.count)
        messageLabel.text = messages[index]
        
        // Show an image
        awesomeImage.isHidden = false
        imageNumber = nonRepeatingRandomNumber(lastNumber: imageNumber, maxValue: numberOfImages)
        awesomeImage.image = UIImage(named: "image\(imageNumber)")
        
        if soundSwitch.isOn == true{
        // Play a random sound
        soundNumber = nonRepeatingRandomNumber(lastNumber: soundNumber, maxValue: numberOfSounds)
        // Play a sound
        let soundName = "sound\(soundNumber)"
        playSound(soundName: soundName, audioPlayer: &awesomePlayer)
        }
      
        }
}


