//
//  HandCraftsViewController.m
//  VistJOrdan New
//
//  Created by Faris on 11/21/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "HandCraftsViewController.h"
#import "UIImage+StackBlur.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"

#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds].size.height>=568.0f?480:300;

@interface HandCraftsViewController ()

@end

@implementation HandCraftsViewController

float alpha,sectionHeight;
HeaderView *v;
@synthesize BlurBackground,NormalBackground,BluredImage,cTable;
@synthesize LabeltextDescription,LabelViewTitle,backgroundImageName;
@synthesize textViewDescription,textViewTitle,ViewTitle,ViewName;
@synthesize descriptionPlaceHolderSize;
- (void)viewDidLoad
{
    self.title=ViewName;
    UIImage *image = [UIImage imageNamed: backgroundImageName];
    [NormalBackground setImage:image];
    
    BluredImage= [[UIImage imageNamed:backgroundImageName] stackBlur:100];
    
    [BlurBackground setImage:BluredImage];
    BlurBackground.alpha=0;
    
    
    cTable.backgroundColor = [UIColor clearColor];
    cTable.backgroundView = [UIView new] ;
    
    
    self.cTable.rowHeight = 100;
    
    if (IS_HEIGHT_GTE_568) {
        v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:Nil options:nil]lastObject];
        
    } else {
        v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView-IponeS4" owner:Nil options:nil]lastObject];
        
    }
    
    v.parentViewName.text=ViewTitle;
    v.ViewName.text=ViewName;
   [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:30]];
    textViewDescription=@"Take time to visit the souq in downtown Amman.  This is a treasure trove for those seeking something a little bit out of the ordinary and authentically Jordanian.  Find great bargains at our excellent gold and silver outlets! Do not miss the busy little spice shops to get your own herbs and seasonings; we know that once you try Jordanian flavors you are going to want to take some home!\n\nFind hand-woven rugs and cushions, beautifully embroidered fabrics and clothing, traditional pottery and glassware, not to mention silver jewelry embedded with semi-precious stones, mosaics, as well as handmade bedouin daggers at all popular tourist sites, hotel boutiques and visitors' centers. These gorgeous handicrafts are handmade locally by Jordanian women carrying on the traditions of their ancestors. There is nothing like finding the perfect Thawb (traditional dress), embroidered in a unique oriental design to complete your shopping experience and take home for yourself or bring back as a gift for a loved one. If you're looking for beauty and skin care supplies you'll find healing and rejuvenating Dead Sea and olive oil products available across the country. Although nothing can compare to your visit to Jordan, bring back a breathtaking landscape created with colored sand in a bottle therefore forever preserving your experience.";
    textViewTitle=@"HandCrafts";
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
    
    return descriptionPlaceHolderSize;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view;
    if(section == 0) {
        
        UIFont *Fontstyle = [UIFont fontWithName:@"Ubuntu-Medium" size:14];
        
        UILabel *description= [[UILabel alloc]initWithFrame: CGRectMake(10,10,270,700)];
        description.textColor =[UIColor colorWithHexString:@"ffffff"];
        [description setFont:Fontstyle];
        description.numberOfLines=0;
        description.textAlignment=NSTextAlignmentJustified;
        description.lineBreakMode = NSLineBreakByWordWrapping;
        description.textAlignment=NSTextAlignmentLeft;
        description.text=textViewDescription;
        [description sizeToFit];
        //=============================//
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, 700)];
        view.backgroundColor =[UIColor colorWithHexString:@"000000 0.3"];
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
