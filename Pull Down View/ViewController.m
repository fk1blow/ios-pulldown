//
//  ViewController.m
//  Pull Down View
//
//  Created by Dragos Tudorache on 12/6/14.
//  Copyright (c) 2014 skemathorus. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveToolbar:)];
    [self.myView addGestureRecognizer:gesture];
}

- (void)viewDidAppear:(BOOL)animated {
//    [self.myView setFrame:CGRectMake(0, (self.view.frame.size.height - 100) * -1, self.view.frame.size.width, self.view.frame.size.height)];
    NSLog(@"current height %f", self.myView.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View gesture handlers

- (void)moveToolbar:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translatedPoint = [panGesture translationInView:self.myView.superview];
    CGFloat velocityY = [panGesture velocityInView:self.view].y;
    
    if ([panGesture state] == UIGestureRecognizerStateBegan) {
        CGFloat delta = self.myView.frame.size.height - [panGesture locationInView:self.view].y;
        CGRect newFrame = self.myView.superview.frame;
        newFrame.size.height = [panGesture locationInView:self.view].y + delta;
        self.myView.frame = newFrame;
    }
    else if ([panGesture state] == UIGestureRecognizerStateChanged) {
        CGRect newFrame = self.myView.frame;
        newFrame.size.height += translatedPoint.y;
        self.myView.frame = newFrame;
        [panGesture setTranslation:CGPointMake(0, 0) inView:self.myView.superview];
    }
    else if ([panGesture state] == UIGestureRecognizerStateEnded) {
        CGFloat halfOfParent = self.myView.superview.frame.size.height / 2;
        CGFloat wantsToCollapse = velocityY < -1500;
        CGFloat wantsToExpand = velocityY > 1500;
        
        if (wantsToCollapse || wantsToExpand) {
            if (wantsToCollapse) {
                [self collapseToolbar];
            } else {
                [self expandToolbar];
            }
        } else {
            if (self.myView.frame.size.height > halfOfParent) {
                [self expandToolbar];
            } else {
                [self collapseToolbar];
            }
        }
    }
}

- (void)expandToolbar
{
    [UIView animateWithDuration:0.12 animations:^{
        [self.myView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    } completion:^(BOOL finished) {
//        self.toolbarIsOpen = YES;
//        self.toolbarIsAnimating = NO;
//        [self.collapseButton setTitle:@"\u2B07" forState:UIControlStateNormal];
    }];
}

- (void)collapseToolbar
{
    [UIView animateWithDuration:0.12 animations:^{
        [self.myView setFrame:CGRectMake(0, 0, self.myView.superview.frame.size.width, 100)];
    } completion:^(BOOL finished) {
//        self.toolbarIsOpen = NO;
//        self.toolbarIsAnimating = NO;
//        [self.collapseButton setTitle:@"\u2B06" forState:UIControlStateNormal];
    }];
}

@end
