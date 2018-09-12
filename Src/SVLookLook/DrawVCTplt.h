
#import <UIKit/UIKit.h>
#import "SVDrawView.h"


#import "SVPaintView.h"


@class DrawVCTplt;
@protocol DrawVCTpltDelegate <NSObject>

-(void)updateDrawVCTplt:(DrawVCTplt*)vc WithDic:(NSDictionary*)dic;


-(void)buttonOfDrawVCTplt:(DrawVCTplt*)vc DidClickedWithName:(NSString*)name;

@end
@interface DrawVCTplt : UIViewController
{
    CGFloat offsetY;
    CGFloat keyBoardHieght;
}
@property (nonatomic,weak) id <DrawVCTpltDelegate> delegate;

@property (nonatomic,strong) SVDrawView * drawView;

@property (nonatomic,strong) SVPaintView * graphView;

@property (nonatomic,strong) UIButton * resetButton;

@property (nonatomic,strong) UIButton * undoButton;

@property (nonatomic,strong) UIButton * v5Button;
-(void)refreshFromDiction:(NSDictionary*)dic;
-(NSDictionary*)configSetting;
@end

