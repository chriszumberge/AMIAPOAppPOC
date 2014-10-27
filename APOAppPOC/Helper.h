//
//  Helper.h
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/17/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PNChart/PNChart.h>

@interface Helper : NSObject

+(NSArray*)reverseArrayToArray:(NSArray*)array;
+(NSArray*)reverseMutableArrayToArray:(NSMutableArray*)array;
+(NSMutableArray*)reverseArrayToMutableArray:(NSArray*)array;
+(NSMutableArray*)reverseMutableArrayToMutableArray:(NSMutableArray*)array;

+ (UIColor*)getColorFromValue:(int)kpiVal andGoodLowerBound:(int)glb andWarningLowerBound:(int)wlb;

+(void)configureNavBarProperties:(UINavigationBar*)navbar;
+(void)configureNavBarProperties:(UINavigationBar*)navbar WithColor:(UIColor*)color;
+(void)setTitleBarProperties;
+(void)setTitleBarPropertiesForBackgroundColor:(UIColor*)color;

@end
