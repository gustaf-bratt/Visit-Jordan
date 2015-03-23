//
//  EmbassiesDetailsViewCont.m
//  VistJOrdan New
//
//  Created by Faris on 11/24/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "EmbassiesDetailsViewCont.h"
#import "UIImage+StackBlur.h"
#import "UIColor_hex.h"
#define FONT_SIZE 14.0f

@interface EmbassiesDetailsViewCont ()
@property NSArray * label;
@property NSArray * text;
@end

@implementation EmbassiesDetailsViewCont
@synthesize extraName,extraAddress,extraEmail,extraPhone,extraWorkinghours,backgroundImage,extraFax;
 ;
@synthesize label,text;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *BluredImage = [[UIImage imageNamed:@"embassies_bg.jpg"] stackBlur:50];
    
    [backgroundImage setImage:BluredImage];
    
    label = [[NSArray alloc]initWithObjects:@"Name",@"Address",@"E-mail",@"Phone",@"Fax",@"Working Hours", nil];
    text = [[NSArray alloc]initWithObjects:extraName,extraAddress,extraEmail,extraPhone,extraFax,extraWorkinghours, nil];
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
    
    return 6;
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
    cell.detailTextLabel.textColor= [UIColor colorWithHexString:@"ffffff"];
    cell.textLabel.textColor= [UIColor colorWithHexString:@"fcfcfc"];
    [cell.textLabel setFont:[UIFont fontWithName:@"Ubuntu-Light" size:18]];
    
    cell.textLabel.text=[label objectAtIndex:indexPath.row];
    cell.detailTextLabel.text =[text objectAtIndex:indexPath.row];

    
    
    return cell;
}




@end