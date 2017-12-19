//
//  ViewController.swift
//  Example-Swift
//
//  Created by Łukasz Jerciński on 06/03/2017.
//  Copyright © 2017 LiveChat Inc. All rights reserved.
//

import UIKit
import chatio
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "chat.io"
    }
    
    @IBAction func openChat(_ sender: Any) {
        //Presenting chat:
        Chatio.presentChat()
    }
}

