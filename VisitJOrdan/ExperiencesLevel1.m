//
//  ExperiencesLevel1.m
//  staticTable
//
//  Created by Faris on 11/19/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "ExperiencesLevel1.h"
#import "ExperiencesCitiesViewC.h"
#import "UIImage+StackBlur.h"
#import "CustomCell.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"

#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds].size.height>=568.0f?480:300

@interface ExperiencesLevel1 ()

@end

@implementation ExperiencesLevel1

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
    UIImage *image = [UIImage imageNamed: backgroundImageName];
    [NormalBackground setImage:image];
    
    BluredImage= [[UIImage imageNamed:backgroundImageName] stackBlur:100];
    
    [BlurBackground setImage:BluredImage];
    BlurBackground.alpha=0;
    self.title =ViewName;
    
    cTable.backgroundColor = [UIColor clearColor];
    cTable.backgroundView = [UIView new] ;
    
    
    [self.cTable registerNib:[UINib nibWithNibName:@"hotelsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    self.cTable.rowHeight = 160;
    
    if (IS_HEIGHT_GTE_568) {
        v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:Nil options:nil]lastObject];
        v.parentViewName.text=ViewTitle;
        v.ViewName.text=ViewName;
    } else {
        v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView-IponeS4" owner:Nil options:nil]lastObject];
        v.parentViewName.text=ViewTitle;
        v.ViewName.text=ViewName;
    }
    
    //[v.parentViewName setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:17]];
    [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:28]];
  
    
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
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, LabeltextDescription.bounds.size.height+80)];
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
    //============================================//
    
   // cell.cellLabel.text=arr_tableData[indexPath.row];
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
    ExperiencesCitiesViewC *instanceObject = [sb instantiateViewControllerWithIdentifier:@"ExperiencesCities"];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"Experiences" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
        
        

        instanceObject.ViewTitle=ViewName;
        instanceObject.ViewName=arr_tableData[indexPath.row];
        instanceObject.PlistName=PlistName;
        instanceObject.textViewDescription=[[[[[dictionary
                                             objectForKey:@"Experiences"]
                                             objectForKey:PlistName]
                                             objectForKey:@"Locations"]
                                             objectForKey:arr_tableData[indexPath.row]]//city name
                                             valueForKey:@"Description"];
    
        instanceObject.backgroundImageName=[[[[[dictionary
                                            objectForKey:@"Experiences"]
                                           objectForKey:PlistName]
                                          objectForKey:@"Locations"]
                                         objectForKey:arr_tableData[indexPath.row]]//city name
                                        valueForKey:@"Map"];

    
    instanceObject.descriptionPlaceHolderSize=300;
    
    [self.navigationController pushViewController:instanceObject animated:YES];

    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
