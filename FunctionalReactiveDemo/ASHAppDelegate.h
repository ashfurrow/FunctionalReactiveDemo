//
//  ASHAppDelegate.h
//  FunctionalReactiveDemo
//
//  Created by Ash Furrow on 1/12/2014.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
