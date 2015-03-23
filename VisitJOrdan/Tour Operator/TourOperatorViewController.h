//
//  TourOperatorViewController.h
//  Visit Jordan
//
//  Created by Faris on 11/6/13.
//
//

#import <UIKit/UIKit.h>

@interface TourOperatorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *NormalBackground;
@property (weak, nonatomic) IBOutlet UIImageView *BlurBackground;
@property (weak, nonatomic) IBOutlet UITableView *cTable;

@property (nonatomic,copy) NSString *backgroundImageName;
@property (nonatomic,strong) UIImage *BluredImage;
@property (nonatomic,strong) UIImage *NormalImage;

@property (nonatomic,strong) UILabel *LabeltextDescription;
@property (nonatomic,strong) UILabel *LabelViewTitle;

@property (nonatomic,copy) NSString *ViewTitle;
@property (nonatomic,copy) NSString *ViewName;
@property (nonatomic,copy) NSString *textViewTitle;
@property (nonatomic,copy) NSString *textViewDescription;


@property (nonatomic) NSInteger descriptionPlaceHolderSize;

@end