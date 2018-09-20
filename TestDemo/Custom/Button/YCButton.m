//
//  YCButton.m
//  TestDemo
//
//  Created by huyuchen on 2018/9/11.
//  Copyright © 2018年 Hyc. All rights reserved.
//

#import "YCButton.h"

@interface YCButton ()

@end

@implementation YCButton

+ (instancetype)buttonWithTitle:(NSString *)title clickBlock:(BlockWithObject)clickBlock {
    YCButton *button = [YCButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title?:@"" forState:UIControlStateNormal];
    [button addTarget:button action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    if (clickBlock) {
        button.clickBlock = clickBlock;
    }
    return button;
}

- (void)didClickButton:(YCButton *)button {
    if (self.clickBlock) {
        self.clickBlock(button);
    }
}

@end
