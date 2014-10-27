//
//  KPI.h
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/16/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPI : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSNumber *goodLowerBound;
@property (nonatomic, strong) NSNumber *warningLowerBound;

@end
