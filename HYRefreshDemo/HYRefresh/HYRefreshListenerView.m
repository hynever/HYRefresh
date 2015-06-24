//
//  HYRefreshListenerView.m
//  jimustock
//
//  Created by jimubox on 15/5/27.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import "HYRefreshListenerView.h"
#import "HYRefreshModel.h"
#import "HYRefreshConstant.h"
#import "HYStatusBarWindow.h"

@interface HYRefreshListenerView ()

@property(nonatomic,weak) UIScrollView *fatherView;

@end

@implementation HYRefreshListenerView

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    //老的superView
    [self.superview removeObserver:self forKeyPath:HYRefreshContentOffset context:nil];
    //这里的superView就是UIScrollView
    if (newSuperview) {
        [newSuperview addObserver:self forKeyPath:HYRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
        self.fatherView = (UIScrollView *)newSuperview;
    }
}

#pragma mark KVO监听的方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([HYRefreshContentOffset isEqualToString:keyPath] && self.fatherView.contentOffset.y < 0) {
        CGFloat dragHeight = ABS(self.fatherView.contentOffset.y - self.refreshModel.originContentOffsetTop);
        CGFloat minHeight = self.refreshModel.originContentOffsetTop+HYRefreshHeight;
        CGFloat maxHeight = minHeight+8;
        if (dragHeight >= minHeight && dragHeight <= maxHeight) {
            //如果松开拖拽了，就刷新，否则不刷新
            if (!self.fatherView.isDragging) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [HYStatusBarWindow showLoadingWithMessage:self.refreshModel.message];
                    if (self.refreshModel.callBack) {
                        self.refreshModel.callBack();
                    }
                });
            }
        }
    }
}

#pragma mark 手动调用开始刷新
-(void)startRefresh
{
    CGFloat dragHeight = ABS(HYRefreshHeight - self.fatherView.contentInset.top);
    self.fatherView.contentOffset = CGPointMake(0, -dragHeight-1);
}

#pragma mark 带有提示信息的结束刷新
-(void)endRefreshWithMessage:(NSString *)msg
{
    [HYStatusBarWindow hideWithMessage:msg];
}

#pragma mark 直接结束刷新
-(void)endRefresh
{
    [HYStatusBarWindow hide];
}


@end
