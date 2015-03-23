//
//  RestaurantSingleTableViewController.m
//  VistJOrdan New
//
//  Created by Faris on 2/19/14.
//  Copyright (c) 2014 Faris. All rights reserved.
//

#import "RestaurantSingleTableViewController.h"
#import "CellHotel.h"
#import "LoadHotelsJSONData.h"
#import "UIColor_hex.h"
#include "HUD.h"
#import "UIImage+StackBlur.h"
#import "Connection.h"
@interface RestaurantSingleTableViewController ()

@end

@implementation RestaurantSingleTableViewController

@synthesize hotelsStars,arrayOfData;
@synthesize ListOfData;
@synthesize Categoty;
@synthesize _flag1,_flag2,_flag3,_flag4,_flag5;


- (void)viewDidLoad
{
        [self.tableView reloadData];
        self.tableView.backgroundColor = [UIColor colorWithHexString:@"000000 0.5"];
        self.tableView.backgroundView = [UIView new] ;
        [self.tableView registerNib:[UINib nibWithNibName:@"CellHotel" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
}

- (void) refreshTableView
{
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1.5];
    
    NSString *url = [[NSString alloc]initWithFormat:@"http://serv01.vm1692.sgvps.net/~karasi/visitjordan/restaurants.php?Categoty=%@",Categoty ];
    LoadHotelsJSONData *json =[[LoadHotelsJSONData alloc]init];
    ListOfData =[json loadDataFromURL:url];
    [self.tableView reloadData];
  
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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger sectionCount=0;

    switch (section) {
        case 0:
            return [_flag5 isEqualToString:@"1"] ? [[arrayOfData[4] objectForKey:@"five-stars"] count]:0;
            break;
        case 1:
            return [_flag4 isEqualToString:@"1"] ? [[arrayOfData[3] objectForKey:@"four-stars"] count]:0;
            break;
        case 2:
           return [_flag3 isEqualToString:@"1"] ? [[arrayOfData[2] objectForKey:@"three-stars"] count]:0;
            break;
            
        case 3:
            return [_flag2 isEqualToString:@"1"] ? [[arrayOfData[1] objectForKey:@"tow-stars"] count]:0;
            break;
            
        case 4:
            return [_flag1 isEqualToString:@"1"] ? [[arrayOfData[0] objectForKey:@"one-stars"] count]:0;
            break;
    }

return sectionCount;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView : (UITableView *)tableView viewForHeaderInSection : (NSInteger) section {
    
    NSString *imageName,*hotelClass =nil;
    
   UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0,60)] ;
    
    if (section==4 && [_flag1 isEqualToString:@"1"]) {
        imageName=@"1_star.png";
        hotelClass=@"1 Star Restaurants";
        UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320.0,20)] ;
        headerLabel.textColor=[UIColor whiteColor];
        headerLabel.text=hotelClass;
        
        UIImageView* headerImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:imageName]];
        headerImage.frame = CGRectMake(180, 0, 95, 20);
        
        [customView addSubview:headerLabel];
        [customView addSubview:headerImage];
        customView.backgroundColor=[UIColor colorWithHexString:@"000000 0.7"];
        
    }else
        if (section==3 && [_flag2 isEqualToString:@"1"]) {
            imageName=@"2_stars.png";
            hotelClass=@"2 Star Restaurants";
            
            UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320.0,20)] ;
            headerLabel.textColor=[UIColor whiteColor];
            headerLabel.text=hotelClass;
            
            UIImageView* headerImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:imageName]];
            headerImage.frame = CGRectMake(180, 0, 95, 20);
            
            [customView addSubview:headerLabel];
            [customView addSubview:headerImage];
            customView.backgroundColor=[UIColor colorWithHexString:@"000000 0.7"];
        }else
            if (section==2 && [_flag3 isEqualToString:@"1"]) {
                
                imageName=@"3-stars.png";
                hotelClass=@"3 Star Restaurants";
                UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320.0,20)] ;
                headerLabel.textColor=[UIColor whiteColor];
                headerLabel.text=hotelClass;
                
                UIImageView* headerImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:imageName]];
                headerImage.frame = CGRectMake(180, 0, 95, 20);
                
                [customView addSubview:headerLabel];
                [customView addSubview:headerImage];
                customView.backgroundColor=[UIColor colorWithHexString:@"000000 0.7"];
                
            }else if (section==1 && [_flag4 isEqualToString:@"1"]) {
                imageName=@"4-stars.png";
                hotelClass=@"4 Star Restaurants";
                UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320.0,20)] ;
                headerLabel.textColor=[UIColor whiteColor];
                headerLabel.text=hotelClass;
                
                UIImageView* headerImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:imageName]];
                headerImage.frame = CGRectMake(180, 0, 95, 20);
                
                [customView addSubview:headerLabel];
                [customView addSubview:headerImage];
                customView.backgroundColor=[UIColor colorWithHexString:@"000000 0.7"];
            }
            else if (section==0 && [_flag5 isEqualToString:@"1"]) {
                imageName=@"5-stars.png";
                hotelClass=@"5 Star Restaurants";
                UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 320.0,20)] ;
                headerLabel.textColor=[UIColor whiteColor];
                headerLabel.text=hotelClass;
                
                UIImageView* headerImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:imageName]];
                headerImage.frame = CGRectMake(180, 0, 95, 20);
                
                [customView addSubview:headerLabel];
                [customView addSubview:headerImage];
                customView.backgroundColor=[UIColor colorWithHexString:@"000000 0.7"];
            }
    


    
    return customView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.rowHeight=130;
    [self.tableView registerNib:[UINib nibWithNibName:@"CellHotel" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];

    
    static NSString *CellIdentifier = @"cell";
    CellHotel *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[CellHotel alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    NSNumber * number=nil;
    
    if (indexPath.section==0 && [_flag5 isEqualToString:@"1"]) {
        cell.hotelName.text= [[[arrayOfData[4] objectForKey:@"five-stars"]objectAtIndex:indexPath.row]valueForKey:@"name"];
        number=[[[arrayOfData[4] objectForKey:@"five-stars"]objectAtIndex:indexPath.row]valueForKey:@"phone"];
        cell.phone.text= [[NSString alloc]initWithFormat:@"%@" , number ];
        cell.address.text=[[[arrayOfData[4] objectForKey:@"five-stars"]objectAtIndex:indexPath.row]valueForKey:@"speciality"];
        cell.website.text=@"";
    }
    
    else if (indexPath.section==1 && [_flag4 isEqualToString:@"1"])
    {
        cell.hotelName.text= [[[arrayOfData[3] objectForKey:@"four-stars"]objectAtIndex:indexPath.row]valueForKey:@"name"];
        number=[[[arrayOfData[3] objectForKey:@"four-stars"]objectAtIndex:indexPath.row]valueForKey:@"phone"];
        cell.phone.text= [[NSString alloc]initWithFormat:@"%@" , number ];
        cell.address.text=[[[arrayOfData[3] objectForKey:@"four-stars"]objectAtIndex:indexPath.row]valueForKey:@"speciality"];
        cell.website.text=@"";
    }
    
    else if (indexPath.section==2 && [_flag3 isEqualToString:@"1"])
    {
        cell.hotelName.text= [[[arrayOfData[2] objectForKey:@"three-stars"]objectAtIndex:indexPath.row]valueForKey:@"name"];
        number=[[[arrayOfData[2] objectForKey:@"three-stars"]objectAtIndex:indexPath.row]valueForKey:@"phone"];
        cell.phone.text= [[NSString alloc]initWithFormat:@"%@" , number ];
        cell.address.text=[[[arrayOfData[2] objectForKey:@"three-stars"]objectAtIndex:indexPath.row]valueForKey:@"speciality"];
        cell.website.text=@"";
    }
    else if (indexPath.section==3 && [_flag2 isEqualToString:@"1"])
    {
        cell.hotelName.text= [[[arrayOfData[1] objectForKey:@"tow-stars"]objectAtIndex:indexPath.row]valueForKey:@"name"];
        number=[[[arrayOfData[1] objectForKey:@"tow-stars"]objectAtIndex:indexPath.row]valueForKey:@"phone"];
        cell.phone.text= [[NSString alloc]initWithFormat:@"%@" , number ];
        cell.address.text=[[[arrayOfData[1] objectForKey:@"tow-stars"]objectAtIndex:indexPath.row]valueForKey:@"speciality"];
        cell.website.text=@"";
    }
    else  if (indexPath.section==4 && [_flag1 isEqualToString:@"1"])
    {
        cell.hotelName.text= [[[arrayOfData[0] objectForKey:@"one-stars"]objectAtIndex:indexPath.row]valueForKey:@"name"];
        number=[[[arrayOfData[0] objectForKey:@"one-stars"]objectAtIndex:indexPath.row]valueForKey:@"phone"];
        cell.phone.text= [[NSString alloc]initWithFormat:@"%@" , number ];
        cell.address.text=[[[arrayOfData[0] objectForKey:@"one-stars"]objectAtIndex:indexPath.row]valueForKey:@"speciality"];
        cell.website.text=@"";
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
            sectionHeader = @"3 Stars Hotels";
            break;
        case 3:
            sectionHeader = @"2 Stars Hotels";
            break;
        case 4:
            sectionHeader = @"1 Stars Hotels";
            break;
        default:
            sectionHeader= @"";
            break;
    }
    return sectionHeader;
}

@end
