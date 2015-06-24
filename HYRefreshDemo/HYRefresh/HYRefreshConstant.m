//
//  HYConstant.m
//  HYRefreshDemo
//
//  Created by jimubox on 15/4/30.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#ifndef __HYConstant__M__
#define __HYConstant__M__

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

/**
 *  产生动画下拉的高度
 */
CGFloat const HYRefreshHeight = 80.0f;

/**
 *  默认刷新状态的文字
 */
NSString * const HYRefrshLoadingMessage = @"正在刷新...";

/**
 *  结束刷新的文字
 */
NSString * const HYRefreshEndRefreshMessage = @"结束刷新！";

/**
 *  刷新成功文字
 */
NSString * const HYRefreshSuccessRefreshMessage = @"刷新成功！";

/**
 *  刷新失败的文字
 */
NSString * const HYRefreshFailureRefreshMessage = @"刷新失败！";

/**
 *  UIScrollView的contentOffset属性名称
 */
NSString * const HYRefreshContentOffset = @"contentOffset";



#endif