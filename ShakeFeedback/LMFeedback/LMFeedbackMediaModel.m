//
//  LMFeedbackMediaModel.m
//  BHBDrawBoarder
//
//  Created by Limo on 2018/5/25.
//  Copyright © 2018年 bihongbo. All rights reserved.
//

#import "LMFeedbackMediaModel.h"

@implementation LMFeedbackMediaModel

- (instancetype)initWithImage:(UIImage *)image {
    
    if ([self init]) {
        self.mediaType = LMFeedbackMediaTypeImage;
        self.image = image;
    }
    return self;
}
@end
