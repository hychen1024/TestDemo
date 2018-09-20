//
//  GCDBarrierViewController.m
//  TestDemo
//
//  Created by huyuchen on 2018/9/13.
//  Copyright © 2018年 Hyc. All rights reserved.
//

#import "GCDBarrierViewController.h"

static NSString *he = @"zhangsan";
static NSString *she = @"tiantian";

@interface GCDBarrierViewController ()
@property (nonatomic, strong) dispatch_queue_t queue;
@end

@implementation GCDBarrierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.queue = dispatch_queue_create("test_queue", DISPATCH_QUEUE_CONCURRENT);
    [self test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test {
    [self print];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_barrier_async(self.queue, ^{
            he = @"lisi";
            she = @"huahua";
        });
    });
}

- (void)print {
    NSLog(@"%@ likes %@",he,she);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self print];
    });
}

@end
