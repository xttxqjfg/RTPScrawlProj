//
//  RTPPathMessage.m
//  RTPScrawlProj
//
//  Created by 易博 on 2019/6/21.
//  Copyright © 2019 易博. All rights reserved.
//

#import "RTPPathMessage.h"

/*!
 涂鸦轨迹消息类
 */
@interface RTPPathMessage()

/*!
 涂鸦轨迹消息轨迹数组
 */
@property (nonatomic, strong) NSArray *pathArr;

@end

@implementation RTPPathMessage

- (NSString *)messageWithContent:(NSArray *)pathArr  size:(CGSize)layerSize {
    NSString *jsonStr = @"";
    
    NSMutableDictionary *pathMessageDic = [[NSMutableDictionary alloc]init];
    [pathMessageDic setObject:RTPPathMessageTypeIdentifier forKey:@"message_type"];
    [pathMessageDic setObject:pathArr forKey:@"message_content"];
    [pathMessageDic setObject:@{@"width":[NSString stringWithFormat:@"%f",layerSize.width],@"height":[NSString stringWithFormat:@"%f",layerSize.height]} forKey:@"layer_size"];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[pathMessageDic copy]
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (jsonData) {
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    else {
        NSLog(@"Got an error: %@", error);
    }
    
    return jsonStr;
}

@end
