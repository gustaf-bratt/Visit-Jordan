//
//  EventDetailsViewController.m
//  VistJOrdan New
//
//  Created by Faris on 11/21/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "UIImage+StackBlur.h"
#import "UIColor_hex.h"
#define FONT_SIZE 14.0f

@interface EventDetailsViewController ()
@property NSArray * label;
@property NSArray * text;
@end

@implementation EventDetailsViewController
@synthesize extraName;
@synthesize extraDate;
@synthesize extraCity;
@synthesize extraLocation;
@synthesize extraOrganizer;
@synthesize extraEntry;
@synthesize extraDetails;
@synthesize extraTime;
@synthesize backgroundImage;
@synthesize label,text;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
     UIImage *BluredImage = [[UIImage imageNamed:@"events-bg.jpg"] stackBlur:50];
    
        [backgroundImage setImage:BluredImage];
    
       label = [[NSArray alloc]initWithObjects:@"Name",@"Date",@"Time",@"City",@"Location",@"Organizer",@"Entry",@"Details", nil];
       text = [[NSArray alloc]initWithObjects:extraName,extraDate,extraTime,extraCity,extraLocation,extraOrganizer,extraEntry,extraDetails, nil];
    
        self.cTable.backgroundColor = [UIColor colorWithHexString:@"000000 0.5"];
        self.cTable.backgroundView = [UIView new];
        [self.cTable reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 8;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [UIView new] ;
        cell.selectedBackgroundView = nil;
    }
    
    cell.textLabel.textColor= [UIColor whiteColor];
    
    cell.detailTextLabel.textColor= [UIColor colorWithHexString:@"ffffff 0.7"];
    cell.textLabel.textColor= [UIColor colorWithHexString:@"fcfcfc"];
    cell.textLabel.text=[label objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[text objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines=0;
    cell.detailTextLabel.numberOfLines=0;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [[text objectAtIndex:indexPath.row]
                   sizeWithFont:[UIFont systemFontOfSize:14]
                   constrainedToSize:CGSizeMake(300, CGFLOAT_MAX)];
    return size.height + 30;
}


@end


