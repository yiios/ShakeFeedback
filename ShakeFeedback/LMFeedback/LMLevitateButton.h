//
//  LMLevitateButton.h
//  MOA
//
//  Created by Limo on 2018/5/28.
//  Copyright © 2018年 moa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^imageBlock)(UIImage *image);

@interface LMLevitateButton : UIButton

@property (nonatomic, copy) imageBlock imageBlock;
+ (instancetype)showLevitateButtonWithController:(UIViewController *)presentViewController;
@end
