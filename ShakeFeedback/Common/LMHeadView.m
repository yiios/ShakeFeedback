//
//  LMHeadView.m
//  BHBDrawBoarder
//
//  Created by Limo on 2018/5/22.
//  Copyright © 2018年 bihongbo. All rights reserved.
//

#import "LMHeadView.h"
#import "LMFeedbackDefine.h"

@implementation LMTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleRect = CGRectZero;
        _imageRect = CGRectZero;
        // Initialization code
    }
    return self;
}
-(id)initWithLeftTitle:(NSString*)title
{
    self = [self initWithFrame:CGRectMake(LEFT_RIGHT_SHIEF, STATUSBAR_SHIFT, 80, 44)];
    if (self) {
        
        self.titleRect = CGRectMake(15, 0, 65, 44);
    }
    return self;
}
-(id)initWithLeftImage:(UIImage*)image
{
    self = [self initWithFrame:CGRectMake(LEFT_RIGHT_SHIEF, STATUSBAR_SHIFT, 54, 44)];
    if (self) {
        [self setImage:image forState:UIControlStateNormal];
        self.imageRect = CGRectMake(15, (44-image.size.height)/2, image.size.width, image.size.height);
        self.titleRect = CGRectMake(15, 0, 65, 44);
    }
    return self;
}
-(id)initWithRightTitle:(NSString*)title
{
    CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:kHeadButtonFontSize]];
    CGFloat buttonWidth = MIN(90, size.width+30);
    
    self = [self initWithFrame:CGRectMake(SCREEN_FIXED_WIDTH-buttonWidth - LEFT_RIGHT_SHIEF, STATUSBAR_SHIFT, buttonWidth, 44)];
    if (self) {
        self.titleRect = CGRectMake(0, 0, buttonWidth, 44);
    }
    return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return contentRect;
    }
    return self.titleRect;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return contentRect;
    }
    return self.imageRect;
}

- (void)setTitleRect:(CGRect)titleRect
{
    _titleRect = titleRect;
    [self setNeedsDisplay];
}

- (void)setImageRect:(CGRect)imageRect
{
    _imageRect = imageRect;
    [self setNeedsDisplay];
}

-(UIView *)addBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, BOTTOM_SHIFT)];
    bottomView.backgroundColor = self.backgroundColor;
    [self addSubview:bottomView];
    return bottomView;
}

@end

@interface LMHeadView()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation LMHeadView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_FIXED_WIDTH, 44+STATUSBAR_SHIFT)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:249.f/255 green:249.f/255 blue:249.f/255 alpha:1.0];
        [self addSeparetorLine];
        self.clipsToBounds = NO;
        
    }
    return self;
}

//底部添加分割线
- (void)addSeparetorLine
{
    if (self.lineLabel) {
        [self.lineLabel removeFromSuperview];
        self.lineLabel = nil;
    }
    self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-UNIT_PIXEL, SCREEN_FIXED_WIDTH, UNIT_PIXEL)];
    self.lineLabel.backgroundColor = [UIColor colorWithRed:228.f/255 green:228.f/255 blue:228.f/255 alpha:1.0];
    [self addSubview:self.lineLabel];
    
}

- (UILabel *)addTitle:(NSString*)title
{
    if (self.titleLabel) {
        self.titleLabel.text = title;
        return self.titleLabel;
    }
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0+STATUSBAR_SHIFT, HEAD_TITLE_WIDTH, 44)];
    self.titleLabel.text = title;
    self.titleLabel.textColor = [UIColor colorWithRed:51.f/255 green:51.f/255 blue:51.f/255 alpha:1.0];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLabel];
    return self.titleLabel;
}

+ (UIButton*)addLeftButtonWithImage:(UIImage*)image
{
    LMTitleButton *btn = [[LMTitleButton alloc] initWithLeftImage:image];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitleColor:[UIColor colorWithRed:235.f/255 green:90.f/255 blue:57.f/255 alpha:1.0] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:235.f/255 green:90.f/255 blue:57.f/255 alpha:0.4] forState:UIControlStateDisabled];
    btn.backgroundColor = [UIColor clearColor];
    return btn;
}

+ (UIButton*)addLeftButtonWithIconTitle:(NSString*)string
{
    LMTitleButton *btn = [[LMTitleButton alloc] initWithLeftTitle:string];

    [btn setTitle:string forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:kHeadButtonFontSize];
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitleColor:[UIColor colorWithRed:235.f/255 green:90.f/255 blue:57.f/255 alpha:1.0] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:235.f/255 green:90.f/255 blue:57.f/255 alpha:0.4] forState:UIControlStateDisabled];
    btn.backgroundColor = [UIColor clearColor];
    return btn;
}


+ (UIButton*)addRightButtonWithIconTitle:(NSString*)string
{
    LMTitleButton *btn = [[LMTitleButton alloc] initWithRightTitle:string];
    
    [btn setTitle:string forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:kHeadButtonFontSize];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor colorWithRed:235.f/255 green:90.f/255 blue:57.f/255 alpha:1.0] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:235.f/255 green:90.f/255 blue:57.f/255 alpha:0.4] forState:UIControlStateDisabled];
    btn.backgroundColor = [UIColor clearColor];

    return btn;
}

+ (UIButton*)addRightButtonWithTitle:(NSString*)string andFontSize:(CGFloat)fontsize
{
    LMTitleButton *btn = [[LMTitleButton alloc] initWithRightTitle:string];
    
    [btn setTitle:string forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontsize];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor colorWithRed:235.f/255 green:90.f/255 blue:57.f/255 alpha:1.0] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:235.f/255 green:90.f/255 blue:57.f/255 alpha:0.4] forState:UIControlStateDisabled];
    btn.backgroundColor = [UIColor clearColor];
    
    return btn;
}
+ (UIButton*)addRightButtonWithTitle:(NSString*)string
{
    return [LMHeadView addRightButtonWithTitle:string andFontSize:kHeadButtonFontSize];
}
@end
