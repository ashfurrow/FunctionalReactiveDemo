//
//  ASHAppDelegate.m
//  FunctionalReactiveDemo
//
//  Created by Ash Furrow on 1/12/2014.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

#import "ASHAppDelegate.h"

#import <500px-iOS-api/PXAPI.h>

@implementation ASHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [PXRequest setConsumerKey:@"DC2To2BS0ic1ChKDK15d44M42YHf9gbUJgdFoF0m" consumerSecret:@"i8WL4chWoZ4kw9fh3jzHK7XzTer1y5tUNvsTFNnB"];
    
    return YES;
}

@end
