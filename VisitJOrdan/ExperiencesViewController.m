//
//  ViewController.m
//  staticTable
//
//  Created by Faris on 11/14/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "ExperiencesViewController.h"
#import "UIImage+StackBlur.h"
#import "CustomCell.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"
#import "ExperiencesLevel1.h"

#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds].size.height>=568.0f?480:300;
@interface ExperiencesViewController ()

@end

@implementation ExperiencesViewController

float alpha,sectionHeight;
HeaderView *v;
@synthesize BlurBackground,NormalBackground,BluredImage,cTable;
@synthesize LabeltextDescription,LabelViewTitle,backgroundImageName;
@synthesize textViewDescription,textViewTitle,ViewTitle,ViewName;
@synthesize arr_tableData,arr_tableImages;
@synthesize descriptionPlaceHolderSize;

- (void)viewDidLoad
{

    UIImage *image = [UIImage imageNamed: backgroundImageName];
    [NormalBackground setImage:image];
    
    BluredImage= [[UIImage imageNamed:backgroundImageName] stackBlur:100];
    
    [BlurBackground setImage:BluredImage];
    BlurBackground.alpha=0;
    
    
    cTable.backgroundColor = [UIColor clearColor];
    cTable.backgroundView = [UIView new] ;
    self.title =ViewName;
    
    
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

    [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:28]];
    /*
    for (NSString *familyName in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"%@", fontName);
        }
    }
    */
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
    
    if (indexPath.section == 0 ) {
        
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
    ExperiencesLevel1 *instanceObject = [sb instantiateViewControllerWithIdentifier:@"ExperiencesLevel1"];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"Experiences" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    

    
    if (indexPath.row==0) {
        
        instanceObject.backgroundImageName=@"Fun-and-adventure.jpg";
        instanceObject.ViewTitle=@"Experiences";
        instanceObject.ViewName=@"Fun & Adventure";
        instanceObject.PlistName=@"fun";
        instanceObject.textViewTitle=@"Fun & Adventure";
        instanceObject.textViewDescription=[[dictionary objectForKey:@"fun"] objectForKey:@"description"];
        instanceObject.descriptionPlaceHolderSize=210;
        instanceObject.arr_tableData=[[dictionary objectForKey:@"fun"] objectForKey:@"names"];
        instanceObject.arr_tableImages=[[dictionary objectForKey:@"fun"] objectForKey:@"images"];
        
    }else if (indexPath.row==1) {
        instanceObject.backgroundImageName=@"history-and-culture.jpg";
        instanceObject.ViewTitle=@"Experiences";
        instanceObject.ViewName=@"History & Culture";
        instanceObject.PlistName=@"history";
        instanceObject.textViewTitle=@"History & Culture";
        instanceObject.textViewDescription=[[dictionary objectForKey:@"history"] objectForKey:@"description"];
        instanceObject.descriptionPlaceHolderSize=210;
        instanceObject.arr_tableData=[[dictionary objectForKey:@"history"] objectForKey:@"names"];
        instanceObject.arr_tableImages=[[dictionary objectForKey:@"history"] objectForKey:@"images"];

        
    }else if (indexPath.row==2) {
        instanceObject.backgroundImageName=@"Eco-and-Nature.jpg";
        instanceObject.ViewTitle=@"Experiences";
        instanceObject.ViewName=@"Eco & Nature";
        instanceObject.PlistName=@"eco";
        instanceObject.textViewTitle=@"Eco & Nature";
        instanceObject.textViewDescription=[[dictionary objectForKey:@"eco"] objectForKey:@"description"];
        instanceObject.descriptionPlaceHolderSize=150;
        instanceObject.arr_tableData=[[dictionary objectForKey:@"eco"] objectForKey:@"names"];
        instanceObject.arr_tableImages=[[dictionary objectForKey:@"eco"] objectForKey:@"images"];
        
    } else if (indexPath.row==3) {
        instanceObject.backgroundImageName=@"lesurie-and-welness.jpg";
        instanceObject.ViewTitle=@"Experiences";
        instanceObject.ViewName=@"Leisure & Wellness";
        instanceObject.PlistName=@"leisure";
        instanceObject.textViewTitle=@"Leisure & Wellness";
        instanceObject.textViewDescription=[[dictionary objectForKey:@"leisure"] objectForKey:@"description"];
        instanceObject.descriptionPlaceHolderSize=190;
        instanceObject.arr_tableData=[[dictionary objectForKey:@"leisure"] objectForKey:@"names"];
        instanceObject.arr_tableImages=[[dictionary objectForKey:@"leisure"] objectForKey:@"images"];
        
    } else if (indexPath.row==4) {
        instanceObject.backgroundImageName=@"religion-and-faith.jpg";
        instanceObject.ViewTitle=@"Experiences";
        instanceObject.ViewName=@"Religion & Faith";
        instanceObject.PlistName=@"religion";
        instanceObject.textViewTitle=@"Religion & Faith";
        instanceObject.textViewDescription=[[dictionary objectForKey:@"religion"] objectForKey:@"description"];
        instanceObject.descriptionPlaceHolderSize=140;
        instanceObject.arr_tableData=[[dictionary objectForKey:@"religion"] objectForKey:@"names"];
        instanceObject.arr_tableImages=[[dictionary objectForKey:@"religion"] objectForKey:@"images"];
        
    } else if (indexPath.row==5) {
        instanceObject.backgroundImageName=@"conferances-and-events.jpg";
        instanceObject.ViewTitle=@"Experiences";
        instanceObject.ViewName=@"Conferences & Events";
        instanceObject.PlistName=@"events";
        instanceObject.textViewTitle=@"Conferences & Events";
        instanceObject.textViewDescription=[[dictionary objectForKey:@"events"] objectForKey:@"description"];
        instanceObject.descriptionPlaceHolderSize=160;
        instanceObject.arr_tableData=[[dictionary objectForKey:@"events"] objectForKey:@"names"];
        instanceObject.arr_tableImages=[[dictionary objectForKey:@"events"] objectForKey:@"images"];
        
    }
    
    
     [self.navigationController pushViewController:instanceObject animated:YES];
    
    //instanceObject.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //[self presentViewController:instanceObject  animated:YES completion:NULL ];
    
  
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"x"]) {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
