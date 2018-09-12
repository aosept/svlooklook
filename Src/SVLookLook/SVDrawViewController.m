//
//  SVDrawViewController.m
//  MLPractice
//
//  Created by 威 沈 on 10/07/2018.
//  Copyright © 2018 ShenWei. All rights reserved.
//

#import "SVDrawViewController.h"
#import "MSDateUtils.h"
#include <math.h>

@interface SVDrawViewController ()<SVDrawViewDelegate>
{
    __block CGFloat oldRate;
    __block CGFloat deltaR;
}
@property (nonatomic,strong) NSArray* currentDataList;
@property (nonatomic,strong) NSArray* oldDataList;
@property (nonatomic,strong) NSArray* oldlineList;
@end

@implementation SVDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.drawView.backgroundColor = [UIColor clearColor];
    self.graphView.backgroundColor = [UIColor whiteColor];
    self.drawView.delegate = self;
    self.oldlineList = @[];
    oldRate = 0;
//    self.graphView.style = SVFunctionGraphStyleByDataList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateSVDrawView:(SVDrawView *)vc WithDic:(NSDictionary *)dic
{
    NSArray* list = dic[@"data"];
    NSString* state = dic[@"state"];
    if(list.count < 1)
        return;
    
    if([state isEqualToString:@"begin"])
    {
        self.oldDataList = self.graphView.dataList;
        if(self.oldDataList == nil)
        {
            self.oldDataList = @[];
            
        }
        self.graphView.dataList = [self.oldDataList arrayByAddingObject:list];
    }
    else if([state isEqualToString:@"move"])
    {
       
        if(self.oldDataList == nil)
        {
            self.oldDataList = @[];
            
        }
        self.graphView.dataList = [self.oldDataList arrayByAddingObject:list];
        
        
        
        if(list.count > 2)//拐弯
        {
            NSDictionary* olddic = list.lastObject;
            NSDictionary* curDic = list[list.count -2];
            
            CGFloat x1,y1;
            x1 = [olddic[@"x"] floatValue];
            y1 = [olddic[@"y"] floatValue];
            
            CGFloat x2,y2;
            x2 = [curDic[@"x"] floatValue];
            y2 = [curDic[@"y"] floatValue];
            CGFloat ratev;
            if(x2 !=x1)
            {
                ratev =  (y2-y1)/(x2-x1);
                ratev = atan(ratev);
                if(list.count > 2)
                {
                    deltaR = oldRate - ratev;
                    NSLog(@"delta:      %.4f,   %.4f",deltaR,ratev);
                }
                oldRate = ratev;
                
//                if(deltaR > 1)
//                {
////                    self->oldRate = 0;
//                    self.oldDataList = self.graphView.dataList;
//                    if(self.oldDataList == nil)
//                    {
//                        self.oldDataList = @[];
//                        
//                    }
//                    [self leastSquares:list];
//                    self.drawView.pointList = @[];
//                }
               
            }
            
        }
    
        
        
    }
    else if([state isEqualToString:@"end"])
    {
        
        if(self.oldDataList == nil)
        {
            self.oldDataList = @[];
            
        }
        self.graphView.dataList = [self.oldDataList arrayByAddingObject:list];
        
        
        
        [self leastSquares:list];
    }
    
//    self.graphView.dataList = @[];
    
    runOnMainQueueWithoutDeadlocking(^{
        [self.graphView setNeedsDisplay];
    });
    
}
-(void)calculateOVer:(NSDictionary*)dic
{
    return;
}
-(void)leastSquares:(NSArray*)dataArray
{
    if(dataArray.count < 1)
    {
        return;
    }
    __weak __typeof__(self) weakSelf = self;
    __strong __typeof(weakSelf)strongSelf = weakSelf;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary* resultDic = [NSMutableDictionary new];
        CGFloat a0,a1;
        CGFloat ex,ey,totalx,totaly;
        NSInteger n;
        
        CGFloat totalx2,totaly2;
        CGFloat totalxy;
        totalx = 0;
        totaly = 0;
        totalx2 = 0;
        totaly2 = 0;
        totalxy = 0;
        n  = dataArray.count;
        
        CGFloat minx = FLT_MAX;
        CGFloat maxx = FLT_MIN;
        
        CGFloat miny = FLT_MAX;
        CGFloat maxy = FLT_MIN;
        for (NSDictionary* dic in dataArray) {
            if([dic isKindOfClass:[NSDictionary class]] == YES)
            {
                CGFloat x,y;
                x = [dic[@"x"] floatValue];
                y = [dic[@"y"] floatValue];
                
                totalxy += x*y;
                totaly += y;
                totalx += x;
                totaly2  += y*y;
                totalx2  += x*x;
                minx = MIN(minx, x);
                maxx = MAX(maxx, x);
                
                miny = MIN(miny, y);
                maxy = MAX(maxy, y);
            }
            
            ex = totalx/n;
            ey = totaly/n;
            
        }
        CGFloat up = (n*totalxy - totalx*totaly);
        CGFloat down = (n*totalx2 - totalx*totalx);
        a1 = up/down;
        a0 = totaly/n - a1*(totalx/n);
        
        
//        if(fabs(a1)<1)
//        {
//            a1 = 0;
//        }
//        else
//        {
//            a1 = 1;
//        }
        CGFloat y1 = a0 + a1*minx;
        CGFloat y2 = a0 + a1*maxx;
        CGFloat x1 = (miny -a0)/a1;
        CGFloat x2 = (maxy -a0)/a1;
        
        
//        if(a1 ==1)
//        {
//            y1 = miny;
//            y2 = maxy;
//        }
//        y1 = miny;
//        y2 = maxy;
        NSArray* lineArray = @[];
//        resultDic[@"a1"] = [NSNumber numberWithDouble:a1];
//        resultDic[@"a0"] = [NSNumber numberWithDouble:a0];
//        resultDic[@"x"] = [NSNumber numberWithDouble:minx];
//        resultDic[@"y"] = [NSNumber numberWithDouble:y1];
        
        if(fabs(a1)<1)
        {
            lineArray = [lineArray arrayByAddingObject:@{@"x":[NSNumber numberWithDouble:minx],
                                                         @"y":[NSNumber numberWithDouble:y1],
                                                         }];
            
            lineArray = [lineArray arrayByAddingObject:@{@"x":[NSNumber numberWithDouble:maxx],
                                                         @"y":[NSNumber numberWithDouble:y2],
                                                         }];
            
        }
        else
        {
            lineArray = [lineArray arrayByAddingObject:@{@"x":[NSNumber numberWithDouble:x1],
                                                         @"y":[NSNumber numberWithDouble:miny],
                                                         }];
            
            lineArray = [lineArray arrayByAddingObject:@{@"x":[NSNumber numberWithDouble:x2],
                                                         @"y":[NSNumber numberWithDouble:maxy],
                                                         }];
        }
        self.oldlineList = [self.oldlineList arrayByAddingObject:lineArray];
        weakSelf.graphView.lineList = self.oldlineList;
        runOnMainQueueWithoutDeadlocking(^{
            [weakSelf.graphView setNeedsDisplay];
        });
    });

}
-(void)resetButtonClicked
{
    self.graphView.dataList = @[];
    
    runOnMainQueueWithoutDeadlocking(^{
        [self.graphView setNeedsDisplay];
    });
    NSLog(@"self.resetButton is clicked");
}
-(void)undoButtonClicked
{
    
    if(self.graphView.dataList.count <= 1)
    {
        self.graphView.dataList = @[];
        self.graphView.lineList = @[];
        self.oldlineList = @[];
    }
    else
    {
        NSRange range = NSMakeRange(0, self.graphView.dataList.count -1);
        self.graphView.dataList = [self.graphView.dataList subarrayWithRange:range];
        
        if(self.graphView.lineList.count >= 1)
        {
            range = NSMakeRange(0, self.graphView.lineList.count -1);
            self.graphView.lineList = [self.graphView.lineList subarrayWithRange:range];
            range = NSMakeRange(0, self.oldlineList.count -1);
            self.oldlineList = [self.oldlineList subarrayWithRange:range];
        }
        
        
        
        
        
        
    }
    
    
    runOnMainQueueWithoutDeadlocking(^{
        [self.graphView setNeedsDisplay];
    });
//    NSLog(@"self.resetButton is clicked");
//    NSLog(@"self.undoButton is clicked");
}

-(void)v5ButtonClicked
{
    
 
    self.graphView.lineList = @[];
    self.oldlineList = @[];
       
   
    runOnMainQueueWithoutDeadlocking(^{
        [self.graphView setNeedsDisplay];
    });
//    NSLog(@"self.resetButton is clicked");
//    NSLog(@"self.v5Button is clicked");
}
@end
