//
//  HYRefreshModel.h
//  HYRefreshDemo
//
//  Created by jimubox on 15/4/29.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBack)();

@interface HYRefreshModel : NSObject

/**
 *  展示的消息
 */
@property(nonatomic,copy) NSString *message;

/**
 *  下拉刷新做的事情
 */
@property(nonatomic,copy) CallBack callBack;

/**
 *  原始的UIScrollView的ContentOffset的Top
 */
@property(nonatomic,assign) CGFloat originContentOffsetTop;


@end
