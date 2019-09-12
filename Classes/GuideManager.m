//
//  GuideManager.m
//  GuideManager
//
//  Created by zhangxiaoye on 2019/9/10.
//  Copyright © 2019 zhangxiaoye. All rights reserved.
//

#import "GuideManager.h"

@interface GuideManager ()

@property (nonatomic, copy) FinishBlock finish;
@property (nonatomic, copy) NSString *guidePageKey;
@property (nonatomic, assign) HWGuidePageType guidePageType;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation GuideManager

+ (instancetype)shareManager
{
    static GuideManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)showGuidePageWithType:(HWGuidePageType)type ViewFrame:(CGRect)viewFrame TipView:(UIView * _Nullable)tipView cornerRadius:(CGFloat)Radius
{
    if (type == GuidePageTypeClosure) {
        
        [self creatControlWithType:type ViewFrame:viewFrame TipView:tipView cornerRadius:Radius completion:NULL];

    }else{
        
        [self creatControlWithType:type ViewFrame:viewFrame TipView:tipView cornerRadius:Radius completion:_finish];

    }
}

- (void)showGuidePageWithType:(HWGuidePageType)type ViewFrame:(CGRect)viewFrame TipView:(UIView * _Nullable)tipView cornerRadius:(CGFloat)Radius completion:(nonnull FinishBlock)completion
{
    [self creatControlWithType:type ViewFrame:viewFrame TipView:tipView cornerRadius:Radius completion:completion];
}

- (void)creatControlWithType:(HWGuidePageType)type ViewFrame:(CGRect)viewFrame TipView:(UIView *_Nullable)tipView cornerRadius:(CGFloat)Radius completion:(FinishBlock)completion
{
    _finish = completion;
    
    // 遮盖视图
    CGRect frame = [UIScreen mainScreen].bounds;
    self.bgView = [[UIView alloc] initWithFrame:frame];
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
    
// 第一个路径 矩形
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:viewFrame cornerRadius:Radius>=0?Radius:5] bezierPathByReversingPath]];

//    圆形
//    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 100) radius:26 startAngle:0 endAngle:2 * M_PI clockwise:NO]];

    // 信息提示视图
    if (tipView) {
        
        [self.bgView addSubview:tipView];
    }

    // 绘制透明区域
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [self.bgView.layer setMask:shapeLayer];
}

- (void)hideGuidePageView{

    [self.bgView removeFromSuperview];
    [[self.bgView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.bgView = nil;
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
    UIView *bgView = recognizer.view;
    [bgView removeFromSuperview];
    [bgView removeGestureRecognizer:recognizer];
    [[bgView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    bgView = nil;
    
    if (_finish){
        _finish();

    }
}

@end
