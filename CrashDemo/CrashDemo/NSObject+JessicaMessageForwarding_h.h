//
//  NSObject+JessicaMessageForwarding_h.h
//  CrashDemo
//
//  Created by youxin on 2018/12/24.
//  Copyright © 2018年 yst. All rights reserved.
//

//#import <Foundation/Foundation.h>
//
//NS_ASSUME_NONNULL_BEGIN
//
//@interface NSObject (JessicaMessageForwarding_h)
//
//@end
//
//NS_ASSUME_NONNULL_END

//防止找不到方法闪退

#import <Foundation/Foundation.h>

@interface NSObject (JessicaMessageForwarding_h)

//是否重写了 methodSignatureForSelector
@property (assign, nonatomic) BOOL isOverriMethodSignatureForSelector;

//是否重写了forwardInvocation
@property (assign, nonatomic) BOOL isOverriForwardInvocation;
@end

