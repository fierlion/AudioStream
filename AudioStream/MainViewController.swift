//
//  MainViewController.swift
//  AudioStream
//
//  Created by Ray Foote on 11/4/15.
//  Copyright © 2015 Ray Foote. All rights reserved.
//

import Foundation
import UIKit

class MainViewController : UIViewController {
    
    @IBAction func Pause(sender: AnyObject) {
        AudioPlayer.pause()
    }
    
    @IBAction func Play(sender: AnyObject) {
        AudioPlayer.play()
    }
    
    override func viewDidLoad() {
    }
}