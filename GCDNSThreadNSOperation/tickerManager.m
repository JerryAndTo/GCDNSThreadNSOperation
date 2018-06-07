//
//  tickerManager.m
//  GCDNSThreadNSOperation
//
//  Created by ZYQ on 2018/6/4.
//  Copyright © 2018年 eilsel. All rights reserved.
//

#import "tickerManager.h"
#define total  50
@interface tickerManager()
@property int tickets;   //剩余票数
@property int saleCount;   //卖出票数
@property (nonatomic, strong) NSThread *threadBJ;
@property (nonatomic, strong) NSThread *threadSH;
@property (nonatomic, strong) NSCondition *ticketCondition;
@end

@implementation tickerManager

- (instancetype)init
{
    if (self = [super init]) {
        self.tickets = total;
        self.threadBJ = [[NSThread alloc]initWithTarget:self selector:@selector(sale) object:nil];
        self.threadSH = [[NSThread alloc]initWithTarget:self selector:@selector(sale) object:nil];
        self.threadSH.name = @"sahgnhai_thread";
        self.threadBJ.name = @"beijing_thread";
        
        self.ticketCondition = [[NSCondition alloc]init];

    }
    return self;
}

- (void)sale{
    
    
    
    while (true) {
        //2.加锁ticketCondition
        [self.ticketCondition lock];
        //1.加锁 synchronized
//        @synchronized(self){
        
        if (self.tickets > 0) {
            [NSThread sleepForTimeInterval:0.5];
            self.tickets -- ;
            self.saleCount = total - self.tickets;
            NSLog(@"%@  剩余票数 : %d  卖出:%d",[NSThread currentThread].name,self.tickets,self.saleCount);
        }
//        }
        [self.ticketCondition unlock];

    }
}
- (void)startToSale
{
    [self.threadBJ start];
    [self.threadSH start];

}
@end
