//
//  TodayViewController.m
//  APOWidget
//
//  Created by Christopher Zumberge on 10/21/14.
//  Copyright (c) 2014 Christopher Zumberge. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createSampleChart];
}

- (void)createSampleChart
{
    PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, self.graphView.frame.size.width, self.graphView.frame.size.height)];
    [lineChart setXLabels:@[@"SEP 1", @"SEP 2", @"SEP 3", @"SEP 4", @"SEP 5"]];
    NSArray *data1Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data1 = [PNLineChartData new];
    data1.color = PNFreshGreen;
    data1.itemCount = lineChart.xLabels.count;
    data1.getData = ^(NSUInteger index) {
        CGFloat yValue = [data1Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    NSArray *data2Array = @[@20.1, @180.1, @26.5, @202.2, @126.2];
    PNLineChartData *data2 = [PNLineChartData new];
    data2.color = PNTwitterColor;
    data2.itemCount = lineChart.xLabels.count;
    data2.getData = ^(NSUInteger index) {
        CGFloat yValue = [data2Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    lineChart.backgroundColor = [UIColor clearColor];
    lineChart.chartData = @[data1, data2];
    [lineChart strokeChart];
    [self.graphView addSubview:lineChart];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (IBAction)btnAction:(id)sender {
    NSLog(@"BUTTON PRESS");
    //[self createSampleChart];
}
@end
