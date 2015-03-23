//
//  HotelsDetailsController.h
//  Visit Jordan
//
//  Created by Faris on 10/23/13.
//
//

#import <UIKit/UIKit.h>

@interface HotelsDetailsController :UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
//============Class Key =============//
   NSString * PlaceName;
//===================================//

NSDictionary *fiveStars,*fourStars,*threeStars,*ListOfData;
NSArray *hotelsStars,*arrayOfData;
}
@property (weak, nonatomic) IBOutlet UIImageView *bluredBG;
@property (nonatomic,retain) NSDictionary *ListOfData;
@property (nonatomic,retain) NSArray *hotelsStars,*arrayOfData;
@property (weak, nonatomic) IBOutlet UITableView *cTable;
@property (nonatomic ,retain) NSString *PlaceName;
@end