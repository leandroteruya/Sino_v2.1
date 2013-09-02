
#import "iPhoneWebView.h"

@interface iPhoneWebView ()<UIWebViewDelegate>

@end

@implementation iPhoneWebView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
     
    
    UIBarButtonItem *safari = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"inappwebview_safari_button", nil)
 style:UIBarButtonItemStyleDone target:self action:@selector(gotosafari)];
    self.navigationItem.rightBarButtonItem = safari;
}


-(void)gotosafari{
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"Open In Safari : %@",urls);
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urls]];
}

-(void)loadUrlInWebView:(NSString*)url{
    NSLog(@"Open Url : %@",url);
    urls = url;
    CGRect webFrame;
    
    if([[AppDelegate instance] getAdIndicator] == NO)
    {
        if([[AppDelegate instance] hasFourInchDisplay])
        {
            webFrame = CGRectMake(0.0, 0.0, 320, 503);
        }
        else
        {
            webFrame = CGRectMake(0.0, 0.0, 320, 415);
        }
        
    }
    else
    {
        if([[AppDelegate instance] hasFourInchDisplay])
        {
            webFrame = CGRectMake(0.0, 49, 320, 503-49);
        }
        else
        {
            webFrame = CGRectMake(0.0, 49, 320, 415-49);
        }
    }
    webViewSe = [[UIWebView alloc] initWithFrame:webFrame];
    
    webViewSe.delegate = self;
    webViewSe.scalesPageToFit = YES;
    
    NSString *urlAddress = url;
    urls = url;
    NSURL *urlss = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:urlss];
    [webViewSe loadRequest:requestObj];
    
    [self.view addSubview:webViewSe];
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.title = NSLocalizedString(@"inappwebview_loading", nil)
;
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.title = NSLocalizedString(@"inappwebview_done", nil);
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

-(BOOL)shouldAutorotate{
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
