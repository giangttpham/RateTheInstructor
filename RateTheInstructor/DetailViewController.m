//
//  DetailViewController.m
//  RateTheInstructor
//
//  Created by Tra` Beo' on 11/12/14.
//  Copyright (c) 2014 Giang Pham. All rights reserved.
//
#import "DetailViewController.h"
#import "CommentViewController.h"
#import "RatingViewController.h"
#import "Comment.h"
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *instructorId;
@property (weak, nonatomic) IBOutlet UILabel *office;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *averageRating;
@property (weak, nonatomic) IBOutlet UILabel *totalRatings;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name.text = self.nameText;
    self.instructorId.text = self.idText;
    self.office.text = self.officeText;
    self.email.text = self.emailText;
    self.phone.text = self.phoneText;
    self.averageRating.text = self.averageRatingText;
    self.totalRatings.text = self.totalRatingsText;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readCommentButtonPressed:(id)sender {
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"CommentSegue"]) {
        Comment *instructorWithComment = [[Comment alloc] init];
        NSString *commentURL = [NSString stringWithFormat:@"http://bismarck.sdsu.edu/rateme/comments/%@",self.idText];
        CommentViewController *commentVC = segue.destinationViewController;
        commentVC.allComments = [instructorWithComment loadComments:commentURL];
        commentVC.navigationItem.title = @"Comments";
//        commentVC.commentURL = [NSString stringWithFormat:@"http://bismarck.sdsu.edu/rateme/comments/%@",self.idText];
    }
    
    if ([[segue identifier] isEqualToString:@"RatingSegue"]) {
        RatingViewController *ratingVC = segue.destinationViewController;
        ratingVC.navigationItem.title = @"Rate";
        ratingVC.instructorId = self.idText;
        ratingVC.averageRating = self.averageRatingText;
        ratingVC.totalRatings = self.totalRatingsText;
        ratingVC.ratingData = [NSMutableDictionary dictionaryWithDictionary: self.ratingData];
        
    }
}


@end
