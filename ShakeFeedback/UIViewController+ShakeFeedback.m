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
    
    [[LMFeedbackManage shareManage] showPromptView];
    
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
    
}

-(void)shake {
    SystemSoundID sound = kSystemSoundID_Vibrate; //震动
    AudioServicesPlaySystemSound(sound);
}

@end
