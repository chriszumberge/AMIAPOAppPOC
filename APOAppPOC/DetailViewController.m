//
//  DetailViewController.m
//  APOAppPOC
//
//  Created by Christopher Zumberge on 10/16/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import "DetailViewController.h"
#import <PNChart/PNChart.h>
#import "KPIData.h"
#import "KPI.h"
#import "Helper.h"
#import <ChameleonFramework/Chameleon.h>

@interface DetailViewController ()

@end

@implementation DetailViewController
{
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGFloat navHeight;
    UIView *currentGraph;
    BOOL firstLoad;
}
@synthesize dashboard;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        dashboard = (Dashboard*)_detailItem;

        // Update the view.
        //[self configureView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    firstLoad = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    if (firstLoad)
    {
        self.graphTitle.text = dashboard.dashboardName;
    }
    else
    {
        [self configureView];
    }
    self.navigationController.navigationBar.tintColor = FlatWhite;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self.view setNeedsDisplay];
    if (firstLoad)
    {
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    navHeight = self.navigationController.navigationBar.frame.size.height;
    if (currentGraph)
    {
        [currentGraph removeFromSuperview];
    }
    currentGraph = nil;
    
    if (dashboard) {
        if ([dashboard.graphType isEqualToString:@"line"])
        {
            //CGFloat charth = screenHeight * 0.75;
            //CGFloat chartw = screenWidth;
            //CGFloat chartx = (screenWidth / 2.0);
            //CGFloat charty = navHeight + 40;
            CGFloat charth = self.graphView.bounds.size.height;
            CGFloat chartw = self.graphView.bounds.size.width;
            CGFloat chartx = 0;
            CGFloat charty = 0;
            
            PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(chartx, charty, chartw, charth)];
            [lineChart setXLabels:[Helper reverseArrayToArray:dashboard.dashboardData.dates]];
            NSMutableArray *kpiNames = [[NSMutableArray alloc] init];
            NSMutableArray *allDataItems = [[NSMutableArray alloc] init];
            int iterator = 0;
            for (KPI *kpi in dashboard.dashboardData.kpiDataArray)
            {
                [kpiNames addObject:kpi.name];
                NSArray *dataArray = kpi.data;
                PNLineChartData *data = [PNLineChartData new];
                data.color = [self getColorFromIteratorValue:iterator];
                data.itemCount = lineChart.xLabels.count;
                data.getData = ^(NSUInteger index) {
                    CGFloat yValue = [dataArray[index] floatValue];
                    return [PNLineChartDataItem dataItemWithY:yValue];
                };
                [allDataItems addObject:data];
                iterator++;
            }
            
            lineChart.chartData = [[NSArray alloc] initWithArray:allDataItems];

            lineChart.backgroundColor = [UIColor clearColor];
            lineChart.translatesAutoresizingMaskIntoConstraints = NO;
            
            self.graphTitle.text = dashboard.dashboardName;
            [self.graphView addSubview:lineChart];
            //[self.view addSubview:lineChart];
            
            [lineChart strokeChart];
            currentGraph = lineChart;
        }
        else if ([dashboard.graphType isEqualToString:@"grid"])
        {
            
        }
        else if ([dashboard.graphType isEqualToString:@"bar"])
        {
            //CGFloat charth = screenHeight * 0.75;
            //CGFloat chartw = screenWidth;
            CGFloat charth = self.graphView.bounds.size.height;
            CGFloat chartw = self.graphView.bounds.size.width;
            NSLog(@"Height %1.2f, Width %1.2f", charth, chartw);
            //CGFloat chartx = (screenWidth / 2) - (chartw / 2);
            //CGFloat charty = navHeight + 40;
            CGFloat chartx = 0;
            CGFloat charty = 0;
            
            PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(chartx, charty, chartw, charth)];
            
            NSMutableArray *xVals = [[NSMutableArray alloc] init];
            NSMutableArray *yVals = [[NSMutableArray alloc] init];
            NSMutableArray *sColors = [[NSMutableArray alloc] init];
            
            for (KPI *kpi in dashboard.dashboardData.kpiDataArray)
            {
                [xVals addObject:kpi.name];
                [yVals addObject:kpi.data.firstObject];
                [sColors addObject:[self getColorFromValue:[kpi.data.firstObject intValue] andGoodLowerBound:[kpi.goodLowerBound intValue] andWarningLowerBound:[kpi.warningLowerBound intValue]]];
            }
            [barChart setXLabels:xVals];
            [barChart setYValues:yVals];
            [barChart setStrokeColors:sColors];
            [barChart setYValueMax:100];
            barChart.showLabel = NO;
            [barChart strokeChart];
            
            self.graphTitle.text = dashboard.dashboardName;
            [self.graphView addSubview:barChart];
            
            //[self.view addSubview:barChart];
            
            [barChart strokeChart];
            currentGraph = barChart;
            //[self.view setNeedsDisplay];
        }
        else
        {
            self.graphTitle.text = @"Invalid Data Format";
        }
        
        [self.view layoutSubviews];
    }
}

- (UIColor*)getColorFromIteratorValue:(int)val
{
    switch (val) {
        case 0:
            return FlatGreen;
        case 1:
            return FlatSkyBlue;
        case 2:
            return FlatRed;
        case 3:
            return FlatYellow;
        case 4:
            return FlatWatermelon;
        case 5:
            return FlatMint;
        case 6:
            return FlatGray;
        case 7:
            return FlatLime;
        case 8:
            return FlatPink;
        case 9:
            return FlatMagenta;
        case 10:
            return FlatPowderBlue;
        default:
            return FlatBlack;
    }
}

- (UIColor*)getColorFromValue:(int)kpiVal andGoodLowerBound:(int)glb andWarningLowerBound:(int)wlb
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

-(void)orientationChanged:(NSNotification *)note
{
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
