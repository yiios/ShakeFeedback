//
//  LMLevitateButton.m
//  MOA
//
//  Created by Limo on 2018/5/28.
//  Copyright © 2018年 moa. All rights reserved.
//

#import "LMLevitateButton.h"
#import "LMFeedbackDefine.h"

@interface LMLevitateButton()

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIViewController *presentViewController;

@end

@implementation LMLevitateButton


+ (instancetype)showLevitateButtonWithController:(UIViewController *)presentViewController {
    
    
    return [[self alloc] initLevitateButtonWithController:presentViewController];
}

- (instancetype)initLevitateButtonWithController:(UIViewController *)presentViewController {
    self = [LMLevitateButton buttonWithType:UIButtonTypeCustom];
    
    if (self) {
        self.frame = CGRectMake(self.window.frame.size.width - 72, self.window.frame.size.height - 88, 56, 56);
        self.backgroundColor = [UIColor colorWithRed:26.f/255 green:115.f/255 blue:227.f/255 alpha:1.f];
        [self setImage:[LMFontImageList iconWithName:@"camera_fill" fontSize:36 color:[UIColor whiteColor]] forState:UIControlStateNormal];
        self.layer.opaque = NO;
        self.layer.allowsGroupOpacity = YES;
        self.layer.cornerRadius = self.bounds.size.height/2.f;
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.75;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        [self.window addSubview:self];
        [self addTarget:self action:@selector(levitateButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.presentViewController = presentViewController;
    }
    
    return self;
}


- (void)levitateButtonClick {
    [self removeFromSuperview];
    
    UIImage *screenshot = [self screenshot];
    
    [[LMFeedbackManage shareManage] restoreShowFeedbcak];
    if (self.imageBlock) {
        self.imageBlock(screenshot);
    }

}

-(UIImage *)screenshot{
    
    UIView * view = self.window;
    
    // view frame为empty 降级
    if (CGRectIsEmpty(view.frame)) {
        return nil;
    }
    
    //绘图
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    //渲染
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    //生产图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



-(UIWindow *)window {
    if (!_window) {
        id <UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
        if ([delegate respondsToSelector:@selector(window)]) {
            _window = [delegate performSelector:@selector(window)];
        } else {
            _window = [[UIApplication sharedApplication] keyWindow];
        }
    }
    return _window;
}


@end
