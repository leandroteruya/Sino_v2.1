#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <UIKit/UIKit.h>

@interface iPhoneLoginController : UIViewController
{
    CGPoint svos;
    bool init;
    UIBarButtonItem *postBtn;
    NSMutableArray *tempStringArray;
    sqlite3 *db;
}
//- (NSMutableArray *) getMyWines;

@property(weak, nonatomic) IBOutlet UITextField *name;
@property(weak, nonatomic) IBOutlet UITextField *password;
@property(weak, nonatomic) IBOutlet UIScrollView *backScroll;
@property(weak, nonatomic) IBOutlet UIButton *restoreBtn;
@property(weak, nonatomic) IBOutlet UIButton *saveInfo;
@property (nonatomic, retain) NSString *editedFieldKey;
@property(weak, nonatomic) IBOutlet UIButton *removeAds;
@property(weak, nonatomic) IBOutlet UIButton *subscribe;
@property(weak, nonatomic) IBOutlet UISwitch *Switch;

//-(void)getSaveArray;
-(IBAction)save:(id)sender;
/*-(IBAction)subscribe:(id)sender;
-(IBAction)removeAds:(id)sender;
-(IBAction)restoreBtn:(id)sender;*/
@end