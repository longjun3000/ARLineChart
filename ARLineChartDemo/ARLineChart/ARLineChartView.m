//
//  RLLineChartView.m
//  testLineChart
//
//  Created by LongJun on 13-12-21.
//  Copyright (c) 2013年 LongJun. All rights reserved.
//
#if !__has_feature(objc_arc)
#error "This source file must be compiled with ARC enabled!"
#endif

#import "ARLineChartView.h"
#import "ARLineChartContentView.h"
#import "ARLineChartCommon.h"


#define MARGIN_TOP 5
#define Y1_MARGIN_LEFT 20
#define Y2_MARGIN_RIGHT 20
#define X_MARGIN_BUTTOM 10 //x轴横线距离底边的高度

@interface ARLineChartView ()

@property (strong, nonatomic) NSString *title1;
@property (strong, nonatomic) NSString *title2;
@property (strong, nonatomic) NSString *titleX;
@property (strong, nonatomic) NSString *desc1;
@property (strong, nonatomic) NSString *desc2;

@property (strong, nonatomic) ARLineChartContentView *lineChartContentView;

@end

@implementation ARLineChartView

- (id)initWithFrame:(CGRect)frame dataSource:(NSArray*)dataSource xTitle:(NSString*)xTitle y1Title:(NSString*)y1Title y2Title:(NSString*)y2Title desc1:(NSString*)desc1 desc2:(NSString*)desc2
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        //        self.backgroundColor = [UIColor brownColor];
        //        self.backgroundColor = [UIColor whiteColor];
        
        //////////// test ///////////////////
        self.titleX = xTitle ? xTitle : @"X";
        self.title1 = y1Title ? y1Title : @"Y1";
        self.title2 = y2Title ? y2Title : @"Y2";
        
        self.desc1 = desc1 ? desc1 : @"Desc1";
        self.desc2 = desc2 ? desc2 : @"Desc2";
        //////////// end //////////////////
        
        ////////////////////////// 上面的标题 //////////////////////////
        UIFont *font = [UIFont systemFontOfSize:14];
        CGFloat y = MARGIN_TOP;
        
        CGSize title1Size = [y1Title sizeWithFont:font];
        CGRect titleRect1 = CGRectMake((self.frame.size.width - title1Size.width) / 2,
                                       y,
                                       title1Size.width,
                                       title1Size.height);
        UILabel *lblTitle1 = [[UILabel alloc] initWithFrame:titleRect1];
        lblTitle1.text = y1Title;
        lblTitle1.textColor = line1Color;
        lblTitle1.font = font;
        [self addSubview:lblTitle1];
        
        //
        y = titleRect1.origin.y + titleRect1.size.height + 2;
        CGSize title2Size = [y2Title sizeWithFont:font];
        CGRect titleRect2 = CGRectMake((self.frame.size.width - title2Size.width) / 2,
                                       y,
                                       title2Size.width,
                                       title2Size.height);
        UILabel *lblTitle2 = [[UILabel alloc] initWithFrame:titleRect2];
        lblTitle2.text = y2Title;
        lblTitle2.textColor = line2Color;
        lblTitle2.font = font;
        [self addSubview:lblTitle2];
        
        
        ////////////////////// 折线图内容区域 ///////////////////////////
        y = titleRect2.origin.y + titleRect2.size.height + 5;
        CGRect rect = CGRectMake(0,
                                 y,
                                 self.frame.size.width,
                                 self.frame.size.height - y - X_MARGIN_BUTTOM);
        self.lineChartContentView = [[ARLineChartContentView alloc] initWithFrame:rect dataSource:dataSource];
        [self addSubview:self.lineChartContentView];
        
        
        ////////////////////// 注册手势监听 ///////////////////////////
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(pinchDetected:)];
        
        [self addGestureRecognizer:pinchRecognizer];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    ////////////////////////// 画标题 //////////////////////////
//    UIColor *textColor = line1Color;
//    UIFont *font = [UIFont systemFontOfSize:14];
//    CGFloat y = MARGIN_TOP;
//
//    //画标题1
//    [textColor set];
//    CGSize title1Size = [self.title1 sizeWithFont:font];
//    CGRect titleRect1 = CGRectMake((self.frame.size.width - title1Size.width) / 2,
//                             y,
//                             title1Size.width,
//                             title1Size.height);
//    [self.title1 drawInRect:titleRect1 withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
//
//    //画标题2
//    textColor = line2Color;
//    [textColor set];
//    y = titleRect1.origin.y + titleRect1.size.height + 2;
//    CGSize title2Size = [self.title2 sizeWithFont:font];
//    CGRect titleRect2 = CGRectMake((self.frame.size.width - title2Size.width) / 2,
//                              y,
//                              title2Size.width,
//                              title2Size.height);
//    [self.title2 drawInRect:titleRect2 withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];

    
    ////////////////////// 画底部线条颜色说明文字 //////////////////////////
    //短线条1
    UIColor *textColor = line1Color;
    [textColor set];
    CGFloat originY =  self.frame.size.height - X_MARGIN_BUTTOM;
    CGFloat y = originY + (X_MARGIN_BUTTOM/2);
    CGPoint startPoint = CGPointMake(Y1_MARGIN_LEFT, y);
    CGPoint endPoint = CGPointMake(Y1_MARGIN_LEFT+ 15, y);
    [ARLineChartCommon drawLine:context startPoint:startPoint endPoint:endPoint lineColor:textColor];
    //描述文字1
    UIFont *descFont = [UIFont systemFontOfSize:8];
    CGSize desc1Size = [self.desc1 sizeWithFont:descFont];
    //    startPoint = CGPointMake(endPoint.x + 3, y - (desc1Size.height/2));
    CGRect desc1Rect = CGRectMake(endPoint.x + 3,
                                  y - (desc1Size.height/2),
                                  desc1Size.width,
                                  desc1Size.height);
    [self.title1 drawInRect:desc1Rect withFont:descFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentLeft];
    
    //短线条2
    textColor = line2Color;
    [textColor set];
    
    startPoint = CGPointMake(desc1Rect.origin.x + desc1Rect.size.width + 10, y);
    endPoint = CGPointMake(startPoint.x + 15, y);
    [ARLineChartCommon drawLine:context startPoint:startPoint endPoint:endPoint lineColor:textColor];
    //描述文字2
    CGSize desc2Size = [self.desc2 sizeWithFont:descFont];
    //    startPoint = CGPointMake(endPoint.x + 3, y - (desc2Size.height/2));
    CGRect desc2Rect = CGRectMake(endPoint.x + 3,
                                  y - (desc2Size.height/2),
                                  desc2Size.width,
                                  desc2Size.height);
    [self.title2 drawInRect:desc2Rect withFont:descFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentLeft];
    
    //x轴说明文字
    [[UIColor grayColor] set];
    UIFont *titleXFont = [UIFont systemFontOfSize:10];
    CGSize titleXSize = [self.title1 sizeWithFont:titleXFont];
    //    startPoint = CGPointMake(self.frame.size.width - Y2_MARGIN_RIGHT - titleXSize.width, y - (titleXSize.height/2));
    //x: self.frame.size.width - Y2_MARGIN_RIGHT - titleXSize.width - 140
    CGRect titleXRect = CGRectMake((self.frame.size.width - titleXSize.width) / 2,
                                   y - (titleXSize.height/2),
                                   titleXSize.width,
                                   titleXSize.height);
    [self.titleX drawInRect:titleXRect withFont:titleXFont lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentRight];
    
}

//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor (context, 142.0/ 255.0, 161.0/ 255.0, 189.0/ 255.0, 1.0);
//    CGContextSetLineWidth(context, 1.0 );//这里设置成了1但画出的线还是2px,给我们的感觉好像最小只能是2px。
//    CGContextSetShouldAntialias(context, YES ); //抗锯齿
//    CGContextMoveToPoint(context, 1.0 , 24.0 );
//    CGContextAddLineToPoint(context, 83.0 , 54.0 );
//    CGContextClosePath(context);
//    CGContextStrokePath(context);
//
//    //
//    [self drawPoint:context point:CGPointMake(50, 60) color:[UIColor redColor]];
//    //
//    [self drawLine:context
//        startPoint:CGPointMake(20, 30)
//          endPoint:CGPointMake(20, 100)
//         lineColor:[UIColor blueColor]];
//}

//x轴和y轴同时放大一个刻度
- (void)zoomUp
{
    [self.lineChartContentView zoomUp];
}
//x轴和y轴同时减小一个刻度
- (void)zoomDown
{
    [self.lineChartContentView zoomDown];
}
//x轴和y轴还原到原始刻度
- (void)zoomOriginal
{
    [self.lineChartContentView zoomOriginal];
}

//x轴放大一个刻度
- (void)zoomHorizontalUp
{
    [self.lineChartContentView zoomHorizontalUp];
}
//x轴减小一个刻度
- (void)zoomHorizontalDown
{
    [self.lineChartContentView zoomHorizontalDown];
}

//y轴放大一个刻度
- (void)zoomVerticalUp
{
    [self.lineChartContentView zoomVerticalUp];
}
//y轴减小一个刻度
- (void)zoomVerticalDown
{
    [self.lineChartContentView zoomVerticalDown];
}

//刷新图表
- (void)refreshData:(NSArray*)dataSource
{
    [self.lineChartContentView refreshData:dataSource];
}

- (IBAction)pinchDetected:(UIPinchGestureRecognizer *)sender {
    
    //比例（经常用到放缩比例）这个属性默认值是1，通过获取放缩比例属性
    CGFloat scale =  [(UIPinchGestureRecognizer *)sender scale];
//    //捏合的速度
//    CGFloat velocity = [(UIPinchGestureRecognizer *)sender velocity];
    
//    NSString *resultString = [[NSString alloc] initWithFormat:
//                              
//                              @"Pinch - scale = %f, velocity = %f",
//                              
//                              scale, velocity];
    
//    NSLog(@"%@", resultString);
//    if([sender state] == UIGestureRecognizerStateEnded) {
    if([sender state] == UIGestureRecognizerStateChanged) {
        if (scale >= 1.1) { //放大
            
            [self.lineChartContentView zoomHorizontalUp];
        }
        else { //缩小
            [self.lineChartContentView zoomHorizontalDown];
        }
    }
    
}


@end




