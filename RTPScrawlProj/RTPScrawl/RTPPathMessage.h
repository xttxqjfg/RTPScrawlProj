//
//  RTPPathMessage.h
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/21.
//  Copyright © 2019 易博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 轨迹消息的类型名
 */
#define RTPPathMessageTypeIdentifier @"RTP:PathMsg"

/*!
 涂鸦轨迹消息类
 */
@interface RTPPathMessage : NSObject

/*!
 涂鸦轨迹图层的大小
 */
@property(nonatomic, assign) CGSize layerSize;

/*!
 初始化轨迹消息
 
 @param pathArr 轨迹消息的内容
 @param layerSize 画布大小
 @return        轨迹消息json串
 */
- (NSString *)messageWithContent:(NSArray *)pathArr size:(CGSize)layerSize;

@end
