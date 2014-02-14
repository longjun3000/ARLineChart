//
//  ARViewController.m
//  ARLineChartDemo
//
//  Created by LongJun on 14-2-14.
//  Copyright (c) 2014年 Arwer Software. All rights reserved.
//

#import "ARViewController.h"
#import "ARLineChartView.h"
#import "ARLineChartCommon.h"

@interface ARViewController ()

@property (strong, nonatomic) ARLineChartView *lineChartView;

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //************* Test: Create Data Source *************
    NSMutableArray *dataSource = [NSMutableArray array];
    // rand() /((double)(RAND_MAX)/100) //取0-100中间的浮点数
    double distanceMin = 0, distanceMax = 100;
    double altitudeMin = 5.0, altitudeMax = 50;
    double speedMin = 0.5, speedMax = 15;
    
    srand(time(NULL)); //Random seed
    
    for (int i=0; i< 11; i++) {
        
        RLLineChartItem *item = [[RLLineChartItem alloc] init];
        double randVal;
        
        randVal = rand() /((double)(RAND_MAX)/distanceMax) + distanceMin;
        item.xValue = randVal;
        
        randVal = rand() /((double)(RAND_MAX)/altitudeMax) + altitudeMin;
        item.y1Value = randVal;
        
        randVal = rand() /((double)(RAND_MAX)/speedMax) + speedMin;
        item.y2Value = randVal;
        
        NSLog(@"Random: item.xValue=%.2lf, item.y1Value=%.2lf, item.y2Value=%.2lf", item.xValue, item.y1Value, item.y2Value);
        [dataSource addObject:item];
    }
    //************ End Test *********************
    
    ////////////// Create Line Char //////////////////////////
    CGRect rect = CGRectMake(5, 40,
                             self.view.frame.size.width - 5 - 5,
                             300);
//    self.lineChartView = [[ARLineChartView alloc] initWithFrame:rect dataSource:dataSource xTitle:@"千米" y1Title:@"海拔（米）" y2Title:@"速度（千米/小时）" desc1:@"海拔" desc2:@"速度"];
    self.lineChartView = [[ARLineChartView alloc] initWithFrame:rect dataSource:dataSource xTitle:@"Kilometre" y1Title:@"Altitude (meters)" y2Title:@"Speed (km/h)" desc1:@"Altitude" desc2:@"Speed"];
    [self.view addSubview:self.lineChartView];
    
    ////////////// Test: Create Control Button ////////////////////
    rect = CGRectMake(self.lineChartView.frame.origin.x,
                      self.lineChartView.frame.origin.y + self.lineChartView.frame.size.height +2,
                      100, 20);
    UIButton *btnZoomUp = [UIButton buttonWithType:UIButtonTypeSystem];
    btnZoomUp.frame = rect;
    btnZoomUp.titleLabel.font = [UIFont systemFontOfSize:10];
    [btnZoomUp setTitle:@"Zoom In All" forState:UIControlStateNormal]; //整体放大
    [btnZoomUp addTarget:self action:@selector(zoomUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZoomUp];
    
    //
    rect = CGRectMake(btnZoomUp.frame.origin.x + btnZoomUp.frame.size.width + 5,
                      btnZoomUp.frame.origin.y,
                      btnZoomUp.frame.size.width,
                      btnZoomUp.frame.size.height);
    UIButton *btnZoomDown = [UIButton buttonWithType:UIButtonTypeSystem];
    btnZoomDown.frame = rect;
    btnZoomDown.titleLabel.font = btnZoomUp.titleLabel.font;
    [btnZoomDown setTitle:@"Zoom Out All" forState:UIControlStateNormal]; //整体缩小
    [btnZoomDown addTarget:self action:@selector(zoomDownAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZoomDown];
    
    //
    rect = CGRectMake(btnZoomDown.frame.origin.x + btnZoomDown.frame.size.width + 5,
                      btnZoomDown.frame.origin.y,
                      btnZoomDown.frame.size.width,
                      btnZoomDown.frame.size.height);
    UIButton *btnZoomOriginal = [UIButton buttonWithType:UIButtonTypeSystem];
    btnZoomOriginal.frame = rect;
    btnZoomOriginal.titleLabel.font = btnZoomUp.titleLabel.font;
    [btnZoomOriginal setTitle:@"Original Size" forState:UIControlStateNormal]; //原始大小
    [btnZoomOriginal addTarget:self action:@selector(zoomOriginalAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZoomOriginal];
    
    //
    rect = CGRectMake(btnZoomUp.frame.origin.x ,
                      btnZoomUp.frame.origin.y + btnZoomUp.frame.size.height + 10,
                      btnZoomDown.frame.size.width,
                      btnZoomDown.frame.size.height);
    UIButton *btnZoomHorizontaUp = [UIButton buttonWithType:UIButtonTypeSystem];
    btnZoomHorizontaUp.frame = rect;
    btnZoomHorizontaUp.titleLabel.font = btnZoomUp.titleLabel.font;
    [btnZoomHorizontaUp setTitle:@"Zoom In Horizontal" forState:UIControlStateNormal]; //水平放大
    [btnZoomHorizontaUp addTarget:self action:@selector(zoomHorizontaUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZoomHorizontaUp];
    
    //
    rect = CGRectMake(btnZoomHorizontaUp.frame.origin.x + btnZoomHorizontaUp.frame.size.width + 25,
                      btnZoomHorizontaUp.frame.origin.y,
                      btnZoomHorizontaUp.frame.size.width,
                      btnZoomHorizontaUp.frame.size.height);
    UIButton *btnZoomHorizontaDown = [UIButton buttonWithType:UIButtonTypeSystem];
    btnZoomHorizontaDown.frame = rect;
    btnZoomHorizontaDown.titleLabel.font = btnZoomUp.titleLabel.font;
    //    btnZoomHorizontaDown.titleLabel.textColor = [UIColor blueColor];
    //    btnZoomHorizontaDown.backgroundColor = [UIColor clearColor];
    [btnZoomHorizontaDown setTitle:@"Zoom Out Horizontal" forState:UIControlStateNormal]; //水平缩小
    [btnZoomHorizontaDown addTarget:self action:@selector(zoomHorizontaDownAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZoomHorizontaDown];
    
    //
    rect = CGRectMake(btnZoomUp.frame.origin.x ,
                      btnZoomHorizontaUp.frame.origin.y + btnZoomHorizontaUp.frame.size.height + 10,
                      btnZoomHorizontaDown.frame.size.width,
                      btnZoomHorizontaDown.frame.size.height);
    UIButton *btnZoomVerticalUp = [UIButton buttonWithType:UIButtonTypeSystem];
    btnZoomVerticalUp.frame = rect;
    btnZoomVerticalUp.titleLabel.font = btnZoomUp.titleLabel.font;
    [btnZoomVerticalUp setTitle:@"Zoom In Vertical" forState:UIControlStateNormal]; //垂直放大
    [btnZoomVerticalUp addTarget:self action:@selector(zoomVerticalUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZoomVerticalUp];
    
    //
    rect = CGRectMake(btnZoomVerticalUp.frame.origin.x + btnZoomVerticalUp.frame.size.width + 25,
                      btnZoomVerticalUp.frame.origin.y,
                      btnZoomVerticalUp.frame.size.width,
                      btnZoomVerticalUp.frame.size.height);
    UIButton *btnZoomVerticalDown = [UIButton buttonWithType:UIButtonTypeSystem];
    btnZoomVerticalDown.frame = rect;
    btnZoomVerticalDown.titleLabel.font = btnZoomUp.titleLabel.font;
    [btnZoomVerticalDown setTitle:@"Zoom Out Vertical" forState:UIControlStateNormal]; //垂直缩小
    [btnZoomVerticalDown addTarget:self action:@selector(zoomVerticalDownAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZoomVerticalDown];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)zoomUpAction:(id)sender
{
    [self.lineChartView zoomUp];
}
- (void)zoomDownAction:(id)sender
{
    [self.lineChartView zoomDown];
}
- (void)zoomOriginalAction:(id)sender
{
    [self.lineChartView zoomOriginal];
}
- (void)zoomHorizontaUpAction:(id)sender
{
    [self.lineChartView zoomHorizontalUp];
}
- (void)zoomHorizontaDownAction:(id)sender
{
    [self.lineChartView zoomHorizontalDown];
}
- (void)zoomVerticalUpAction:(id)sender
{
    [self.lineChartView zoomVerticalUp];
}
- (void)zoomVerticalDownAction:(id)sender
{
    [self.lineChartView zoomVerticalDown];
}

@end

