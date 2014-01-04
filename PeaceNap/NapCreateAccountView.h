//
//  NapCreateAccountView.h
//  PeaceNap
//
//  Created by furukawa on 2013/04/24.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NapAppDelegate.h"
#import "peaceNapConnection.h"

@interface NapCreateAccountView : UIViewController <NapDelegate>{
    peaceNapConnection *createAccount;
    
}
@property(retain,nonatomic)IBOutlet UITextField *userID;
@property(retain,nonatomic)IBOutlet UITextField *usrtPass;
@property(retain,nonatomic)IBOutlet UITextField *phoneNumber;

-(IBAction)sendAccountData:(id)sender;

@end
