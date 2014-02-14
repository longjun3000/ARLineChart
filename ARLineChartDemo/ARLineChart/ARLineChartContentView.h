//
//  SportLineChartContentView.h
//  testLineChart
//
//  Created by LongJun on 13-12-21.
//  Copyright (c) 2013年 LongJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARLineChartView.h"

@interface ARLineChartContentView : UIView

//构造函数，必须使用
- (id)initWithFrame:(CGRect)frame dataSource:(NSArray*)dataSource;

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
