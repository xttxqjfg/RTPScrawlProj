//
//  RTPScrawlView.h
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/17.
//  Copyright © 2019 易博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTPScrawlView : UIView

/**
 接收到的原数据绘画

 @param jsonStr json数据
 */
- (void)drawLineWithPathData:(NSString *)jsonStr;

/**
 *  清除所有轨迹
 */
- (void)clearAllPaint;

/**
 *  撤销一步
 */
- (void)undo;

@end
