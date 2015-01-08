//
//  DrawLineView.m
//  风筝
//
//  Created by 李俊英 on 15/1/8.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "DrawLineView.h"

@implementation DrawLineView
- (void)drawRect:(CGRect)rect
{
    [self drawMyLine];
}

- (void)drawMyLine
{
    NSLog(@"Called one time");
    //draw line
    CGContextRef context    =UIGraphicsGetCurrentContext();//获取画布
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//线条颜色
    CGContextSetShouldAntialias(context,NO);//设置线条平滑，不需要两边像素宽
    CGContextSetLineWidth(context,1.0f);//设置线条宽度
    CGContextMoveToPoint(context,153,6); //线条起始点
    CGContextAddLineToPoint(context,153,145);//线条结束点
    CGContextStrokePath(context);//结束，也就是开始画
}
@end
