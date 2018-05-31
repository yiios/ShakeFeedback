//
//  UIViewController+ShakeFeedback.m
//  MOA
//
//  Created by Limo on 2018/5/22.
//  Copyright © 2018年 moa. All rights reserved.
//

#import "UIViewController+ShakeFeedback.h"
#import "LMDrawBoarderController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "LMFeedbackManage.h"
#import <objc/runtime.h>

@implementation UIViewController (ShakeFeedback)


#pragma mark - ShakeToEdit
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //手机震动
//    dispatch_queue_t queue = dispatch_queue_create("shake", NULL);
//    dispatch_async(queue, ^{
//        [self shake];
//    });
    
}

-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"cancel");
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if ([LMFeedbackManage shareManage].isStartFeedback == NO && [LMFeedbackManage shareManage].isOpenLMShakeFeedback == YES) {
        [self showPromptView];
    }
}

-(void)shake {
    SystemSoundID sound = kSystemSoundID_Vibrate; //震动
    AudioServicesPlaySystemSound(sound);
}



- (void)showPromptView {
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"invocationHeaderLabelText", @"LMShakeFeedback", nil) message:NSLocalizedStringFromTable(@"StartAlertTextIntro", @"LMShakeFeedback", nil) delegate:self cancelButtonTitle:@"没啥事" otherButtonTitles:@"遇到问题", @"关闭摇一摇反馈", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
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


#pragma mark - Method Swizzling

- (void)swizzled_viewDidLoad {
    
    [self swizzled_viewDidLoad];
    
    [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:YES];
    
}

- (void)swizzled_viewWillAppear:(BOOL)animated {
    
    [self swizzled_viewWillAppear:animated];

    [self becomeFirstResponder];

}


-(void)swizzled_viewWillDisappear:(BOOL)animated {
    
    [self swizzled_viewWillDisappear:animated];

    [self resignFirstResponder];
    
}


+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        Class class = [super class];
        
        // viewDidLoad swizzled
        {
            SEL originalViewDidLoadSelector = @selector(viewDidLoad);
            SEL swizzledViewDidLoadSelector = @selector(swizzled_viewDidLoad);
            
            Method originalViewDidLoadMethod = class_getInstanceMethod(class, originalViewDidLoadSelector);
            Method swizzledViewDidLoadMethod = class_getInstanceMethod(class, swizzledViewDidLoadSelector);
            
            BOOL didAddViewDidLoadMethod =
            class_addMethod(class,
                            originalViewDidLoadSelector,
                            method_getImplementation(swizzledViewDidLoadMethod),
                            method_getTypeEncoding(swizzledViewDidLoadMethod));
            
            if (didAddViewDidLoadMethod) {
                class_replaceMethod(class,
                                    swizzledViewDidLoadSelector,
                                    method_getImplementation(originalViewDidLoadMethod),
                                    method_getTypeEncoding(originalViewDidLoadMethod));
            } else {
                method_exchangeImplementations(originalViewDidLoadMethod, swizzledViewDidLoadMethod);
            }
        }
        
        // viewWillAppear swizzled
        {
            SEL originalViewWillAppearSelector = @selector(viewWillAppear:);
            SEL swizzledViewWillAppearSelector = @selector(swizzled_viewWillAppear:);
            
            Method originalViewWillAppearMethod = class_getInstanceMethod(class, originalViewWillAppearSelector);
            Method swizzledViewWillAppearMethod = class_getInstanceMethod(class, swizzledViewWillAppearSelector);
            
            BOOL didAddViewWillAppearMethod =
            class_addMethod(class,
                            originalViewWillAppearSelector,
                            method_getImplementation(swizzledViewWillAppearMethod),
                            method_getTypeEncoding(swizzledViewWillAppearMethod));
            
            if (didAddViewWillAppearMethod) {
                class_replaceMethod(class,
                                    swizzledViewWillAppearSelector,
                                    method_getImplementation(originalViewWillAppearMethod),
                                    method_getTypeEncoding(originalViewWillAppearMethod));
            } else {
                method_exchangeImplementations(originalViewWillAppearMethod, swizzledViewWillAppearMethod);
            }
        }

        // viewWillDisappear swizzled
        {
            SEL originalViewWillDisappearSelector = @selector(viewWillDisappear:);
            SEL swizzledViewWillDisappearSelector = @selector(swizzled_viewWillDisappear:);
            
            Method originalViewWillDisappearMethod = class_getInstanceMethod(class, originalViewWillDisappearSelector);
            Method swizzledViewWillDisappearMethod = class_getInstanceMethod(class, swizzledViewWillDisappearSelector);
            
            BOOL didAddViewWillDisappearMethod =
            class_addMethod(class,
                            originalViewWillDisappearSelector,
                            method_getImplementation(swizzledViewWillDisappearMethod),
                            method_getTypeEncoding(swizzledViewWillDisappearMethod));
            
            if (didAddViewWillDisappearMethod) {
                class_replaceMethod(class,
                                    swizzledViewWillDisappearSelector,
                                    method_getImplementation(originalViewWillDisappearMethod),
                                    method_getTypeEncoding(originalViewWillDisappearMethod));
            } else {
                method_exchangeImplementations(originalViewWillDisappearMethod, swizzledViewWillDisappearMethod);
            }
        }

    });
}


@end
