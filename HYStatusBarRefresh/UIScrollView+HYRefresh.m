//
//  HYStatusBarRefresh.m
//  下拉刷新demo
//
//  Created by 黄勇 on 15/4/25.
//  Copyright (c) 2015年 huangyong. All rights reserved.
//

#import "UIScrollView+HYRefresh.h"
#import "HYStatusBarWindow.h"
#import "HYRefreshModel.h"
#import <objc/runtime.h>

/**
 *  UIScrollView的contentOffset属性名称
 */
static NSString * const HYRefreshContentOffset = @"contentOffset";
/**
 *  产生动画下拉的高度
 */
static CGFloat const HYRefreshHeight = 64.0f;


@interface UIScrollView()

@property(nonatomic,strong) HYRefreshModel *model;

@end

@implementation UIScrollView(HYRefresh)

/**
 *  添加头部刷新
 *
 *  @param callback 刷新要执行的代码
 */
-(void)addHeaderWithCallback:(void(^)())callback
{
    self.model = [HYRefreshModel new];
    self.model.originContentOffsetTop = self.contentInset.top;
    self.model.callBack = callback;
    self.contentOffset = CGPointMake(0, -64);
    [self addObserver:self forKeyPath:HYRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark KVO监听的方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([HYRefreshContentOffset isEqualToString:keyPath]) {
        CGFloat dragHeight = ABS(self.contentOffset.y - self.model.originContentOffsetTop);
        CGFloat minHeight = self.model.originContentOffsetTop+HYRefreshHeight;
        CGFloat maxHeight = minHeight+8;
        if (dragHeight >= minHeight && dragHeight <= maxHeight) {
            //如果松开拖拽了，就刷新，否则不刷新
            if (!self.isDragging) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [HYStatusBarWindow showLoadingWithMessage:@"正在刷新..."];
                    if (self.model.callBack) {
                        self.model.callBack();
                    }
                });
            }
        }
    }
}

-(void)hideWithMessage:(NSString *)msg
{
    [HYStatusBarWindow hideLoadingWithMessage:msg];
}

-(void)hide
{
    [HYStatusBarWindow hide];
}

#pragma mark - get&set方法
#pragma mark set/originContentOffsetTop
static char HYModelKey;
-(void)setModel:(HYRefreshModel *)model
{
    objc_setAssociatedObject(self, &HYModelKey, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(HYRefreshModel *)model
{
    HYRefreshModel *model = (HYRefreshModel *)objc_getAssociatedObject(self, &HYModelKey);
    return model;
}

@end
