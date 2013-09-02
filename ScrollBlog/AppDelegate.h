
#import <UIKit/UIKit.h>
 #import <StoreKit/StoreKit.h>
#import "PPRevealSideViewController.h"
#import "MBProgressHUD.h"
#import "RXMLElement.h"
#import "GADBannerView.h"
#import "GADInterstitial.h"
#import "UIViewController+RECurtainViewController.h"
#import <sqlite3.h>

@class ViewController;
@class PPRevealSideViewController;
@class StartAnimationController;
@class MGScrollView,PhotoBox;
@interface AppDelegate : UIResponder <UIApplicationDelegate,PPRevealSideViewControllerDelegate,UIWebViewDelegate,MBProgressHUDDelegate,GADInterstitialDelegate,SKProductsRequestDelegate,SKPaymentTransactionObserver>
{
    NSMutableArray *recentPost;
    UILabel *loadMore;
    UIActivityIndicatorView *activityLoadMore;
    int current_page;
    int total_page;
    NSMutableArray *previous_total_per_page;
    int total_post_per_page;
    MGScrollView *currentScrollView;
   
    NSString *currentPostID;
    
    NSDictionary *afterLaunch;
   
    UINavigationController *root;
    
    MBProgressHUD *HUD;
    NSMutableArray *pageMenu;
    UIWebView *sharedWebView;
    NSString *methodJson;
    NSArray *scrollBlogSettings;
    BOOL homeIndcator;
    BOOL adIndicator;
    BOOL twitterIndicator;
    NSArray *twitter;
    NSString *globalPostCategory;
    GADBannerView *bannerView_;
    GADInterstitial *interstitial_;
    NSArray *inAppPurchaseArray;
    SKProduct *prods;
    bool enableLandscapeMode;
    NSString *pushedPostID;
    NSString *pushedType;
    
    sqlite3 *db;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) StartAnimationController *startController;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;
+ (AppDelegate *) instance;
-(void)startApp;
-(void)setLandscapeMode:(BOOL)enable;
-(NSMutableArray*)getRecentPostArray;
-(NSMutableArray*)getPreviTotalArray;

-(void)setUiLabelLoadMore:(UILabel*)label;
-(UILabel*)getUILabel;
-(void)noInternetConnectivityAlert;
-(void)setIndicatorView:(UIActivityIndicatorView*)ind;
-(UIActivityIndicatorView*)getIndicatorView;
-(void)checkConnectivity;
-(int)getTotalPage;
-(int)getCurrentPage;
-(int)get_total_post_per_page;
-(void)endlessRecentPostJson;
-(void)downloadRecentPostJson;
-(BOOL)hasFourInchDisplay;
-(void)anywhereSlide;
-(void)turnOffSlideAnywhereSlide;
-(void)pushLeftBtn;
-(NSString*)getURL;
-(NSString*)getCurrentPostID;
-(void)setCurrentPostID:(NSString*)pID;
-(BOOL)checkSaveFileExist;
-(NSMutableArray*)getPageMenuArray;
-(void)downloadPageMenu;
-(NSMutableArray*)getFileSave;
-(void)postCommentiPhone:(NSData*)postData;
-(void)setSharedWebView:(UIWebView*)shared;
-(void)setMethodUrl:(NSString*)method;
-(void)downloadScrollBlogSettings;
-(void)addIndicator:(BOOL)ind;
-(BOOL)getHomeIndicator;
-(NSString*)getCurrentMethodJson;
-(void)changeCategory:(NSString*)currentID categoryName:(NSString*)name;
-(void)setCurrentMGScrollView:(MGScrollView*)sc;
-(MGScrollView*)getCurrentScrollView;
-(void)goToPage:(NSString*)pageID categoryName:(NSString*)pageName;
-(void)goCustomWeb:(NSString*)link pName:(NSString*)pageName;
-(void)backToHome;
-(void)searchPost:(NSString*)searchString;
-(void)goToRss:(NSString*)link pName:(NSString*)pName;
-(void)goToClassificacao:(NSString*)link pName:(NSString*)pName;
-(void)goToFiltro:(NSString*)link pName:(NSString*)pName;
-(void)setDetailGoDetailType:(BOOL)is;
-(NSArray*)getSettingArray;
-(GADBannerView*)getAdmobBanner;
-(void)refreshAdMobBanner;
-(BOOL)getAdIndicator;
-(void)removeAdsFunction;
-(BOOL)checkPurchase;
-(NSArray*)inAppPurchaseArray;
-(void)readyToBuy;
-(void)retoreButton;
-(void)goToTwitterPage:(NSString*)link pName:(NSString*)pName;
-(void)changeViewControllerTitle:(NSString*)str;
-(void)setIndicatorTwitter:(BOOL)twiInd;
-(BOOL)getTweetIndi;
-(void)setTwitterArray:(NSArray*)ary;
-(NSArray*)getTwitterArray;
-(void)endlessRecentTwitterJson;
-(void)MapControllerRe:(NSArray*)ary;
-(void)defaultViewController;
-(void)changeMapControllerLoad:(NSString*)str;
-(NSArray*)downloadAllMapData:(NSString*)query;
-(void)backTodefaultController;
-(void)getPostByID:(NSString*)ID;
-(NSArray*)findNearestMe:(NSString*)query;
-(void)setGlobalCategory:(NSString*)cat;
-(NSString*)getGlobalCategory;
-(void)goToPost:(NSString*)postID;

-(void)goToContactUsTemplate:(NSArray*)ary;

@end
