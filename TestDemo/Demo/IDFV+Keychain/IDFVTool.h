//
//  IDFVTool.h
//  TestDemo
//
//  Created by huyuchen on 2018/9/13.
//  Copyright © 2018年 Hyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDFVTool : NSObject

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;

+ (NSString *)getIDFV;

@end
