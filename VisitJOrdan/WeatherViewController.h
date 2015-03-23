//
//  WeatherViewController.h
//  VistJOrdan New
//
//  Created by Faris on 11/24/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *weatherWebView;
- (BOOL)connectedToInternet;
@end
