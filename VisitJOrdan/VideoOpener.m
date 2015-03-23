//
//  VideoOpener.m
//  iPhone
//
//  Created by Ali Hajjaj on 9/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VideoOpener.h"

@implementation VideoOpener

@synthesize linkAddress;
@synthesize delegate;
@synthesize webView;
@synthesize videoName;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    self.title=videoName;
	NSURL *url = [NSURL URLWithString:linkAddress];
	NSString* embedHTML = @"\
    <html><head>\
	<style type=\"text/css\">\
	body {\
	background-color: black;\
	color: black;\
	}\
	</style>\
	</head><body style=\"margin:0\"><div style=\"top:10px;left:10px;\">\
	<iframe class=\"youtube-player\" type=\"text/html\"  src=\"http://www.youtube.com/embed/%@\" width=\"%0.0f\" height=\"%0.0f\" frameborder=\"0\" allowfullscreen></iframe></div>\
	</body></html>";
	CGRect frame = webView.frame;
	NSString* html = [NSString stringWithFormat:embedHTML, url,frame.size.width, frame.size.height];  
	[webView loadHTMLString:html baseURL:nil];
}

- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



- (void)dealloc {
}


@end


