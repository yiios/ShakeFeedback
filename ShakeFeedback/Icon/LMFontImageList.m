//
//  LMFontImageList.m
//  MOA
//
//  Created by Limo on 2018/5/29.
//  Copyright © 2018年 moa. All rights reserved.
//

#import "LMFontImageList.h"

@implementation LMFontImageList
+ (NSDictionary*)IconDictionary
{
    return @{
             @"check":@"\U0000e645", // 对号
             @"close":@"\U0000e646", // 错号
             @"round_check":@"\U0000e657", // 圆圈中的对号
             @"round_close_fill":@"\U0000e658", // 圆圈中的错号
             @"camera_fill":@"\U0000e664", // 照相机
             @"comment_fill":@"\U0000e666", // 信息
             @"voice_fill":@"\U0000e6f0", // 录音话筒
             @"pic_fill":@"\U0000e72c", // 照片
             @"community_fill":@"\U0000e740", // 对话
             @"play_fill":@"\U0000e74f", // 播放
             @"all":@"\U0000e755", // 音频
             @"shake":@"\U0000e765", // 摇手机
             @"emoji_light":@"\U0000e7a1", // 笑脸
             @"record_fill":@"\U0000e7a4", // 摄像机
             @"铅笔_pencil86":@"\U0000e96d", // 铅笔
             @"橡皮擦":@"\U0000e6b8", // 橡皮
             @"back_android_light":@"\U0000e7ed", // 右箭头
             };
}

//单独定义一个字体文件，方便管理多个字体库
+ (NSString*)fontName
{
    return @"iconfont";
}

@end
