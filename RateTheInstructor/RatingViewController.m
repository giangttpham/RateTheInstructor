//
//  RatingViewController.m
//  RateTheInstructor
//
//  Created by Tra` Beo' on 11/13/14.
//  Copyright (c) 2014 Giang Pham. All rights reserved.
//

#import "RatingViewController.h"
#import  <QuartzCore/QuartzCore.h>

@interface RatingViewController()
@property (weak, nonatomic) IBOutlet UITextView *commentTextview;
@property (weak, nonatomic) IBOutlet UITextField *ratingTextField;
@property (weak, nonatomic) IBOutlet UITextField *studentIdTextField;

@end
@implementation RatingViewController
- (void) viewDidLoad {
    [super viewDidLoad];
    self.ratingTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.studentIdTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.commentTextview.layer.borderWidth = 1.0f;
    self.commentTextview.layer.borderColor = [[UIColor grayColor] CGColor];
    self.commentTextview.layer.cornerRadius = 8;
}
- (IBAction)doneButtonPressed:(id)sender {
    [self.commentTextview resignFirstResponder];
    [self.ratingTextField resignFirstResponder];
    [self.studentIdTextField resignFirstResponder];
}
- (IBAction)submitButtonPressed:(id)sender {
    // add the rating k to an instructor with id "n", k is one of the values 1, 2, 3, 4 or 5
    long updatedTotalRatings = [self.totalRatings longLongValue] + 1;
    float updatedAverageRating = (([self.totalRatings integerValue] * [self.averageRating floatValue])
                                  + [self.ratingTextField.text floatValue]) / updatedTotalRatings;
    
    [self.ratingData setObject:[NSNumber numberWithFloat:updatedAverageRating] forKey:@"average"];
    [self.ratingData setObject:[NSNumber numberWithLong:updatedTotalRatings] forKey:@"totalRatings"];
    NSURL *ratingPostURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://bismarck.sdsu.edu/rateme/rating/%@/%@",self.instructorId,self.ratingTextField.text]];
    NSMutableURLRequest *ratingRequest = [[NSMutableURLRequest alloc] init];
    [ratingRequest setURL:ratingPostURL];
    [ratingRequest setHTTPMethod:@"POST"];
    [ratingRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *jsonRatingData = [NSJSONSerialization dataWithJSONObject:self.ratingData options:0 error:nil];
    [ratingRequest setHTTPBody:jsonRatingData];
    NSURLConnection *ratingConn = [[NSURLConnection alloc] initWithRequest:ratingRequest delegate:self];
    
    if ([self.commentTextview.text length] > 0) {
        NSURL *commentPostURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://bismarck.sdsu.edu/rateme/comment/%@",self.instructorId]];
        NSMutableURLRequest *commentRequest = [[NSMutableURLRequest alloc] init];
        [commentRequest setURL:commentPostURL];
        [commentRequest setHTTPMethod:@"POST"];
        [commentRequest setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
        //    NSData *jsonCommentData = [NSJSONSerialization dataWithJSONObject:self.allCommentData options:0 error:nil];
        //NSData *jsonCommentData = [NSJSONSerialization dataWithJSONObject:commentData options:0 error:nil];
        
        [commentRequest setHTTPBody:[self.commentTextview.text dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLConnection *commentConn = [[NSURLConnection alloc] initWithRequest:commentRequest delegate:self];
    }
    NSLog(@"Done");
}

//- (void)connection:(NSURLConnection *)connection didReceiveResponse: (NSHTTPURLResponse *)response
//{
//    NSMutableData* receivedData;
//    [receivedData setLength:0];
//    NSDictionary * headers = [response allHeaderFields];
//}
@end
