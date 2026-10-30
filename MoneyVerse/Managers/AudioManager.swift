//
//  AudioManager.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 25/12/2025.
//

import Foundation
import AVFoundation
import Combine

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    
    var player: AVQueuePlayer?
    var looper: AVPlayerLooper?
    
    @Published var currentSong: String?

    func playSong(named fileName: String, loops: Int = 0, volume: Float = 1.0) {
        if currentSong == fileName {
            player?.play()
            return
        }
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "m4a") else {
            print("Song not found: \(fileName).m4a")
            return
        }
        
        let playerItem = AVPlayerItem(url: url)
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        
        if loops != 0 {
            looper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
        }
        
        self.player = queuePlayer
        self.player?.volume = volume
        self.player?.play()
        
        self.currentSong = fileName
    }
    
    func stopIntro() {
        if let player = player {
            player.pause()
            player.seek(to: .zero)
        }
    }
}
