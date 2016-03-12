//
//  DeviceViewController.swift
//  SwiftStarter
//
//  Created by Stephen Schiffli on 10/20/15.
//  Copyright © 2015 MbientLab Inc. All rights reserved.
//

import UIKit

class DeviceViewController: UIViewController {
    @IBOutlet weak var deviceStatus: UILabel!
    
    var device: MBLMetaWear!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        device.addObserver(self, forKeyPath: "state", options: NSKeyValueObservingOptions.New, context: nil)
        device.connectWithHandler { (error: NSError?) -> Void in
            NSLog("We are connected")
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        device.removeObserver(self, forKeyPath: "state")
        device.disconnectWithHandler(nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            switch (self.device.state) {
            case .Connected:
                self.deviceStatus.text = "Connected";
            case .Connecting:
                self.deviceStatus.text = "Connecting";
            case .Disconnected:
                self.deviceStatus.text = "Disconnected";
            case .Disconnecting:
                self.deviceStatus.text = "Disconnecting";
            case .Discovery:
                self.deviceStatus.text = "Discovery";
            }
        }
    }
}
