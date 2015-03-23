//
//  DashBoardViewController.m
//  staticTable
//
//  Created by Faris on 11/17/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "DashBoardViewController.h"
#import "ExperiencesViewController.h"
#import "GeneralInformationViewController.h"
#import "VideosViewController.h"
#import "ContactUsViewController.h"
#import "LanguageViewController.h"
#import "cViewController.h"
#import "HandCraftsViewController.h"
#import "HotelsViewController.h"
#import "SideRestaurantsViewController.h"

#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
@interface DashBoardViewController ()

@end

@implementation DashBoardViewController
@synthesize scrollTE;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillLayoutSubviews{
    
  
    // iphone 4S problem

    if (IS_HEIGHT_GTE_568) {//1965
        [scrollTE setContentSize:CGSizeMake(10,2000)];
        [scrollTE setScrollEnabled:TRUE];
       
    }else{
        
      [scrollTE setContentSize:CGSizeMake(80,2100)];
    scrollTE.frame = CGRectOffset( scrollTE.frame, 0, 90 );
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Logo_header.jpg"] forBarMetrics:UIBarMetricsDefault];

}
-(void)viewWillDisappear:(BOOL)animated{
    
    UIImage *_defaultImage;
[self.navigationController.navigationBar setBackgroundImage:_defaultImage forBarMetrics:UIBarMetricsDefault];

}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"Logo_header.jpg"] forBarMetrics:UIBarMetricsDefault];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnExperiences:(id)sender {
    
    ExperiencesViewController *instanceObject = [[ExperiencesViewController alloc]init];
    [self.navigationController pushViewController:instanceObject animated:NO];
    [self.navigationController popViewControllerAnimated:NO];


}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        NSBundle *bundle = [NSBundle mainBundle];
    
    if ([segue.identifier isEqual:@"expSegue"]) {
        
        ExperiencesViewController *instanceObject = segue.destinationViewController;
        instanceObject.backgroundImageName=@"Experiences.jpg";
        instanceObject.ViewTitle=@"Jordanian";
        instanceObject.ViewName=@"Experiences";
        instanceObject.textViewTitle=@"Experiences";
        instanceObject.textViewDescription=@"";
        instanceObject.descriptionPlaceHolderSize=0;
      
        instanceObject.arr_tableData=[[NSArray alloc]initWithObjects:
                                      @"Fun & Adventure",
                                      @"History & Culture",
                                      @"Eco & Nature",
                                      @"Leisure & Wellness",
                                      @"Religion & Faith",
                                      @"Conferences & Events",nil];
        
        instanceObject.arr_tableImages=[[NSArray alloc]initWithObjects:
                                        @"fun&ad.png",
                                        @"history-and-culture.png",
                                        @"eco-and-nature.png",
                                        @"lesuire-and-wellness.png",
                                        @"religion-and-faith.png",
                                        @"events-and-conferences.png",nil];
        
    }else if ([segue.identifier isEqual:@"generalInfo"]){
        
    
        NSString *plistPath = [bundle pathForResource:@"Experiences" ofType:@"plist"];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        GeneralInformationViewController *instanceObject = segue.destinationViewController;
        instanceObject.backgroundImageName=@"General_Information.jpg";
        instanceObject.ViewTitle=@"";
        instanceObject.ViewName=@"General Information";
        instanceObject.textViewTitle=@"General Information";
        instanceObject.textViewDescription=[[dictionary objectForKey:@"otherString"] objectForKey:@"generalInfo"];
        instanceObject.descriptionPlaceHolderSize=650;
    
    } else  if ([segue.identifier isEqual:@"Itineraries"]) {
        
        ExperiencesViewController *instanceObject = segue.destinationViewController;
        instanceObject.backgroundImageName=@"itineraires_MAIN.jpg";
        instanceObject.ViewTitle=@"";
        instanceObject.ViewName=@"Itineraries";
        
        instanceObject.arr_tableData=[[NSArray alloc]initWithObjects:
                                      @"Fun and Adventure",
                                      @"History and Culture",
                                      @"Eco and Nature",
                                      @"Leisure and Wellness",
                                      @"Biblical Itineraries",nil];
        
        instanceObject.arr_tableImages=[[NSArray alloc]initWithObjects:
                                        @"fun&ad.png",
                                        @"history-and-culture.png",
                                        @"eco-and-nature.png",
                                        @"lesuire-and-wellness.png",
                                        @"religion-and-faith.png",nil];
        
    }else if ([segue.identifier isEqual:@"CheckList"]) {
        NSString *plistPath = [bundle pathForResource:@"CheckList" ofType:@"plist"];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        
        ExperiencesViewController *instanceObject = segue.destinationViewController;
        instanceObject.backgroundImageName=@"jordan-checklist.jpg";
        instanceObject.ViewTitle=@"";
        instanceObject.ViewName=@"CheckList";
        instanceObject.textViewTitle=@"CheckList";
        instanceObject.descriptionPlaceHolderSize=0;
        
        instanceObject.arr_tableData=[[NSArray alloc] initWithArray:[[dictionary objectForKey:@"CheckList"]objectForKey:@"data"]];
        
        instanceObject.arr_tableImages=[[NSArray alloc] initWithArray:[[dictionary objectForKey:@"CheckList"]objectForKey:@"images"]];

        
    } else if ([segue.identifier isEqual:@"videos"]) {
 
        VideosViewController *instanceObject = segue.destinationViewController;
        instanceObject.backgroundImageName=@"videos-main-image.jpg";
        instanceObject.ViewTitle=@"";
        instanceObject.ViewName=@"Videos";
        instanceObject.descriptionPlaceHolderSize=0;
        
        
    }else if ([segue.identifier isEqual:@"ContactUs"]) {
        
        ContactUsViewController *instanceObject = segue.destinationViewController;
        instanceObject.backgroundImageName=@"contact-us_bg.jpg";
        instanceObject.ViewTitle=@"";
        instanceObject.ViewName=@"Contact Us";
        instanceObject.descriptionPlaceHolderSize=180;
    }
    else if ([segue.identifier isEqual:@"language"]) {
        
        LanguageViewController *instanceObject = segue.destinationViewController;
        instanceObject.backgroundImageName=@"language_bg.jpg";
        instanceObject.ViewTitle=@"";
        instanceObject.ViewName=@" Language";
        instanceObject.descriptionPlaceHolderSize=1090;
        
        
    } else if ([segue.identifier isEqual:@"Cuisin"]) {
        
        cViewController *instanceObject = segue.destinationViewController;
        instanceObject.backgroundImageName=@"cuisine.jpg";
        instanceObject.ViewTitle=@"";
        instanceObject.ViewName=@"Jordanian Food";
        instanceObject.descriptionPlaceHolderSize=510;
     
        
    } else if ([segue.identifier isEqual:@"HandCrafts"]) {
        
        cViewController *instanceObject = segue.destinationViewController;
        instanceObject.backgroundImageName=@"handcrafts.jpg";
        instanceObject.ViewTitle=@"";
        instanceObject.ViewName=@"Handicrafts";
        instanceObject.descriptionPlaceHolderSize=600;
        
        
    } else if ([segue.identifier isEqual:@"TourOperator"]) {
        
        cViewController *instanceObject = segue.destinationViewController;
        instanceObject.backgroundImageName=@"tour-operator.jpg";
        instanceObject.ViewTitle=@"";
        instanceObject.ViewName=@"Tour Operator";
        instanceObject.descriptionPlaceHolderSize=0;
        
        
    }else if ([segue.identifier isEqual:@"Events"]) {
        
        cViewController *instanceObject = segue.destinationViewController;
        instanceObject.backgroundImageName=@"events-bg.jpg";
        instanceObject.ViewTitle=@"";
        instanceObject.ViewName=@"Events";
        instanceObject.descriptionPlaceHolderSize=0;
        
        
    }else if ([segue.identifier isEqual:@"Embassies"]) {
        
        cViewController *instanceObject = segue.destinationViewController;
        instanceObject.backgroundImageName=@"embassies_bg.jpg";
        instanceObject.ViewTitle=@"";
        instanceObject.ViewName=@"  Embassies";
        instanceObject.descriptionPlaceHolderSize=0;
        
        
    }else  if ([segue.identifier isEqual:@"Hotels"]) {
       
         HotelsViewController *instanceObject = segue.destinationViewController;
         instanceObject.backgroundImageName=@"hotels.jpg";
         instanceObject.ViewTitle=@"";
         instanceObject.ViewName=@"Hotels";
         //Amman> Aqaba > Dead Sea > Hamamat Mai'n > Irbid > Madaba > Nature reserves
         instanceObject.arr_tableData=[[NSArray alloc]initWithObjects:
         @"Amman", @"Aqaba",@"Dead Sea",@"Ma'in",@"Irbid",@"Madaba",@"NatureReserve",@"Petra",nil];
         
         instanceObject.arr_tableImages=[[NSArray alloc]initWithObjects:
         @"ic_amman.jpg",@"ic_aqaba.jpg",@"ic_DeadSea.jpg",@"ic_hammamat-main.jpg",@"ic_irbid.jpg",@"ic_Madaba.jpg",@"ic_nature-reserves.jpg",@"ic_Petra.jpg",nil];
        
    }
}



@end
