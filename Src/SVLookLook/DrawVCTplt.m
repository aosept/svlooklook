





#import "DrawVCTplt.h"

@interface DrawVCTplt ()

@end

@implementation DrawVCTplt

-(SVDrawView*)drawView
{
    if (_drawView == nil) {
        _drawView = [SVDrawView new];
        _drawView.backgroundColor = [UIColor whiteColor];
//        _drawView.numberOfLines=0;
        _drawView.layer.borderWidth = 0;
        _drawView.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return _drawView;
}


-(SVPaintView*)graphView
{
    if (_graphView == nil) {
        _graphView = [SVPaintView new];
        _graphView.backgroundColor = [UIColor whiteColor];
//        _graphView.numberOfLines=0;
        _graphView.layer.borderWidth = 0;
        _graphView.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return _graphView;
}


-(UIButton*)resetButton
{
    if (_resetButton == nil) {
        _resetButton = [self buildButtonWith:@"resetButton" andAction:@selector(buttonDidClicked:)];
    }
    return _resetButton;
}

-(UIButton*)v5Button
{
    if (_v5Button == nil) {
        _v5Button = [self buildButtonWith:@"v5Button" andAction:@selector(buttonDidClicked:)];
    }
    return _v5Button;
}

-(UIButton*)undoButton
{
    if (_undoButton == nil) {
        _undoButton = [self buildButtonWith:@"undoButton" andAction:@selector(buttonDidClicked:)];
    }
    return _undoButton;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    
    [self.view addSubview:self.graphView];
    
    [self.view addSubview:self.drawView];
    
    [self.view addSubview:self.resetButton];
    
    [self.view addSubview:self.v5Button];
    
    [self.view addSubview:self.undoButton];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat rate = [self rateOfwidth];
    if(rate == 0)
    {
        rate = [self screenW]/667.0;
    }
    
    self.drawView.backgroundColor = [UIColor clearColor];
    
    self.graphView.backgroundColor = [UIColor whiteColor];
    
    self.resetButton.backgroundColor = [UIColor lightGrayColor];
    
    [self.resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    
    self.v5Button.backgroundColor = [UIColor lightGrayColor];
    
    [self.v5Button setTitle:@"去蓝线" forState:UIControlStateNormal];
    
    self.undoButton.backgroundColor = [UIColor lightGrayColor];
    
    [self.undoButton setTitle:@"undo" forState:UIControlStateNormal];
    
}

-(void)viewDidLayoutSubviews
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
        fixTop = self.view.safeAreaInsets.top;//remove this line if has error
    } else {
        fixTop = 0;
    }
    if (@available(iOS 11.0, *)) {
        fixLeft = self.view.safeAreaInsets.left;//remove this line if has error
    } else {
        fixLeft = 0;
    }
    left += fixLeft;
    top += fixTop;
    top += offsetY;
    
    CGFloat    graphView_Width = 375.00*rate;
    CGFloat    graphView_Height = 300.00*rateH;
    CGFloat    drawView_xInterval = 0.00*rate;
    CGFloat    resetButton_xInterval = 18.00*rate;
    CGFloat    resetButton_yInterval = 10.00*rateH;
    CGFloat    resetButton_Width = 73.90*rate;
    CGFloat    resetButton_Height = 23.90*rateH;
    CGFloat    v5Button_xInterval = 10.00*rate;
    CGFloat    undoButton_xInterval = 10.00*rate;
    
    x =  left;
    y =  top;
    w = graphView_Width;
    h = graphView_Height;
    self.graphView.frame = CGRectMake(x, y, w, h);
    
    xInterval = drawView_xInterval;
    x =  left + xInterval;
    y =  top;
    self.drawView.frame = CGRectMake(x, y, w, h);
    
    yInterval = resetButton_yInterval;
    xInterval = resetButton_xInterval;
    x =  left + xInterval;
    y =  y + h + yInterval;
    w = resetButton_Width;
    h = resetButton_Height;
    self.resetButton.frame = CGRectMake(x, y, w, h);
    
    xInterval = v5Button_xInterval;
    x =  x + w + xInterval;
    self.v5Button.frame = CGRectMake(x, y, w, h);
    
    xInterval = undoButton_xInterval;
    x =  x + w + xInterval;
    self.undoButton.frame = CGRectMake(x, y, w, h);
    
}
-(void)buttonDidClicked:(UIButton*)button

{
    
    if(button == self.resetButton)
    {
        NSLog(@"self.resetButton is clicked");
        [self resetButtonClicked];
        
        if([self.delegate respondsToSelector:@selector(buttonOfDrawVCTplt:DidClickedWithName:)])
        {
            [self.delegate buttonOfDrawVCTplt:self DidClickedWithName:@"resetButton"];
        }
        else
        {
            NSLog(@"Method buttonOfDrawVCTplt:self DidClickedWithName: not implemented");
        }
    }
    
    if(button == self.v5Button)
    {
        NSLog(@"self.v5Button is clicked");
        [self v5ButtonClicked];
        
        if([self.delegate respondsToSelector:@selector(buttonOfDrawVCTplt:DidClickedWithName:)])
        {
            [self.delegate buttonOfDrawVCTplt:self DidClickedWithName:@"v5Button"];
        }
        else
        {
            NSLog(@"Method buttonOfDrawVCTplt:self DidClickedWithName: not implemented");
        }
    }
    
    if(button == self.undoButton)
    {
        NSLog(@"self.undoButton is clicked");
        [self undoButtonClicked];
        
        if([self.delegate respondsToSelector:@selector(buttonOfDrawVCTplt:DidClickedWithName:)])
        {
            [self.delegate buttonOfDrawVCTplt:self DidClickedWithName:@"undoButton"];
        }
        else
        {
            NSLog(@"Method buttonOfDrawVCTplt:self DidClickedWithName: not implemented");
        }
    }
    
}

-(void)resetButtonClicked
{
    
    NSLog(@"self.resetButton is clicked");
}

-(void)v5ButtonClicked
{
    
    NSLog(@"self.v5Button is clicked");
}

-(void)undoButtonClicked
{
    
    NSLog(@"self.undoButton is clicked");
}

-(void)refreshFromDiction:(NSDictionary*)dic
{
    
    /*
     
     */
    if(dic)
    {
        
    }
}

-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyBoardHieght=keyBoardRect.size.height;
    
    
}

-(void)keyboardHide:(NSNotification *)note
{
    keyBoardHieght = 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIButton*)buildButtonWith:(NSString*)title andAction:(SEL)action
{
    UIButton * button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 1.0;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.9 green:0.7 blue:0.8 alpha:1.0] forState:UIControlStateHighlighted];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    return button;
}


-(CGFloat)screenH
{
    
    if (self.view.bounds.size.width < self.view.bounds.size.height) {
        return self.view.bounds.size.height;
    }
    else
    return self.view.bounds.size.width;
}

-(CGFloat)screenW
{
    
    if (self.view.bounds.size.width < self.view.bounds.size.height) {
        return self.view.bounds.size.width;
    }
    else
    return self.view.bounds.size.height;
}
-(CGFloat)rateOfwidth
{
    CGFloat rate = self.view.bounds.size.width/375.0;
    return rate;
}
-(CGFloat)rateOfHeight
{
    CGFloat rate = self.view.bounds.size.height/667.0;
    return rate;
}
-(BOOL)islandScape
{
    if (self.view.bounds.size.width < self.view.bounds.size.height) {
        return NO;
    }
    else
    return YES;
}
@end















//the
