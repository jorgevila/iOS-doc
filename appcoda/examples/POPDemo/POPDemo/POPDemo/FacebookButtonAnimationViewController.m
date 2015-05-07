//
//  FacebookButtonAnimationViewController.m
//  POPDemo
//
//  Created by Simon Ng on 21/12/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "FacebookButtonAnimationViewController.h"

@interface FacebookButtonAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *msgTextField;

@end

@implementation FacebookButtonAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.msgTextField.delegate = self;
    self.sendButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *comment;
    
    if (range.length == 0) {
        comment = [NSString stringWithFormat:@"%@%@", textField.text, string];
    } else {
        comment = [textField.text substringToIndex:textField.text.length - range.length];
    }
    
    if (comment.length == 0) {
        // Show Like
        [self showLikeButton];
    } else  {
        // Show Send
        [self showSendButton];
    }
    
    return YES;
}

- (void)showSendButton {
    if (self.sendButton.isHidden) {
        self.likeButton.hidden = YES;
        self.sendButton.hidden = NO;
        
        POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        
        sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(8, 8)];
        sprintAnimation.springBounciness = 20.f;
        [self.sendButton pop_addAnimation:sprintAnimation forKey:@"sendAnimation"];
    }
}

-(void)showLikeButton {
    self.likeButton.hidden = NO;
    self.sendButton.hidden = YES;
    
    POPSpringAnimation *spin = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    spin.fromValue = @(M_PI / 4);
    spin.toValue = @(0);
    spin.springBounciness = 20;
    spin.velocity = @(10);
    [self.likeButton.layer pop_addAnimation:spin forKey:@"likeAnimation"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
