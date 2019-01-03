//
//  ViewController.m
//  CrashDemo
//
//  Created by youxin on 2018/12/24.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+Extension.h"
#import "NSMutableArray+Extension.h"
//#import "NSObject+JessicaMessageForwarding_h.h"
#import "NSTimer+WeakTimer.h"
#import "TestController.h"

@interface ViewController (){
    UIButton *mainBtn;
    UIButton *btn;
    
}
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *v = [[UIView alloc]init];
 
    [self mainBtnTest]; //测试页面是否被卡死
    [self btnTest];     //测试找不到事件
    [self arrTest];     //测试数组和可变数据
    [self nstimer];    //防泄漏NStimer
    
    
//    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
//
//        [backButton addTarget:self action:@selector(navigationBackButtonClicked) forControlEvents:UIControlEventTouchUpInside];
////
////        [backButton setBackgroundImage:[UIImage imageNamed:@"fanHuiC60.88"] forState:UIControlStateNormal];
//    [backButton setTitle:@"666" forState:(UIControlStateNormal)];
//
//
//
//        UIBarButtonItem *backBtnI = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                              target:self action:@selector(pushFirstPage)];
//
//        negativeSpacer.width = -17;
//
//        self.navigationItem.leftBarButtonItems = @[negativeSpacer,backBtnI];
  
    
//    UIBarButtonItem *leftButon = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete_login"] style:UIBarButtonItemStylePlain target:self action:@selector(pushFirstPage)];
//
//    self.navigationItem.leftBarButtonItem = leftButon;
    
//    UIBarButtonItem *leftButon = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete_login"] style:UIBarButtonItemStylePlain target:self action:@selector(pushFirstPage)];
//    UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//
//    fixedButton.width = -60;
//
//    self.navigationItem.leftBarButtonItems = @[fixedButton, leftButon];


    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
        [backButton addTarget:self action:@selector(pushFirstPage) forControlEvents:UIControlEventTouchUpInside];
    
        [backButton setBackgroundImage:[UIImage imageNamed:@"delete_login"] forState:UIControlStateNormal];
  
        UIBarButtonItem *backBtnI = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           
                                                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                          target:nil action:nil];
    
     negativeSpacer.width = -25;
    
   self.navigationItem.leftBarButtonItems = @[negativeSpacer,backBtnI];
 
}
-(void)pushFirstPage{
    self.view.backgroundColor = [UIColor redColor];
    TestController *testVC = [[TestController alloc]init];
    [self.navigationController pushViewController:testVC animated:YES];
}

-(void)nstimer{
  //几种定时器比较  https://www.jianshu.com/p/c167ca4d1e7e
    self.timer = [NSTimer scheduledWeakTimerWithTimeInterval:1.0 target:self selector:@selector(timerTest) userInfo:nil repeats:YES];
    
}
// 如果不点击屏幕，定时器也会随着控制器地销毁而销毁，具体使用看需求
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.view.backgroundColor =  [self randomColor];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerTest {
    NSLog(@"%s", __func__);
}


-(void)mainBtnTest{
    
    mainBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    mainBtn.frame = CGRectMake(0, 100, 414, 40);
    [self.view addSubview:mainBtn];
    mainBtn.backgroundColor =[UIColor redColor];
    [mainBtn setTitle:@"666" forState:(UIControlStateSelected)];
    
    [mainBtn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
}
-(void)btnAction:(UIButton*)btn{
   [self nstimer];
    self.view.backgroundColor =  [self randomColor];
}
- (UIColor*)randomColor{
    CGFloat
    hue = (arc4random() %256/256.0);
    CGFloat saturation = (arc4random() %128/256.0) +0.5;
    CGFloat brightness = (arc4random() %128/256.0) +0.5;
    UIColor*color = [UIColor  colorWithRed:hue green:brightness blue:brightness alpha:1.0];
    return color;
    
}

-(void)btnTest{
    
    btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(0, 150, 414, 40);
    [self.view addSubview:btn];
    btn.backgroundColor =[UIColor redColor];
    [btn setTitle:@"666" forState:(UIControlStateSelected)];
    
    [btn addTarget:self action:@selector(test1) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)arrTest{
    NSArray *array = @[@1];
    [array objectAtIndex:4];
    //    array[4];
    //    错误提示：[__NSSingleObjectArrayI objectAtIndex:]: index 4 beyond bounds [0 .. 0]
    
    
    NSArray *array2 = @[@1,@2];
    [array2 objectAtIndex:4];
    //    错误提示：[__NSArrayI objectAtIndex:]: index 4 beyond bounds [0 .. 1]'
    //    array[4];
    //    错误提示：[__NSArrayI objectAtIndexedSubscript:]: index 4 beyond bounds [0 .. 1]'
    
    NSArray *arrayM = @[@1].mutableCopy;
    [arrayM objectAtIndex:4];
    //    错误提示：[__NSArrayM objectAtIndex:]: index 4 beyond bounds [0 .. 0]
    
    //    arrayM[4];
    //    错误提示：[__NSArrayM objectAtIndexedSubscript:]: index 4 beyond bounds [0 .. 0]
   
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@"100"];
    for(int i =0;i<100;i++){
        NSLog(@"%@",arr[i]);
    }
    NSLog(@"---%@",arr[100]);
    
}

-(void)test{
    
}

@end
