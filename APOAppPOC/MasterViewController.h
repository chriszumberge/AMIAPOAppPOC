//
//  MasterViewController.h
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/16/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSDictionary *responseDictionary;
@property (strong, nonatomic) NSArray *responseArray;



@end

