//
//  ViewController.m
//  Example-ObjC
//
//  Created by Łukasz Jerciński on 15/03/2017.
//  Copyright © 2017 LiveChat Inc. All rights reserved.
//

#import "ViewController.h"
@import chatio;
@import MapKit;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"chat.io";
}

- (IBAction)openChat:(id)sender {
    //Presenting chat:
    [Chatio presentChatWithAnimated:YES completion:nil];
}

@end
