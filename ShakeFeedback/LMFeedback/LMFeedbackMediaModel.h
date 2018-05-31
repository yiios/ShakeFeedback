//
//  LMFeedbackMediaModel.h
//  BHBDrawBoarder
//
//  Created by Limo on 2018/5/25.
//  Copyright © 2018年 bihongbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

typedef NS_ENUM(NSInteger, LMFeedbackMediaType) {
    LMFeedbackMediaTypeUnknown = 0,
    LMFeedbackMediaTypeImage   = 1,
    LMFeedbackMediaTypeVideo   = 2,
    LMFeedbackMediaTypeAudio   = 3,
};

@interface LMFeedbackMediaModel : NSObject

@property (nonatomic, assign) LMFeedbackMediaType mediaType;

@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithImage:(UIImage *)image;

@end
