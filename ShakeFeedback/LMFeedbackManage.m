//
//  LMFeedbackManage.m
//  MOA
//
//  Created by Limo on 2018/5/29.
//  Copyright © 2018年 moa. All rights reserved.
//

#import "LMFeedbackManage.h"
#import "LMNavigationController.h"
#import "LMDrawBoarderController.h"
#import "LMFeedbackDefine.h"

@interface LMFeedbackManage()<UIAlertViewDelegate>

// 新创建的Window
@property (nonatomic, strong) UIWindow *window;
// 暂存原来的keyWindow
@property (nonatomic, strong) UIWindow *prevWindow;

@end


@implementation LMFeedbackManage

static LMFeedbackManage *_manage;


- (void)feedbackMsgStr:(NSString *)msgStr andMediaModelArr:(NSArray <LMFeedbackMediaModel *>*)mediaModelArr {
    
    
    
    [[LMFeedbackManage shareManage] dismissFeedback];
}

-(void)showFeedback{
    
    if (self.isOpenLMShakeFeedback == NO) {
        return;
    }
    
    if (_isStartFeedback == YES) {
        return;
    }
    
    UIImage *image = [self screenshot];
    
    self.prevWindow = [UIApplication sharedApplication].keyWindow;

    LMDrawBoarderController *viewControoler = [[LMDrawBoarderController alloc] init];
    viewControoler.sourceImage = image;
    LMNavigationController *nav = [[LMNavigationController alloc] initWithRootViewController:viewControoler];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nav;
    self.window.windowLevel = UIWindowLevelStatusBar + 1;
    self.window.hidden = YES;
    self.window.alpha = 1;

    [self.window makeKeyAndVisible];

    _isStartFeedback = YES;

}

- (void)dismissFeedback {
    [self.window resignKeyWindow];
//    [self.prevWindow makeKeyAndVisible];
    self.window.rootViewController = nil;
    self.window = nil;
    
    _isStartFeedback = NO;
}


- (void)tempDismissFeedback {
    self.window.hidden = YES;

    [self.window resignKeyWindow];
}

- (void)restoreShowFeedbcak {
    self.window.hidden = NO;

    [self.window makeKeyAndVisible];
}

#pragma mark - PromptView

- (void)showPromptView {
    
    if ([LMFeedbackManage shareManage].isStartFeedback == NO && [LMFeedbackManage shareManage].isOpenLMShakeFeedback == YES) {
        _isStartFeedback = YES;
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"invocationHeaderLabelText", @"LMShakeFeedback", nil) message:NSLocalizedStringFromTable(@"StartAlertTextIntro", @"LMShakeFeedback", nil) delegate:self cancelButtonTitle:@"没啥事" otherButtonTitles:@"遇到问题", @"关闭摇一摇反馈", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    _isStartFeedback = NO;

    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    
    if ([btnTitle isEqualToString:@"没啥事"]) {
        
    } else if ([btnTitle isEqualToString:@"遇到问题"]) {
        [[LMFeedbackManage shareManage] showFeedback];
    } else if ([btnTitle isEqualToString:@"关闭摇一摇反馈"]) {
        
        [LMFeedbackManage shareManage].isOpenLMShakeFeedback = NO;
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"已关闭摇一摇反馈" message:@"你可以在设置页面重新打开摇一摇反馈" delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"okButton", @"LMShakeFeedback", nil) otherButtonTitles:nil];
        [alert show];
    }
    
}


#pragma mark - ScreenShot
-(UIImage *)screenshot {
    
    UIView * view = [[UIApplication sharedApplication].windows firstObject];
    
    // view frame为empty 降级
    if (CGRectIsEmpty(view.frame)) {
        return nil;
    }
    
    
    //绘图
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    //渲染
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    //生产图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)setIsOpenLMShakeFeedback:(BOOL)isOpenLMShakeFeedback {
    
    if (_isOpenLMShakeFeedback == isOpenLMShakeFeedback) {
        return;
    }
    
    _isOpenLMShakeFeedback = isOpenLMShakeFeedback;
    
    [[NSUserDefaults standardUserDefaults] setBool:_isOpenLMShakeFeedback forKey:@"isOpenLMShakeFeedback"];
}



#pragma mark - share

+ (instancetype)shareManage {
    return [[self alloc]init];
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manage == nil) {
            _manage = [super allocWithZone:zone];
            
            
            [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"isOpenLMShakeFeedback":@YES}];

            _manage.isOpenLMShakeFeedback = [[NSUserDefaults standardUserDefaults] boolForKey:@"isOpenLMShakeFeedback"];

        }
    });
    return _manage;
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
- (id)copyWithZone:(NSZone *)zone {
    return _manage;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return _manage;
}

@end
