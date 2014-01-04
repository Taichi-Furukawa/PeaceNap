//
//  NapMainViewController.m
//  PeaceNap
//
//  Created by furukawa on 2013/04/23.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "NapMainViewController.h"

@interface NapMainViewController ()

@end

@implementation NapMainViewController{
    SharedData *data;
}

@synthesize start,FirstLabel;

int count=0;
int minute=0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated
{
    minute=0;
    count=0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 共有データインスタンスを取得
    
    
	// Do any additional setup after loading the view, typically from a nib
    
    
    
}
 
-(void)FirstAction:(id)sender{
    
    //count+=300;
    minute+=5;
    count+=10;
    NSString *string = @"分";
    
    NSString *str = [NSString stringWithFormat:@"%d %@",minute,string];
    data = [SharedData instance];
    SharedData *sharedminute = [SharedData instance];
    [sharedminute  setData:str forKey:@"パス"];
    
    FirstLabel.text = str;
    
    
    
}

-(void)SecondAction:(id)sender{
    
    
    NSNumber *num = [NSNumber numberWithInt:count];
    
    [data setData:num forKey:@"メッセージ"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
