//
//  NewGalleryViewController.h
//  Vist Jordan
//
//  Created by Sojoud Ahmad on 6/23/14.
//  Copyright (c) 2014 Faris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewGalleryViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak,nonatomic) IBOutlet UICollectionView *collec;

@end
