//
//  LMMyDrawer.h
//  BHBDrawBoarder
//
//  Created by bihongbo on 16/1/4.
//  Copyright © 2016年 bihongbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMPaintPath : UIBezierPath

+ (instancetype)paintPathWithLineWidth:(CGFloat)width
                            startPoint:(CGPoint)startP;

@end


@interface LMMyDrawer : UIView

/**
 *  撤销的线条数组
 */
@property (nonatomic, strong) NSMutableArray * canceledLines;
/**
 *  线条数组
 */
@property (nonatomic, strong) NSMutableArray * lines;


/**
 设置画笔颜色 、 默认黑色

 @param color 画笔颜色Color
 */
@property (nonatomic, strong) UIColor *strokeColor;


/**
 设置画笔宽度 、 默认5pt
 */
@property (nonatomic, assign) CGFloat strokeWidth;

/**
 *  清屏
 */
- (void)clearScreen;

/**
 *  撤销
 */
- (void)undo;

/**
 *  恢复
 */
- (void)redo;

@end


@interface LMScrollView : UIScrollView

@end

