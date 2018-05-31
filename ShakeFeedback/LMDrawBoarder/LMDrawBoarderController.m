//
//  LMDrawBoarderController.m
//  BHBDrawBoarder
//
//  Created by bihongbo on 16/1/4.
//  Copyright © 2016年 bihongbo. All rights reserved.
//
// 屏幕尺寸

#import "LMDrawBoarderController.h"
#import "LMMyDrawer.h"
#import "LMHeadView.h"
#import "LMFeedbackController.h"
#import "LMFeedbackDefine.h"

@interface LMDrawBoarderController ()

@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSArray * linesInfo;
@property (nonatomic, strong) NSArray * canceledLinesInfo;

/** 工具条的view */
@property (nonatomic, strong) UIView *toolView;
/** 画板view */
@property (nonatomic, strong) LMScrollView *boardView;

/** 工具条按钮数组 */
@property (nonatomic, strong) NSMutableArray   *toolButtonArr;
/** 按钮背景颜色 */
@property (nonatomic, strong) NSArray   *btnBackgroundColors;

@property (nonatomic, strong) LMMyDrawer *myDrawer;

@property (nonatomic, strong) UIButton * delAllBtn;//删除
@property (nonatomic, strong) UIButton * fwBtn;//上一步
@property (nonatomic, strong) UIButton * ntBtn;//下一步

@property (nonatomic, strong) LMHeadView *headView;
@property (nonatomic, strong) UIButton *cancelButton;// 取消按钮
@property (nonatomic, strong) UIButton *endEditingButton;// 完成画板按钮

@end


@implementation LMDrawBoarderController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 顶部导航条
    [self loadHeadView];
    // 底部工具条
    [self loadBottomToolsView];
    // 画板View
    [self loadDrawView];
}

- (void)dealloc {
    [self.myDrawer removeObserver:self forKeyPath:@"canceledLines"];
    [self.myDrawer removeObserver:self forKeyPath:@"lines"];
}

// 加载顶部View
- (void)loadHeadView {
    
    self.headView = [[LMHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.f+STATUSBAR_SHIFT)];
    [self.headView addTitle:NSLocalizedStringFromTable(@"bugHeader", @"LMShakeFeedback", nil)];
    [self.view addSubview:self.headView];
    
    self.cancelButton = [LMHeadView addLeftButtonWithImage:[LMFontImageList iconWithName:@"close" fontSize:24 color:[UIColor colorWithRed:235.f/255 green:90.f/255 blue:57.f/255 alpha:1.0]]];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.cancelButton];
    
    self.endEditingButton = [LMHeadView addRightButtonWithTitle:self.imageBlock?NSLocalizedStringFromTable(@"okButton", @"LMShakeFeedback", nil):NSLocalizedStringFromTable(@"nextAccessbilityButton", @"LMShakeFeedback", nil)];
    [self.endEditingButton addTarget:self action:@selector(endEditingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.endEditingButton];
    
}

- (void)loadBottomToolsView {
    
    // 底部工具条
    self.toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-BOTTOM_SHIFT-55.f, self.view.frame.size.width, 55.f)];
    self.toolView.backgroundColor = [UIColor colorWithRed:245.f/255 green:244.f/255 blue:245.f/255 alpha:1];
    [self.view addSubview:self.toolView];
    
    // 底部按钮
    CGFloat btnW = self.toolView.bounds.size.width/8.f;
    
    for (int i = 0; i<8; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*btnW+((btnW-25)/2), 15, 25, 25);
        
        UIColor * btnBackgroundColor = self.btnBackgroundColors[i];
        [btn setBackgroundColor:btnBackgroundColor];
        
        btn.layer.cornerRadius = 12.5f;
        btn.layer.masksToBounds = YES;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self.toolView addSubview:btn];
        
        if (i != 7) {
            [self.toolButtonArr addObject:btn];
            UIImage * imgDis = [LMFontImageList iconWithName:@"round_check" fontSize:25 color:[UIColor whiteColor]];
            [btn setImage:imgDis forState:UIControlStateSelected];
            
            if (i == 0) {
                [self btnClick:btn];
            }
            
        } else {
            [btn setImage:[LMFontImageList iconWithName:@"橡皮擦" fontSize:30	 color:[UIColor blackColor]] forState:UIControlStateNormal];
        }
    }

}


- (void)loadDrawView {
    
    [self.myDrawer addObserver:self forKeyPath:@"lines" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.myDrawer addObserver:self forKeyPath:@"canceledLines" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    //画板view
    CGSize macBoardVSize = CGSizeMake(self.view.bounds.size.width - 30.f, self.view.bounds.size.height - self.toolView.frame.size.height - CGRectGetMaxY(self.headView.frame) - 20.f);
    CGRect boardvRect = [self calculateScaleImage:self.sourceImage ToSize:macBoardVSize];
    
    boardvRect = CGRectMake(boardvRect.origin.x + 15.f, boardvRect.origin.y + CGRectGetMaxY(self.headView.frame) + 10.f, boardvRect.size.width, boardvRect.size.height);
    
    self.boardView = [[LMScrollView alloc] initWithFrame:boardvRect];
    
    [self.boardView addSubview:self.myDrawer];
    self.myDrawer.frame = self.boardView.bounds;
    self.myDrawer.layer.contents = (id)self.sourceImage.CGImage;
    [self.boardView setContentSize:self.myDrawer.frame.size];
    
    // 圆角边框
    self.boardView.layer.cornerRadius = 8;
    self.boardView.layer.masksToBounds = YES;
    self.boardView.layer.borderWidth = 1;
    self.boardView.layer.borderColor = [UIColor colorWithRed:0.f/255 green:101.f/255 blue:255.f/255 alpha:1].CGColor;
    
    [self.boardView setUserInteractionEnabled:YES];
    [self.boardView setScrollEnabled:YES];
    [self.boardView setMultipleTouchEnabled:YES];
    [self.boardView setDelaysContentTouches:NO];
    [self.boardView setCanCancelContentTouches:NO];
    [self.view insertSubview:self.boardView belowSubview:self.toolView];

}


- (void)cancelButtonClick {
    // 关闭按钮
    
    if (self.imageBlock) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [[LMFeedbackManage shareManage] dismissFeedback];
    }
    
}

- (void)endEditingButtonClick {
    
    // 完成编辑
    UIImage *screenshotImage = [self screenshot];

    if (self.imageBlock) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            self.imageBlock(screenshotImage);
        }];

    } else {
        LMFeedbackController *feedbackController = [[LMFeedbackController alloc] initWithImage:screenshotImage];

        [self.navigationController pushViewController:feedbackController animated:YES];
    }
}


- (void)btnClick:(UIButton *)sender {
    
    if ([self.toolButtonArr containsObject:sender] == NO) {
        // 清理画板
        [self.myDrawer clearScreen];
    } else {
        sender.selected = YES;
        self.myDrawer.strokeColor = sender.backgroundColor;
        for (UIButton *btn in self.toolButtonArr) {
            if (sender != btn) {
                btn.selected = NO;
            }
        }
    }
    
//撤销
//    [self.myDrawer undo];
//重做
//    [self.myDrawer redo];
}



- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    if([keyPath isEqualToString:@"lines"]){
        NSMutableArray * lines = [_myDrawer mutableArrayValueForKey:@"lines"];
        if (lines.count) {
            [self.delAllBtn setEnabled:YES];
            [self.fwBtn setEnabled:YES];
            
        }else{
            [self.delAllBtn setEnabled:NO];
            [self.fwBtn setEnabled:NO];
        }
    }else if([keyPath isEqualToString:@"canceledLines"]){
        NSMutableArray * canceledLines = [_myDrawer mutableArrayValueForKey:@"canceledLines"];
        if (canceledLines.count) {
            [self.ntBtn setEnabled:YES];
        }else{
            [self.ntBtn setEnabled:NO];
            
        }
    }
}


// 计算等比例缩放
- (CGRect)calculateScaleImage:(UIImage *)sourceImage ToSize:(CGSize)size {
    
    CGFloat width = CGImageGetWidth(sourceImage.CGImage);
    CGFloat height = CGImageGetHeight(sourceImage.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1) {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    } else {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height - height)/2;
    
    // 返回新的改变大小后的图片
    return CGRectMake(xPos, yPos, width, height);
}


-(UIImage *)screenshot{
    
    UIView * view = self.myDrawer;
    
    // view frame为empty 降级
    if (CGRectIsEmpty(view.frame)) {
        return nil;
    }
    
    //绘图
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    //渲染
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    //生产图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Get&Set
- (LMMyDrawer *)myDrawer {
    if (_myDrawer == nil) {
        _myDrawer = [[LMMyDrawer alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width*5, SCREEN_SIZE.height*2)];
        _myDrawer.layer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return _myDrawer;
}


- (NSArray *)btnBackgroundColors {
    if (_btnBackgroundColors == nil) {
        _btnBackgroundColors = @[
                                 [UIColor colorWithRed:218.f/255 green:87.f/255 blue:78.f/255 alpha:1],
                                 [UIColor colorWithRed:236.f/255 green:193.f/255 blue:77.f/255 alpha:1],
                                 [UIColor colorWithRed:220.f/255 green:110.f/255 blue:62.f/255 alpha:1],
                                 [UIColor colorWithRed:235.f/255 green:101.f/255 blue:160.f/255 alpha:1],
                                 [UIColor colorWithRed:55.f/255 green:169.f/255 blue:70.f/255 alpha:1],
                                 [UIColor colorWithRed:44.f/255 green:129.f/255 blue:202.f/255 alpha:1],
                                 [UIColor colorWithRed:35.f/255 green:46.f/255 blue:59.f/255 alpha:1],
                                 [UIColor clearColor]
                                 ];
    }
    return _btnBackgroundColors;
}


- (NSMutableArray *)toolButtonArr {
    if (_toolButtonArr == nil) {
        _toolButtonArr = [NSMutableArray array];
    }
    return _toolButtonArr;
}


@end
