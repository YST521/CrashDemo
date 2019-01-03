//
//  NSObject+JessicaMessageForwarding_h.m
//  CrashDemo
//
//  Created by youxin on 2018/12/24.
//  Copyright © 2018年 yst. All rights reserved.
//
#import "NSObject+JessicaMessageForwarding_h.h"
#import <objc/runtime.h>
@implementation NSObject (JessicaMessageForwarding_h)


+ (void)load   {
    
    static dispatch_once_t onceToken1;
    dispatch_once(&onceToken1, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(forwardInvocation:);
        SEL swizzledSelector = @selector(jessica_forwardInvocation:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(methodSignatureForSelector:);
        SEL swizzledSelector = @selector(jessica_methodSignatureForSelector:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    
}

#pragma mark - Method Swizzling

- (void)jessica_forwardInvocation:(NSInvocation *)anInvocation {
    
    if (self.isOverriForwardInvocation) {
        return [self jessica_forwardInvocation:anInvocation];
    }
    
    if ([self respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)jessica_methodSignatureForSelector:(SEL)aSelector {
    
    if (self.isOverriMethodSignatureForSelector) {
        return [self jessica_methodSignatureForSelector:aSelector];
    }
    
    NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (methodSignature == nil) {
#warning 诸如UIKeyboardInputManagerClient 这个类自己重写了 methodSignatureForSelector方法, 就得遵循自己地方法
        
        self.isOverriMethodSignatureForSelector = NO;
        self.isOverriForwardInvocation = NO;
        
        for (NSString *methodStr in [self getAllMethodArray]) {
            if ([methodStr isEqualToString:@"methodSignatureForSelector:"]) {
                self.isOverriMethodSignatureForSelector = YES;
            }
            if ([methodStr isEqualToString:@"forwardInvocation:"]) {
                self.isOverriForwardInvocation = YES;
            }
        }
        
        if (self.isOverriMethodSignatureForSelector) {
            return [self jessica_methodSignatureForSelector:aSelector];
        }
        
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return methodSignature;
}


-(NSArray *)getAllMethodArray{
    u_int count;
    NSMutableArray *arrayM = [NSMutableArray array];
    
    Method *mothList_f = class_copyMethodList([self class],&count) ;
    for (int i = 0; i < count; i++) {
        Method temp_f = mothList_f[i];
        
        SEL name_f = method_getName(temp_f);
        const char * name_s = sel_getName(name_f);
        [arrayM addObject:[NSString stringWithUTF8String:name_s]];
        
    }
    free(mothList_f);
    
    return arrayM.copy;
}

-(BOOL)isOverriMethodSignatureForSelector{
    NSNumber* vale = objc_getAssociatedObject(self, @selector(isOverriMethodSignatureForSelector));
    return [vale boolValue];
}

-(BOOL)isOverriForwardInvocation{
    NSNumber* vale = objc_getAssociatedObject(self, @selector(isOverriForwardInvocation));
    return [vale boolValue];
}

-(void)setIsOverriMethodSignatureForSelector:(BOOL)vale{
    objc_setAssociatedObject(self, @selector(isOverriMethodSignatureForSelector), [NSNumber numberWithBool:vale], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setIsOverriForwardInvocation:(BOOL)vale{
    objc_setAssociatedObject(self, @selector(isOverriForwardInvocation), [NSNumber numberWithBool:vale], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
