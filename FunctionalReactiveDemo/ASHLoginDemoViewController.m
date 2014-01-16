//
//  ASHLoginDemoViewController.m
//  FunctionalReactiveDemo
//
//  Created by Ash Furrow on 1/13/2014.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

#import "ASHLoginDemoViewController.h"

@interface ASHLoginDemoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ASHLoginDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
RACSignal *enabledSignal = [RACSignal combineLatest:@[self.emailTextField.rac_textSignal, self.passwordTextField.rac_textSignal] reduce:^id(NSString *emailAddress, NSString *password){
    
    BOOL emailValid = [emailAddress rangeOfString:@"@"].location != NSNotFound;
    BOOL passwordValid = password.length > 6;
    return @(emailValid && passwordValid);
}];
   
    
    
    
    
    
    
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"Button was pressed");
    }];
    
    
    

    
    
    
    
    
    self.button.rac_command = [[RACCommand alloc] initWithEnabled:enabledSignal signalBlock:^RACSignal *(id input) {
        // Return a signal that represents a unit of work
        // It will be subscribed to when the button is pressed
        // Since this is confusing, it's being replaced with RACAction in ReactiveCocoa 3.0
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"Button was pressed.");
            // Perform some long-running task, like a network operation
            [subscriber sendCompleted];
            
            // Return a RACDisposable representing a possible cancellation
            return nil;
        }];
    }];
}

@end
