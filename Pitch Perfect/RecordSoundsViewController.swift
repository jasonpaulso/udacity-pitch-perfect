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
//    let imageStop = UIImage(named:"stopRecordingButton")
//    let imagePlay = UIImage(named: "recordButton")
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        print("Recording Started")
        recordingLabel.text = "Tap to stop recoding and perfect your pitch!"
        stopRecordingButton.isEnabled = true
        recordButton.isHidden = true
        stopRecordingButton.isHidden = false
        recordButton.isEnabled = false
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
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        print("Recording Stopped")
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        stopRecordingButton.isHidden = true
        recordButton.isHidden = false
        recordingLabel.text = "Tap to Record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.speaker)
        try! audioSession.setActive(false)
    }
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        stopRecordingButton.isEnabled = false
        stopRecordingButton.isHidden = true
    }
    

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
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
    
}

