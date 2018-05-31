//
//  LMFeedbackDefine.h
//  MOA
//
//  Created by Limo on 2018/5/29.
//  Copyright © 2018年 moa. All rights reserved.
//

#ifndef LMFeedbackDefine_h
#define LMFeedbackDefine_h

#define IS_IPHONEX      (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)?(SCREEN_WIDTH == 812.f && SCREEN_HEIGHT == 375.f) : (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f))

#define STATUSBAR_SHIFT     (IS_IPHONEX ? (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? 20 : 44) : 20)
#define BOTTOM_SHIFT        (IS_IPHONEX ? (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? 21 : 34 ) : 0)
#define LEFT_RIGHT_SHIEF    (IS_IPHONEX ? (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) ? 44 : 0 ) : 0)

#define SCREEN_FIXED_WIDTH  (((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))?[UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.width)

#define SCREEN_SIZE         ([UIScreen mainScreen].bounds.size)
#define SCREEN_WIDTH        ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SCALE        ([UIScreen mainScreen].scale)
#define UNIT_PIXEL (1/SCREEN_SCALE)

#define HEAD_TITLE_WIDTH (SCREEN_FIXED_WIDTH-160)

#define kHeadButtonFontSize 17

#import "LMFeedbackManage.h"
#import "LMFontImageList.h"
#import "LMFeedbackMediaModel.h"

#endif /* LMFeedbackDefine_h */
