//
//  LMMyDrawer.m
//  BHBDrawBoarder
//
//  Created by bihongbo on 16/1/4.
//  Copyright © 2016年 bihongbo. All rights reserved.
//

#import "LMMyDrawer.h"

@implementation LMPaintPath

+ (instancetype)paintPathWithLineWidth:(CGFloat)width
                            startPoint:(CGPoint)startP
{
    LMPaintPath * path = [[self alloc] init];
    path.lineWidth = width;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineCapRound; //终点处理
    [path moveToPoint:startP];
    return path;
}

@end

@interface LMMyDrawer ()

@property (nonatomic, strong)LMPaintPath * path;
@property (nonatomic, strong)CAShapeLayer * slayer;

@end

@implementation LMMyDrawer

#pragma mark -leftcycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _strokeWidth = 5;
    }
    return self;
}

// 根据touches集合获取对应的触摸点
- (CGPoint)pointWithTouches:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    
    return [touch locationInView:self];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint startP = [self pointWithTouches:touches];
    
    if ([event allTouches].count == 1) {
        
        LMPaintPath *path = [LMPaintPath paintPathWithLineWidth:_strokeWidth
                                                     startPoint:startP];
        _path = path;
        
        CAShapeLayer * slayer = [CAShapeLayer layer];
        slayer.path = path.CGPath;
        slayer.backgroundColor = [UIColor clearColor].CGColor;
        slayer.fillColor = [UIColor clearColor].CGColor;
        slayer.lineCap = kCALineCapRound;
        slayer.lineJoin = kCALineJoinRound;
        slayer.strokeColor = self.strokeColor.CGColor;
        slayer.lineWidth = path.lineWidth;
        [self.layer addSublayer:slayer];
        _slayer = slayer;
        [[self mutableArrayValueForKey:@"canceledLines"] removeAllObjects];
        [[self mutableArrayValueForKey:@"lines"] addObject:_slayer];
        
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 获取移动点
    CGPoint moveP = [self pointWithTouches:touches];
    
    if ([event allTouches].count > 1){
        
        [self.superview touchesMoved:touches withEvent:event];
        
    }else if ([event allTouches].count == 1) {
        
        [_path addLineToPoint:moveP];
        
        _slayer.path = _path.CGPath;
        
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([event allTouches].count > 1){
        [self.superview touchesMoved:touches withEvent:event];
    }
}


/**  画线 */
- (void)drawLine {

    [self.layer addSublayer:self.lines.lastObject];
    
}


/** 清屏 */
- (void)clearScreen {
    
    if (!self.lines.count) return ;
    
    [self.lines makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [[self mutableArrayValueForKey:@"lines"] removeAllObjects];
    [[self mutableArrayValueForKey:@"canceledLines"] removeAllObjects];

}

/**  撤销 */
- (void)undo {
    //当前屏幕已经清空，就不能撤销了
    if (!self.lines.count) return;
    [[self mutableArrayValueForKey:@"canceledLines"] addObject:self.lines.lastObject];
    [self.lines.lastObject removeFromSuperlayer];
    [[self mutableArrayValueForKey:@"lines"] removeLastObject];
    
}


/**  恢复 */
- (void)redo {
    //当没有做过撤销操作，就不能恢复了
    if (!self.canceledLines.count) return;
    [[self mutableArrayValueForKey:@"lines"] addObject:self.canceledLines.lastObject];
    [[self mutableArrayValueForKey:@"canceledLines"] removeLastObject];
    [self drawLine];
    
}

#pragma mark - Get

- (UIColor *)strokeColor {
    if (_strokeColor == nil) {
        _strokeColor = [UIColor blackColor];
    }
    return _strokeColor;
}

- (NSMutableArray *)lines {
    if (_lines == nil) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}


- (NSMutableArray *)canceledLines {
    if (_canceledLines == nil) {
        _canceledLines = [NSMutableArray array];
    }
    return _canceledLines;
}


@end



@implementation LMScrollView

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view {
    if ([event allTouches].count == 1) {
        return YES;
    }
    return NO;
}

@end
