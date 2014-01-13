//
//  ASHDetailViewController.m
//  FunctionalReactiveDemo
//
//  Created by Ash Furrow on 1/12/2014.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

#import "ASHGestureRecognizerDemoViewController.h"

@interface ASHGestureRecognizerDemoViewController ()

@property (weak, nonatomic) IBOutlet UIView *boxView;

@end

@implementation ASHGestureRecognizerDemoViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] init];
    [self.view addGestureRecognizer:recognizer];
    
    RAC(self.boxView, center) = [[recognizer rac_gestureSignal] map:^id(UIGestureRecognizer *recognizer) {
        return [NSValue valueWithCGPoint:[recognizer locationInView:recognizer.view]];
    }];
    RAC(self.boxView, backgroundColor) = [[recognizer rac_gestureSignal] map:^id(id value) {
        CGPoint location = [recognizer locationInView:recognizer.view];
        CGFloat hue = location.x / CGRectGetWidth(recognizer.view.bounds);
        CGFloat brightness = location.y / CGRectGetHeight(recognizer.view.bounds);
        return [UIColor colorWithHue:hue saturation:1.0f brightness:brightness alpha:1.0f];
    }];
    [[recognizer rac_gestureSignal] subscribeNext:^(UIPanGestureRecognizer *recognizer) {
        CGPoint location = [recognizer locationInView:recognizer.view];
        NSLog(@"(%f, %f)", location.x, location.y);
    }];
}

@end
