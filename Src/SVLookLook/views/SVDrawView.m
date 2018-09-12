





#import "SVDrawView.h"

@interface SVDrawView ()
{
    CGPoint beginPoint;
    CGPoint endPoint;
    CGPoint touchPoint;
    
}

@end

@implementation SVDrawView
-(NSArray*)pointList
{
    if(_pointList == nil)
    {
        _pointList = @[];
    }
    return _pointList;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self];
    self.pointList = @[];
    self.pointList = [self.pointList arrayByAddingObject:@{@"x":[NSNumber numberWithDouble:p.x],
                                                           @"y":[NSNumber numberWithDouble:p.y],
                                                           }];
//    NSLog(@"%@",self.pointList);
    [self reportPointList:@"begin"];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    CGPoint p = [[touches anyObject] locationInView:self];
   
    self.pointList = [self.pointList arrayByAddingObject:@{@"x":[NSNumber numberWithDouble:p.x],
                                                           @"y":[NSNumber numberWithDouble:p.y],
                                                           }];
//    NSLog(@"%@",self.pointList);
    [self reportPointList:@"move"];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    CGPoint p = [[touches anyObject] locationInView:self];
    self.pointList = [self.pointList arrayByAddingObject:@{@"x":[NSNumber numberWithDouble:p.x],
                                                           @"y":[NSNumber numberWithDouble:p.y],
                                                           }];
//    NSLog(@"%@",self.pointList);
    [self reportPointList:@"end"];
}
-(void)reportPointList:(NSString*)state
{
    if(state == nil)
    {
        NSLog(@"Error parameter state.");
        return;

    }
    
    if([self.delegate respondsToSelector:@selector(updateSVDrawView:WithDic:)])
    {
        [self.delegate updateSVDrawView:self WithDic:@{@"data":self.pointList,
                                                       @"state":state,
                                                       }];
    }
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self];
    self.pointList = [self.pointList arrayByAddingObject:@{@"x":[NSNumber numberWithDouble:p.x],
                                                           @"y":[NSNumber numberWithDouble:p.y],
                                                           }];
//    NSLog(@"%@",self.pointList);
    self.pointList = @[];
}

#pragma mark -
- (void)addAllViews
{
    
    CGFloat rate = [self rateOfwidth];
    if(rate == 0)
    {
        rate = [self screenW]/667.0;
    }
   
}

-(void)layoutSubviews
{
    CGFloat left,top;
    CGFloat x,y,w,h;
    CGFloat rate = [self rateOfwidth];
    CGFloat rateH = [self rateOfHeight];
    CGFloat xInterval = 10.0,yInterval = 10.0;
    left = 0.00*rate;
    top = 0.00;
    CGFloat sw = [self screenW];
    CGFloat wr = sw/375.0;
    CGFloat wh = [self screenH];
    CGFloat nomalR = wh - 667.0*wr;
    CGFloat fixTop = 0;
    CGFloat fixLeft = 0;
    if (@available(iOS 11.0, *)) {
        fixTop = self.safeAreaInsets.top;//remove this line if has error
    } else {
        fixTop = 0;
    }
    if (@available(iOS 11.0, *)) {
        fixLeft = self.safeAreaInsets.left;//remove this line if has error
    } else {
        fixLeft = 0;
    }
    left += fixLeft;
    top += fixTop;
    top += offsetY;
    
    
}
-(void)buttonDidClicked:(UIButton*)button

{
    
}

-(void)refreshFromDiction:(NSDictionary*)dic
{
    
    /*
     
     */
    if(dic)
    {
        
    }
}


-(UIButton*)buildButtonWith:(NSString*)title andAction:(SEL)action
{
    UIButton * button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 0.0;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.9 green:0.7 blue:0.8 alpha:1.0] forState:UIControlStateHighlighted];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    return button;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        [self addAllViews];
    }
    return self;
}
-(CGFloat)screenH
{
    
    if ([UIScreen mainScreen].bounds.size.width < [UIScreen mainScreen].bounds.size.height) {
        return self.frame.size.height;
    }
    else
    return self.frame.size.width;
}

-(CGFloat)screenW
{
    if (self.frame.size.width < self.frame.size.height)
    {
        return self.frame.size.height;
    }
    else
    return self.frame.size.width;
    
}
-(CGFloat)rateOfwidth
{
    CGFloat rate = self.frame.size.width/375.0;
    if(rate == 0)
    rate = [UIScreen mainScreen].bounds.size.width/375.0;
    
    return rate;
}
-(CGFloat)rateOfHeight
{
    CGFloat rate = [UIScreen mainScreen].bounds.size.height/667.0;
    return rate;
}
-(BOOL)islandScape
{
    return NO;
}

-(NSDictionary*)configSetting
{
    NSDictionary * dic = @{
                           };
    return dic;
}
@end










//the end

