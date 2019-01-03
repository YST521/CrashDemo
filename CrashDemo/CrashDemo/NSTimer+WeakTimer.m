//
//  NSTimer+WeakTimer.m
//  CrashDemo
//
//  Created by youxin on 2018/12/24.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "NSTimer+WeakTimer.h"

@interface TimerWeakObject : NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer *timer;

- (void)fire:(NSTimer *)timer;
@end

@implementation TimerWeakObject

- (void)fire:(NSTimer *)timer
{
    if (self.target) {
        if ([self.target respondsToSelector:self.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.target performSelector:self.selector withObject:timer.userInfo];
#pragma clang diagnostic pop
        }
    }
    else{
        [self.timer invalidate];
    }
}

@end

@implementation NSTimer (WeakTimer)

+ (NSTimer *)scheduledWeakTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)repeats
{
    TimerWeakObject *object = [[TimerWeakObject alloc] init];
    object.target = aTarget;
    object.selector = aSelector;
    object.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:object selector:@selector(fire:) userInfo:userInfo repeats:repeats];
    
    return object.timer;
}

@end

