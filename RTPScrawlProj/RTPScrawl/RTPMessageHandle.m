//
//  RTPMessageHandle.m
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/17.
//  Copyright © 2019 易博. All rights reserved.
//

#import "RTPMessageHandle.h"

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

- (void)addScrawlToMessageQ:(NSDictionary *)message {
    
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
