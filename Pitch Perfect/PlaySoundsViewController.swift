//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jason Paul Southwell on 10/17/16.
//  Copyright © 2016 Jason Paul Southwell. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {
    
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb  }
    
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        stopButton.isEnabled = true
        switch(ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
            print("Snail Button Pressed")
        case .Fast:
            playSound(rate: 1.5)
            print("Rabbit Button Pressed")
        case .Chipmunk:
            print("Chipmunk Button Pressed")
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
            print("Vader Button Pressed")
        case .Echo:
            playSound(echo: true)
            print("Echo Button Pressed")
        case .Reverb:
            playSound(reverb: true)
            print("Reverb Button Pressed")
        }
    }
    
    
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        stopButton.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(playState: .NotPlaying)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
