
#import <UIKit/UIKit.h>


@class SVDrawView;
@protocol SVDrawViewDelegate <NSObject>

-(void)updateSVDrawView:(SVDrawView*)vc WithDic:(NSDictionary*)dic;


@end
@interface SVDrawView : UIView
{
    CGFloat offsetY;
    CGFloat keyBoardHieght;
}
@property (nonatomic,weak) id <SVDrawViewDelegate> delegate;
@property (nonatomic,strong) NSArray* pointList;
-(void)refreshFromDiction:(NSDictionary*)dic;
-(NSDictionary*)configSetting;
@end
