//
//  Helper.m
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/17/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import "Helper.h"
#import <ChameleonFramework/Chameleon.h>

@implementation Helper

+(NSArray*)reverseArrayToArray:(NSArray *)array
{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (NSObject *o in [array reverseObjectEnumerator])
    {
        [mArray addObject:o];
    }
    return [[NSArray alloc] initWithArray:mArray];
}

+(NSArray*)reverseMutableArrayToArray:(NSMutableArray *)array
{
    return [self reverseArrayToArray:array];
}

+(NSMutableArray*)reverseArrayToMutableArray:(NSArray *)array
{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (NSObject *o in [array reverseObjectEnumerator])
    {
        [mArray addObject:o];
    }
    return mArray;
}

+(NSMutableArray*)reverseMutableArrayToMutableArray:(NSMutableArray *)array
{
    return [self reverseArrayToMutableArray:array];
}

+ (UIColor*)getColorFromValue:(int)kpiVal andGoodLowerBound:(int)glb andWarningLowerBound:(int)wlb
{
    if (kpiVal >= glb)
    {
        return FlatGreen;
    }
    else if (kpiVal >= wlb)
    {
        return FlatYellow;
    }
    else
    {
        return FlatRed;
    }
}

+(void)configureNavBarProperties:(UINavigationBar*)navbar
{
    navbar.tintColor = [UIColor flatSkyBlueColor];
    [self setTitleBarPropertiesForBackgroundColor:[UIColor flatSkyBlueColor]];
}

+(void)configureNavBarProperties:(UINavigationBar*)navbar WithColor:(UIColor*)color
{
    navbar.tintColor = color;
    [self setTitleBarPropertiesForBackgroundColor:color];
}

+ (void)setTitleBarProperties
{
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:FlatWhite forKey:NSForegroundColorAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:FlatWhite, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    [[UINavigationBar appearance] setTintColor:FlatSkyBlue];
}

+ (void)setTitleBarPropertiesForBackgroundColor:(UIColor *)color
{
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    UIColor *txtColor = [UIColor colorWithContrastingBlackOrWhiteColorOn:color isFlat:YES];
    [titleBarAttributes setValue:txtColor forKey:NSForegroundColorAttributeName];
    //[titleBarAttributes setValue:ROBOTO_SLAB_LIGHT(25.0f) forKey:NSFontAttributeName];
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:txtColor, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    //[[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSFontAttributeName:ROBOTO_SLAB(15.0f)} forState:UIControlStateNormal];
}

@end
