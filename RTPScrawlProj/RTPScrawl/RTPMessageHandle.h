//
//  RTPMessageHandle.h
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/17.
//  Copyright © 2019 易博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTPMessageHandle : NSObject

/**
 消息处理单例

 @return 单例类型
 */
+ (RTPMessageHandle *) shareInstance;


- (void)addScrawlToMessageQ:(NSDictionary *)message;


/**
 清空消息队列
 */
- (void)cleanMessageQ;

@end
