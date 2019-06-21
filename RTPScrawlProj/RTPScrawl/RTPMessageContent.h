//
//  RTPMessageContent.h
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/21.
//  Copyright © 2019 易博. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RTPMessageCoding <NSObject>
@required

/*!
 将消息内容序列化，编码成为可传输的json数据
 
 @discussion
 消息内容通过此方法，将消息中的所有数据，编码成为json数据，返回的json数据将用于网络传输。
 */
- (NSData *)encode;

/*!
 将json数据的内容反序列化，解码生成可用的消息内容
 
 @param data    消息中的原始json数据
 
 @discussion
 网络传输的json数据，会通过此方法解码，获取消息内容中的所有数据，生成有效的消息内容。
 */
- (void)decodeWithData:(NSData *)data;

@end

@interface RTPMessageContent : NSObject <RTPMessageCoding>

/*!
 消息中携带的发送者的用户id
 */
@property(nonatomic, copy) NSString *senderUserId;

@end
