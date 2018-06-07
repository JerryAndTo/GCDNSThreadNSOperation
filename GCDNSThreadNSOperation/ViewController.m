//
//  ViewController.m
//  GCDNSThreadNSOperation
//
//  Created by ZYQ on 2018/6/4.
//  Copyright © 2018年 eilsel. All rights reserved.
//

#import "ViewController.h"
#import "tickerManager.h"
#import "testSingle.h"

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    tickerManager * manager = [[tickerManager alloc]init];
//    [manager startToSale];
//    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [btn addTarget:self action:@selector(clickNSThread) forControlEvents:UIControlEventTouchUpInside];
//    btn.frame = CGRectMake(100, 100, 100, 50);
//    [btn setTitle:@"NSThread" forState:UIControlStateNormal];
//    [self.view addSubview:btn];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn addTarget:self action:@selector(clickGCD) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 150, 100, 50);
    [btn setTitle:@"GCD" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIButton * btn0 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn0 addTarget:self action:@selector(clickSingle) forControlEvents:UIControlEventTouchUpInside];
    btn0.frame = CGRectMake(100, 200, 100, 50);
    [btn0 setTitle:@"单例" forState:UIControlStateNormal];
    [self.view addSubview:btn0];
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 addTarget:self action:@selector(clickAfter) forControlEvents:UIControlEventTouchUpInside];
    btn1.frame = CGRectMake(100, 250, 100, 50);
    [btn1 setTitle:@"延迟执行" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 addTarget:self action:@selector(clickNSOperation) forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(100, 300, 100, 50);
    [btn2 setTitle:@"NSOperation" forState:UIControlStateNormal];
    [self.view addSubview:btn2];

}

- (void)clickNSOperation
{
    NSLog(@"执行NSOperation");
//1.[invocationOpre start]在主线程执行（可以阻塞主线程）
//    NSInvocationOperation * invocationOpre = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationOpreAction) object:nil];
//    [invocationOpre start];
   
//2.[invocationOpre start]在主线程执行（可以阻塞子线程），NSInvocationOperation是同步的，end在invocation 2之后输出
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            NSInvocationOperation * invocationOpre = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationOpreAction) object:nil];
//            [invocationOpre start];
//        NSLog(@"end");
//
//    });
//3.NSBlockOperation也是同步的。和情况2一样
//    NSBlockOperation * blockOpre = [NSBlockOperation blockOperationWithBlock:^{
//        for (int i = 0; i<3; i++)
//        {
//            NSLog(@"invocation %d",i);
//            [NSThread sleepForTimeInterval:3];
//        }
//
//    }];
//    [blockOpre start];
//4.NSBlockOperation通过另一种方法开启。end先执行，说明是异步操作
//    NSBlockOperation * blockOpre = [NSBlockOperation blockOperationWithBlock:^{
//        for (int i = 0; i<3; i++)
//        {
//            NSLog(@"invocation %d",i);
//            [NSThread sleepForTimeInterval:1];
//        }
//
//    }];
//    if (!self.operationQueue)
//    {
//        self.operationQueue = [[NSOperationQueue alloc]init];
//    }
//    [self.operationQueue addOperation:blockOpre];
//
//     NSLog(@"end");
    
    
    
    
}
- (void)invocationOpreAction
{
    for (int i = 0; i<3; i++) {
        NSLog(@"invocation %d",i);
        [NSThread sleepForTimeInterval:3];
    }
}
- (void)clickAfter
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"延迟2秒执行");//有危险，如果要执行的已经释放会崩溃
    });

}
- (void)clickSingle
{
//    testSingle * test = [testSingle single];
//    NSLog(@"---%@",test);
//  dispatch_once 只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"init  Only one");
    });
}
- (void)clickGCD
{
//    dispatch_get_main_queue() && dispatch_get_global_queue(<#long identifier#>, <#unsigned long flags#>)
    NSLog(@"执行GCD");
//1.**********************
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        //耗时任务(存数据库/下载图片)
//        NSLog(@"start task 1");
//        [NSThread sleepForTimeInterval:3];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"刷新UI");
//
//        });
//    });
//2.**************************异步多线程（并发）,优先级只能保证谁先开始，不能保证谁先结束
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            //耗时任务(存数据库/下载图片)
//            NSLog(@"start task 1");
//            [NSThread sleepForTimeInterval:3];
//            NSLog(@"start task 1");
//
//        });
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        //耗时任务(存数据库/下载图片)
//        NSLog(@"start task 2");
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"start task 2");
//
//    });   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //耗时任务(存数据库/下载图片)
//        NSLog(@"start task 3");
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"start task 3");
//
//    });
//3.*************************在一个子线程（串行）执行，不是三个线程   第二个参数设为DISPATCH_QUEUE_SERIAL和NULL是一个意思
//    dispatch_queue_t queue = dispatch_queue_create("com.test.gcd.queue", NULL);
//    dispatch_async(queue, ^{
//        //耗时任务(存数据库/下载图片)
//        NSLog(@"start task 1");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 1");
//    });dispatch_async(queue, ^{
//        //耗时任务(存数据库/下载图片)
//        NSLog(@"start task 2");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 2");
//    });
//    dispatch_async(queue, ^{
//        //耗时任务(存数据库/下载图片)
//        NSLog(@"start task 3");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 3");
//    });
//4.*************************在三个线程，有序执行（并发）
//    dispatch_queue_t queue = dispatch_queue_create("com.test.gcd.queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        //耗时任务(存数据库/下载图片)
//        NSLog(@"start task 1");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 1");
//    });dispatch_async(queue, ^{
//        //耗时任务(存数据库/下载图片)
//        NSLog(@"start task 2");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 2");
//    });
//    dispatch_async(queue, ^{
//        //耗时任务(存数据库/下载图片)
//        NSLog(@"start task 3");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 3");
//    });
//    //5.*************************多个异步任务完成后，回调   DISPATCH_QUEUE_CONCURRENT:创建并行的queue
//
//   dispatch_queue_t queue = dispatch_queue_create("com.test.gcd.queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"start task 1");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 1");
//
//    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"start task 2");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 2");
//
//    });dispatch_group_async(group, queue, ^{
//        NSLog(@"start task 3");
//        [NSThread sleepForTimeInterval:2];
//        NSLog(@"end task 3");
//
//    });
//    dispatch_group_notify(group, queue, ^{
//        //3个线程中,首先完成的一个线程中输出
//        NSLog(@"all task over");
//        //回到主线程刷新UI
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"回到主线程刷新UI");
//        });
//    });
//
    
    
//    //6.*************************模拟请求
//
//    dispatch_queue_t queue = dispatch_queue_create("com.test.gcd.queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, queue, ^{
//        //因为这个请求时异步的，所以瞬间就 queue 就走完了
//        [self sendRequest1:^{
//            NSLog(@"Request1 done");
//
//        }];
//
//    });
//    dispatch_group_async(group, queue, ^{
//        [self sendRequest2:^{
//            NSLog(@"Request2 done");
//
//        }];
//
//
//    });
////    dispatch_group_async(group, queue, ^{
////        NSLog(@"start task 3");
////        [NSThread sleepForTimeInterval:2];
////        NSLog(@"end task 3");
////
////    });
//    dispatch_group_notify(group, queue, ^{
//        //3个线程中,首先完成的一个线程中输出
//        NSLog(@"all task over");
//        //回到主线程刷新UI
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"回到主线程刷新UI");
//        });
//    });
//
    //7.*************************模拟请求，达到了异步请求完成后统一回调
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.gcd.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    //dispatch_group_enter和dispatch_group_leave成对出现
    dispatch_group_enter(group);
    [self sendRequest1:^{
        NSLog(@"Request1 done");
        dispatch_group_leave(group);
    }];
    
    //dispatch_group_enter和dispatch_group_leave成对出现
    dispatch_group_enter(group);
    [self sendRequest2:^{
        NSLog(@"Request2 done");
        dispatch_group_leave(group);
    }];
    
    
  
    dispatch_group_notify(group, queue, ^{
        //3个线程中,首先完成的一个线程中输出
        NSLog(@"all task over");
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回到主线程刷新UI");
        });
    });
    
}
//模拟发请求
- (void)sendRequest1:(void(^)())block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //耗时任务(存数据库/下载图片)
        NSLog(@"start task 1");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"end task 1");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
        
    });
}
- (void)sendRequest2:(void(^)())block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //耗时任务(存数据库/下载图片)
        NSLog(@"start task 2");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"end task 2");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block();
            }
        });
        
    });
}
- (void)clickNSThread
{
    NSLog(@"主线程-NSThread");
    //1.通过alloc init的方法创建并执行线程
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(runThread1) object:nil];
    thread1.name = @"name_thread1";
    [thread1 setThreadPriority:0.2];
    [thread1 start];
    
    NSThread *thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(runThread1) object:nil];
    thread2.name = @"name_thread2";
    //优先级高只是优先执行，并不一定保证先完成
    [thread1 setThreadPriority:0.4];

    [thread2 start];
    //2.通过detachNewThreadSelector的方法创建并执行线程
//    [NSThread detachNewThreadSelector:@selector(runThread1) toTarget:self withObject:nil];
    //3.通过InBackground
//    [self performSelectorInBackground:@selector(runThread1) withObject:nil];
}
- (void)runThread1
{
    NSLog(@"%@.子线程-NSThread",[NSThread currentThread].name);

    for (int i = 0; i<10; i++)
    {
        NSLog(@"%d",i);
        sleep(1);
        if (i == 9) {
            [self performSelectorOnMainThread:@selector(runOnMainThread) withObject:nil waitUntilDone:nil];
        }
    }
}

- (void)textTest
{
    NSLog(@"git测试");

}
- (void)textTest1
{
    NSLog(@"git测试1");
    
}
- (void)runOnMainThread
{
    NSLog(@"回到主线程");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
