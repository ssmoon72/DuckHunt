//
//  AudioManager.swift
//  DuckHunt
//
//  Created by Allen Fang, Samuel Moon, Harrison Mai, Alan Le on 5/14/17.
//  Copyright © 2017 Allen Fang, Samuel Moon, Harrison Mai, Alan Le. All rights reserved.
//

import AVFoundation

class AudioManager {
    static let instance = AudioManager()
    private init() {}
    
    private var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        let url = Bundle.main.url(forResource: "shooting-stars-main", withExtension: "mp3")
        
        var err: NSError?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch let err1 as NSError {
            err = err1
        }
        
        if err != nil {
            print("error")
        }
    }
    
    func playMainMenuMusic() {
        let url = Bundle.main.url(forResource: "shooting-stars-intro", withExtension: "mp3")
        
        var err: NSError?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch let err1 as NSError {
            err = err1
        }
        
        if err != nil {
            print("error")
        }
    }

    
}
