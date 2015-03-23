//
//  LanguageViewController.m
//  staticTable
//
//  Created by Faris on 11/19/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "LanguageViewController.h"
#import "UIImage+StackBlur.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds].size.height>=568.0f?480:300;
@interface LanguageViewController ()

@end

@implementation LanguageViewController

float alpha,sectionHeight;
HeaderView *v;
HeaderView *v;
@synthesize BlurBackground,NormalBackground,BluredImage,cTable;
@synthesize LabeltextDescription,LabelViewTitle,backgroundImageName;
@synthesize textViewDescription1,textViewDescription2,textViewTitle,ViewTitle,ViewName;
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
    [v setFrame:CGRectMake(0, 0, 320, self.cTable.bounds.size.height)];
    textViewTitle=@"Language";
     [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:30]];
    v.backgroundColor =[UIColor clearColor];
    self.cTable.tableHeaderView =v;
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"LanguageData" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    textViewDescription1 = [[dictionary objectForKey:@"language"] objectForKey:@"text1"];
    textViewDescription2= [[dictionary objectForKey:@"language"] objectForKey:@"text2"];

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
        
        //======== Define letters label & image==========//
        UILabel *description =  [[UILabel alloc] initWithFrame: CGRectMake(10,15,270,400)];
        description.textColor =[UIColor colorWithHexString:@"ffffff"];
        [description setFont:Fontstyle];
        description.numberOfLines=0;
        description.textAlignment=NSTextAlignmentJustified;
        description.lineBreakMode = NSLineBreakByWordWrapping;
        description.textAlignment=NSTextAlignmentLeft;
        description.text=textViewDescription1;
        [description sizeToFit];
        
        UIImage *lettersImage= [UIImage imageNamed:@"language-text.png"];
        lettersImage =  [UIImage imageWithCGImage:[lettersImage CGImage] scale:2.0 orientation:UIImageOrientationUp];
        
        UIImageView *lettersImageView= [[UIImageView alloc]initWithImage:lettersImage];
        UIView *imageLettersHolder = [[UIView alloc]initWithFrame:CGRectMake(8, description.bounds.size.height+20, 200, 0)];
      
         [imageLettersHolder addSubview:lettersImageView];
        //======== Define numbers label & image ==========//
        
        UILabel *description1 =  [[UILabel alloc] initWithFrame: CGRectMake(10,940,250,200)];
        description1.textColor =[UIColor colorWithHexString:@"ffffff"];
        [description1 setFont:Fontstyle];
        description1.numberOfLines=0;
        description1.textAlignment=NSTextAlignmentJustified;
        description1.lineBreakMode = NSLineBreakByWordWrapping;
        description1.textAlignment=NSTextAlignmentLeft;
        description1.text=textViewDescription2;
        [description1 sizeToFit];
        
        
        UIImage *numbersImage= [UIImage imageNamed:@"language-numbers.png"];
        numbersImage =  [UIImage imageWithCGImage:[numbersImage CGImage] scale:2.0 orientation:UIImageOrientationUp];

        UIImageView *numbersImageView= [[UIImageView alloc]initWithImage:numbersImage];
        UIView *numbsersHolder = [[UIView alloc]initWithFrame:CGRectMake(8, 720, 0, 0)];
        [numbsersHolder addSubview:numbersImageView];
        //=============================//
    
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 260, LabeltextDescription.bounds.size.height)];
        view.backgroundColor =[UIColor colorWithHexString:@"000000 0.3"];
        view.layer.cornerRadius = 9;
        view.layer.masksToBounds = YES;


        [view addSubview:description];
        [view addSubview:description1];
        [view addSubview:imageLettersHolder];
        [view addSubview:numbsersHolder];
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
