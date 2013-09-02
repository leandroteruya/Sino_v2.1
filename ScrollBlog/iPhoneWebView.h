

#import <UIKit/UIKit.h>

@interface iPhoneWebView : UIViewController
{
    UIWebView *webViewSe;
    NSString *urls;
}
-(void)loadUrlInWebView:(NSString*)url;
@end
