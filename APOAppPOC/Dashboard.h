//
//  Dashboard.h
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/16/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPIData.h"

@interface Dashboard : NSObject
@property (nonatomic, strong) NSString *dashboardName;
@property (nonatomic, strong) KPIData *dashboardData;
@property (nonatomic, strong) NSString *graphType;
@end
