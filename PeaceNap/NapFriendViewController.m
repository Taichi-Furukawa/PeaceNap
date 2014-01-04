//
//  NapFriendViewController.m
//  PeaceNap
//
//  Created by furukawa on 2013/04/23.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "NapFriendViewController.h"

@interface NapFriendViewController ()

@end

@implementation NapFriendViewController
@synthesize friendsearch;

-(void)searchBarCancelButtonClicked:(UISearchBar*)searchBar{
    [friendsearch resignFirstResponder];
}
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
    NSUserDefaults *user_friend=[NSUserDefaults standardUserDefaults];
    NSArray *friend_arr=[NSArray array];
    friend_arr=[user_friend arrayForKey:@"friendList"];
    return [friend_arr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell; //= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
        NSUserDefaults *user_friend=[NSUserDefaults standardUserDefaults];
        NSArray *friends=[NSArray array];
        friends=[user_friend arrayForKey:@"friendList"];
        NSString *cellValue=[[NSString alloc]init];
        cellValue = [friends objectAtIndex:indexPath.section];
        cell.textLabel.text = cellValue;
    return cell;
}


//connection関連
-(void)searchBarSearchButtonClicked:(UISearchBar*)searchBar{
    getfriend=[[peaceNapConnection instance]init];
    getfriend.deleagte=self;
    [getfriend getFriend:searchBar.text];
    
    [searchBar resignFirstResponder];
}

-(void)ReceiveData:(NSString *)responce{
    if([responce isEqualToString:@"404"]==YES){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"friend not found"
                                  message:@"please retext friend id" delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil
                                  ];
        [alertView show];
    }else{
        NSUserDefaults *user_def = [NSUserDefaults standardUserDefaults];
        NSMutableArray *friends=[NSMutableArray array];
        NSArray *friendsarr=[user_def arrayForKey:@"friendList"];
        friends=[NSMutableArray arrayWithArray:friendsarr];
        BOOL b = [friends containsObject:responce];
        if (b==NO) {
            //friends=[NSMutableArray array];
            [friends addObject:responce];
            [user_def setObject:friends forKey:@"friendList"];
            [self.tableView reloadData];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"すでに登録されたユーザーです"
                                      message:@"やりなおせ" delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil
                                      ];
            [alertView show];
        }
    }
    getfriend=[[peaceNapConnection instance]init];
}

//ここまで
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
