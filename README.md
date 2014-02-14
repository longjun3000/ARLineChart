ARLineChar
==========

ARLineChar is a line char view on iOS , written using Objective-C . There are scenarios for applications requiring dual- Y axis.
x -axis and y-axis can zoom in and out , you can scroll , double-click can restore the original size.

ARLineChar是一个iOS的折线图，使用Objective-C编写。适用于需要有双Y轴的应用场景。
x轴和y轴可以放大和缩小，可以滚动，双击可以还原原始大小。


How to use ?
============
1. "ARLineChar" folder all the files can be added to the project .

2. where it is needed to introduce the header file :
```
#import "ARLineChartView.h"
#import "ARLineChartCommon.h"
```

3. the initialization data sources, such as :
```
NSMutableArray *dataSource = [NSMutableArray array];
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
```

4. the initialization line chart view:
```
CGRect rect = CGRectMake (5, 40, self.view.frame.size.width - 5 - 5, 300);
self.lineChartView = [[ARLineChartView alloc] initWithFrame: rect dataSource: dataSource xTitle: @ "Kilometre" y1Title: @ "Altitude (meters)" y2Title: @ "Speed ​​(km / h)" desc1: @ "Altitude" desc2: @ "Speed"];
[self.view addSubview: self.lineChartView];
```

如何使用？
========
1、将“ARLineChar”文件夹内所有文件加入到工程中即可。

2、在需要的地方引入头文件：
```
#import "ARLineChartView.h"
#import "ARLineChartCommon.h"
```

3、初始化数据源，例如：
```
NSMutableArray *dataSource = [NSMutableArray array];
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
```

4、初始化折线图视图：
```
CGRect rect = CGRectMake (5, 40, self.view.frame.size.width - 5 - 5, 300);
self.lineChartView = [[ARLineChartView alloc] initWithFrame: rect dataSource: dataSource xTitle: @ "Kilometre" y1Title: @ "Altitude (meters)" y2Title: @ "Speed ​​(km / h)" desc1: @ "Altitude" desc2: @ "Speed"];
[self.view addSubview: self.lineChartView];
```


Contact
=======
ArwerSoftware@gmail.com

联系方式
=======
ArwerSoftware@gmail.com


License
=======
The MIT License (MIT)

Copyright © 2014 <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

