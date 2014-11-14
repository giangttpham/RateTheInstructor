//
//  CommentViewController.h
//  RateTheInstructor
//
//  Created by Tra` Beo' on 11/12/14.
//  Copyright (c) 2014 Giang Pham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UITableViewController
<UITableViewDataSource, UITableViewDelegate>
@property NSString *commentURL;
@property NSArray *allComments;

@end
