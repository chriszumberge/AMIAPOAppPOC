//
//  DetailCollectionViewController.h
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/20/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBCollectionViewBalancedColumnLayout.h"
#import "Dashboard.h"

@interface DetailCollectionViewController : UICollectionViewController <RBCollectionViewBalancedColumnLayoutDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) Dashboard* dashboard;

@end
