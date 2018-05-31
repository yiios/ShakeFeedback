//
//  LMFeedbackManage.h
//  MOA
//
//  Created by Limo on 2018/5/29.
//  Copyright © 2018年 moa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LMFeedbackMediaModel;

@interface LMFeedbackManage : NSObject


/** 是否正在反馈信息 */
@property (nonatomic, assign, readonly) BOOL isStartFeedback;

// 摇一摇反馈是否开启
@property (nonatomic, assign) BOOL isOpenLMShakeFeedback;

// 显示与隐藏
- (void)showFeedback;
- (void)dismissFeedback;

// 暂时隐藏与恢复显示
- (void)tempDismissFeedback;
- (void)restoreShowFeedbcak;

- (void)feedbackMsgStr:(NSString *)msgStr andMediaModelArr:(NSArray <LMFeedbackMediaModel *>*)mediaModelArr;

/**
 获取单例信息

 @return 单例
 */
+ (instancetype)shareManage;

@end
