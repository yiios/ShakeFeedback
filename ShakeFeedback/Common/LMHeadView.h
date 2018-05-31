//
//  LMHeadView.h
//  BHBDrawBoarder
//
//  Created by Limo on 2018/5/22.
//  Copyright © 2018年 bihongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMTitleButton : UIButton

-(id)initWithLeftImage:(UIImage*)image;
-(id)initWithLeftTitle:(NSString*)title;
-(id)initWithRightTitle:(NSString*)title;

@property (nonatomic) CGRect titleRect;
@property (nonatomic) CGRect imageRect;
-(UIView *)addBottomView;

@end




@interface LMHeadView : UIView

- (UILabel *)addTitle:(NSString*)title;
+ (UIButton*)addLeftButtonWithImage:(UIImage*)image;
+ (UIButton*)addRightButtonWithTitle:(NSString*)string;

+ (UIButton*)addLeftButtonWithIconTitle:(NSString*)string;
+ (UIButton*)addRightButtonWithIconTitle:(NSString*)string;

@end
