//
//  MusicPlayer.swift
//  Flappy
//
//  Created by liusy182 on 24/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//

import Foundation
import AVFoundation

enum MusicPlayerError: ErrorType {
    case ResourceNotFound
}

class MusicPlayer {
    private var player: AVAudioPlayer? = nil
    
    init(filename: String, type: String) throws {
        if let resource = NSBundle.mainBundle().pathForResource(filename, ofType: type) {
            let url = NSURL(fileURLWithPath: resource)
            player = try AVAudioPlayer(contentsOfURL: url)
            player?.numberOfLoops = -1
            player?.prepareToPlay()
        } else {
            throw MusicPlayerError.ResourceNotFound
        }
    }
    
    func play() {
        player?.play()
    }
    func stop() {
        player?.stop()
    }
}