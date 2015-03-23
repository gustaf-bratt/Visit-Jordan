//
//  KLViewController.m
//  KLScrollSelectDemo
//
//  Created by Kieran Lafferty on 2013-04-03.
//  Copyright (c) 2013 KieranLafferty. All rights reserved.
//

#import "KLViewController.h"
#import <Social/Social.h>
#import "UIColor_hex.h"
#import "_9ThingDetailsViewController.h"
@interface KLViewController ()

@end

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f

@implementation KLViewController
@synthesize leftColumnData,rightColumnData,listData;
-(void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.title=@"99 Things To Do in Amman";
    if (IS_HEIGHT_GTE_568 ) {
        self.scrollSelect = [[KLScrollSelect alloc] initWithFrame: CGRectMake(0, 65, 320, 505)];
    }else
        self.scrollSelect = [[KLScrollSelect alloc] initWithFrame: CGRectMake(0, 65, 320, 438)];
    
    [self.scrollSelect setDataSource: self];
    [self.scrollSelect setDelegate: self];
    [self.view addSubview: self.scrollSelect];
    
    //Configure data source arrays
    NSString* leftPlistPath = [[NSBundle mainBundle] pathForResource:@"LeftCityList"
                                                              ofType:@"plist"];
    self.leftColumnData = [NSArray arrayWithContentsOfFile: leftPlistPath];
    
    
    NSString* rightPlistPath = [[NSBundle mainBundle] pathForResource:@"RightCityList"
                                                               ofType:@"plist"];
    self.rightColumnData = [NSArray arrayWithContentsOfFile: rightPlistPath];

}
- (CGFloat)scrollRateForColumnAtIndex: (NSInteger) index {
    
    return 15 + index * 15;
}
-(NSInteger) numberOfColumnsInScrollSelect:(KLScrollSelect *)scrollSelect {
    return 2;
}
-(NSInteger) scrollSelect:(KLScrollSelect *)scrollSelect numberOfRowsInColumnAtIndex:(NSInteger)index {
    if (index == 0) {
        //Left column
        return self.leftColumnData.count;
    }
    //Right Column
    else return self.rightColumnData.count;
}

- (UITableViewCell*) scrollSelect:(KLScrollSelect*) scrollSelect cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KLScrollingColumn* column = [[scrollSelect columns] objectAtIndex: indexPath.column];
    KLImageCell* cell;
    
    //registerClass only works on iOS 6 so if the app runs on iOS 5 we shouldn't use this method.
    //On iOS 5 we only initialize a new KLImageCell if the cell is nil
    if (IOS_VERSION >= 6.0) {
        [column registerClass:[KLImageCell class] forCellReuseIdentifier:@"Cell" ];
        cell = [column dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    } else {
        cell = [column dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[KLImageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        }
    }
    
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    
    NSDictionary* dictForCell = indexPath.column == 0? [self.leftColumnData objectAtIndex:indexPath.row] : [self.rightColumnData objectAtIndex:indexPath.row];
    
    

    //============== custom code ========//
    
      [cell.image setImage:[UIImage imageNamed: [dictForCell objectForKey:@"image"]]];
      //[cell.label setText:@"Fly to"];
      [cell.subLabel setText: [dictForCell objectForKey:@"title"]];
      cell.subLabel.backgroundColor=[UIColor colorWithHexString:@"000000 0.5"];
    
      cell.subLabel.font  = [ UIFont fontWithName: @"Ubuntu-Medium" size: 14.0 ];
      cell.subLabel.numberOfLines=0;
      cell.subLabel.lineBreakMode = NSLineBreakByWordWrapping;
      cell.subLabel.frame = CGRectMake(0.0, cell.frame.size.height-50, cell.subLabel.frame.size.width, 40);
 
    return cell;
}

- (void)scrollSelect:(KLScrollSelect *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath {
    
       NSDictionary* dictForCell = indexPath.column == 0? [self.leftColumnData objectAtIndex:indexPath.row] : [self.rightColumnData objectAtIndex:indexPath.row];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _9ThingDetailsViewController *detailView = [sb instantiateViewControllerWithIdentifier:@"_9ThingDetails"];
    
    detailView.imgImage=[UIImage imageNamed: [dictForCell objectForKey:@"image"]];
    detailView.textTitle = [dictForCell objectForKey:@"title"];
    detailView.textDescription= [dictForCell objectForKey:@"details"];

    [self.navigationController pushViewController:detailView animated:YES];
    
   // NSLog(@"Selected cell at index %d, %d", indexPath.column, indexPath.row);
    
}


- (CGFloat) scrollSelect: (KLScrollSelect*) scrollSelect heightForColumnAtIndex: (NSInteger) index {
    
    if (index==0) {
         return 200;
    }
    else{
        return 260;
    }
}

@end

