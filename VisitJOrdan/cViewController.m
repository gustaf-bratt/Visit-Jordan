//
//  cViewController.m
//  VistJOrdan New
//
//  Created by Faris on 11/21/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "cViewController.h"
#import "UIImage+StackBlur.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds].size.height>=568.0f?480:300;


@interface cViewController ()

@end

@implementation cViewController

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
    
    textViewDescription=@"Wherever you are in Jordan, you\'re never too far away from a conversation about food. Whether the discussion is a heated argument on the busy streets of Amman over the city\'s best kunafe or one in the coastal towns of Aqaba as the catch of the day comes in, or in the most remote part of the Wadi Rum desert you\'ll doubtlessly end up talking about food, and if you\'re talking about it you\'re more than likely to be eating it with your Jordanian hosts later!\n\nSit down with the bedouin in their desert tents, drink camel milk and eat mansaf the national dish, and you\'ll learn how people have survived for centuries in this harsh landscape. Try baklava pastries in any of their forms, and you'll experience the flavors and recipes of the Ottoman Empire. And if you pick up a menu in cosmopolitan Amman, you\'ll see dishes made famous by different ethnicities within the Jordanian community, not to mention cuisine from all around the world.\n\nIt matters little where people are from, or what language they speak. In Jordan, food is the word on everybody\'s lips, and all are welcome to join the discussion.";
    
    textViewTitle=@"Cuisin";
    v.backgroundColor =[UIColor clearColor];
    [v setFrame:CGRectMake(0, 0, 320, self.cTable.bounds.size.height+30)];
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
        
        //======== Define description label ==========//
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
