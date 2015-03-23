//
//  EXEventDetailController.m
//  Visit Jordan
//
//  Created by Faris on 10/10/13.
//
//

#import "EXEventDetailController.h"
#import "EXTableViewController.h"

@interface EXEventDetailController ()

@end

@implementation EXEventDetailController

@synthesize extraName;
@synthesize extraDate;
@synthesize extraTime;
@synthesize extraCity;
@synthesize extraLocation;
@synthesize extraOrganizer;
@synthesize extraEntry;
@synthesize extraDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=extraName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.details.text = extraDetails;
    self.date.text  = extraDate;
    self.time.text = extraTime;
    self.location.text = extraLocation;
    self.city.text = extraCity;
    self.organizer.text = extraOrganizer;
    self.entry.text = extraEntry;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_date release];
    [_time release];
    [_city release];
    [_location release];
    [_organizer release];
    [_entry release];
    [_details release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setDate:nil];
    [self setTime:nil];
    [self setCity:nil];
    [self setLocation:nil];
    [self setOrganizer:nil];
    [self setEntry:nil];
    [self setDetails:nil];
    [super viewDidUnload];
}
@end
