//
//  99ThingDetailsViewController.h
//  VistJOrdan New
//
//  Created by Faris on 12/3/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface _9ThingDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (strong, nonatomic) NSString *textTitle;
@property (strong, nonatomic) NSString *textDescription;
@property (strong, nonatomic) UIImage *imgImage;

@end
