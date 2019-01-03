//
//  NSArray+Extension.m
//  CrashDemo
//
//  Created by youxin on 2018/12/24.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "NSArray+Extension.h"
#import <objc/runtime.h>

@implementation NSArray (Extension)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class clsI = NSClassFromString(@"__NSArrayI");
        
        Method method1 = class_getInstanceMethod(clsI, @selector(objectAtIndexedSubscript:));
        Method method2 = class_getInstanceMethod(clsI, @selector(yye_objectAtIndexedSubscript:));
        method_exchangeImplementations(method1, method2);
        
        Method method3 = class_getInstanceMethod(clsI, @selector(objectAtIndex:));
        Method method4 = class_getInstanceMethod(clsI, @selector(yye_objectAtIndex:));
        method_exchangeImplementations(method3, method4);
        
        Class clsSingleI = NSClassFromString(@"__NSSingleObjectArrayI");
        Method method5 = class_getInstanceMethod(clsSingleI, @selector(objectAtIndex:));
        Method method6 = class_getInstanceMethod(clsSingleI, @selector(yyeSingle_objectAtIndex:));
        method_exchangeImplementations(method5, method6);
    });
}

- (id)yye_objectAtIndexedSubscript:(NSUInteger)index{
    if(index>=self.count) return self.lastObject;
    
    return [self yye_objectAtIndexedSubscript:index];
}

- (id)yye_objectAtIndex:(NSUInteger)index{
    if(index>=self.count) return self.lastObject;
    
    return [self yye_objectAtIndex:index];
}

- (id)yyeSingle_objectAtIndex:(NSUInteger)index{
    if(index>=self.count){
        return self.lastObject;
    }
    
    return [self yyeSingle_objectAtIndex:index];
}



@end
