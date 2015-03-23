//
//  ViewController.m
//  VoovilSideMenu
//
//  Created by Özcan Akbulut on 23.10.13.
//  Copyright (c) 2013 Özcan Akbulut. All rights reserved.
//

#import "SideRestaurantsViewController.h"
#import "RestaurantSingleTableViewController.h"
#import "UIColor_hex.h"
#import "UIImage+StackBlur.h"
#include "HUD.h"

@interface SideRestaurantsViewController ()

@property (strong,nonatomic) NSArray *menuArray;

@end

@implementation SideRestaurantsViewController
@synthesize menuArray, sideMenu, menuTable,json;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //UIImage *BluredImage = [[UIImage imageNamed:@"resturents_background.jpg"] stackBlur:30];
    
    self.title = @"Restaurants";
    
   // [self.backgroundImageView setImage:BluredImage];
    
    if (refrenceTableView == nil) {
		refrenceTableView = [[RestaurantSingleTableViewController alloc] init];
        [self showMenu];
}
    

	[self.restaurantsTable setDataSource:refrenceTableView];
	[self.restaurantsTable setDelegate:refrenceTableView];
    self.restaurantsTable.rowHeight=130;
    [self.restaurantsTable registerNib:[UINib nibWithNibName:@"CellHotel" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
     self.restaurantsTable.backgroundColor = [UIColor colorWithHexString:@"000000 0.5"];
     self.restaurantsTable.backgroundView = [UIView new] ;
    [self loadJSON_DATA:@"http://serv01.vm1692.sgvps.net/~karasi/visitjordan/restaurants.php"];

    // Modern Objective-C
    NSString *menuPlistPath = [[NSBundle mainBundle] pathForResource:@"sideMenu" ofType:@"plist"];
    menuArray = [[NSArray alloc] initWithContentsOfFile:menuPlistPath];
   
    // Begin Gesture
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    // End Gesture
   
    // Begin - Custom Navigation,..
    self.navigationController.navigationBar.translucent = YES;
    [(UIView*)[self.navigationController.navigationBar.subviews objectAtIndex:0] setAlpha:0.8f];
    // End - Custom Navigation,..
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self showMenu];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark - Actions -
- (IBAction)showMenuDown:(id)sender {

    if(sideMenu.frame.origin.x == 0) //only show the menu if it is not already shown
        [self showMenu];
    else
        [self hideMenu];
    
}

#pragma mark - animations -
-(void)showMenu{
    
    //slide the content view to the right to reveal the menu
  [UIView animateWithDuration:0.5 animations:^{
          self.navigationController.navigationBar.frame = CGRectMake(-275, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);

    [sideMenu setFrame:CGRectMake(menuTable.frame.size.width*-1, sideMenu.frame.origin.y, sideMenu.frame.size.width, sideMenu.frame.size.height)];
    }];
    
}

-(void)hideMenu{
    
    //slide the content view to the left to hide the menu
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBar.frame = CGRectMake(0, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);

        [sideMenu setFrame:CGRectMake(0, sideMenu.frame.origin.y, sideMenu.frame.size.width, sideMenu.frame.size.height)];
    }];
}

#pragma mark - Gesture handlers -

-(void)handleSwipeLeft:(UISwipeGestureRecognizer*)recognizer{
    if(sideMenu.frame.origin.x == 0)
        [self showMenu];
}

-(void)handleSwipeRight:(UISwipeGestureRecognizer*)recognizer{
    if(sideMenu.frame.origin.x != 0)
        [self hideMenu];
}

-(void)loadJSON_DATA:(NSString *)url{

   // [HUD showUIBlockingIndicator];
    
    [HUD showUIBlockingIndicatorWithText:@"Loading... Please Wait" withTimeout:8];

    dispatch_queue_t loadJSON = dispatch_queue_create("Load JSON",NULL);
    
    dispatch_async(loadJSON, ^{
        
        NSData* ytData = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:url]
                          ];
        
        if (ytData!=Nil) {
            self.json = [NSJSONSerialization
                         JSONObjectWithData:ytData
                         options:kNilOptions
                         error:nil];
        }
        else
            self.json=nil;
        
        //NSLog(@"begin loading ...%@",url);
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (self.json == nil) {
 
                    UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Network Error"
                                                                        message: @"Error connecting to the internet"
                                                                       delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
                    [someError show];
               
            }
            
            
            refrenceTableView.arrayOfData = [json objectForKey:@"restaurants"];
            refrenceTableView._flag1=[json objectForKey:@"one"];
            refrenceTableView._flag2=[json objectForKey:@"tow"];
            refrenceTableView._flag3=[json objectForKey:@"three"];
            refrenceTableView._flag4=[json objectForKey:@"four"];
            refrenceTableView._flag5=[json objectForKey:@"five"];
            
            [HUD hideUIBlockingIndicator];
            [self.restaurantsTable reloadData];
            
        });
        
    });

    
}

#pragma mark - UITableView Datasource -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    
          return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return 1;
    else
        return menuArray.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

      
    if ([indexPath section] == 0) {
        UITableViewCell *avatarCell = [tableView dequeueReusableCellWithIdentifier:@"avatarMenuCell"];
        UIImageView *imageAvatar = (UIImageView *) [avatarCell viewWithTag:301];
        imageAvatar.image = [UIImage imageNamed:@"restaurants_menu_img"];
        
        //CALayer *imageLayer = imageAvatar.layer;
        //[imageLayer setCornerRadius:60.0];
        //[imageLayer setBorderWidth:0];
        //[imageLayer setMasksToBounds:YES];
        return avatarCell;
        
    } else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
        
        NSDictionary *menuItem = [menuArray objectAtIndex:indexPath.row];
        
        UILabel *titleLabel = (UILabel *) [cell viewWithTag:300];
        titleLabel.text = menuItem[@"Title"];
        CALayer *separator = [CALayer layer];
        separator.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.25].CGColor;
        separator.frame = CGRectMake(31, 43, 200, .5);
        [cell.layer addSublayer:separator];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0)
        return 150;
    else
        return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else
        return @"Restaurants Menu";
}

#pragma mark - UITableView Delegate -

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[[menuArray objectAtIndex:indexPath.row]objectForKey:@"Title"];
    
    NSString *param = [[menuArray objectAtIndex:indexPath.row]objectForKey:@"Title"];
    self.title= param;
    
    param = [param stringByReplacingOccurrencesOfString:@" " withString:@""];

    [self hideMenu];
    [self loadJSON_DATA:[[NSString alloc]initWithFormat:
                         @"http://serv01.vm1692.sgvps.net/~karasi/visitjordan/restaurants.php?class=%@",
                         param]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
