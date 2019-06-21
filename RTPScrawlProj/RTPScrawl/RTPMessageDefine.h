//
//  RTPMessageDefine.h
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/21.
//  Copyright © 2019 易博. All rights reserved.
//

#ifndef RTPMessageDefine_h
#define RTPMessageDefine_h

/*!
 涂鸦消息类型
 */
typedef NS_ENUM(NSUInteger, RTPMessageType) {
    
    /*!
     轨迹类型
     */
    RTPMessageType_PATH = 1,
    
    /*!
     图片类型
     */
    RTPMessageType_PIC = 2,
    
    /*!
     表情类型
     */
    RTPMessageType_EMOJI = 3,
    
    /*!
     语音类型
     */
    RTPMessageType_VOICE = 4,
    
    /*!
     文本类型
     */
    RTPMessageType_TEXT = 5,
    
    /*!
     无效类型
     */
    RTPMessageType_UNKNOW
    
};

#endif /* RTPMessageDefine_h */
