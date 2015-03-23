//
//  ImageCache.h
//  VistJOrdan New
//
//  Created by Faris on 12/3/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCache : NSObject

@property (nonatomic, retain) NSCache *imgCache;


#pragma mark - Methods

+ (ImageCache*)sharedImageCache;
- (void) AddImage:(NSString *)imageURL: (UIImage *)image;
- (UIImage*) GetImage:(NSString *)imageURL;
- (BOOL) DoesExist:(NSString *)imageURL;

@end