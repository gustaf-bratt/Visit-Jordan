//
//  LanguageViewController.h
//  staticTable
//
//  Created by Faris on 11/19/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanguageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
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
@property (nonatomic,copy) NSString *textViewDescription1,*textViewDescription2;


@property (nonatomic) NSInteger descriptionPlaceHolderSize;

@end