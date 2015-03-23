//
//  DetailsView.m
//  testGallary
//
//  Created by Sojoud Ahmad on 6/22/14.
//  Copyright (c) 2014 sojoud. All rights reserved.
//

#import "DetailsView.h"

@interface DetailsView ()

@end

@implementation DetailsView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CMFGalleryCell" owner:self options:nil];
     if (self) {
    if ([arrayOfViews count] < 1) {
        return nil;
    }
    
    if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
        return nil;
    }
    
    self = [arrayOfViews objectAtIndex:0];
}

return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.imageBB.image=self.img;
 


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
