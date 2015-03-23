//
//  ExperiencesCitiesViewC.m
//  VistJOrdan New
//
//  Created by Faris on 11/26/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "ExperiencesCitiesViewC.h"
#import "UIImage+StackBlur.h"
#import "CustomCell.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"
#import  "MapViewController.h"
#import "GetThereViewController.h"

#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds].size.height>=568.0f?480:300;

@interface ExperiencesCitiesViewC ()

@end

@implementation ExperiencesCitiesViewC

float alpha,sectionHeight;
HeaderView *v ;
@synthesize BlurBackground,NormalBackground,BluredImage,cTable;
@synthesize LabeltextDescription,LabelViewTitle,backgroundImageName;
@synthesize textViewDescription,textViewTitle,ViewTitle,ViewName;
@synthesize arr_tableData,arr_tableImages;
@synthesize descriptionPlaceHolderSize;
@synthesize PlistName;
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
    
    arr_tableData=[[NSArray alloc]initWithObjects:@"\tHow to get there",@"\tMap", nil];
    arr_tableImages=[[NSArray alloc]initWithObjects:@"how-to-get-there.png",@"Map-ic.png", nil];
    
    [self.cTable registerNib:[UINib nibWithNibName:@"CustomCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    self.cTable.rowHeight = 90;
    
    
        
        if (IS_HEIGHT_GTE_568) {
            
            v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:Nil options:nil]lastObject];
             [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:28]];
            
            if ([ViewName isEqualToString:@"Bethany Beyond the Jordan"] || [self.ViewName isEqualToString:@"Dana Biosphere Reserve"] ){
            [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:22]];
                
            }
           
        } else {
            v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView-IponeS4" owner:Nil options:nil]lastObject];
            [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:28]];
            
            if ([ViewName isEqualToString:@"Bethany Beyond the Jordan"] || [self.ViewName isEqualToString:@"Dana Biosphere Reserve"] ){
                [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:22]];
                
            }
        }
    
    
    v.parentViewName.text=ViewTitle;
    v.ViewName.text=ViewName;
    
    
    
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
    //NSLog(@"%@",ViewName);
    
    if ([self.ViewName isEqualToString:@"Aqaba"] && [self.ViewTitle isEqualToString:@"History & Culture" ]){
        return 725;
    }
    
    
    if ([self.ViewName isEqualToString:@"Dana Biosphere Reserve"] && [self.ViewTitle isEqualToString:@"Eco & Nature" ]){
        return 370;
    }

    if ([self.ViewName isEqualToString:@"Dana Biosphere Reserve"])
        return 150;
    
    if ([self.ViewName isEqualToString:@"Aqaba"] && [self.ViewTitle isEqualToString:@"Eco & Nature" ]){
        return 600;
    }

    if ([self.ViewName isEqualToString:@"Wadi Mujib"] && [self.ViewTitle isEqualToString:@"Eco & Nature" ]){
        return 630;
    }

    if ([self.ViewName isEqualToString:@"Wadi Rum"] && [self.ViewTitle isEqualToString:@"Eco & Nature" ]){
        return 570;
    }
    
    if ([self.ViewName isEqualToString:@"The Dead Sea"] && [self.ViewTitle isEqualToString:@"Leisure & Wellness" ]){
        return 670;
    }
    if ([self.ViewName isEqualToString:@"Hammamat Ma'in"] && [self.ViewTitle isEqualToString:@"Leisure & Wellness" ]){
        return 430;
    }
    if ([self.ViewName isEqualToString:@"Amman"] && [self.ViewTitle isEqualToString:@"Leisure & Wellness" ]){
        return 430;
    }
    if ([self.ViewName isEqualToString:@"Aqaba"] && [self.ViewTitle isEqualToString:@"Leisure & Wellness" ]){
        return 510;
    }
    
    if ([self.ViewName isEqualToString:@"Madaba"] && [self.ViewTitle isEqualToString:@"Religion & Faith" ]){
        return 480;
    }
    
    if ([self.ViewName isEqualToString:@"Bethany Beyond the Jordan"] && [self.ViewTitle isEqualToString:@"Religion & Faith" ]){
        return 460;
    }
    
    if ([self.ViewName isEqualToString:@"Mukawir"] && [self.ViewTitle isEqualToString:@"Religion & Faith" ]){
        return 250;
    }
    if ([self.ViewName isEqualToString:@"Anjara"] && [self.ViewTitle isEqualToString:@"Religion & Faith" ]){
        return 250;
    }
    
    if ([self.ViewName isEqualToString:@"Amman"] && [self.ViewTitle isEqualToString:@"Conferences & Events" ]){
        return 610;
    }
    if ([self.ViewName isEqualToString:@"The Dead Sea"] && [self.ViewTitle isEqualToString:@"Conferences & Events" ]){
        return 400;
    }
    
    if ([self.ViewName isEqualToString:@"Petra"] && [self.ViewTitle isEqualToString:@"Conferences & Events" ]){
        return 400;
    }
    if ([self.ViewName isEqualToString:@"Aqaba"] && [self.ViewTitle isEqualToString:@"Conferences & Events" ]){
        return 600;
    }
    
    if ([self.ViewName isEqualToString:@"Jerash"])
        return 600;
    
    if ([self.ViewName isEqualToString:@"As-Salt"])
        return 630;
    
    if ([self.ViewName isEqualToString:@"Mount Nebo"])
        return 360;
    
    if ([self.ViewName isEqualToString:@"Mukawir"])
        return 210;
    
    if ([self.ViewName isEqualToString:@"The Jordan Valley"])
        return 170;
    
    if ([self.ViewName isEqualToString:@"Karak"])
        return 850;
    
    if ([self.ViewName isEqualToString:@"Ajlun"])
        return 700;
    
    if ([self.ViewName isEqualToString:@"Umm Qays"])
        return 350;
    
    if ([self.ViewName isEqualToString:@"Aqaba"])
        return 347;
    
    if ([self.ViewName isEqualToString:@"Amman"])
        return 550;
    
    if ([self.ViewName isEqualToString:@"Petra"]  && [self.ViewTitle isEqualToString:@"History & Culture" ])
        return 640;
    
    if ([self.ViewName isEqualToString:@"Pella"]  && [self.ViewTitle isEqualToString:@"History & Culture" ])
        return 340;
    
    return descriptionPlaceHolderSize;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view;
    if(section == 0) {
        
        UIFont *Fontstyle = [UIFont fontWithName:@"Ubuntu-Medium" size:14];
        
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
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, 100)];
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
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"Experiences" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    if(indexPath.row==0){
        
        GetThereViewController *contView = [sb instantiateViewControllerWithIdentifier:@"GetThereView"];
        
        contView.ViewName=ViewName;
        contView.PlistName=ViewName;
        contView.backgroundImageName=backgroundImageName;
        contView.descriptionPlaceHolderSize=500;
        contView.textViewDescription= [[[[[dictionary
                                           objectForKey:@"Experiences"]
                                          objectForKey:PlistName]
                                         objectForKey:@"Locations"]
                                        objectForKey:ViewName]
                                       objectForKey:@"GetThere"];
        
        [self.navigationController pushViewController:contView animated:YES];
        
    }else if (indexPath.row==1) {
        
        MapViewController *map = [sb instantiateViewControllerWithIdentifier:@"MapView"];
        // NSLog(@"PlistName: %@",PlistName);
        // NSLog(@"locationName: %@",ViewName);
        
        map.x=[[[[[[dictionary
                    objectForKey:@"Experiences"]
                   objectForKey:PlistName]
                  objectForKey:@"Locations"]
                 objectForKey:ViewName]
                objectForKey:@"Latitude"]doubleValue];
        
        map.y= [[[[[[dictionary
                     objectForKey:@"Experiences"]
                    objectForKey:PlistName]
                   objectForKey:@"Locations"]
                  objectForKey:ViewName]//city name
                 objectForKey:@"Longitude"]doubleValue];
        
        map.locationName=ViewName;
        
        [self.navigationController pushViewController:map animated:YES];
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
