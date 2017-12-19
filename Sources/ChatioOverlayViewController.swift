//
//  ChatioOverlayViewController.swift
//  Example-Swift
//
//  Created by Łukasz Jerciński on 06/03/2017.
//  Copyright © 2017 LiveChat Inc. All rights reserved.
//

import Foundation
import UIKit

enum ChatState {
    case presented
    case hidden
}

@objc protocol ChatioOverlayViewControllerDelegate : NSObjectProtocol {
    func closedChatView()
    func handle(URL: URL)
}

class ChatioOverlayViewController : UIViewController, ChatViewDelegate {
    let chatView = ChatView()
    private var preloadingWindow = UIWindow()
    var webViewBridge : WebViewBridge? {
        didSet {
            chatView.webViewBridge = webViewBridge
        }
    }
    var chatState : ChatState = .hidden
    var configuration : ChatioConfiguration? {
        didSet {
            chatView.configuration = configuration
        }
    }
    var customVariables : Dictionary<String, String>? {
        didSet {
            chatView.customVariables = customVariables
        }
    }
    weak var delegate : ChatioOverlayViewControllerDelegate?
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
    override var shouldAutorotate : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatView.delegate = self
        
        // Adding webView to temporary UIWindow to start preloading content.
        preloadingWindow.alpha = 0.0
        preloadingWindow.windowLevel = UIWindowLevelNormal - 100
        preloadingWindow.addSubview(chatView)
    }
    
    // MARK: Public methods
    
    func presentChat(animated: Bool, completion: ((Bool) -> Void)? = nil) {
        view.addSubview(chatView)
        chatView.frame = view.bounds
        chatView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        chatView.presentChat(animated: animated, completion: { (finished) in
            if let completion = completion {
                ChatioState.markChatAsOpened()
                self.chatState = .presented
                completion(finished)
            }
        })
    }
    
    func dismissChat(animated: Bool, completion: ((Bool) -> Void)? = nil) {
        chatView.dismissChat(animated: animated, completion: { (finished) in
            if finished {
                self.chatState = .hidden
                self.preloadingWindow.addSubview(self.chatView)
            }
            
            if let completion = completion {
                completion(finished)
            }
        })
    }
    
    // MARK: ChatioViewDelegate
    
    @objc func closedChatView() {
        chatState = .hidden
        preloadingWindow.addSubview(chatView)
        
        if let delegate = delegate {
            delegate.closedChatView()
        }
    }
    
    @objc func handle(URL: URL) {
        if let delegate = delegate {
            delegate.handle(URL: URL)
        }
    }
}
