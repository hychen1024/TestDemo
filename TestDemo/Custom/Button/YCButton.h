//
//  YCButton.h
//  TestDemo
//
//  Created by huyuchen on 2018/9/11.
//  Copyright © 2018年 Hyc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YCButton : UIButton

@property (nonatomic, copy) BlockWithObject clickBlock;

+ (instancetype)buttonWithTitle:(NSString *)title clickBlock:(BlockWithObject)clickBlock;

@end

NS_ASSUME_NONNULL_END
