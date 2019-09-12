//
//  GuideManager.h
//  GuideManager
//
//  Created by zhangxiaoye on 2019/9/10.
//  Copyright © 2019 zhangxiaoye. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FinishBlock)(void);

typedef NS_ENUM(NSInteger, HWGuidePageType) {
    GuidePageTypeHome = 0,
    GuidePageTypeMajor,
    GuidePageTypeClosure,
};

@interface GuideManager : NSObject

// 获取单例
+ (instancetype)shareManager;

/**
  显示方法

 @param type 指引页类型
 @param viewFrame 挖空大小
 @param tipView 提示视图
 @param Radius 圆角
 */
- (void)showGuidePageWithType:(HWGuidePageType)type ViewFrame:(CGRect)viewFrame TipView:(UIView *__nullable)tipView cornerRadius:(CGFloat)Radius;

/**
 指引页类型

 @param type 指引页类型
 @param viewFrame 挖空大小
 @param tipView 提示视图
 @param Radius 圆角
 @param completion 完成时回调
 */
- (void)showGuidePageWithType:(HWGuidePageType)type ViewFrame:(CGRect)viewFrame TipView:(UIView *__nullable)tipView cornerRadius:(CGFloat)Radius completion:(FinishBlock)completion;


/**
 隐藏方法
 */
- (void)hideGuidePageView;

@end

NS_ASSUME_NONNULL_END
