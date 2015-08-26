//
//  WRFileLogger.m
//  IOSBuildTest
//
//  Created by wangrui on 8/26/15.
//  Copyright (c) 2015 wangrui. All rights reserved.
//

#import "WRFileLog.h"

@implementation WRFileLog

+ (NSMutableDictionary *)loggers {
    
    static NSMutableDictionary *_logger = nil;
    
    if (!_logger) {
        _logger = [NSMutableDictionary dictionary];
    }
    
    return _logger;
}

+ (void)log:(BOOL)asynchronous
      level:(DDLogLevel)level
       flag:(DDLogFlag)flag
    context:(NSInteger)context
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
        tag:(id)tag
     format:(NSString *)format, ... {
    va_list args;
    
    if (format) {
        va_start(args, format);
        
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        [self log:asynchronous
          message:message
            level:level
             flag:flag
          context:context
             file:file
         function:function
             line:line
              tag:tag];
        
        va_end(args);
    }
}

+ (void)log:(BOOL)asynchronous
      level:(DDLogLevel)level
       flag:(DDLogFlag)flag
    context:(NSInteger)context
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
        tag:(id)tag
     format:(NSString *)format
       args:(va_list)args {
    
    if (format) {
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        [self log:asynchronous
          message:message
            level:level
             flag:flag
          context:context
             file:file
         function:function
             line:line
              tag:tag];
    }
}

+ (void)log:(BOOL)asynchronous
    message:(NSString *)message
      level:(DDLogLevel)level
       flag:(DDLogFlag)flag
    context:(NSInteger)context
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
        tag:(id)tag {
    
    DDLogMessage *logMessage = [[DDLogMessage alloc] initWithMessage:message
                                                               level:level
                                                                flag:flag
                                                             context:context
                                                                file:[NSString stringWithFormat:@"%s", file]
                                                            function:[NSString stringWithFormat:@"%s", function]
                                                                line:line
                                                                 tag:tag
                                                             options:(DDLogMessageOptions)0
                                                           timestamp:nil];
    
    [[DDTTYLogger sharedInstance] logMessage:logMessage];
    [[self currentLogger] logMessage:logMessage];
}

+ (DDFileLogger *)currentLogger {
    
    DDFileLogger *logger = [[self loggers] objectForKey:NSStringFromClass([self class])];
    
    if (!logger) {
        return [self defaultFileLogger];
    }
    
    return logger;
}

+ (DDFileLogger *)defaultFileLogger {
    
    static DDFileLogger *l = nil;
    
    if (!l) {
        l = [[DDFileLogger alloc] init];
    }
    
    return l;
}

+ (void)setCurrentLogger:(DDFileLogger *)logger {
    if (logger) {
        [[self loggers] setObject:logger forKey:NSStringFromClass([self class])];
    }
}

@end
