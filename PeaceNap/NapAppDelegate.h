//
//  NapAppDelegate.h
//  PeaceNap
//
//  Created by furukawa on 2013/04/19.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NapBatchViewController.h"
#import "NapFriendViewController.h"
#import "NapMainViewController.h"
#import "NapLoginController.h"
#import "NapTabViewController.h"
#import "NSString+MD5.h"
#import "SharedData.h"
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>
@interface NapAppDelegate : UIResponder <UIApplicationDelegate>{
    //NSString *deviceToken;
}

@property (strong, nonatomic) UIWindow *window;

@property (assign,nonatomic) NSString *deviceToken;

@end
