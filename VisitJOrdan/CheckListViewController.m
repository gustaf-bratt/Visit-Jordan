//
//  CheckListViewController.m
//  staticTable
//
//  Created by Faris on 11/19/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//


#import "CheckListViewController.h"
#import "UIImage+StackBlur.h"
#import "CustomCell.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds].size.height>=568.0f?480:300;
@interface CheckListViewController ()

@end

@implementation CheckListViewController

float alpha,sectionHeight;
HeaderView *v;
@synthesize BlurBackground,NormalBackground,BluredImage,cTable;
@synthesize LabeltextDescription,LabelViewTitle,backgroundImageName;
@synthesize textViewDescription,textViewTitle,ViewTitle,ViewName;
@synthesize arr_tableData,arr_tableImages;
@synthesize descriptionPlaceHolderSize;
@synthesize PlistName;
- (void)viewDidLoad
{
    self.title =@"Checklist";
    UIImage *image = [UIImage imageNamed: backgroundImageName];
    [NormalBackground setImage:image];
    
    BluredImage= [[UIImage imageNamed:backgroundImageName] stackBlur:100];
    
    [BlurBackground setImage:BluredImage];
    BlurBackground.alpha=0;
    
    
    cTable.backgroundColor = [UIColor clearColor];
    cTable.backgroundView = [UIView new] ;
    
    cTable.layer.cornerRadius = 9;
    cTable.layer.masksToBounds = YES;
    
    
    [self.cTable registerNib:[UINib nibWithNibName:@"CheckListCustomCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    self.cTable.rowHeight = 140;
    
    if (IS_HEIGHT_GTE_568) {
        v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:Nil options:nil]lastObject];
        v.parentViewName.text=@"";
        v.ViewName.text=@"Checklist";
    } else {
        v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView-IponeS4" owner:Nil options:nil]lastObject];
        v.parentViewName.text=@"";
        v.ViewName.text=@"Checklist";
    }

   [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:30]];
    [v setFrame:CGRectMake(0, 0, 320, self.cTable.bounds.size.height)];
    v.backgroundColor =[UIColor clearColor];
    cTable.backgroundColor = [UIColor clearColor];
    cTable.backgroundView = [UIView new];
    self.cTable.tableHeaderView =v;
    self.cTable.rowHeight=300;
    [super viewDidLoad];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows = 0;
    
    if (section==0) {
        rows = 0;
    }
    else if (section==1){
        rows = arr_tableData.count;
    }
    return rows;
}
-(CGFloat)getTextHeight{
    
    return descriptionPlaceHolderSize;
}
/*
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view;
    if(section == 0) {
        
        UIFont *Fontstyle = [UIFont fontWithName:@"Helvetica" size:14];
        
        //======== Define description label ==========//
        UILabel *description =  [[UILabel alloc] initWithFrame: CGRectMake(10,55,240,20)];
        description.textColor =[UIColor colorWithHexString:@"ffffff"];
        [description setFont:Fontstyle];
        description.numberOfLines=0;
        description.textAlignment=NSTextAlignmentJustified;
        description.lineBreakMode = NSLineBreakByWordWrapping;
        description.textAlignment=NSTextAlignmentLeft;
        description.text=@"Make sure you do not leave the country before checking off the list of experiences below:";
        [description sizeToFit];
        //=============================//
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, LabeltextDescription.bounds.size.height+80)];
        view.backgroundColor =[UIColor colorWithHexString:@"000000 0.6"];
        view.layer.cornerRadius = 9;
        view.layer.masksToBounds = YES;
        //======== title  holder ==========//
        UIView *titleHolder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        //titleHolder.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"header_title.png"]];
        titleHolder.backgroundColor =[UIColor colorWithHexString:@"#000000 0.4"];
        [view addSubview:titleHolder];
        
        //======== add title ==========//
        UILabel *title;
        if([PlistName isEqualToString:@"Conferences"])
            title =  [[UILabel alloc] initWithFrame: CGRectMake(2,10,320,20)];
        else
            title =  [[UILabel alloc] initWithFrame: CGRectMake(20,10,320,20)];
        title.textColor =[UIColor colorWithHexString:@"ffffff"];
        [title setFont:[UIFont fontWithName:@"Arial" size:26.0f]];
        title.text=textViewTitle;
        //=============================//
        [view addSubview:description];
        [view addSubview:title];
    }
    return view;
}
 */

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return [self getTextHeight];
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    

    
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
    separatorLineView.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:separatorLineView];
    
    //================ Cell Padding ==============//
  
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new] ;
    cell.selectedBackgroundView = [UIView new];
    [cell.cellLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:15]];
    //============================================//
    
    cell.cellLabel.text=arr_tableData[indexPath.row];
    cell.cellImageView.image=[UIImage imageNamed:arr_tableImages[indexPath.row]];
    cell.cellLabel.numberOfLines=0;
    
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

