//
//  HYRefreshListenerView.h
//  jimustock
//
//  Created by jimubox on 15/5/27.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYRefreshModel;
@interface HYRefreshListenerView : UIView

@property(nonatomic,strong) HYRefreshModel *refreshModel;

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
