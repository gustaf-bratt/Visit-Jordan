//
//  HotelsDetailsController.m
//  Visit Jordan
//
//  Created by Faris on 10/23/13.
//
//

#import "HotelsDetailsController.h"
#import "CellHotel.h"
#import "LoadHotelsJSONData.h"
#import "UIColor_hex.h"
#include "HUD.h"
#import "UIImage+StackBlur.h"
#import "Connection.h"

@interface HotelsDetailsController ()

@end

@implementation HotelsDetailsController
@synthesize hotelsStars,arrayOfData;
@synthesize ListOfData;
@synthesize PlaceName;
@synthesize bluredBG;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=PlaceName;
    
    UIImage *BluredImage = [[UIImage imageNamed:@"hotels.jpg"] stackBlur:50];
    
    [bluredBG setImage:BluredImage];
    
   [HUD showUIBlockingIndicatorWithText:@"Loading... Please Wait" withTimeout:8];    
    
  if ([self testInternetConcecction]) {
       
  
   [self performSelectorOnMainThread:@selector(refreshTableView) withObject:nil waitUntilDone:YES];

    self.arrayOfData = [ListOfData objectForKey:@"hotels"];
    
    self.cTable.backgroundColor = [UIColor colorWithHexString:@"000000 0.5"];
    self.cTable.backgroundView = [UIView new] ;
    //self.view.backgroundColor
    
    self.cTable.rowHeight=130;
    [self.cTable registerNib:[UINib nibWithNibName:@"CellHotel" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [self.cTable reloadData];
    
      }
}
- (void) refreshTableView
{
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1.5];
    
    NSString *url = [[NSString alloc]initWithFormat:@"http://serv01.vm1692.sgvps.net/~karasi/visitjordan/hotelsData.php?location=%@",PlaceName ];
    LoadHotelsJSONData *json =[[LoadHotelsJSONData alloc]init];
    ListOfData =[json loadDataFromURL:url];

}

-(void)hideHUD
{
    [HUD hideUIBlockingIndicator];
}
-(Boolean)testInternetConcecction{
    
    Boolean val=false;
    
	if ([Connection isConnected]) {
        val= TRUE;
	}
	else {
		UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Network Error" message: @"Error connecting to the internet" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
		[someError show];
	}
    return val;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger sectionCount=0;
    
    switch (section) {
        case 0:
            sectionCount = [[arrayOfData[0] objectForKey:@"five-stars"] count];
            break;
        case 1:
           sectionCount = [[arrayOfData[1] objectForKey:@"four-stars"] count];
            break;
        case 2:
           sectionCount = [[arrayOfData[2] objectForKey:@"three-stars"] count];
            break;
    }
    
    return sectionCount;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView : (UITableView *)tableView viewForHeaderInSection : (NSInteger) section {
    
    NSString *imageName,*hotelClass =nil;
    
    if (section==2) {
        imageName=@"3-stars.png";
        hotelClass=@"3 Star Hotels";
    }else if (section==1) {
        imageName=@"4-stars.png";
        hotelClass=@"4 Star Hotels";
    }
    else if (section==0) {
        imageName=@"5-stars.png";
        hotelClass=@"5 Star Hotels";
    }

    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0,60)] ;
	UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 320.0,20)] ;
    headerLabel.textColor=[UIColor whiteColor];
	headerLabel.text=hotelClass;

	UIImageView* headerImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:imageName]];
	headerImage.frame = CGRectMake(180, 10, 95, 20);
    
	[customView addSubview:headerLabel];
    [customView addSubview:headerImage];
    customView.backgroundColor=[UIColor colorWithHexString:@"000000 0.7"];

    return customView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   

   static NSString *CellIdentifier = @"cell";
   CellHotel *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[CellHotel alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    NSNumber * number=nil;
   // [cell.hotelName sizeToFit];
   
    if (indexPath.section==0) {
       cell.hotelName.text= [[[arrayOfData[0] objectForKey:@"five-stars"]objectAtIndex:indexPath.row]valueForKey:@"name"];
        number=[[[arrayOfData[0] objectForKey:@"five-stars"]objectAtIndex:indexPath.row]valueForKey:@"phone"];
        cell.phone.text= [[NSString alloc]initWithFormat:@"%@" , number ];
        cell.address.text=[[[arrayOfData[0] objectForKey:@"five-stars"]objectAtIndex:indexPath.row]valueForKey:@"address"];
        cell.website.text=[[[arrayOfData[0] objectForKey:@"five-stars"]objectAtIndex:indexPath.row]valueForKey:@"website"];
    }
 
    else if (indexPath.section==1)
    {
     cell.hotelName.text= [[[arrayOfData[1] objectForKey:@"four-stars"]objectAtIndex:indexPath.row]valueForKey:@"name"];
     number=[[[arrayOfData[1] objectForKey:@"four-stars"]objectAtIndex:indexPath.row]valueForKey:@"phone"];
     cell.phone.text= [[NSString alloc]initWithFormat:@"%@" , number ];
     cell.address.text=[[[arrayOfData[1] objectForKey:@"four-stars"]objectAtIndex:indexPath.row]valueForKey:@"address"];
     cell.website.text=[[[arrayOfData[1] objectForKey:@"four-stars"]objectAtIndex:indexPath.row]valueForKey:@"website"];
    }
    
    else if (indexPath.section==2)
    {
        cell.hotelName.text= [[[arrayOfData[2] objectForKey:@"three-stars"]objectAtIndex:indexPath.row]valueForKey:@"name"];
        number=[[[arrayOfData[2] objectForKey:@"three-stars"]objectAtIndex:indexPath.row]valueForKey:@"phone"];
        cell.phone.text= [[NSString alloc]initWithFormat:@"%@" , number ];
        cell.address.text=[[[arrayOfData[2] objectForKey:@"three-stars"]objectAtIndex:indexPath.row]valueForKey:@"address"];
        cell.website.text=[[[arrayOfData[2] objectForKey:@"three-stars"]objectAtIndex:indexPath.row]valueForKey:@"website"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [UIView new] ;
    cell.selectedBackgroundView = nil;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    NSString * sectionHeader;
    
    switch (section) {
        case 0:
            sectionHeader = @"5 Stars Hotels";
            break;
        case 1:
            sectionHeader = @"4 Stars Hotels";
            break;
        case 2:
            sectionHeader = @"2 Stars Hotels";
            break;
            
        default:
            sectionHeader= @"";
            break;
    }
    return sectionHeader;
}


@end
