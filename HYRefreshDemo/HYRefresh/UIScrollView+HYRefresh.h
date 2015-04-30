//
//  HYStatusBarRefresh.h
//  下拉刷新demo
//
//  Created by 黄勇 on 15/4/25.
//  Copyright (c) 2015年 huangyong. All rights reserved.
//

#import <UIKit/UIKit.h>

/************************在状态栏显示刷新状态************************/
@interface UIScrollView (HYRefresh)


/**
 *  添加头部刷新
 *
 *  @param callback 刷新要执行的代码
 */
-(void)addHeaderWithCallback:(void(^)())callback;

/**
 *  带有可以自定义Message的下拉刷新
 *
 *  @param msg      自定义Message
 *  @param callback 刷新要执行的代码
 */
-(void)addHeaderWithMessage:(NSString *)msg Callback:(void(^)())callback;

/**
 *  手动调用刷新
 */
-(void)startRefresh;

/**
 *  带有提示信息的隐藏
 *
 *  @param msg 提示信息
 */
-(void)endRefreshWithMessage:(NSString *)msg;

/**
 *  直接隐藏
 */
-(void)endRefresh;

@end
