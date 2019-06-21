//
//  RTPPaintPath.m
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/21.
//  Copyright © 2019 易博. All rights reserved.
//

#import "RTPPaintPath.h"

@implementation RTPPaintPath

/**
 初始化轨迹画笔
 
 @return 画笔实例
 */
+ (instancetype)initRTPPaintPath {
    RTPPaintPath * path = [[self alloc] init];
    path.lineWidth = 3.0;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineCapRound; //终点处理
    return path;
}

@end
