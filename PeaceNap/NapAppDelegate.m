//
//  NapAppDelegate.m
//  PeaceNap
//
//  Created by furukawa on 2013/04/19.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "NapAppDelegate.h"
#import "peaceNapConnection.h"

@implementation NapAppDelegate
@synthesize window,deviceToken;
BOOL login;
BOOL session=NO;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *user_def = [NSUserDefaults standardUserDefaults];
    login=[user_def boolForKey:@"LoginState"];
    if (login==NO) {
        NapLoginController *move=[[NapLoginController alloc]init];
        UIStoryboard *storyboad = [[[self window]rootViewController]storyboard];
        move = [storyboad instantiateViewControllerWithIdentifier:@"NapLoginController"];
        self.window.rootViewController = move;
        
    }else{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound| UIRemoteNotificationTypeAlert)];
            peaceNapConnection *session=[peaceNapConnection instance];
            [session sessionCheck];
    }
    return YES;
}

- (void)application:(UIApplication*)app didFailToRegisterForRemoteNotificationsWithError:(NSError*)err{
	NSLog(@"Errorinregistration.Error:%@",err);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *Token = [[[[devToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                              stringByReplacingOccurrencesOfString:@">" withString:@""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    deviceToken=Token;
    NSLog(@"deletoken=%@",deviceToken);
    
    peaceNapConnection *sendtoken=[peaceNapConnection instance];
    [sendtoken send_DeviceToken:deviceToken];

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
