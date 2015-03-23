//
//  GetThereViewController.m
//  VistJOrdan New
//
//  Created by Faris on 11/27/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "GetThereViewController.h"

#import "UIImage+StackBlur.h"
#import "CustomCell.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"


#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds].size.height>=568.0f?480:300;

@interface GetThereViewController ()

@end

@implementation GetThereViewController

float alpha,sectionHeight;
HeaderView *v ;
@synthesize BlurBackground,NormalBackground,BluredImage,cTable;
@synthesize LabeltextDescription,backgroundImageName;
@synthesize textViewDescription,textViewTitle,ViewTitle,ViewName;
@synthesize descriptionPlaceHolderSize;
@synthesize PlistName;
- (void)viewDidLoad
{
    
    self.title = ViewName;

    UIImage *image = [UIImage imageNamed: backgroundImageName];
    [NormalBackground setImage:image];
    
    BluredImage= [[UIImage imageNamed:backgroundImageName] stackBlur:180];
    
    [BlurBackground setImage:BluredImage];
    BlurBackground.alpha=0;
    
    cTable.backgroundColor = [UIColor clearColor];
    cTable.backgroundView = [UIView new] ;
    
    
    [self.cTable registerNib:[UINib nibWithNibName:@"CustomCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    self.cTable.rowHeight = 90;
    
    if ([ViewName isEqualToString:@"Bethany Beyond the Jordan"] || [self.ViewName isEqualToString:@"Dana Biosphere Reserve"] ) {
        
        
        if (IS_HEIGHT_GTE_568) {
            
            v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:Nil options:nil]lastObject];
            [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:22]];
            
        } else {
            v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView-IponeS4" owner:Nil options:nil]lastObject];
            [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:26]];
        }
        
    }
    
    v.parentViewName.text=@"How To Get There";
    v.ViewName.text=ViewName;
    
    
    [v setFrame:CGRectMake(0, 0, 320, self.cTable.bounds.size.height)];
    v.backgroundColor =[UIColor clearColor];
    self.cTable.tableHeaderView =v;
    [super viewDidLoad];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)getTextHeight{
    
    int height;
   // NSLog(@"%@",self.ViewName);
    if ([self.ViewName isEqualToString:@"Petra"])
     height=950;
    else
        if ([self.ViewName isEqualToString:@"The Jordan Valley"])
            height=450;
    else
        if ([self.ViewName isEqualToString:@"Madaba"])
        height=450;
    
        else
            if ([self.ViewName isEqualToString:@"Pella"])
                height=500;
    
    else if ([self.ViewName isEqualToString:@"Aqaba"])
        height=700;
        else if([self.ViewName isEqualToString:@"Umm Qays"]||[self.ViewName isEqualToString:@"Wadi Rum"])
        height=450;
    else
        height=300;
    
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view;
    if(section == 0) {
        
        UIFont *Fontstyle = [UIFont fontWithName:@"Ubuntu" size:14];
        
        //======== Define description label ==========//
        
        UILabel *description= [[UILabel alloc]initWithFrame: CGRectMake(10,10,250,descriptionPlaceHolderSize)];
        description.textColor =[UIColor colorWithHexString:@"ffffff"];
        [description setFont:Fontstyle];
        description.numberOfLines=0;
        description.textAlignment=NSTextAlignmentJustified;
        description.lineBreakMode = NSLineBreakByWordWrapping;
        description.textAlignment=NSTextAlignmentLeft;
        description.text=textViewDescription;
        [description sizeToFit];
        //=============================//
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, 2000)];
        view.backgroundColor =[UIColor colorWithHexString:@"000000 0.0"];
        view.layer.cornerRadius = 9;
        view.layer.masksToBounds = YES;
        
        [view addSubview:description];
        
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return [self getTextHeight];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0 ) {
        
    }
    
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    separatorLineView.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:separatorLineView];
    
    //================ Cell Padding ==============//
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new] ;
    cell.selectedBackgroundView = [UIView new];
    //============================================//

    
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int headerView = self.cTable.contentOffset.y;
    
    v.buttomArrow.image=nil;
    
    if (headerView==0) {
        v.buttomArrow.image=[UIImage imageNamed:@"Down-arrow.png"];
    }
      int y=SCREEN_HEIGHT;
    
    if (headerView >= 0 && headerView <= self.cTable.bounds.size.height ) {
        alpha = headerView / (float) y;
        
        alpha+=0.266999;
        
        if (alpha > 1) {
            alpha = 1;
        }
        
        BlurBackground.alpha=alpha;
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
