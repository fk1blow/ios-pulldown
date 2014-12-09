//
//  ViewController.h
//  Pull Down View
//
//  Created by Dragos Tudorache on 12/6/14.
//  Copyright (c) 2014 skemathorus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    CGPoint lastLocation;
}

@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIView *otherView;
@property (weak, nonatomic) IBOutlet UILabel *currentX;
@property (weak, nonatomic) IBOutlet UILabel *currentY;

@end

