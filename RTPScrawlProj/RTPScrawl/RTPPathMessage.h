//
//  RTPPathMessage.h
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/21.
//  Copyright © 2019 易博. All rights reserved.
//

#import "RTPMessageContent.h"

/*!
 涂鸦轨迹消息类
 */
@interface RTPPathMessage : RTPMessageContent

/*!
 轨迹消息的内容
 */
@property(nonatomic, copy) NSString *content;

/*!
 轨迹消息的附加信息
 */
@property(nonatomic, copy) NSString *extra;

/*!
 初始化轨迹消息
 
 @param content 轨迹消息的内容
 @return        轨迹消息对象
 */
+ (instancetype)messageWithContent:(NSString *)content;

@end
