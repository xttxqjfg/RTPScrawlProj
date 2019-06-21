//
//  RTPMessageHandle.h
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/17.
//  Copyright © 2019 易博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTPMessageDefine.h"
#import "RTPMessageContent.h"
#import "RTPMessage.h"

@interface RTPMessageHandle : NSObject

/**
 消息处理单例

 @return 单例类型
 */
+ (RTPMessageHandle *) shareInstance;


/**
 发送消息

 @param messageType 消息类型
 @param content 消息内容
 */
- (void)sendMessage:(RTPMessageType)messageType
                   content:(RTPMessageContent *)content;

/**
 接收到消息

 @param messageType 消息类型
 @param content 消息内容
 */
- (void)reciveMessage:(RTPMessageType)messageType
            content:(RTPMessageContent *)content;

@end
