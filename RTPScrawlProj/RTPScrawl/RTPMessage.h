//
//  RTPMessage.h
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/21.
//  Copyright © 2019 易博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTPMessageDefine.h"
#import "RTPMessageContent.h"

@interface RTPMessage : NSObject

/*!
 消息类型
 */
@property(nonatomic, assign) RTPMessageType messageType;

/*!
 消息的内容
 */
@property(nonatomic, strong) RTPMessageContent *content;

/*!
 消息的附加字段
 */
@property(nonatomic, copy) NSString *extra;

/*!
 RTPMessage初始化方法
 
 @param  messageType    消息类型
 @param  content        消息内容
 */
- (instancetype)initWithType:(RTPMessageType)messageType
                     content:(RTPMessageContent *)content;

@end
