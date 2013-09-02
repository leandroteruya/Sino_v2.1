
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface PushToLeftViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    NSMutableArray *tableData;
    BOOL showODRefresh;
    
      BOOL mapIndicator;
}
@property(nonatomic,retain) IBOutlet UITableView *tableViews;
@property(nonatomic,retain) IBOutlet UISearchBar *searchBars;
-(void)setShowODRefresh:(BOOL)arg;
-(void)setTableData:(NSMutableArray*)array;
@end
