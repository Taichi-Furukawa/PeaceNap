//
//  NapMainViewController.h
//  PeaceNap
//
//  Created by furukawa on 2013/04/23.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NapAppDelegate.h"

@interface NapMainViewController : UIViewController

@property(retain,nonatomic) IBOutlet UIButton *start;
@property(retain,nonatomic) IBOutlet UIButton *plus;
@property(retain,nonatomic) IBOutlet UILabel *FirstLabel;

-(IBAction)FirstAction:(id)sender;
-(IBAction)SecondAction:(id)sender;


@end
