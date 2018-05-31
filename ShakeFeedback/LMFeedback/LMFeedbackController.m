//
//  LMFeedbackController.m
//  BHBDrawBoarder
//
//  Created by Limo on 2018/5/24.
//  Copyright © 2018年 bihongbo. All rights reserved.
//

#import "LMFeedbackController.h"
#import "LMFeedbackMediaCell.h"
#import "LMFeedbackMediaModel.h"
#import "LMHeadView.h"
//#import "MPPPickerPhotoActionHelper.h"
#import "FSTextView.h"
#import "LMDrawBoarderController.h"
#import "LMLevitateButton.h"
#import "LMFeedbackDefine.h"

//@interface LMFeedbackController ()<LMFeedbackMediaCellProtocol,MPPPickerPhotoActionHelperDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate>
@interface LMFeedbackController ()<LMFeedbackMediaCellProtocol,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *headSubView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headSubViewHeight;

@property (nonatomic, strong) LMHeadView *headView;
@property (nonatomic, strong) UIButton *cancelButton;// 取消按钮
@property (nonatomic, strong) UIButton *endEditingButton;// 完成画板按钮

@property (weak, nonatomic) IBOutlet FSTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeight;


@property (weak, nonatomic) IBOutlet UIButton *screenshotButton;
@property (weak, nonatomic) IBOutlet UIButton *pickPhotoButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;

@property (nonatomic, strong) NSMutableArray <LMFeedbackMediaModel *>*arrDataSources;

//@property (nonatomic, strong) MPPPickerPhotoActionHelper *pickPhotoActionHelper;

@property (nonatomic, assign) BOOL isLoadController;

@end

@implementation LMFeedbackController

#pragma mark - Leftcycle

- (instancetype)initWithImage:(UIImage *)image {
    
    LMFeedbackController *feedbackController = [[UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    [feedbackController.arrDataSources addObject:[[LMFeedbackMediaModel alloc] initWithImage:image]];
    
    return feedbackController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadHeadView];
    
    [self initCollectionView];

    [self loadPickPhotoAction];

    
    [self.screenshotButton setImage:[LMFontImageList iconWithName:@"camera_fill" fontSize:24 color:[UIColor darkGrayColor]] forState:UIControlStateNormal];
    
    [self.pickPhotoButton setImage:[LMFontImageList iconWithName:@"pic_fill" fontSize:24 color:[UIColor darkGrayColor]] forState:UIControlStateNormal];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.isLoadController == NO) {
        [self setContainerView];
    }

    self.isLoadController = YES;
}

- (void)viewSafeAreaInsetsDidChange {
    
    [super viewSafeAreaInsetsDidChange];
    if (@available(iOS 11.0, *)) {
        self.headSubViewHeight.constant = self.view.safeAreaInsets.top + 44;
    }
}

// 加载顶部View
- (void)loadHeadView {
//    self.headSubViewHeight.constant = 44.f+STATUSBAR_SHIFT;
    
    self.headView = [[LMHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44.f+STATUSBAR_SHIFT)];
    [self.headView addTitle:NSLocalizedStringFromTable(@"bugHeader", @"LMShakeFeedback", nil)];
    [self.headSubView addSubview:self.headView];
    
    self.cancelButton = [LMHeadView addLeftButtonWithImage:[LMFontImageList iconWithName:@"close" fontSize:24 color:[UIColor colorWithRed:235.f/255 green:90.f/255 blue:57.f/255 alpha:1.0]]];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.cancelButton];
    
    self.endEditingButton = [LMHeadView addRightButtonWithTitle:NSLocalizedStringFromTable(@"sendAccessbilityButton", @"LMShakeFeedback", nil)];
    [self.endEditingButton addTarget:self action:@selector(endEditingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.endEditingButton];
    
}

- (void)setContainerView {
    
    self.bottomViewHeight.constant = 44.f + BOTTOM_SHIFT;
    
//    self.textViewHeight.constant = self.containerScrollView.height - 120.f;
//    self.containerViewHeight.constant = self.containerScrollView.height;
    
    self.textView.placeholder = NSLocalizedStringFromTable(@"bugCommentPlaceholder", @"LMShakeFeedback", nil);
}


- (void)initCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(58.f, 75.f);
    layout.minimumInteritemSpacing = 8.f;
    layout.minimumLineSpacing = 1.5;
    layout.sectionInset = UIEdgeInsetsMake(20.f, 12.f, 15.f, 12.f);
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView reloadData];
}


- (void)loadPickPhotoAction {
    
//    self.pickPhotoActionHelper = [[MPPPickerPhotoActionHelper alloc] init];
//    self.pickPhotoActionHelper.pickerPhotoDelegate = self;
//    self.pickPhotoActionHelper.responder = self;
//    self.pickPhotoActionHelper.useType = ImageSelect;
}

#pragma makr - Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrDataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LMFeedbackMediaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LMFeedbackMediaCell" forIndexPath:indexPath];
    
    if (self.arrDataSources.count > indexPath.row) {
        cell.mediaModel = self.arrDataSources[indexPath.row];
        cell.delegate = self;
    }
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [[self getPas] previewSelectedPhotos:self.lastSelectPhotos assets:self.lastSelectAssets index:indexPath.row isOriginal:self.isOriginal];
}


- (void)feedbackMediaCell:(LMFeedbackMediaCell *)cell clickCloseButtonMediaModel:(LMFeedbackMediaModel *)mediaModel {
    
    [self.arrDataSources removeObject:mediaModel];
    
    [self.collectionView reloadData];
    
}

- (void)feedbackMediaCell:(LMFeedbackMediaCell *)cell clickPlayButtonMediaModel:(LMFeedbackMediaModel *)mediaModel {
    
    if (mediaModel.mediaType == LMFeedbackMediaTypeImage) {
        LMDrawBoarderController *viewController = [[LMDrawBoarderController alloc] init];
        viewController.sourceImage = mediaModel.image;
        viewController.imageBlock = ^(UIImage *image) {
            mediaModel.image = image;
            [self.collectionView reloadData];
        };
        [self presentViewController:viewController animated:YES completion:nil];
    }
    

}

////多选发送多张图片
//- (void)finishPickerPhotoAction:(MPPPickerPhotoActionHelper *)mspPickerPhotoActionHelper photosInfo:(NSDictionary *)imagesInfo selectImageSizeType:(AlbumsImageSizeType)selectImageSizeType {
//    NSArray *dataArray = imagesInfo[@"images"];
//    for (int i = 0; i < dataArray.count; i++) {
//
//        //genertateDictWithContent里面包含大量的图片处理产生的autorelease对象，大图大量循环时内存递增明显
//        @autoreleasepool {
//            UIImage *image = dataArray[i];
//
//            LMFeedbackMediaModel *model = [[LMFeedbackMediaModel alloc] initWithImage:image];
//
//            [self.arrDataSources addObject:model];
//        }
//    }
//
//    [self.pickPhotoActionHelper dismissAlbum];
//
//    [self.collectionView reloadData];
//}



- (void)textViewDidChange:(UITextView *)textView{
    
    CGFloat textViewMinHeight = 140.f; // TextView最小高度

    // 重要属性
    CGFloat textViewContentH = textView.contentSize.height;
    
    //    NSLog(@"%@",NSStringFromCGSize(textView.contentSize));
    // 1.计算TextView的高度
    if (textViewContentH < textViewMinHeight) { // 小于最小值的情况
        [self setConstraint:textViewMinHeight];
    } else { // 其余情况高度随着内容的高度变化
        [self setConstraint:textViewContentH];
    }
    
//    // 2.计算底部工具条的高度
//    self.bottomToolBarHeightConstraint.constant = 8 + 8 + _textViewHeightConstraint.constant;
    
    // 3.添加动画效果
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
//    // 4.让TextView中的光标回到0位置
//#warning TextView光标复位的小技巧
//    [textView setContentOffset:CGPointZero animated:YES]; // 这一句就能够起作用
//    [textView scrollRangeToVisible:textView.selectedRange]; // 不加这句也可以
}


- (void)cancelButtonClick {
    // 关闭按钮
    [[LMFeedbackManage shareManage] dismissFeedback];
}

- (void)endEditingButtonClick {
    
    // 完成编辑
    
    [[LMFeedbackManage shareManage] feedbackMsgStr:self.textView.text andMediaModelArr:self.arrDataSources];
    
}

- (IBAction)screenshotButtonClick:(UIButton *)sender {
    // 截图
    if (self.arrDataSources.count >= 4) {
        // 警告 不能超过4个
        [self reachedMaximimNumberAlertView];
    } else {
        [[LMFeedbackManage shareManage] tempDismissFeedback];
        LMLevitateButton *levitateButton = [LMLevitateButton showLevitateButtonWithController:self];
        levitateButton.imageBlock = ^(UIImage *image){
            [self.arrDataSources addObject:[[LMFeedbackMediaModel alloc] initWithImage:image]];
            [self.collectionView reloadData];
        };
    }

}

- (IBAction)pickPhotoButtonClick:(UIButton *)sender {
    
    if (self.arrDataSources.count >= 4) {
        // 警告 不能超过4个
        [self reachedMaximimNumberAlertView];
    } else {
//        self.pickPhotoActionHelper.maxSelectCount = 4-self.arrDataSources.count;
//        [self.pickPhotoActionHelper showAlbum];
    }
}


- (void)setConstraint:(CGFloat)textViewHeight {
    
    self.textViewHeight.constant = textViewHeight;
    self.containerViewHeight.constant = textViewHeight + 120.f;
    self.containerScrollView.contentSize = CGSizeMake(0.f, self.containerViewHeight.constant);
}


- (void)reachedMaximimNumberAlertView {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:NSLocalizedStringFromTable(@"reachedMaximimNumberOfAttachmentsTitleStringName", @"LMShakeFeedback", nil) message:NSLocalizedStringFromTable(@"reachedMaximimNumberOfAttachmentsMessageStringName", @"LMShakeFeedback", nil) delegate:self cancelButtonTitle:NSLocalizedStringFromTable(@"okButton", @"LMShakeFeedback", nil) otherButtonTitles:nil];
    
    [alertView show];
}

#pragma mark - Get&&Set

- (NSMutableArray<LMFeedbackMediaModel *> *)arrDataSources {
    if (_arrDataSources == nil) {
        _arrDataSources = [NSMutableArray array];
    }
    return _arrDataSources;
}


@end
