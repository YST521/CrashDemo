//
//  ViewController.m
//  WKCrashManagerDemo
//
//  Created by wangkun on 2018/12/10.
//  Copyright © 2018年 wangkun. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController (){
    UIButton *btn;
    Person *pp;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    // Do any additional setup after loading the view, typically from a nib.
//    https://github.com/WangKunKun/WKDemo
    
    pp = [[Person alloc]init];
    pp.name = @"张三";
    pp.age = @"18";
    [pp addObserver:self
                forKeyPath:@"name"
                   options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                   context:nil];
    
   
}
- (IBAction)kvoCrash:(id)sender {
    
    //pp先添加 KVO 然后touchesBegan 中移除 然后再点击使监听对象的属性发生变化 正常情况会闪退 通过runtime之后就不会发生闪退了
    pp.name = @"123456";
    
}
#pragma mark 监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"name"])
    {
        NSLog(@"%@",[object valueForKey:@"name"]);
        self.view.backgroundColor = [UIColor greenColor];
        NSLog(@"ChangeInfo:%@",change);
    }
}

//字典插入空值
- (IBAction)dictionAddNill:(id)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *str = nil;
    [dic setObject:str forKey:@"kk"];
    [dic setObject:nil forKey:@"ll"];
}
//字符串越界
- (IBAction)anString:(id)sender {
    
//        NSString *str = @"123";
//        NSLog(@"%@",[str substringWithRange:NSMakeRange(0, 5)]);
    
    NSMutableString *mStr = [[NSMutableString alloc]init];
    [mStr appendFormat: @"123"];
    //越界插入
    [mStr insertString:@"4" atIndex:6];
    NSLog(@"==== %@--%@--%@",mStr, [mStr substringToIndex: 10],[mStr substringFromIndex:100]);
    //[mStr substringWithRange:NSMakeRange(1, 20)]
}
//越界读取
- (IBAction)anArray:(id)sender {
    
    NSArray *aa = @[@"100"];
    NSLog(@"---- %@",aa[100]);
}
//没找到方法
- (IBAction)noAction:(id)sender {
    
    btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(100, 100, 100, 100 );
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(selSelector1) forControlEvents:(UIControlEventTouchUpInside)];
    
}
-(void)selSelector{
    self.view.backgroundColor = [UIColor greenColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [pp removeObserver:self forKeyPath:@"name"];
    btn.hidden = YES;
}

- (IBAction)methodNotFountClick:(id)sender {
    
    UIView * v = self;
    UIView * new = [UIView new];
    [v addSubview:new];
}

- (IBAction)arrarAddNilClick:(id)sender {
    NSMutableArray * arr = [NSMutableArray array];
    id a = nil;
    [arr addObject:a];
}

- (IBAction)strAppendNilClick:(id)sender {
    NSMutableString * str = [NSMutableString string];
    NSString * s = nil;
    [str appendString:s];
}

#pragma mark 释放观察者
- (void)dealloc
{
    [pp removeObserver:self forKeyPath:@"name"];
}
@end
