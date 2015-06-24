//
//  HYConstant.h
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
UIKIT_EXTERN CGFloat HYRefreshHeight;

/**
 *  默认刷新状态的文字
 */
UIKIT_EXTERN NSString * const HYRefrshLoadingMessage;

/**
 *  结束刷新的文字
 */
UIKIT_EXTERN NSString * const HYRefreshEndRefreshMessage;

/**
 *  刷新成功文字
 */
UIKIT_EXTERN NSString * const HYRefreshSuccessRefreshMessage;

/**
 *  刷新失败的文字
 */
UIKIT_EXTERN NSString * const HYRefreshFailureRefreshMessage;

/**
 *  UIScrollView的contentOffset属性名称
 */
UIKIT_EXTERN NSString * const HYRefreshContentOffset;

#endif
