//
//  ASH500pxDemoViewController.m
//  FunctionalReactiveDemo
//
//  Created by Ash Furrow on 1/12/2014.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

#import "ASH500pxDemoViewController.h"

#import "ASHPhotoModel.h"

#import <500px-iOS-api/PXAPI.h>

@interface ASH500pxDemoViewController ()

@property (nonatomic, strong) NSArray *photosArray;

@end

@implementation ASH500pxDemoViewController

#pragma mark - Class Methods

+(NSURLRequest *)popularURLRequest {
    return [[PXRequest apiHelper] urlRequestForPhotoFeature:PXAPIHelperPhotoFeaturePopular resultsPerPage:100 page:0 photoSizes:PXPhotoModelSizeThumbnail sortOrder:PXAPIHelperSortOrderRating except:PXPhotoModelCategoryNude];
}

#pragma mark - Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *request = [ASH500pxDemoViewController popularURLRequest];
    RAC(self, photosArray) = [[[[NSURLConnection rac_sendAsynchronousRequest:request] reduceEach:^id(NSHTTPURLResponse *response, NSData *data) {
        if (data && response.statusCode == 200) {
            id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            return results;
        } else {
            return nil;
        }
    }] deliverOn:[RACScheduler mainThreadScheduler]] map:^id(NSDictionary *results) {
        NSArray *photosArray = [[[results[@"photos"] rac_sequence] map:^id(NSDictionary *photoDictionary) {
            ASHPhotoModel *model = [ASHPhotoModel new];
            
            model.photoName = photoDictionary[@"name"];
            model.photoId = photoDictionary[@"id"];
            model.photoThumbnailURLString = photoDictionary[@"image_url"];
            
            return model;
        }] array];
        
        return photosArray;
    }];
    
    // Note that self needs to be weakified
    __weak __typeof(self) weakSelf = self;
    [RACObserve(self, photosArray) subscribeNext:^(id x) {
        __typeof(weakSelf) self = weakSelf;
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photosArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.photosArray[indexPath.row] photoName];
    
    return cell;
}

@end
