//
//  ViewController.m
//  LoginProject
//
//  Created by 渡辺 優介 on 13/04/21.
//  Copyright (c) 2013年 渡辺 優介. All rights reserved.
//

#import "NapLoginController.h"

@interface NapLoginController ()

@end

@implementation NapLoginController

@synthesize addressTextBox,passwordTextBox;

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//ログインボタンの押下時のイベントハンドラ
- (IBAction)touchedLoginButton:(id)sender {
    NSString *address = self.addressTextBox.text;
    NSString *password = self.passwordTextBox.text;
    [self loginConnection:address password:password];
    //ここに*addressとpasswordを用いてデータベースへアクセス処理

}

-(void)loginConnection:(NSString *)user_id password:(NSString *)user_pass{
    login=[[peaceNapConnection instance]init];
    login.deleagte=self;
    [login accountLogin:user_id password:user_pass];
    
}


-(void)ReceiveData:(NSString *)responce{
    NSLog(@"loginresponce=%@",responce);
    if ([@"ng" isEqualToString:responce]==YES) {
        //createCookie
    }else{
        [login setCookie:responce forKey:@"PHPSESSID" domain:@"peacenap.sp2lc.salesio-sp.ac.jp" cookiePath:@"/" expires:@"1-Jan-2030 00:00:00 GMT"];
        NSUserDefaults *user_default = [NSUserDefaults standardUserDefaults];
            [user_default setObject:self.addressTextBox.text forKey:@"user_id"];
            [user_default setObject:self.passwordTextBox.text forKey:@"user_pass"];
            [user_default setBool:YES forKey:@"LoginState"];
            NapTabViewController *move=[self.storyboard instantiateViewControllerWithIdentifier:@"NapMainTab"];
            [self presentViewController:move animated:YES completion:nil];
    }
    login=[[peaceNapConnection instance]init];
}
@end
