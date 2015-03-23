//
//  EXEventDetailController.h
//  Visit Jordan
//
//  Created by Faris on 10/10/13.
//
//

#import <UIKit/UIKit.h>

@interface EXEventDetailController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *date;
@property (retain, nonatomic) IBOutlet UILabel *time;
@property (retain, nonatomic) IBOutlet UILabel *city;
@property (retain, nonatomic) IBOutlet UILabel *location;
@property (retain, nonatomic) IBOutlet UILabel *organizer;
@property (retain, nonatomic) IBOutlet UILabel *entry;
@property (retain, nonatomic) IBOutlet UITextView *details;

@property(nonatomic,strong) NSString *extraName;
@property(nonatomic,strong) NSString *extraDate;
@property(nonatomic,strong) NSString *extraTime;
@property(nonatomic,strong) NSString *extraCity;
@property(nonatomic,strong) NSString *extraLocation;
@property(nonatomic,strong) NSString *extraOrganizer;
@property(nonatomic,strong) NSString *extraEntry;
@property(nonatomic,strong) NSString *extraDetails;




@end
