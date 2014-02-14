//
//  RLLineChartView.h
//  testLineChart
//
//  Created by LongJun on 13-12-21.
//  Copyright (c) 2013年 LongJun. All rights reserved.
//
/* 使用方法：
 ///////////// Test 创建数据源 /////////////////////
 NSMutableArray *dataSource = [NSMutableArray array];
 // rand() /((double)(RAND_MAX)/100) //取0-100中间的浮点数
 double distanceMin = 0, distanceMax = 100;
 double altitudeMin = 5.0, altitudeMax = 50;
 double speedMin = 0.5, speedMax = 15;
 srand(time(NULL)); //随机数种子
 for (int i=0; i< 11; i++) {
 //        for (int i=0; i< self.xArray.count; i++) {
 RLLineChartItem *item = [[RLLineChartItem alloc] init];
 double randVal;
 
 randVal = rand() /((double)(RAND_MAX)/distanceMax) + distanceMin;
 item.xValue = randVal;
 //            item.xValue = [(NSNumber*)[self.xArray objectAtIndex:i] doubleValue];
 
 randVal = rand() /((double)(RAND_MAX)/altitudeMax) + altitudeMin;
 item.y1Value = randVal;
 
 randVal = rand() /((double)(RAND_MAX)/speedMax) + speedMin;
 item.y2Value = randVal;
 
 NSLog(@"随机： item.xValue=%.2lf, item.y1Value=%.2lf, item.y2Value=%.2lf", item.xValue, item.y1Value, item.y2Value);
 [dataSource addObject:item];
 }
 /////////////// End Test ///////////////////////////
 
 ////////////// 创建图表视图 //////////////////////////
 CGRect rect = CGRectMake(5, 40,
 self.view.frame.size.width - 5 - 5,
 300);
 self.lineChartView = [[RLLineChartView alloc] initWithFrame:rect dataSource:dataSource];
 self.lineChartView.title1 = @"海拔（米）";
 self.lineChartView.title2 = @"速度（千米/小时）";
 self.lineChartView.titleX = @"千米";
 [self.view addSubview:self.lineChartView];
 
 */

#import <UIKit/UIKit.h>

@interface ARLineChartView : UIView


//构造函数，必须使用
- (id)initWithFrame:(CGRect)frame dataSource:(NSArray*)dataSource xTitle:(NSString*)xTitle y1Title:(NSString*)y1Title y2Title:(NSString*)y2Title desc1:(NSString*)desc1 desc2:(NSString*)desc2;

//x轴和y轴同时放大一个刻度
- (void)zoomUp;
//x轴和y轴同时减小一个刻度
- (void)zoomDown;
//x轴和y轴还原到原始刻度
- (void)zoomOriginal;

//x轴放大一个刻度
- (void)zoomHorizontalUp;
//x轴减小一个刻度
- (void)zoomHorizontalDown;

//y轴放大一个刻度
- (void)zoomVerticalUp;
//y轴减小一个刻度
- (void)zoomVerticalDown;

//刷新图表
- (void)refreshData:(NSArray*)dataSource;

@end
