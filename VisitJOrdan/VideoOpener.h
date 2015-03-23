//
//  VideoOpener.h
//  iPhone
//
//  Created by Ali Hajjaj on 9/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol FlipsideViewControllerDelegate;

@interface VideoOpener : UIViewController {
	UIWebView *webView;
	NSString *linkAddress;
}
@property (nonatomic, retain) NSString *linkAddress;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSString *videoName;

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
- (IBAction)done:(id)sender;
@end

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(VideoOpener *)controller;
@end



