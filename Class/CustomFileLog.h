//
//  CustomFileLog.h
//  IOSBuildTest
//
//  Created by wangrui on 8/26/15.
//  Copyright (c) 2015 wangrui. All rights reserved.
//

#import "WRFileLog.h"

/**
 *  自定义输出宏到自己想保存的文件
 */

#define AnthongerLogToFile(frmt, ...)  WRLogToFile(CustomFileLog,frmt, __VA_ARGS__)

@interface CustomFileLog : WRFileLog

@end
