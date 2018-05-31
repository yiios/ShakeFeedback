//
//  LMDrawBoarderController.h
//  LMDrawBoarder
//
//  Created by bihongbo on 16/1/4.
//  Copyright © 2016年 bihongbo. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LMFeedbackController;
typedef void(^imageBlock)(UIImage *image);

@interface LMDrawBoarderController : UIViewController

@property (nonatomic, copy) imageBlock imageBlock;

@property (nonatomic, strong) UIImage *sourceImage;

@end
