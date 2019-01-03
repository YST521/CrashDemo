//
//  NSTimer+WeakTimer.h
//  CrashDemo
//
//  Created by youxin on 2018/12/24.
//  Copyright © 2018年 yst. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (WeakTimer)

+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:( __nullable id)userInfo
                                        repeats:(BOOL)repeats;


@end

NS_ASSUME_NONNULL_END
