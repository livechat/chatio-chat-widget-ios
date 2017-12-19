//
//  AppDelegate.m
//  Example-ObjC
//
//  Created by Łukasz Jerciński on 15/03/2017.
//  Copyright © 2017 LiveChat Inc. All rights reserved.
//

#import "AppDelegate.h"
@import chatio;

@interface AppDelegate () <ChatioDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    Chatio.licenseId = @"8928139"; // Set your licence number here
    Chatio.name = @"iOS Widget Example"; // User name and email can be provided if known
    Chatio.email = @"example@livechatinc.com";
    
    // Setting some custom variables:
    [Chatio setVariableWithKey:@"First variable name" value:@"Some value"];
    [Chatio setVariableWithKey:@"Second name" value:@"Other value"];
    
    Chatio.delegate = self;
    
    return YES;
}

#pragma mark - LiveChatDelegate

- (void)receivedWithMessage:(ChatioMessage *)message {
    if (!Chatio.isChatPresented) {
        // Notifying user
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Support" message:message.text preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *chatAction = [UIAlertAction actionWithTitle:@"Go to Chat" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // Presenting chat if not presented:
            if (!Chatio.isChatPresented) {
                [Chatio presentChatWithAnimated:YES completion:nil];
            }
        }];
        [alert addAction:chatAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
}

- (void)handleWithURL:(NSURL *)URL {
    [[UIApplication sharedApplication] openURL:URL];
}

@end
