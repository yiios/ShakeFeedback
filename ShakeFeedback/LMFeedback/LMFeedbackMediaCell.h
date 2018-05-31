//
//  LMFeedbackMediaCell.h
//  BHBDrawBoarder
//
//  Created by Limo on 2018/5/25.
//  Copyright © 2018年 bihongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMFeedbackMediaCell,LMFeedbackMediaModel;

@protocol LMFeedbackMediaCellProtocol

- (void)feedbackMediaCell:(LMFeedbackMediaCell *)cell clickCloseButtonMediaModel:(LMFeedbackMediaModel *)mediaModel;

- (void)feedbackMediaCell:(LMFeedbackMediaCell *)cell clickPlayButtonMediaModel:(LMFeedbackMediaModel *)mediaModel;

@end

@interface LMFeedbackMediaCell : UICollectionViewCell

@property (nonatomic, strong) LMFeedbackMediaModel *mediaModel;

@property (nonatomic, weak) id <LMFeedbackMediaCellProtocol>delegate;

@end
