//
//  ItinerariesViewController.m
//  staticTable
//
//  Created by Faris on 11/19/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "ItinerariesViewController.h"
#import "UIImage+StackBlur.h"
#import "CustomCell.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"
#import "ItinerariesDetailsViewController.h"
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds].size.height>=568.0f?480:300;

@interface ItinerariesViewController ()

@end

@implementation ItinerariesViewController

float alpha,sectionHeight;
HeaderView *v;
@synthesize BlurBackground,NormalBackground,BluredImage,cTable;
@synthesize LabeltextDescription,LabelViewTitle,backgroundImageName;
@synthesize ViewTitle,ViewName;
@synthesize arr_tableData,arr_tableImages;
@synthesize descriptionPlaceHolderSize;
- (void)viewDidLoad
{
    self.title =ViewName;

    UIImage *image = [UIImage imageNamed: backgroundImageName];
    [NormalBackground setImage:image];
    
    BluredImage= [[UIImage imageNamed:backgroundImageName] stackBlur:100];
    
    [BlurBackground setImage:BluredImage];
    BlurBackground.alpha=0;
    
    
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
    [v setFrame:CGRectMake(0, 0, 320, self.cTable.bounds.size.height)];
    v.backgroundColor =[UIColor clearColor];
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
    [cell.cellLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:15]];
    //============================================//
    
    cell.cellLabel.text=arr_tableData[indexPath.row];
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
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ItinerariesDetailsViewController *instanceObject = [sb instantiateViewControllerWithIdentifier:@"ItinerariesDetails"];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"ItinerariesList" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //NSLog(@"%@",[dictionary objectForKey:@"fun"]);
    
    if (indexPath.row==0){
        instanceObject.backgroundImageName=@"itineraires_fun-and-adventure.jpg";
        instanceObject.ViewTitle=@"Itineraries";
        instanceObject.ViewName=@"Fun And Adventure";
        instanceObject.textViewTitle=@"Fun And Adventure";
        instanceObject.arrTextDescription=[[NSArray alloc]initWithObjects:
                                           [[[dictionary objectForKey:@"fun"]objectForKey:@"label1"] objectForKey:@"text"],
                                           [[[dictionary objectForKey:@"fun"]objectForKey:@"label2"] objectForKey:@"text"],
                                           [[[dictionary objectForKey:@"fun"]objectForKey:@"label3"] objectForKey:@"text"],nil];
        
        instanceObject.arrTitle=[[NSArray alloc]initWithObjects:
                                           [[[dictionary objectForKey:@"fun"]objectForKey:@"label1"] objectForKey:@"title"],
                                           [[[dictionary objectForKey:@"fun"]objectForKey:@"label2"] objectForKey:@"title"],
                                           [[[dictionary objectForKey:@"fun"]objectForKey:@"label3"] objectForKey:@"title"],nil];
        
        instanceObject.descriptionPlaceHolderSize=0;
        instanceObject.numberOfSection = 3;
      
    }else if (indexPath.row==1){
        instanceObject.backgroundImageName=@"itineraires_leisure_history-and-culture.jpg";
        instanceObject.ViewTitle=@"Itineraries";
        instanceObject.ViewName=@"History and Culture";
        instanceObject.textViewTitle=@"History and Culture";
        
        instanceObject.arrTextDescription=[[NSArray alloc]initWithObjects:
                                           [[[dictionary objectForKey:@"history"]objectForKey:@"label1"] objectForKey:@"text"],
                                           [[[dictionary objectForKey:@"history"]objectForKey:@"label2"] objectForKey:@"text"],
                                           [[[dictionary objectForKey:@"history"]objectForKey:@"label3"] objectForKey:@"text"],nil];
        
        instanceObject.arrTitle=[[NSArray alloc]initWithObjects:
                                 [[[dictionary objectForKey:@"history"]objectForKey:@"label1"] objectForKey:@"title"],
                                 [[[dictionary objectForKey:@"history"]objectForKey:@"label2"] objectForKey:@"title"],
                                 [[[dictionary objectForKey:@"history"]objectForKey:@"label3"] objectForKey:@"title"],nil];
        instanceObject.descriptionPlaceHolderSize=0;
        instanceObject.numberOfSection = 3;
    }else if (indexPath.row==2){
        
        instanceObject.backgroundImageName=@"itineraires_eco-and-nature.jpg";
        instanceObject.ViewTitle=@"Itineraries";
        instanceObject.ViewName=@"Eco and Nature";
        instanceObject.textViewTitle=@"Eco and Nature";
        

        instanceObject.arrTextDescription=[[NSArray alloc]initWithObjects:
                                           [[[dictionary objectForKey:@"eco"]objectForKey:@"label1"] objectForKey:@"text"],
                                           [[[dictionary objectForKey:@"eco"]objectForKey:@"label2"] objectForKey:@"text"],
                                           [[[dictionary objectForKey:@"eco"]objectForKey:@"label3"] objectForKey:@"text"],nil];
        
        instanceObject.arrTitle=[[NSArray alloc]initWithObjects:
                                 [[[dictionary objectForKey:@"eco"]objectForKey:@"label1"] objectForKey:@"title"],
                                 [[[dictionary objectForKey:@"eco"]objectForKey:@"label2"] objectForKey:@"title"],
                                 [[[dictionary objectForKey:@"eco"]objectForKey:@"label3"] objectForKey:@"title"],nil];
        instanceObject.descriptionPlaceHolderSize=0;
        instanceObject.numberOfSection = 3;
        
    }else if (indexPath.row==3){
        instanceObject.backgroundImageName=@"itineraires_leisure-and-wellness.jpg";
        instanceObject.ViewTitle=@"Itineraries";
        instanceObject.ViewName=@"Leisure and Wellness";
        instanceObject.textViewTitle=@"Leisure and Wellness";
        

        instanceObject.arrTextDescription=[[NSArray alloc]initWithObjects:
                                           [[[dictionary objectForKey:@"leisure"]objectForKey:@"label1"] objectForKey:@"text"],
                                           [[[dictionary objectForKey:@"leisure"]objectForKey:@"label2"] objectForKey:@"text"],
                                           [[[dictionary objectForKey:@"leisure"]objectForKey:@"label3"] objectForKey:@"text"],nil];
        
        instanceObject.arrTitle=[[NSArray alloc]initWithObjects:
                                 [[[dictionary objectForKey:@"leisure"]objectForKey:@"label1"] objectForKey:@"title"],
                                 [[[dictionary objectForKey:@"leisure"]objectForKey:@"label2"] objectForKey:@"title"],
                                 [[[dictionary objectForKey:@"leisure"]objectForKey:@"label3"] objectForKey:@"title"],nil];
        instanceObject.descriptionPlaceHolderSize=0;
        instanceObject.numberOfSection = 3;
        
    }else if (indexPath.row==4){
        instanceObject.backgroundImageName=@"itineraires_biblical-itenraries.jpg";
        instanceObject.ViewTitle=@"Itineraries";
        instanceObject.ViewName=@"Biblical Itineraries";
        instanceObject.textViewTitle=@"Biblical Itineraries";
        
        instanceObject.arrTextDescription=[[NSArray alloc]initWithObjects:
                                           [[[dictionary objectForKey:@"biblical"]objectForKey:@"label1"] objectForKey:@"text"],
                                           [[[dictionary objectForKey:@"biblical"]objectForKey:@"label2"] objectForKey:@"text"],
                                           [[[dictionary objectForKey:@"biblical"]objectForKey:@"label3"] objectForKey:@"text"],
                                           [[[dictionary objectForKey:@"biblical"]objectForKey:@"label4"] objectForKey:@"text"],nil];
        
        instanceObject.arrTitle=[[NSArray alloc]initWithObjects:
                                 [[[dictionary objectForKey:@"biblical"]objectForKey:@"label1"] objectForKey:@"title"],
                                 [[[dictionary objectForKey:@"biblical"]objectForKey:@"label2"] objectForKey:@"title"],
                                 [[[dictionary objectForKey:@"biblical"]objectForKey:@"label3"] objectForKey:@"title"],
                                 [[[dictionary objectForKey:@"biblical"]objectForKey:@"label4"] objectForKey:@"title"],nil];
        
        instanceObject.descriptionPlaceHolderSize=0;
        instanceObject.numberOfSection = 4;
    }
    
    
    [self.navigationController pushViewController:instanceObject animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
