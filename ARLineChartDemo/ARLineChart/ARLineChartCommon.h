//
//  SportLineChartUtilty.h
//  testLineChart
//
//  Created by LongJun on 13-12-21.
//  Copyright (c) 2013年 LongJun. All rights reserved.
//

#import <Foundation/Foundation.h>

#define line1Color  [UIColor colorWithRed:(float)249/255 green:(float)176/255 blue:(float)47/255 alpha:1.0]//棕黄色
#define line2Color  [UIColor colorWithRed:(float)73/255 green:(float)146/255 blue:(float)187/255 alpha:1.0]//青蓝色
#define xylineColor  [UIColor blackColor]


@interface ARLineChartCommon : NSObject

+ (void)drawPoint:(CGContextRef)context point:(CGPoint)point color:(UIColor *)color;
+ (void)drawLine:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor;
+ (void)drawText:(CGContextRef)context text:(NSString*)text point:(CGPoint)point color:(UIColor *)color font:(UIFont*)font textAlignment:(NSTextAlignment)textAlignment;
+ (void)drawText2:(CGContextRef)context text:(NSString*)text color:(UIColor *)color fontSize:(CGFloat)fontSize;


@end


@interface RLLineChartItem : NSObject

@property double xValue; //水平x轴的值
@property double y1Value; //第一根垂直的y轴的值
@property double y2Value; //第二根垂直的y轴的值

@end