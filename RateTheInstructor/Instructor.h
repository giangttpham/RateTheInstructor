//
//  Instructor.h
//  RateTheInstructor
//
//  Created by Tra` Beo' on 11/12/14.
//  Copyright (c) 2014 Giang Pham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Instructor : NSObject
- (void) loadInstructorDetail: (NSString *)detailURL;
- (NSString*) fullName;
- (NSString*) instructorId;
- (NSString*) office;
- (NSString*) phone;
- (NSString*) email;
- (NSString*) averageRating;
- (NSString*) totalRatings;
- (NSDictionary*) ratingData;
@end
