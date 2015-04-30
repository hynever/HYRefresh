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
#import "HYConstant.h"
#import <objc/runtime.h>

/**
 *  UIScrollView的contentOffset属性名称
 */
static NSString * const HYRefreshContentOffset = @"contentOffset";


@interface UIScrollView()

@property(nonatomic,strong) HYRefreshModel *model;

@end

@implementation UIScrollView(HYRefresh)


#pragma mark 使用默认Message的下拉刷新
-(void)addHeaderWithCallback:(void(^)())callback
{
    [self addHeaderWithMessage:nil Callback:callback];
}

#pragma mark 带有自定义Message的下拉刷新
-(void)addHeaderWithMessage:(NSString *)msg Callback:(void(^)())callback
{
    if (self.model) return;
    self.model = [HYRefreshModel new];
    self.model.originContentOffsetTop = self.contentInset.top;
    self.model.callBack = callback;
    self.model.message = msg;
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
                    [HYStatusBarWindow showLoadingWithMessage:self.model.message ? self.model.message : HYRefrshLoadingMessage];
                    if (self.model.callBack) {
                        self.model.callBack();
                    }
                });
            }
        }
    }
}

#pragma mark 手动调用开始刷新
-(void)startRefresh
{
    CGFloat dragHeight = ABS(HYRefreshHeight - self.contentInset.top);
    self.contentOffset = CGPointMake(0, dragHeight);
}

#pragma mark 带有提示信息的结束刷新
-(void)endRefreshWithMessage:(NSString *)msg
{
    [HYStatusBarWindow hideLoadingWithMessage:msg];
}

#pragma mark 直接结束刷新
-(void)endRefresh
{
    [HYStatusBarWindow hide];
}

#pragma mark - get&set方法
#pragma mark set&get/model
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
