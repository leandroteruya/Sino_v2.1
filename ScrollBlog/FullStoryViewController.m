

#import "FullStoryViewController.h"
#import "iPhoneLoginController.h"
#import "iPhoneWebView.h"
@interface FullStoryViewController ()

@end

@implementation FullStoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)insertData:(NSArray*)array{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification 
                                               object:nil];
    
   tempWebView = [[UIWebView alloc] init];
    
    pUrl = [array objectAtIndex:7];
    
   // tempWebView.delegate = self;
    [[AppDelegate instance] setCurrentPostID:[array objectAtIndex:5]];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    tempWebView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: NSLocalizedString(@"background_images", nil)]];
    tempWebView.delegate = self;
   
    
    gallery = [[array objectAtIndex:8] objectAtIndex:5];
    
   
    
    
    for(UIView *wview in [[[tempWebView subviews] objectAtIndex:0] subviews]) {
        if([wview isKindOfClass:[UIImageView class]]) { wview.hidden = YES; }
    }
    NSLog(@"%@",[array objectAtIndex:2]);
    if([[array objectAtIndex:2] isEqualToString:@"0"])
    {
        if(showComment == YES)
        {
        [tempWebView loadHTMLString:[NSString stringWithFormat:@"<link rel='stylesheet' href='%@/wp-content/plugins/scrollblog/js/couraselcss.css' /><script src='http://code.jquery.com/jquery-1.9.0.min.js'></script><script src='%@/wp-content/plugins/scrollblog/js/jquery.touchcarousel-1.1.min.js'></script> <style> img{ width:100%%; height:auto; } iframe{ width:100%%; height:auto; } object{ width:100%%; height:auto; } hr.embosed { width:100%%; height:0; color:none; background:none; border:none; border-top:0.5px solid #555555; border-bottom:1px solid #d3d3d3; }</style><body background='%@' style='padding:0; margin:0px;  font-family:HelveticaNeue;'> <div style='padding:8px; '> <div style='background-color:#f0f0f2; border-radius: 4px; box-shadow: 0 0 3px #000;'> <div style='font-size:18px;font-weight:bold;padding:10px;'> %@ </div> <div style='padding:10px;font-size:12px; margin-top:-15px;'> %@ </div>  <div id='get_post_gallery'></div> <div style='padding:10px;font-size:12px; margin-top:-20px;'> %@ </div> <div id='commentsContainer' style='background-color: #C8C8C8;border-bottom-right-radius:4px;border-bottom-left-radius:4px;'><div style='font-size:14px;padding-left:10px;padding-top:10px;'> %@ . <a href='http://share/' style='color:black; text-decoration:none;'>%@</a></div> <div id='commentAll'> <div style='padding:10px;' align='center'> <img src='%@' height='16' style='height:16px;width:16px;' /> </div> </div> </div> </div> </div></body><script> function reloadComment(){ $('#commentAll').load('%@/?scrollblogkruk=comment&id=%@', function() { $('html, body').animate({ scrollTop: $(document).height() } , 1000); }); } function getJson() { $('#commentAll').load('%@/?scrollblogkruk=comment&id=%@'); $('#get_post_gallery').load('%@/?scrollblogkruk=get_post_gallery&id=%@'); } getJson(); </script>",[[AppDelegate instance] getURL],[[AppDelegate instance] getURL],NSLocalizedString(@"background_images", nil),[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:3],NSLocalizedString(@"fullstory_comments", nil),NSLocalizedString(@"fullstory_share", nil),@"ajax-loader.gif",[[AppDelegate instance] getURL],[array objectAtIndex:5],[[AppDelegate instance] getURL],[array objectAtIndex:5],[[AppDelegate instance] getURL],[array objectAtIndex:5]] baseURL:baseURL];
        }
        else
        {
            [tempWebView loadHTMLString:[NSString stringWithFormat:@"<link rel='stylesheet' href='%@/wp-content/plugins/scrollblog/js/couraselcss.css' /><script src='http://code.jquery.com/jquery-1.9.0.min.js'></script><script src='%@/wp-content/plugins/scrollblog/js/jquery.touchcarousel-1.1.min.js'></script> <style> img{ width:100%%; height:auto; } iframe{ width:100%%; height:auto; } object{ width:100%%; height:auto; } hr.embosed { width:100%%; height:0; color:none; background:none; border:none; border-top:0.5px solid #555555; border-bottom:1px solid #d3d3d3; }</style><body background='%@' style='padding:0; margin:0px;  font-family:HelveticaNeue;'> <div style='padding:8px; '> <div style='background-color:#f0f0f2; border-radius: 4px; box-shadow: 0 0 3px #000;'> <div style='font-size:18px;font-weight:bold;padding:10px;'> %@ </div> <div style='padding:10px;font-size:12px; margin-top:-15px;'> %@ </div>  <div id='get_post_gallery'></div> <div style='padding:10px;font-size:12px; margin-top:-20px;'> %@ </div> <div id='commentsContainer' style='background-color: #C8C8C8;border-bottom-right-radius:4px;border-bottom-left-radius:4px;'><div style='font-size:14px;padding-left:10px;padding-top:10px;'> %@ . <a href='http://share/' style='color:black; text-decoration:none;'>%@</a></div> <div id='commentAll' style='display:none;'> <div style='padding:10px;' align='center'> <img src='%@' height='16' style='height:16px;width:16px;' /> </div> </div> </div> </div> </div></body><script> function reloadComment(){ $('#commentAll').load('%@/?scrollblogkruk=comment&id=%@', function() { $('html, body').animate({ scrollTop: $(document).height() } , 1000); }); } function getJson() { $('#commentAll').load('%@/?scrollblogkruk=comment&id=%@'); $('#get_post_gallery').load('%@/?scrollblogkruk=get_post_gallery&id=%@'); } getJson(); </script>",[[AppDelegate instance] getURL],[[AppDelegate instance] getURL],NSLocalizedString(@"background_images", nil),[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:3],NSLocalizedString(@"fullstory_comments", nil),NSLocalizedString(@"fullstory_share", nil),@"ajax-loader.gif",[[AppDelegate instance] getURL],[array objectAtIndex:5],[[AppDelegate instance] getURL],[array objectAtIndex:5],[[AppDelegate instance] getURL],[array objectAtIndex:5]] baseURL:baseURL];
        }
       
    }
    else
    {
        if(showComment == YES)
        {
        [tempWebView loadHTMLString:[NSString stringWithFormat:@"<link rel='stylesheet' href='%@/wp-content/plugins/scrollblog/js/couraselcss.css' /><script src='http://code.jquery.com/jquery-1.9.0.min.js'></script><script src='%@/wp-content/plugins/scrollblog/js/jquery.touchcarousel-1.1.min.js'></script> <style> img{ width:100%%; height:auto; } iframe{ width:100%%; height:auto; } object{ width:100%%; height:auto; } hr.embosed { width:100%%; height:0; color:none; background:none; border:none; border-top:0.5px solid #555555; border-bottom:1px solid #d3d3d3; }</style><body background='%@' style='padding:0; margin:0px; font-family:HelveticaNeue;'> <div style='padding:8px; '> <div style='background-color:#f0f0f2; border-radius: 4px; box-shadow: 0 0 3px #000;'> <div style='font-size:18px;font-weight:bold;padding:10px;'> %@ </div> <div style='padding:10px;font-size:12px; margin-top:-15px;'> %@ </div> <div> <img src='%@' width='100%%' /> </div> <div id='get_post_gallery'></div> <div style='padding:10px;font-size:12px; margin-top:-20px;'> %@ </div> <div id='commentsContainer' style='background-color: #C8C8C8;border-bottom-right-radius:4px;border-bottom-left-radius:4px;'> <div style='font-size:14px;padding-left:10px;padding-top:10px;'> %@ . <a href='http://share/' style='color:black; text-decoration:none;'>%@</a></div><div id='commentAll'> <div style='padding:10px;' align='center'> <img src='%@' height='16' style='height:16px;width:16px;' /> </div> </div> </div> </div> </div></body><script> function reloadComment(){ $('#commentAll').load('%@/?scrollblogkruk=comment&id=%@', function() { $('html, body').animate({ scrollTop: $(document).height() } , 1000); }); } function getJson() { $('#commentAll').load('%@/?scrollblogkruk=comment&id=%@'); $('#get_post_gallery').load('%@/?scrollblogkruk=get_post_gallery&id=%@'); } getJson(); </script>",[[AppDelegate instance] getURL],[[AppDelegate instance] getURL],NSLocalizedString(@"background_images", nil),[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2],[array objectAtIndex:3],NSLocalizedString(@"fullstory_comments", nil),NSLocalizedString(@"fullstory_share", nil),@"ajax-loader.gif",[[AppDelegate instance] getURL],[array objectAtIndex:5],[[AppDelegate instance] getURL],[array objectAtIndex:5],[[AppDelegate instance] getURL],[array objectAtIndex:5]] baseURL:baseURL];
        }
        else
        {
            [tempWebView loadHTMLString:[NSString stringWithFormat:@"<link rel='stylesheet' href='%@/wp-content/plugins/scrollblog/js/couraselcss.css' /><script src='http://code.jquery.com/jquery-1.9.0.min.js'></script><script src='%@/wp-content/plugins/scrollblog/js/jquery.touchcarousel-1.1.min.js'></script> <style> img{ width:100%%; height:auto; } iframe{ width:100%%; height:auto; } object{ width:100%%; height:auto; } hr.embosed { width:100%%; height:0; color:none; background:none; border:none; border-top:0.5px solid #555555; border-bottom:1px solid #d3d3d3; }</style><body background='%@' style='padding:0; margin:0px; font-family:HelveticaNeue;'> <div style='padding:8px; '> <div style='background-color:#f0f0f2; border-radius: 4px; box-shadow: 0 0 3px #000;'> <div style='font-size:18px;font-weight:bold;padding:10px;'> %@ </div> <div style='padding:10px;font-size:12px; margin-top:-15px;'> %@ </div> <div> <img src='%@' width='100%%' /> </div> <div id='get_post_gallery'></div> <div style='padding:10px;font-size:12px; margin-top:-20px;'> %@ </div> <div id='commentsContainer' style='background-color: #C8C8C8;border-bottom-right-radius:4px;border-bottom-left-radius:4px;'><div style='font-size:14px;padding-left:10px;padding-top:10px;'> %@ . <a href='http://share/' style='color:black; text-decoration:none;'>%@</a></div> <div id='commentAll' style='display:none;'> <div style='padding:10px;' align='center'> <img src='%@' height='16' style='height:16px;width:16px;' /> </div> </div> </div> </div> </div></body><script> function reloadComment(){ $('#commentAll').load('%@/?scrollblogkruk=comment&id=%@', function() { $('html, body').animate({ scrollTop: $(document).height() } , 1000); }); } function getJson() { $('#commentAll').load('%@/?scrollblogkruk=comment&id=%@'); $('#get_post_gallery').load('%@/?scrollblogkruk=get_post_gallery&id=%@'); } getJson(); </script>",[[AppDelegate instance] getURL],[[AppDelegate instance] getURL],NSLocalizedString(@"background_images", nil),[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2],[array objectAtIndex:3],NSLocalizedString(@"fullstory_comments", nil),NSLocalizedString(@"fullstory_share", nil),@"ajax-loader.gif",[[AppDelegate instance] getURL],[array objectAtIndex:5],[[AppDelegate instance] getURL],[array objectAtIndex:5],[[AppDelegate instance] getURL],[array objectAtIndex:5]] baseURL:baseURL];
        }
    }
    
       [self.view addSubview:tempWebView];
    
    UIScrollView *scroll = [tempWebView.subviews lastObject];
    if ([scroll isKindOfClass:[UIScrollView class]]) {
        
        scroll.decelerationRate = UIScrollViewDecelerationRateNormal;
        
        
    }
    
    if([[AppDelegate instance] getAdIndicator] == NO)
    {
    
    if([[array objectAtIndex:6] isEqualToString:@"open"])
    {
        
        if([[AppDelegate instance] hasFourInchDisplay])
        {
            tempWebView.frame = CGRectMake(0, 0, 320, 504-40);
        }
        else
        {
            tempWebView.frame = CGRectMake(0, 0, 320, 417-40);
        }

        
        [self createAGrowTextView];
    }
    else{
        
        if([[AppDelegate instance] hasFourInchDisplay])
        {
            tempWebView.frame = CGRectMake(0, 0, 320, 504);
        }
        else
        {
            tempWebView.frame = CGRectMake(0, 0, 320, 417);
        }

        
    }
    }
    else
    {
        if([[array objectAtIndex:6] isEqualToString:@"open"])
        {
            
            if([[AppDelegate instance] hasFourInchDisplay])
            {
                tempWebView.frame = CGRectMake(0, 49, 320, 504-40-49);
            }
            else
            {
                tempWebView.frame = CGRectMake(0, 49, 320, 417-40-49);
            }
            
            
            [self createAGrowTextView];
        }
        else{
            
            if([[AppDelegate instance] hasFourInchDisplay])
            {
                tempWebView.frame = CGRectMake(0, 49, 320, 504-49);
            }
            else
            {
                tempWebView.frame = CGRectMake(0, 49, 320, 417-49);
            }
            
            
        }

        
    }
    specialBtnArray = [array objectAtIndex:8];
    if([[[array objectAtIndex:8] objectAtIndex:0] intValue] == 1)
    {
   
    }
    else
    {
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%@",[[array objectAtIndex:8] objectAtIndex:1]] style:UIBarButtonItemStyleDone target:self action:@selector(openSpecialBtn)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    
    
}

-(void)openSpecialBtn{
    NSLog(@"%@",[specialBtnArray objectAtIndex:0]);
    if([[specialBtnArray objectAtIndex:0] intValue] == 1)
    {
         NSLog(@"Open None");
        
    }
    else if([[specialBtnArray objectAtIndex:0] intValue] == 2)
    {
        
         NSLog(@"Open Map");
       
        NSString* anntonationTitle =[NSString stringWithFormat:@"%@,%@",[specialBtnArray objectAtIndex:2],[specialBtnArray objectAtIndex:3]];
        MapViewController *map = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
        map.title = self.title;
        [map addSingleAnntonation:[NSArray arrayWithObjects:anntonationTitle,[specialBtnArray objectAtIndex:2],[specialBtnArray objectAtIndex:3], nil]];
        [self.navigationController pushViewController:map animated:YES];
        
    }
    else if([[specialBtnArray objectAtIndex:0] intValue] == 3)
    {
        NSLog(@"Open In App Web View");
        iPhoneWebView *ip = [[iPhoneWebView alloc] init];
        
        [ip loadUrlInWebView:[NSString stringWithFormat:@"%@",[specialBtnArray objectAtIndex:4]]];
         [self.navigationController pushViewController:ip animated:YES];
        
    }
    else if([[specialBtnArray objectAtIndex:0] intValue] == 4)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[specialBtnArray objectAtIndex:4]]]];
        NSLog(@"Open In App Safari");
    }
   
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [[AppDelegate instance] anywhereSlide];
    [[AppDelegate instance] setLandscapeMode:NO];
}

-(void)viewWillAppear:(BOOL)animated{
     [[AppDelegate instance] setLandscapeMode:NO];
}

-(void)setShowCommment:(BOOL)arg{
    
    showComment = arg;
}

-(void)openActionSheet{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle: NSLocalizedString(@"fullstory_actionsheet_title", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"fullstory_actionsheet_cancel_btn", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"fullstory_actionsheet_facebook_btn", nil), NSLocalizedString(@"fullstory_actionsheet_twitter_btn", nil),NSLocalizedString(@"fullstory_actionsheet_email_btn", nil),NSLocalizedString(@"fullstory_actionsheet_openinsafari_btn", nil), nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		NSLog(@"Facebook");
        iPhoneWebView *ip = [[iPhoneWebView alloc] init];
        
        [ip loadUrlInWebView:[NSString stringWithFormat:@"https://m.facebook.com/sharer.php?u=%@",pUrl]];
        
        [self.navigationController pushViewController:ip animated:YES];
        
	} else if (buttonIndex == 1) {
        NSLog(@"Twitter");
        iPhoneWebView *ip = [[iPhoneWebView alloc] init];
        
        [ip loadUrlInWebView:[NSString stringWithFormat:@"http://twitter.com/intent/tweet?text=%@",pUrl]];
        
        
         [self.navigationController pushViewController:ip animated:YES];
	} else if (buttonIndex == 2) {
		NSLog(@"Email");
        
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:[NSString stringWithFormat:@"Have you visit %@",pUrl]];
        
        
        NSString *emailBody = [NSString stringWithFormat:@"Check out this link : %@",pUrl];
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentModalViewController:mailer animated:YES];
        
        
	}else if (buttonIndex == 3) {
		NSLog(@"Open in Safari");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",pUrl]]];
	}
    else{
        NSLog(@"Cancel");
        
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}



-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        
        NSString *myString = [[inRequest URL] absoluteString];
        NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"http://photo"] invertedSet];

        
        if([myString isEqualToString:@"http://share/"])
        {
            NSLog(@"Share");
            [self openActionSheet];
            
        }
        else if([myString rangeOfCharacterFromSet:set].location != NSNotFound)
        {
            NSLog(@"Pic");
            NSArray *arys = [myString componentsSeparatedByString:@";"];
            
            if([arys count] == 1)
            {
                NSLog(@"WebView");
                iPhoneWebView *ip = [[iPhoneWebView alloc] init];
                [ip loadUrlInWebView:myString];
                [self.navigationController pushViewController:ip animated:YES];
            }
            else
            {
            NSMutableArray *allImage = [[NSMutableArray alloc] init];
            for (NSDictionary *result in gallery) {
                
               
                MyPhoto *photo = [[MyPhoto alloc] initWithImageURL:[NSURL URLWithString:[result objectForKey:@"img_url"]] name:[result objectForKey:@"img_caption"]];
                [allImage addObject:photo];
            }
            
           
          
            MyPhotoSource *source = [[MyPhotoSource alloc] initWithPhotos:allImage];
            
            EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:source];
            photoController._pageIndex = [[arys objectAtIndex:1] intValue];
           
            [[AppDelegate instance] setLandscapeMode:YES];
            [self.navigationController pushViewController:photoController animated:YES];
            
            }
            
        }
        
        
        
        return NO;
    }
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)aView {
   
    UIScrollView *scroll = [tempWebView.subviews lastObject];
    if ([scroll isKindOfClass:[UIScrollView class]]) {
      
        scroll.decelerationRate = UIScrollViewDecelerationRateNormal;
        
         // NSLog(@"Jumpe %f",scroll.contentSize.height);
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)createAGrowTextView {
	
    
	
    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, 320, 40)];
    containerView.backgroundColor = [UIColor clearColor];
	textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(41, 3, 205, 40)];
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
	textView.minNumberOfLines = 1;
	textView.maxNumberOfLines = 3;
	textView.returnKeyType = UIReturnKeyDefault; 
	textView.font = [UIFont systemFontOfSize:15.0f];
	textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    textView.text = NSLocalizedString(@"fullstory_comment_placeholder", nil);
    textView.textColor = [UIColor grayColor];
 
    
    [self.view addSubview:containerView];
	
    UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
    entryImageView.frame = CGRectMake(40, 0, 213, 40);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    imageView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // view hierachy
    [containerView addSubview:imageView];
    [containerView addSubview:textView];
    [containerView addSubview:entryImageView];
    
    UIImage *sendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
    UIImage *settingBtnBackground = [[UIImage imageNamed:@"MessageEntrySettingButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    UIImage *selectedSettingSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySettingButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
	UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	doneBtn.frame = CGRectMake(containerView.frame.size.width - 69, 8, 63, 27);
    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [doneBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
	[doneBtn setTitle:NSLocalizedString(@"fullstory_comment_post_btn", nil) forState:UIControlStateNormal];
    
    [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
	[containerView addSubview:doneBtn];
    
    
    
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	setBtn.frame = CGRectMake(6, 8, 27, 27);
    setBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [setBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];
	
    
    [setBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    setBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    setBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    
    [setBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[setBtn addTarget:self action:@selector(openSetting) forControlEvents:UIControlEventTouchUpInside];
    [setBtn setBackgroundImage:settingBtnBackground forState:UIControlStateNormal];
    [setBtn setBackgroundImage:selectedSettingSendBtnBackground forState:UIControlStateSelected];
	[containerView addSubview:setBtn];

    
    
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

-(void)openSetting
{
	iPhoneLoginController *se = [[iPhoneLoginController alloc] initWithNibName:@"iPhoneLoginController" bundle:nil];
    se.title = @"Settings";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:se];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [self presentModalViewController:nav animated:YES];
}


-(void)resignTextView
{
	
    if([[AppDelegate instance] checkSaveFileExist] == YES)
    {
        NSString *post =[NSString stringWithFormat:@"author=%@&email=%@&url=%@&comment=%@&comment_post_ID=%@",[[[AppDelegate instance] getFileSave] objectAtIndex:0],[[[AppDelegate instance] getFileSave] objectAtIndex:1],[[[AppDelegate instance] getFileSave] objectAtIndex:2],textView.text,[[AppDelegate instance] getCurrentPostID]];
        
        
        NSLog(@"%@",post);
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        [[AppDelegate instance] setSharedWebView:tempWebView];
        
         [[AppDelegate instance] postCommentiPhone:postData];
         [textView resignFirstResponder];
    }
    else
    {
        [self openSetting];
    }
   
}

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
	
	// set views with new info
	containerView.frame = containerFrame;
	textView.text = @"";
    textView.textColor = [UIColor blackColor];
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
	// set views with new info
	containerView.frame = containerFrame;
	
	// commit animations
	[UIView commitAnimations];
    
    textView.text =  NSLocalizedString(@"fullstory_comment_placeholder", nil);;
    textView.textColor = [UIColor grayColor];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	containerView.frame = r;
}


@end
