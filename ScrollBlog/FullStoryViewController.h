

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
#import <MessageUI/MessageUI.h>
#import "MapViewController.h"
#import "EGOPhotoGlobal.h"
#import "MyPhoto.h"
#import "MyPhotoSource.h"
@interface FullStoryViewController : UIViewController<UIWebViewDelegate,HPGrowingTextViewDelegate,UIActionSheetDelegate,MFMailComposeViewControllerDelegate>
{
    UIWebView *tempWebView ;
    
    UIView *containerView;
    HPGrowingTextView *textView;
    BOOL showComment;
    NSString *pUrl;
    NSArray *specialBtnArray;
    NSArray *gallery;
  
}

-(void)insertData:(NSArray*)array;
-(void)setShowCommment:(BOOL)arg;
-(void)resignTextView;
@end
