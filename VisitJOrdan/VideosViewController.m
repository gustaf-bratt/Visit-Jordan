//
//  VideosViewController.m
//  staticTable
//
//  Created by Faris on 11/19/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

//
//  ItinerariesViewController.m
//  staticTable
//
//  Created by Faris on 11/19/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "VideosViewController.h"
#import "UIImage+StackBlur.h"
#import "CustomCell.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"
#import "VideoOpener.h"
#import "Connection.h"

#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds].size.height>=568.0f?480:300;
@interface VideosViewController ()

@end

@implementation VideosViewController

float alpha,sectionHeight;
HeaderView *v;
@synthesize BlurBackground,NormalBackground,BluredImage,cTable;
@synthesize LabeltextDescription,LabelViewTitle,backgroundImageName;
@synthesize ViewTitle,ViewName;
@synthesize arr_tableData,arr_tableImages,arr_VideoID;
@synthesize descriptionPlaceHolderSize;
- (void)viewDidLoad
{
    self.title=ViewName;
    UIImage *image = [UIImage imageNamed: backgroundImageName];
    [NormalBackground setImage:image];
    
    BluredImage= [[UIImage imageNamed:backgroundImageName] stackBlur:100];

    [BlurBackground setImage:BluredImage];
    BlurBackground.alpha=0;
    
    
    arr_tableData=[[NSArray alloc]initWithObjects:
                                  @"Fun and Adventure",
                                  @"History and Culture",
                                  @"Eco and Nature",
                                  @"Religion and Faith",
                                  @"Meetings, conferences and Events in Jordan",nil];
    
    arr_tableImages=[[NSArray alloc]initWithObjects:
                     
                                    @"fun&ad.png",
                                    @"history-and-culture.png",
                                    @"eco-and-nature.png",
                                    @"religion-and-faith.png",
                                    @"events-and-conferences.png",
                                    nil];
    
    arr_VideoID=[[NSArray alloc]initWithObjects:
                     @"gLa7jcbVlNM",
                     @"1DP64eHZAYA",
                     @"tvI1ztjbiwk",
                     @"cpV9VotSPRE",
                     @"eB7huBi2T6o",nil];
    
    
    cTable.backgroundColor = [UIColor clearColor];
    cTable.backgroundView = [UIView new] ;
    
    
    
    [self.cTable registerNib:[UINib nibWithNibName:@"CustomCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    self.cTable.rowHeight = 100;
    
    
    if (IS_HEIGHT_GTE_568) {
        v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:Nil options:nil]lastObject];
        v.parentViewName.text=ViewTitle;
        v.ViewName.text=ViewName;
    } else {
        v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView-IponeS4" owner:Nil options:nil]lastObject];
        v.parentViewName.text=ViewTitle;
        v.ViewName.text=ViewName;
    }
    
    v.parentViewName.text=ViewTitle;
    v.ViewName.text=ViewName;
    [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:30]];
    v.backgroundColor =[UIColor clearColor];
     [v setFrame:CGRectMake(0, 0, 320, self.cTable.bounds.size.height)];
    self.cTable.tableHeaderView =v;
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
    //============================================//
    
    cell.cellLabel.text=arr_tableData[indexPath.row];
    [cell.cellLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:15]];
    cell.cellImageView.image=[UIImage imageNamed:arr_tableImages[indexPath.row]];
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([Connection isConnected]) {
		VideoOpener *controller = [[VideoOpener alloc] initWithNibName:@"VideoOpener" bundle:nil];
        controller.linkAddress=[arr_VideoID objectAtIndex:indexPath.row];
        controller.videoName=arr_tableData[indexPath.row];
		[self.navigationController pushViewController:controller animated:YES];
	}else {
		UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Network Error" message: @"Error connecting to the internet" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
		[someError show];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
