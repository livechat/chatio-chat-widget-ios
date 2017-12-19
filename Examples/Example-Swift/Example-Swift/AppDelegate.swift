//
//  AppDelegate.swift
//  Example-Swift
//
//  Created by Łukasz Jerciński on 06/03/2017.
//  Copyright © 2017 LiveChat Inc. All rights reserved.
//

import UIKit
import chatio

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ChatioDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Chatio.licenseId = "8928139" // Set your licence number here
        Chatio.name = "iOS Widget Example" // User name and email can be provided if known
        Chatio.email = "example@chat.io"
        
        // Setting some custom variables:
        Chatio.setVariable(withKey:"First variable name", value:"Some value")
        Chatio.setVariable(withKey:"Second name", value:"Other value")
        
        Chatio.delegate = self
        
        return true
    }
    
    // MARK: ChatioDelegate
    
    func received(message: ChatioMessage) {
        if (!Chatio.isChatPresented) {
            // Notifying user
            let alert = UIAlertController(title: "Support", message: message.text, preferredStyle: .alert)
            let chatAction = UIAlertAction(title: "Go to Chat", style: .default) { alert in
                // Presenting chat if not presented:
                if !Chatio.isChatPresented {
                    Chatio.presentChat()
                }
            }
            alert.addAction(chatAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func handle(URL: URL) {
        UIApplication.shared.openURL(URL)
    }
}

