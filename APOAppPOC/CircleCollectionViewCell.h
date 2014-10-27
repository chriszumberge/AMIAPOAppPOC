//
//  CircleCollectionViewCell.h
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/20/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
