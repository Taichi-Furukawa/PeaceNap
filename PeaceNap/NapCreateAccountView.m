//
//  NapCreateAccountView.m
//  PeaceNap
//
//  Created by furukawa on 2013/04/24.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "NapCreateAccountView.h"

@interface NapCreateAccountView ()

@end

@implementation NapCreateAccountView
@synthesize userID,usrtPass,phoneNumber;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"modal create view");
	// Do any additional setup after loading the view.
}

-(IBAction)sendAccountData:(id)sender{
    createAccount=[[peaceNapConnection instance]init];
    createAccount.deleagte=self;
    [createAccount createAccount:userID.text password:usrtPass.text phoneNumber:phoneNumber.text];
}

-(void)ReceiveData:(NSString *)responce{
    NSLog(@"createaccount=%@",responce);
    if ([responce isEqualToString:@"ok"]){
        
    [self loginPeaceNap];
    }
}

-(void)loginPeaceNap{
    //NSLog(@"login now");
    NapLoginController *move=[self.storyboard instantiateViewControllerWithIdentifier:@"NapLoginController"];
    [self presentViewController:move animated:NO completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
