//
//  RTPMessageHandle.m
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/17.
//  Copyright © 2019 易博. All rights reserved.
//

#import "RTPMessageHandle.h"

#import <RongIMKit/RongIMKit.h>


@interface RTPMessageHandle()

/**
 待发送的消息队列
 */
@property (nonatomic,strong) NSMutableArray *messageQueue;

@end

@implementation RTPMessageHandle

+ (RTPMessageHandle *)shareInstance
{
    static RTPMessageHandle *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

/**
 发送消息
 
 @param messageType 消息类型
 @param content 消息内容
 */
- (void)sendMessage:(RTPMessageType)messageType
            content:(NSString *)content {
    
    // 构建消息的内容，这里以文本消息为例。
    RCTextMessage *pathMessage = [RCTextMessage messageWithContent:content];
    
    // 调用RCIMClient的sendMessage方法进行发送，结果会通过回调进行反馈。
    [[RCIMClient sharedRCIMClient] sendMessage:ConversationType_GROUP targetId:@"2000000000001" content:pathMessage pushContent:nil pushData:nil success:^(long messageId) {
        NSLog(@"发送成功。当前消息ID：%ld", messageId);
    } error:^(RCErrorCode nErrorCode, long messageId) {
        NSLog(@"发送失败。消息ID：%ld， 错误码：%ld", messageId, (long)nErrorCode);
    }];
}

/**
 接收到消息
 
 @param messageType 消息类型
 @param content 消息内容
 */
- (void)reciveMessage:(RTPMessageType)messageType
              content:(NSString *)content {
    
}


/**
 清空消息队列
 */
- (void)cleanMessageQ {
    [self.messageQueue removeAllObjects];
}


#pragma mark -- get --
- (NSMutableArray *)messageQueue {
    if (!_messageQueue) {
        _messageQueue = [[NSMutableArray alloc]init];
    }
    return _messageQueue;
}


@end
