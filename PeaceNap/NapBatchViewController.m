//
//  NapBatchViewController.m
//  PeaceNap
//
//  Created by furukawa on 2013/04/23.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "NapBatchViewController.h"

@interface NapBatchViewController ()

@end

@implementation NapBatchViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(IBAction)pressStartRequest:(id)sender{
    NSUserDefaults *user_def = [NSUserDefaults standardUserDefaults];
    [user_def setBool:NO forKey:@"LoginState"];
    
    NSMutableURLRequest *logoutReq=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://peacenap.sp2lc.salesio-sp.ac.jp/main.php"]];
    NSString *Str=[NSString stringWithFormat:@"action=logout"];
    NSHTTPCookie *aCookie = [self getpeacenapCookie];
    NSArray *cook = [NSArray arrayWithObjects:aCookie, nil];
    NSDictionary *header = [NSHTTPCookie requestHeaderFieldsWithCookies:cook];
    
    [logoutReq setAllHTTPHeaderFields:header];
    logoutReq.HTTPMethod=@"POST";
    logoutReq.HTTPBody=[Str dataUsingEncoding:NSUTF8StringEncoding];
    NSURLConnection *logoutconn=[[NSURLConnection alloc]initWithRequest:logoutReq delegate:self];
    if (!logoutconn) {
        NSLog(@"connection err");
    }

    //クッキー削除
    NSHTTPCookieStorage *aStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [aStorage cookies];
    
    //特定のドメイン(xxxx.ne.jp)のクッキーを全て削除
    for (NSHTTPCookie *aCookie in cookies) {
        NSDictionary *prop = [aCookie properties];
        NSString *cookieDomain = [prop objectForKey:NSHTTPCookieDomain];
        if (cookieDomain && [cookieDomain isEqualToString:@"peacenap.sp2lc.salesio-sp.ac.jp"]) {
            
            //無効なクッキーへ入れ替え。(deleteCookieのみだとキャッシュが残るため)
            //[prop setValue:@"" forKey:NSHTTPCookieValue];
            //追記：過去の時間を設定しクッキーを無効に
            [prop setValue:[NSDate dateWithTimeIntervalSinceNow:-3600]         forKey:NSHTTPCookieExpires];
            NSHTTPCookie *newCookie = [[NSHTTPCookie alloc] initWithProperties:prop];
            [aStorage deleteCookie:aCookie];
            [aStorage setCookie:newCookie];
        }
    }
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    NapLoginController *move=[self.storyboard instantiateViewControllerWithIdentifier:@"NapLoginController"];
    [self presentViewController:move animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

-(NSHTTPCookie *)getpeacenapCookie{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [ NSHTTPCookieStorage sharedHTTPCookieStorage ];
    // Cookie処理ループ
    for (cookie in [storage cookies]) {
        // 目的のCookieが見つかったら値を返す
        if ([cookie.domain isEqualToString: @"peacenap.sp2lc.salesio-sp.ac.jp" ]) {
            //NSLog(@"%@",cookie);
            return cookie;
        }
    }
    return nil;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
