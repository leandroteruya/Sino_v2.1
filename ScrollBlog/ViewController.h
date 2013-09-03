#import <UIKit/UIKit.h>
//#import "iPhoneLoginController.h"
@class MGScrollView,PhotoBox,MapViewController,mapViewViewController;
@interface ViewController : UIViewController<UIScrollViewDelegate>
{
    MGScrollView *scroller;
    float currentScrollHeight;
    float fixedHeight;
    int currentOldPost;
    BOOL useWebBrowserAsDetail;
    UIBarButtonItem *rightBar;
    MapViewController *map;
    mapViewViewController *mapGroup;
    
    /*FILTRO DATA*/
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UILabel *datelabel;
    IBOutlet UILabel *datelabeltipo;
    IBOutlet UIButton *btn_buscar;
    
    /*FILTRO DATA TIPO*/
    UIPickerView *dateTipoPicker;
    NSMutableArray *pickerDataTipo;
    
    /*SQL LITE*/
    sqlite3 *db;
    
    NSMutableArray *recentPost;
    NSMutableArray *previous_total_per_page;
    int current_page;
    int total_page;
}
-(void)refreshLayout;
-(void)refreshLayoutFiltro;
-(void)goToTop;
-(void)setGoDetailType:(BOOL)type;
-(void)showHideRightBar:(BOOL)show;
-(void)backToOrginScroller;
-(void)changeToMapController:(NSArray*)ary;
-(void)changeToDefaultViewController;

/*FILTRO DATA*/
@property(nonatomic,retain) UIDatePicker *datePicker;
@property(nonatomic,retain) IBOutlet UILabel *datelabel;
@property(nonatomic,retain) IBOutlet UILabel *datelabeltipo;

/*FILTRO DATA TIPO*/
@property (nonatomic, retain) UIPickerView *dateTipoPicker;
@property (nonatomic, retain)  NSArray *pickerDataTipo;



@end