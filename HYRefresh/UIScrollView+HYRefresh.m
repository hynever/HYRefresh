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
#import "HYRefreshConstant.h"
#import <objc/runtime.h>
#import "HYRefreshListenerView.h"

@interface UIScrollView()<UIScrollViewDelegate>

@property(nonatomic,strong) HYRefreshListenerView *listenerView;

@end

@implementation UIScrollView(HYRefresh)


#pragma mark 使用默认Message的下拉刷新
-(void)addHeaderRefreshWithCallback:(void(^)())callback
{
    [self addHeaderRefreshWithMessage:nil Callback:callback];
}

#pragma mark 带有自定义Message的下拉刷新
-(void)addHeaderRefreshWithMessage:(NSString *)msg Callback:(void(^)())callback
{
    if (self.listenerView) return;
    
    self.listenerView = [[HYRefreshListenerView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.listenerView];
    
    HYRefreshModel *refreshModel = [HYRefreshModel new];
    refreshModel.originContentOffsetTop = self.contentInset.top;
    refreshModel.callBack = callback;
    refreshModel.message = msg;
    self.listenerView.refreshModel = refreshModel;
}

#pragma mark 手动调用开始刷新
-(void)startRefresh
{
    [self.listenerView endRefresh];
    [self.listenerView startRefresh];
}

#pragma mark 带有提示信息的结束刷新
-(void)endRefreshWithMessage:(NSString *)msg
{
    [self.listenerView endRefreshWithMessage:msg];
}

#pragma mark 直接结束刷新
-(void)endRefresh
{
    [self.listenerView endRefresh];
}

#pragma mark - get&set方法
#pragma mark set&get/model
static char HYListenerViewKey;
-(void)setListenerView:(HYRefreshListenerView *)listenerView
{
    objc_setAssociatedObject(self, &HYListenerViewKey, listenerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(HYRefreshListenerView *)listenerView
{
    HYRefreshListenerView *LISTENERVIEW = (HYRefreshListenerView *)objc_getAssociatedObject(self, &HYListenerViewKey);
    return LISTENERVIEW;
}

@end
