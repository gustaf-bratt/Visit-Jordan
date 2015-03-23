//
//  EventDetailsViewController.h
//  VistJOrdan New
//
//  Created by Faris on 11/21/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UITableView *cTable;
@property (nonatomic ,retain) NSString *PlaceName;

@property(nonatomic,strong) NSString *extraName;
@property(nonatomic,strong) NSString *extraDate;
@property(nonatomic,strong) NSString *extraTime;
@property(nonatomic,strong) NSString *extraCity;
@property(nonatomic,strong) NSString *extraLocation;
@property(nonatomic,strong) NSString *extraOrganizer;
@property(nonatomic,strong) NSString *extraEntry;
@property(nonatomic,strong) NSString *extraDetails;
 
@end
