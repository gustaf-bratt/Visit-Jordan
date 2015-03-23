//
//  TourOperatorCell.h
//  Visit Jordan
//
//  Created by Faris on 11/6/13.
//
//

#import <UIKit/UIKit.h>

@interface TourOperatorCell : UITableViewCell{
}
@property (retain, nonatomic) IBOutlet UILabel *t_name;
@property (retain, nonatomic) IBOutlet UILabel *t_phone;
@property (retain, nonatomic) IBOutlet UILabel *t_email;
//@property (retain, nonatomic) IBOutlet UILabel *t_webaddress;
//@property (retain, nonatomic) IBOutlet UILabel *t_address;
//@property (retain, nonatomic) IBOutlet UILabel *t_contact;
@property (weak, nonatomic) IBOutlet UITextView *webLink;

@end
