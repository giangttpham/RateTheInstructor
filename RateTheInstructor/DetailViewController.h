//
//  DetailViewController.h
//  RateTheInstructor
//
//  Created by Tra` Beo' on 11/12/14.
//  Copyright (c) 2014 Giang Pham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property NSString *nameText;
@property NSString *idText;
@property NSString *officeText;
@property NSString *emailText;
@property NSString *phoneText;
@property NSString *averageRatingText;
@property NSString *totalRatingsText;
@property NSString *commentURL;
@property NSDictionary *ratingData;
@property NSArray *commentData;
@end
