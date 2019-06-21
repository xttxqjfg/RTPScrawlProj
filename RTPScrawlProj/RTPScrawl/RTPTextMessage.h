//
//  RTPTextMessage.h
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/21.
//  Copyright © 2019 易博. All rights reserved.
//

#import "RTPMessageContent.h"

/*!
 文本消息类
 */
@interface RTPTextMessage : RTPMessageContent

/*!
 文本消息的内容
 */
@property(nonatomic, copy) NSString *content;

/*!
 文本消息的附加信息
 */
@property(nonatomic, copy) NSString *extra;

/*!
 初始化文本消息
 
 @param content 文本消息的内容
 @return        文本消息对象
 */
+ (instancetype)messageWithContent:(NSString *)content;

@end
