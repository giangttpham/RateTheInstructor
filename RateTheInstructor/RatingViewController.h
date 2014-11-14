//
//  RatingViewController.h
//  RateTheInstructor
//
//  Created by Tra` Beo' on 11/13/14.
//  Copyright (c) 2014 Giang Pham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingViewController : UIViewController
@property NSString *instructorId;
@property NSString *averageRating;
@property NSString *totalRatings;
@property NSMutableDictionary *ratingData;
@end
