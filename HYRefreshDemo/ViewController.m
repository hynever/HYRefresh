//
//  ViewController.m
//  HYRefreshDemo
//
//  Created by jimubox on 15/4/28.
//  Copyright (c) 2015年 jimubox. All rights reserved.
//

#import "ViewController.h"
#import "HYRefresh.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView addHeaderWithCallback:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"刷新成功啦~~~");
//            [self.tableView endRefreshWithMessage:@"刷新成功！"];
//        });
//    }];
    [self.tableView addHeaderWithMessage:@"HY正在帮你刷新..." Callback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"刷新成功啦~~~");
//            [self.tableView endRefreshWithMessage:@"刷新成功！"];
            [self.tableView endRefresh];
        });
    }];
    [self.tableView startRefresh];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
