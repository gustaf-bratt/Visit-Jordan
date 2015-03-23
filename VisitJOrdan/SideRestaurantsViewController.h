//
//  ViewController.h
//  VoovilSideMenu
//
//  Created by Özcan Akbulut on 23.10.13.
//  Copyright (c) 2013 Özcan Akbulut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantSingleTableViewController.h"

@interface SideRestaurantsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    RestaurantSingleTableViewController *refrenceTableView;
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIView *sideMenu;
@property (weak, nonatomic) IBOutlet UITableView *menuTable;
@property (weak, nonatomic) IBOutlet UITableView *restaurantsTable;
@property  (nonatomic,strong) NSDictionary* json;
@end
