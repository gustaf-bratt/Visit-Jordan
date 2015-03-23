//
//  ItinerariesDetailsViewController.m
//  staticTable
//
//  Created by Faris on 11/19/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "ItinerariesDetailsViewController.h"
#import "UIImage+StackBlur.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"
#import "ItinerariesDetailCell.h"
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds].size.height>=568.0f?480:300;

@interface ItinerariesDetailsViewController ()

@end

@implementation ItinerariesDetailsViewController

float alpha,sectionHeight;
HeaderView *v;
@synthesize BlurBackground,NormalBackground,BluredImage,cTable;
@synthesize LabeltextDescription,LabelViewTitle,backgroundImageName;
@synthesize textViewTitle,ViewTitle,ViewName;
@synthesize descriptionPlaceHolderSize;
@synthesize arrTextDescription,arrTitle;
@synthesize numberOfSection;

- (void)viewDidLoad
{
    self.title =ViewName;
    UIImage *image = [UIImage imageNamed: backgroundImageName];
    [NormalBackground setImage:image];
    
    BluredImage= [[UIImage imageNamed:backgroundImageName] stackBlur:100];
    
    [BlurBackground setImage:BluredImage];
    BlurBackground.alpha=0;
    //NSLog(@"%@",[arrTextDescription objectAtIndex:2]);
    
    
    cTable.backgroundColor = [UIColor clearColor];
    cTable.backgroundView = [UIView new] ;
    
    
    if (IS_HEIGHT_GTE_568) {
        v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:Nil options:nil]lastObject];
        v.parentViewName.text=ViewTitle;
        v.ViewName.text=ViewName;
        
    } else {
        v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView-IponeS4" owner:Nil options:nil]lastObject];
        v.parentViewName.text=ViewTitle;
        v.ViewName.text=ViewName;
    }
    
    [v.parentViewName setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:17]];
    [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:28]];
    
    [v setFrame:CGRectMake(0, 0, 320, self.cTable.bounds.size.height+40)];
    v.backgroundColor =[UIColor clearColor];
    self.cTable.tableHeaderView =v;
    [super viewDidLoad];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

      return numberOfSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *h;
        h = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.cTable.frame.size.width,100)];
        h.backgroundColor=[UIColor colorWithHexString:@"000000 0.7"];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 20)];
        title.textColor=[UIColor whiteColor];
        title.text =[arrTitle objectAtIndex:section];
        [h addSubview:title];
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: h.bounds byRoundingCorners:
                      UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii: (CGSize){10, 10.0}].CGPath;
    h.layer.mask = maskLayer;
    
    //[h.layer setCornerRadius:7.0f];
    //[h.layer setMasksToBounds:YES];
    
    

    return h;
}
-(CGFloat)tableView:(UITableView *)tableView HeightForFooterInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
    UIView *h;
    h = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,5)];
    h.backgroundColor=[UIColor colorWithHexString:@"000000 0.3"];
    
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: h.bounds byRoundingCorners:
                      UIRectCornerBottomLeft | UIRectCornerBottomRight  cornerRadii: (CGSize){10, 10.0}].CGPath;
    h.layer.mask = maskLayer;
    
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = [[arrTextDescription objectAtIndex:indexPath.section]
                   sizeWithFont:[UIFont fontWithName:@"Ubuntu-Medium" size:15]
                   constrainedToSize:CGSizeMake(280, CGFLOAT_MAX)];
    return size.height+70;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.textLabel.numberOfLines=0;
    cell.backgroundColor = [UIColor colorWithHexString:@"000000 0.2"];
    cell.backgroundView = [UIView new];
    cell.selectedBackgroundView = [UIView new];
    [cell.textLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:15]];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.selectedBackgroundView = [UIView new];
    cell.textLabel.text=[arrTextDescription objectAtIndex:indexPath.section];
    
    //[cell.layer setCornerRadius:7.0f];
   // [cell.layer setMasksToBounds:YES];

    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
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
