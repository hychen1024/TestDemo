//
//  GCDSemaphoreViewController.m
//  TestDemo
//
//  Created by huyuchen on 2018/9/11.
//  Copyright © 2018年 Hyc. All rights reserved.
//

#import "GCDSemaphoreViewController.h"

@interface GCDSemaphoreViewController ()
@property (nonatomic, strong) YCButton *btn1;
@property (nonatomic, strong) YCButton *btn2;
@end

@implementation GCDSemaphoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    self.btn1 = [YCButton buttonWithTitle:@"demo1" clickBlock:^(id obj1) {
        [weakSelf demo_1];
    }];
    
    self.btn2 = [YCButton buttonWithTitle:@"demo2" clickBlock:^(id obj1) {
        [weakSelf demo_2];
    }];
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    
    self.btn1.frame = CGRectMake(0, 0, 100, 40);
    self.btn2.frame = CGRectMake(0, 50, 100, 40);
}

- (void)demo_1 {
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(4);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 20; ++i) {
        NSInteger value = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"1_value_%ld_%d",value,i);
        
        dispatch_group_async(group, queue, ^{
            NSLog(@"index:%d",i);
            sleep(1);
            NSInteger value = dispatch_semaphore_signal(semaphore);
            NSLog(@"2_value_%ld",value);
        });
    }
}

- (void)demo_2 {
    
}
@end
