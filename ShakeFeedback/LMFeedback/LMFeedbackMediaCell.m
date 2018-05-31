//
//  LMFeedbackMediaCell.m
//  BHBDrawBoarder
//
//  Created by Limo on 2018/5/25.
//  Copyright © 2018年 bihongbo. All rights reserved.
//

#import "LMFeedbackMediaCell.h"
#import "LMFeedbackMediaModel.h"
#import "LMFeedbackDefine.h"

@interface LMFeedbackMediaCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end

@implementation LMFeedbackMediaCell

- (void)setMediaModel:(LMFeedbackMediaModel *)mediaModel {
    _mediaModel = mediaModel;
    
    if (mediaModel == nil) {
        return;
    }
    
    self.imageView.image = mediaModel.image;

    if (mediaModel.mediaType == LMFeedbackMediaTypeImage) {

        [self.playButton setImage:[LMFontImageList iconWithName:@"铅笔_pencil86" fontSize:32 color:[UIColor blackColor]] forState:UIControlStateNormal];

        self.durationLabel.hidden = YES;
    } else {
        [self.playButton setImage:[LMFontImageList iconWithName:@"play" fontSize:32 color:[UIColor blackColor]] forState:UIControlStateNormal];
        self.durationLabel.hidden = NO;
    }
    
}
- (IBAction)closeButtonClick:(UIButton *)sender {
    
    if ([(NSObject *)self.delegate respondsToSelector:@selector(feedbackMediaCell:clickCloseButtonMediaModel:)]) {
        [self.delegate feedbackMediaCell:self clickCloseButtonMediaModel:self.mediaModel];
    }
    
}
- (IBAction)playButtonClick:(UIButton *)sender {
    
    if ([(NSObject *)self.delegate respondsToSelector:@selector(feedbackMediaCell:clickPlayButtonMediaModel:)]) {
        [self.delegate feedbackMediaCell:self clickPlayButtonMediaModel:self.mediaModel];
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    [self.closeButton setImage:[LMFontImageList iconWithName:@"round_close_fill" fontSize:20 color:[UIColor blackColor]] forState:UIControlStateNormal];
    

    
}

@end
