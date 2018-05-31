//
//  NSLayoutConstraintOnePixelLine.m
//  MOA
//
//  Created by Limo on 2018/5/28.
//  Copyright © 2018年 moa. All rights reserved.
//

#import "NSLayoutConstraintOnePixelLine.h"

@implementation NSLayoutConstraintOnePixelLine
- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.constant == 1) {
        self.constant = 1 / [UIScreen mainScreen].scale;
    }
}

@end
