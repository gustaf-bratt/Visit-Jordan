//
//  CuisinViewController.m
//  VistJOrdan New
//
//  Created by Faris on 11/21/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "CuisinViewController.h"
#import "UIImage+StackBlur.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"
@interface CuisinViewController ()

@end

@implementation CuisinViewController

float alpha,sectionHeight;

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
    
    HeaderView *v =[[[NSBundle mainBundle]loadNibNamed:@"VideoHeaderView" owner:Nil options:nil]lastObject];
    v.parentViewName.text=ViewTitle;
    v.ViewName.text=ViewName;
    textViewDescription=@"Wherever you are in Jordan, you’re never too far away from a conversation about food. Whether the discussion is a heated argument on the busy streets of Amman over the city’s best kunafe or one in the coastal towns of Aqaba as the catch of the day comes in, or in the most remote part of the Wadi Rum desert you’ll doubtlessly end up talking about food, and if you’re talking about it you’re more than likely to be eating it with your Jordanian hosts later!\n\n Sit down with the bedouin in their desert tents, drink camel milk and eat mansaf the national dish, and you’ll learn how people have survived for centuries in this harsh landscape. Try baklava pastries in any of their forms, and you’ll experience the flavors and recipes of the Ottoman Empire. And if you pick up a menu in cosmopolitan Amman, you’ll see dishes made famous by different ethnicities within the Jordanian community, not to mention cuisine from all around the world.\\n\nIt matters little where people are from, or what language they speak. In Jordan, food is the word on everybody’s lips, and all are welcome to join the discussion. ";
    
    textViewTitle=@"Cuisin";
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
        rows = 1;
    }
    return rows;
}
-(CGFloat)getTextHeight{
    
    return descriptionPlaceHolderSize;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view;
    if(section == 0) {
        
        UIFont *Fontstyle = [UIFont fontWithName:@"Helvetica" size:14];
        
        //======== Define description label ==========//
        UILabel *description =  [[UILabel alloc] initWithFrame: CGRectMake(10,55,250,20)];
        description.textColor =[UIColor colorWithHexString:@"ffffff"];
        [description setFont:Fontstyle];
        description.numberOfLines=0;
        description.textAlignment=NSTextAlignmentJustified;
        description.lineBreakMode = NSLineBreakByWordWrapping;
        ///description.textAlignment=NSTextAlignmentLeft;
        
        //build a style for justification
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:textViewDescription];
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15] range:NSMakeRange(0, str.length)];
        description.attributedText = str;
        
        //description.text=textViewDescription;
        [description sizeToFit];
        
        
        /**(1)** Build the NSAttributedString *******/
        NSMutableAttributedString* attrStr = [NSMutableAttributedString attributedStringWithString:@"Hello World!"];
        // for those calls we don't specify a range so it affects the whole string
        [attrStr setFont:[UIFont systemFontOfSize:12]];
        [attrStr setTextColor:[UIColor grayColor]];
        // now we only change the color of "Hello"
        [attrStr setTextColor:[UIColor redColor] range:NSMakeRange(0,5)];
        
        
        /**(2)** Affect the NSAttributedString to the OHAttributedLabel *******/
        myAttributedLabel.attributedText = attrStr;
        // Use the "Justified" alignment
        myAttributedLabel.textAlignment = UITextAlignmentJustify;
        // "Hello World!" will be displayed in the label, justified, "Hello" in red and " World!" in gray.
        
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
        UILabel *title =  [[UILabel alloc] initWithFrame: CGRectMake(7,10,320,20)];
        title.textColor =[UIColor colorWithHexString:@"ffffff"];
        [title setFont:[UIFont fontWithName:@"Arial" size:26.0f]];
        title.text=textViewTitle;
        //=============================//
        [view addSubview:description];
        [view addSubview:title];
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
    
    
    if (headerView >= 0 && headerView <= self.cTable.bounds.size.height ) {
        alpha = headerView / (float) 480;
        
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
