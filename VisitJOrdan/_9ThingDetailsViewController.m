//
//  99ThingDetailsViewController.m
//  VistJOrdan New
//
//  Created by Faris on 12/3/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "_9ThingDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor_hex.h"

@interface _9ThingDetailsViewController ()

@end

@implementation _9ThingDetailsViewController
@synthesize textDescription,textTitle,imgImage;


- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title =textTitle;
    [self.description setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:17]];
    
    [self.imageView.layer setBorderColor: [[UIColor colorWithHexString:@"000000 0.6"] CGColor]];
    [self.imageView.layer setBorderWidth: 2.0];
    
    self.description.text=textDescription;
    [self.imageView setImage:imgImage];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
