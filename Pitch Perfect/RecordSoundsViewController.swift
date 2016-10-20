//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jason Paul Southwell on 10/13/16.
//  Copyright © 2016 Jason Paul Southwell. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let imageStop = UIImage(named:"stopRecordingButton")
    let imagePlay = UIImage(named: "recordButton")
    
    func record() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        print(filePath!)

    }
    
    func stopRecording() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
        try! audioSession.setActive(false)
    }
    
    @IBOutlet weak var recordingLabel: UILabel!

    @IBOutlet weak var recordButton: UIButton!

    
    var audioRecorder: AVAudioRecorder!
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Recording Finished")
        if (flag) {
            self.performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Saving Failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "stopRecording")
        { let playSoundsVC = segue.destination as!
            PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            print("Recorded Audio URL: \(recordedAudioURL)")
            playSoundsVC.recordedAudioURL = recordedAudioURL }
    }
    
    @IBAction func buttonPress(_ sender: Any) {
        
        if(recordButton.imageView?.image == UIImage(named:"recordButton")){
            recordButton.setImage(imageStop, for: [])
            recordingLabel.text = "Tap to Stop Recording"
            record()
        } else {
            recordButton.setImage(imagePlay, for: [])
            recordingLabel.text = "Tap to Record"
            stopRecording()
        }
    }

    
}

