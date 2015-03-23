//
//  EmbassiesViewController.m
//  VistJOrdan New
//
//  Created by Faris on 11/24/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "EmbassiesViewController.h"
#import "UIImage+StackBlur.h"
#import "CustomCell.h"
#import "HeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIColor.h>
#import "UIColor_Hex.h"
#import "Connection.h"
#import "EmbassiesDetailsViewCont.h"
#import "InternetConnection.h"
#import "HUD.h"
#import "LoadHotelsJSONData.h"

#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define SCREEN_HEIGHT [[UIScreen mainScreen ] bounds].size.height>=568.0f?480:300;

@interface EmbassiesViewController ()
@property (nonatomic,strong) NSDictionary *dicEmbassies;
@property (nonatomic,strong)NSArray * arrEmbassies;
@property NSInteger listsize;
@end

@implementation EmbassiesViewController

float alpha,sectionHeight;
HeaderView *v;
@synthesize BlurBackground,NormalBackground,BluredImage,cTable;
@synthesize LabeltextDescription,LabelViewTitle,backgroundImageName;
@synthesize ViewTitle,ViewName;
@synthesize arr_tableData,arr_tableImages;
@synthesize descriptionPlaceHolderSize;
@synthesize arrEmbassies,dicEmbassies;
@synthesize ListOfData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=ViewName;
    
    UIImage *image = [UIImage imageNamed: backgroundImageName];
    [NormalBackground setImage:image];
    
    BluredImage= [[UIImage imageNamed:backgroundImageName] stackBlur:200];
    
    [BlurBackground setImage:BluredImage];
    BlurBackground.alpha=0;
    
    [HUD showUIBlockingIndicatorWithText:@"Loading... Please Wait" withTimeout:8];
    
    
    if ([self connectedToInternet]) {
        
        dispatch_queue_t loadJSON = dispatch_queue_create("Load JSON Feed",NULL);
        
        dispatch_async(loadJSON, ^{
            
            //NSLog(@"loading Started...");
            NSString *url = [[NSString alloc]initWithFormat:@"http://ns1.vm1692.sgvps.net/~karasi/visitjordan/embassies.php" ];
            
            NSData* ytData = [NSData dataWithContentsOfURL:
                              [NSURL URLWithString:url]
                              ];
            
            if (ytData!=Nil) {
                self.ListOfData = [NSJSONSerialization
                             JSONObjectWithData:ytData
                             options:kNilOptions
                             error:nil];
                
            }
            

            dispatch_async(dispatch_get_main_queue(), ^{
                
                //NSLog(@"JSON:%@",json);
                //NSLog(@"loading finished");
                  [HUD hideUIBlockingIndicator];
                
                if (ListOfData !=nil)
                {
                   self.arrEmbassies= [ListOfData objectForKey:@"emb"];
                    [self.cTable reloadData];
                }else{
                    
                    UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Network Error"
                                                                        message: @"Error connecting to the internet"
                                                                       delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
                    [someError show];
                    self.ListOfData=nil;
                }
                
            });
            
        });
        
        
        self.cTable.backgroundColor = [UIColor colorWithHexString:@"000000 0.5"];
        self.cTable.backgroundView = [UIView new] ;
        
        self.cTable.rowHeight=130;
        [self.cTable registerNib:[UINib nibWithNibName:@"CellHotel" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
       
    }
    
    cTable.backgroundColor = [UIColor clearColor];
    cTable.backgroundView = [UIView new] ;
    [self.cTable registerNib:[UINib nibWithNibName:@"CustomCell_TO" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    
    self.cTable.rowHeight = 100;
    
    if (IS_HEIGHT_GTE_568) {
        v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:Nil options:nil]lastObject];
        
    } else {
        v =[[[NSBundle mainBundle]loadNibNamed:@"HeaderView-IponeS4" owner:Nil options:nil]lastObject];
        
    }
    v.parentViewName.text=ViewTitle;
    v.ViewName.text=ViewName;
    [v.ViewName setFont:[UIFont fontWithName:@"Ubuntu-Light" size:30]];
    [v setFrame:CGRectMake(0, 0, 320, self.cTable.bounds.size.height+40)];
    v.backgroundColor =[UIColor clearColor];
    self.cTable.tableHeaderView =v;
    
}

- (BOOL)connectedToInternet
{
    InternetConnection *networkReachability = [InternetConnection reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    return networkStatus == NotReachable ?FALSE:TRUE;
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
        rows = [self.arrEmbassies count];
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
    
    
    //================ Cell Padding ==============//
    cell.backgroundColor = [UIColor clearColor];
    //cell.backgroundView = [UIView new] ;
    /*
     cell.selectedBackgroundView = nil;
     [cell.layer setCornerRadius:7.0f];
     [cell.layer setMasksToBounds:YES];
     [cell.layer setBorderWidth:1.0f];
     */
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //============================================//
    [cell.cellLabel setFont:[UIFont fontWithName:@"Ubuntu" size:15]];
    
    cell.cellLabel.text=[[NSString alloc]initWithFormat:@"%@",[self.arrEmbassies[indexPath.row] valueForKey:@"name"]];
    cell.cellLabel.textColor=[UIColor colorWithHexString:@"ffffff 0.8"];
    cell.cellLabel.lineBreakMode=0;
    cell.cellLabel.font = [UIFont systemFontOfSize:14];
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
    EmbassiesDetailsViewCont *embass = [sb instantiateViewControllerWithIdentifier:@"EmbassiesDetailsView"];
    
    embass.extraName=[self.arrEmbassies[indexPath.row] valueForKey:@"name"];
    embass.extraPhone=[self.arrEmbassies[indexPath.row] valueForKey:@"phone"];
    embass.extraFax=[self.arrEmbassies[indexPath.row] valueForKey:@"fax"];
    embass.extraAddress=[self.arrEmbassies[indexPath.row] valueForKey:@"address"];
    embass.extraEmail=[self.arrEmbassies[indexPath.row] valueForKey:@"email"];
    embass.extraWorkinghours=[self.arrEmbassies[indexPath.row] valueForKey:@"workinghours"];
    
    [self.navigationController pushViewController:embass animated:TRUE];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
