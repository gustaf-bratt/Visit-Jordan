//
//  EmbassiesDetailsViewCont.h
//  VistJOrdan New
//
//  Created by Faris on 11/24/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmbassiesDetailsViewCont : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UITableView *cTable;
@property (nonatomic ,retain) NSString *PlaceName;

@property(nonatomic,strong) NSString *extraName;
@property(nonatomic,strong) NSString *extraAddress;
@property(nonatomic,strong) NSString *extraPhone;
@property(nonatomic,strong) NSString *extraEmail;
@property(nonatomic,strong) NSString *extraFax;
@property(nonatomic,strong) NSString *extraWorkinghours;
@end
