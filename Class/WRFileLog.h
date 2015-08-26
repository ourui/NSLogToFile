//
//  WRFileLogger.h
//  IOSBuildTest
//
//  Created by wangrui on 8/26/15.
//  Copyright (c) 2015 wangrui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaLumberjack.h"

#define WLOGV_MACRO(classname,isAsynchronous, lvl, flg, ctx, atag, fnct, frmt, ...) \
        [classname log : isAsynchronous                                     \
                    level : lvl                                                \
                    flag : flg                                                \
                    context : ctx                                                \
                    file : __FILE__                                           \
                    function : fnct                                               \
                    line : __LINE__                                           \
                    tag : atag                                               \
                    format : (frmt), ## __VA_ARGS__]


#define WRLogToFile(classname,frmt, ...)  WLOGV_MACRO(classname,LOG_ASYNC_ENABLED, \
                                            DDLogLevelDebug, DDLogFlagDebug,0,nil, \
                                            __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)



#define NSLogToFile(frmt, ...)  WRLogToFile(WRFileLog,frmt, __VA_ARGS__)

@interface WRFileLog : NSObject

+ (void)log:(BOOL)synchronous
      level:(DDLogLevel)level
       flag:(DDLogFlag)flag
    context:(NSInteger)context
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
        tag:(id)tag
     format:(NSString *)format, ... NS_FORMAT_FUNCTION(9,10);

+ (void)setCurrentLogger:(DDFileLogger *)logger;

@end
