//
//  WeatherViewController.m
//  VistJOrdan New
//
//  Created by Faris on 11/24/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "WeatherViewController.h"
#import "XMLReader.h"
#import "UIImage+StackBlur.h"
#import "HUD.h"
#import "InternetConnection.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController



- (void)viewDidLoad
{  

    [super viewDidLoad];
     self.title=@"Weather";
    
    
    NSString *urlAddress = @"http://ns1.vm1692.sgvps.net/~karasi/visitjordan/zweatherfeed/";

    self.weatherWebView.alpha=0;
    
    if ([self connectedToInternet]) {
        
       [HUD showUIBlockingIndicatorWithText:@"Loading... Please Wait" withTimeout:7];
       
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        
        //Create a URL object.
        NSURL *url = [NSURL URLWithString:urlAddress];
        
        //URL Requst Object
        [self.weatherWebView loadHTMLString:@"" baseURL:nil];
        NSURLRequest* requestObj = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60.0];
         [self performSelector:@selector(hideHUD) withObject:nil afterDelay:9];
        //Load the request in the UIWebView.
        [self.weatherWebView loadRequest:requestObj];
	}
	else {
		UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Network Error" message: @"Error connecting to the internet" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
		[someError show];
	}

   
}


- (BOOL)connectedToInternet
{
    InternetConnection *networkReachability = [InternetConnection reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    return networkStatus == NotReachable ?FALSE:TRUE;
}


-(void)hideHUD
{
    [HUD hideUIBlockingIndicator];
    self.weatherWebView.alpha=1;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //this method will call after getting any error while loading the web view.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}



@end
