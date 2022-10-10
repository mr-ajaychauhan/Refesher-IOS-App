//
//  AudioPlayer.swift
//  Restart-App
//
//  Created by Drillmaps India on 10/10/22.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound : String ,type:String ){
    if let path = Bundle.main.path(forResource: sound, ofType:type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path ))
            audioPlayer?.play()
        }catch{
            print("Could Not Play The Sound File")
        }
    }
}
