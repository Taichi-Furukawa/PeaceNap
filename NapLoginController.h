//
//  ViewController.h
//  LoginProject
//
//  Created by 渡辺 優介 on 13/04/21.
//  Copyright (c) 2013年 渡辺 優介. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NapAppDelegate.h"
#import "peaceNapConnection.h"
@interface NapLoginController : UIViewController <NapDelegate> {
    peaceNapConnection *login;
}
- (IBAction)touchedLoginButton:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *addressTextBox;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextBox;

-(void)loginConnection:(NSString *)user_id password:(NSString *)user_pass;

@end
