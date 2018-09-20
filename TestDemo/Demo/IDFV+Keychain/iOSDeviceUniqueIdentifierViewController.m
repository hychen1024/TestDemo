//
//  iOSDeviceUniqueIdentifierViewController.m
//  TestDemo
//
//  Created by huyuchen on 2018/9/13.
//  Copyright © 2018年 Hyc. All rights reserved.
//

#import "iOSDeviceUniqueIdentifierViewController.h"
#import "IDFVTool.h"

@interface iOSDeviceUniqueIdentifierViewController ()

@end

@implementation iOSDeviceUniqueIdentifierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self iOSDeviceUniqueIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)iOSDeviceUniqueIdentifier {
    //IDFV identifierForVendor Apple给供应商唯一的一个值,同一个公司发行的app在相同的设备上运行会有相同的标识,但是当用户卸载该公司所有的app时该值会重置
    //获取IDFV
    NSLog(@"idfv:\r%@",[IDFVTool getIDFV]);
}


@end
