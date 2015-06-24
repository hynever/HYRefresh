//
//  HYStatusBarWindow.h
//  HYRefreshDemo
//
//  Created by jimubox on 15/4/29.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 淡入淡出持续时间 */
#define kFadeDuration 0.3

@interface HYStatusBarWindow : NSObject

/**
 *  展示消息
 *
 *  @param msg 消息的文字
 */
+(void)showMessage:(NSString *)msg;

/**
 *  展示有loading效果的hud
 *
 *  @param msg        loading状态的文字
 *  @param successMsg 成功后的文字
 *  @param failureMsg 失败后的文字
 */
+(void)showLoadingWithMessage:(NSString *)msg;

/**
 *  @param msg 最后即将推出的时候的文字
 */
+(void)hideWithMessage:(NSString *)msg;

/**
 *  立马隐藏window
 */
+(void)hide;

@end
