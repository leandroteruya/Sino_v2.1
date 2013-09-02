

#import "ViewController.h"
#import "MGScrollView.h"
#import "MGTableBoxStyled.h"
#import "MGLineStyled.h"
#import "PhotoBox.h"
#import "FullStoryViewController.h"
#import "iPhoneWebView.h"
#import "MapViewController.h"
#import "mapViewViewController.h"
#define HEADER_FONT                    [UIFont fontWithName:@"HelveticaNeue-Bold" size:16]
#define HEADER_FONT_CLASSIFICACAO      [UIFont fontWithName:@"HelveticaNeue" size:18]
#define NORMAL_BOLD_FONT               [UIFont fontWithName:@"HelveticaNeue-Bold" size:12]
#define NORMAL_FONT                    [UIFont fontWithName:@"HelveticaNeue" size:12]
#define REFRESH_HEADER_HEIGHT 80.0f

@interface ViewController ()

@end

@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@implementation ViewController

/*DATA*/
@synthesize datePicker;
@synthesize datelabel;
@synthesize datelabeltipo;

/*DATA TIPO*/
@synthesize dateTipoPicker, pickerDataTipo;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: NSLocalizedString(@"background_images", nil)]];
    
    if([[AppDelegate instance] getAdIndicator] == NO)
    {
        if([[AppDelegate instance] hasFourInchDisplay])
        {
      
            scroller = [MGScrollView scrollerWithSize:CGSizeMake(320, 503)];
        }
        else
        {
            scroller = [MGScrollView scrollerWithSize:CGSizeMake(320, 415)];  
        }   
    }
    else
    {
        if([[AppDelegate instance] hasFourInchDisplay])
        {
            
            scroller = [MGScrollView scrollerWithSize:CGSizeMake(320, 453)];
            scroller.frame = CGRectMake(0, 50, 320, 453);
        }
        else
        {
            scroller = [MGScrollView scrollerWithSize:CGSizeMake(320, 365)];
            scroller.frame = CGRectMake(0, 50, 320, 365);
        }

    }
    
    scroller.delegate = self;

    [self.view addSubview:scroller];
     scroller.bottomPadding = 8;
   
    
    ///MONTA CONTEUDO DA HOME
    for(int i = 0;i<[[[AppDelegate instance] getRecentPostArray] count];i++)
    {
        
        
        if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:8] intValue] == 1)
        {
        
            if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] isEqualToString:@"0"])
            {
            
                [self addBoxWithNoImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[self stringByStrippingHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
            }
            else
            {
                [self addBoxWithImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] imageUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] shortDesc:[self stringByStrippingHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
            
            }
            
        }
        else if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:8] intValue] == 2)
        {
            if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] isEqualToString:@"0"])
            {
                
                [self addBoxWithNoImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[self stringByStrippingHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
            }
            else
            {
                [self fullImageBox:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] title:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                
            }

            
        }
        else if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:8] intValue] == 3)
        {
            if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] isEqualToString:@"0"])
            {
                
                [self addBoxWithNoImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[self stringByStrippingHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
            }
            else
            {
                [self addBoxWithTopImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] imageUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] shortDesc:[self stringByStrippingHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                
            }
            
            
        }

    
    }
   
    if([[AppDelegate instance] getTotalPage] == [[AppDelegate instance] getCurrentPage])
    {
   
    }
    else
    {
        [self loadMore];
    }
    
    
    [scroller layoutWithSpeed:0.3 completion:nil];
    
    
   
    
    currentScrollHeight = scroller.bounds.origin.y;
    
    
    
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:scroller];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    fixedHeight = CGRectGetHeight(self.view.frame);
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(pushLeft)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    
    
    rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settingBtn.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(subscribe)];
    
       self.navigationItem.rightBarButtonItem = rightBar;
    
    
}

-(void)backToOrginScroller{
    [scroller removeFromSuperview];
    if([[AppDelegate instance] hasFourInchDisplay])
    {
        
        scroller = [MGScrollView scrollerWithSize:CGSizeMake(320, 503)];
        
    }
    else
    {
        scroller = [MGScrollView scrollerWithSize:CGSizeMake(320, 415)];
       
    }
    
    
    scroller.delegate = self;
    
    [self.view addSubview:scroller];
    scroller.bottomPadding = 8;
    
    for(int i = 0;i<[[[AppDelegate instance] getRecentPostArray] count];i++)
    {
        
        
        if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:8] intValue] == 1)
        {
            
            if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] isEqualToString:@"0"])
            {
                
                [self addBoxWithNoImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[self stringByStrippingHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
            }
            else
            {
                [self addBoxWithImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] imageUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] shortDesc:[self stringByStrippingHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                
            }
            
        }
        else if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:8] intValue] == 2)
        {
            if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] isEqualToString:@"0"])
            {
                
                [self addBoxWithNoImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[self stringByStrippingHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
            }
            else
            {
                [self fullImageBox:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] title:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                
            }
            
            
        }
        else if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:8] intValue] == 3)
        {
            if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] isEqualToString:@"0"])
            {
                
                [self addBoxWithNoImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[self stringByStrippingHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
            }
            else
            {
                [self addBoxWithTopImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] imageUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] shortDesc:[self stringByStrippingHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                
            }
            
            
        }
        
        
    }
    
    if([[AppDelegate instance] getTotalPage] == [[AppDelegate instance] getCurrentPage])
    {
        
    }
    else
    {
        [self loadMore];
    }
    
    
    [scroller layoutWithSpeed:0.3 completion:nil];
    
    
    
    
    currentScrollHeight = scroller.bounds.origin.y;
    
    
    
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:scroller];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    fixedHeight = CGRectGetHeight(self.view.frame);
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_menu_icon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(pushLeft)];
    self.navigationItem.leftBarButtonItem = leftbtn;
    
    
    rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settingBtn.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(subscribe)];
    
    self.navigationItem.rightBarButtonItem = rightBar;
    
}

-(void)viewDidAppear:(BOOL)animated{
    
   // [[AppDelegate instance] anywhereSlide];
}

-(void)pushLeft{
    
    [[AppDelegate instance] pushLeftBtn];
}

-(void)showHideRightBar:(BOOL)show{
    if(show == true)
    {
        self.navigationItem.rightBarButtonItem = rightBar;
    }
    else
    {
    self.navigationItem.rightBarButtonItem = nil;
    }
}


-(void)subscribe{
    
    //[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    iPhoneCommentPostController *se = [[iPhoneCommentPostController alloc] initWithNibName:@"iPhoneCommentPostController" bundle:nil];
    se.title = @"Settings";
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:se];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [self presentModalViewController:nav animated:YES];
    
}

-(NSString *) stringByStrippingHTML:(NSString*)des {
    NSRange r;
    NSString *s = des;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

-(void)loadMore{
    
    MGTableBoxStyled *section = MGTableBoxStyled.box;
    section.margin = UIEdgeInsetsMake(20.0, 7.0, 0.0, 0.0);
    [scroller.boxes addObject:section];
    
    PhotoBox *box = [PhotoBox loadMore:(CGSize){305, 40}];
    
    box.onTap = ^{
        
        
        
        if([[AppDelegate instance] getTweetIndi] == YES)
        {
            [self performSelectorOnMainThread:@selector(endlessTwitter) withObject:nil waitUntilDone:FALSE];
        }
        else
        {
       
        [self performSelectorOnMainThread:@selector(endless) withObject:nil waitUntilDone:FALSE];
        currentOldPost = [[[AppDelegate instance] getRecentPostArray] count]+1;
        }
        
        //[scroller.boxes count];
        //NSLog(@"%d %d",[scroller.boxes count],cou);
        //[scroller.boxes removeObjectAtIndex:10];
        //[scroller layoutWithSpeed:0.3 completion:nil];
    };
    
    [section.topLines addObject:box];
    
}

-(void)endless{
    
    
    
    
    
    [[[AppDelegate instance] getUILabel] setHidden:YES];
    [[[AppDelegate instance] getIndicatorView] startAnimating];
    
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
                
        [[AppDelegate instance] endlessRecentPostJson];
        
        
        //[scroller.boxes removeAllObjects];
        
        int syeu = [[[AppDelegate instance] getRecentPostArray] count] - [[[[AppDelegate instance] getPreviTotalArray] objectAtIndex:[[AppDelegate instance] getCurrentPage]-1] intValue];
        
        
      
        NSLog(@"Next Post Start %d",syeu);
        
       
        for(int i = syeu;i<[[[AppDelegate instance] getRecentPostArray] count];i++)
        {
            if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:8] intValue] == 1)
            {
                
                if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] isEqualToString:@"0"])
                {
                    
                    [self addBoxWithNoImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[self flattenHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                }
                else
                {
                    [self addBoxWithImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] imageUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] shortDesc:[self flattenHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                    
                }
                
            }
            else if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:8] intValue] == 2)
            {
                if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] isEqualToString:@"0"])
                {
                    
                    [self addBoxWithNoImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                }
                else
                {
                    [self fullImageBox:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] title:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                    
                }
                
                
            }
            else if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:8] intValue] == 3)
            {
                if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] isEqualToString:@"0"])
                {
                    
                    [self addBoxWithNoImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[self flattenHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                }
                else
                {
                    [self addBoxWithTopImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] imageUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] shortDesc:[self flattenHTML:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2]] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                    
                }
                
                
            }
            
        }
        
        
        
        
        if([[AppDelegate instance] getTotalPage] == [[AppDelegate instance] getCurrentPage])
        {
            
        }
        else
        {
            [self loadMore];
        }
        
        [scroller.boxes removeObjectAtIndex:currentOldPost-1];
        [scroller layoutWithSpeed:0.3 completion:nil];
        //[(id)scroller snapToNearestBox];
       currentScrollHeight = scroller.bounds.origin.y;
        
        
        
    });
    
    
   
}



-(void)endlessTwitter{
    
    
    
    
    
    [[[AppDelegate instance] getUILabel] setHidden:YES];
    [[[AppDelegate instance] getIndicatorView] startAnimating];
    
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
        
            
            [[AppDelegate instance] endlessRecentTwitterJson];
        
        
        
        //[scroller.boxes removeAllObjects];
        
        int syeu = [[[AppDelegate instance] getRecentPostArray] count] - [[[[AppDelegate instance] getPreviTotalArray] objectAtIndex:[[AppDelegate instance] getCurrentPage]-1] intValue];
        
        int ser = [scroller.boxes count]-1;
         [scroller.boxes removeObjectAtIndex:ser];
        
        NSLog(@"Next Post Start %d",syeu);
        
        
        for(int i = syeu;i<[[[AppDelegate instance] getRecentPostArray] count];i++)
        {
            
            
            
            [self addBoxWithNoImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:@"" fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] jsonComment:@"" postID:@"0" comment_status:@"" pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:@"",@"",@"",@"",@"", nil]];
        }
        
        
        
        
       [self loadMore];
       
        NSLog(@"%d",currentOldPost);
        [scroller layoutWithSpeed:0.3 completion:nil];
        //[(id)scroller snapToNearestBox];
        currentScrollHeight = scroller.bounds.origin.y;
        
        
        
    });
    
    
    
}



- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}



-(void)fullImageBox:(NSString*)url title:(NSString*)title pDate:(NSString*)pDate fullContent:(NSString*)content jsonComment:(NSString*)comment postID:(NSString*)pID comment_status:(NSString*)status pUrl:(NSString*)pUrl extra:(NSArray*)ary{
    MGTableBoxStyled *section = MGTableBoxStyled.box;
    section.margin = UIEdgeInsetsMake(20.0, 7.0, 0.0, 0.0);
    [scroller.boxes addObject:section];
    
    PhotoBox *box = [PhotoBox fullImageBox:CGSizeMake(305,305) pictureURL:url title:title pDate:pDate];
    
    box.onTap = ^{
       [self goToDetailViewController:[NSArray arrayWithObjects:title,pDate,url,content,comment,pID,status,pUrl,ary, nil]];
    };
    
    [section.topLines addObject:box];
}

-(void)fullImageBox2:(NSString*)url title:(NSString*)title pDate:(NSString*)pDate fullContent:(NSString*)content jsonComment:(NSString*)comment postID:(NSString*)pID comment_status:(NSString*)status pUrl:(NSString*)pUrl extra:(NSArray*)ary{
    MGTableBoxStyled *section = MGTableBoxStyled.box;
    section.margin = UIEdgeInsetsMake(1.0, 7.0, 0.0, 0.0);
    [scroller.boxes addObject:section];
    
    UIEdgeInsets titleInsets = UIEdgeInsetsMake(0, 0.0, 5.0, 0.0);
    section.padding = titleInsets;
    
    id waffle2 = content;
    id waffleHeader = title;
    id waffleHeader2 = pDate;
    
    NSString *trimmedString = [content stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    
    //Header dos Clippings nome Classificacao
    if([trimmedString length] > 0 )
    {
        id nome_classificacao
        = content;
        // stuff
        
        MGLineStyled *lineHeader0 = [MGLineStyled multilineWithText:[self decodeHTMLCharacterEntities:nome_classificacao] font:HEADER_FONT_CLASSIFICACAO width:304
                                                            padding:UIEdgeInsetsMake(8, 16, 8, 16) ];
        lineHeader0.borderStyle &= ~MGBorderEtchedBottom;
        lineHeader0.backgroundColor = [UIColor colorWithRed:17/255.0f
                                                      green:126/255.0f
                                                       blue:84/255.0f
                                                      alpha:1.0f];
        lineHeader0.textColor = UIColor.whiteColor;
        [section.topLines addObject:lineHeader0];
    }
    //FIM Header dos Clippings nome Classificacao
    
    //Titulo Clipping
    // stuff
    MGLineStyled *lineHeader1 = [MGLineStyled multilineWithText:[self decodeHTMLCharacterEntities:waffleHeader] font:HEADER_FONT width:304
                                                        padding:UIEdgeInsetsMake(0, 16, 3, 16)];
    lineHeader1.borderStyle &= ~MGBorderEtchedBottom;
    lineHeader1.backgroundColor = [UIColor colorWithRed:204/255.0f
                                                  green:204/255.0f
                                                   blue:204/255.0f
                                                  alpha:1.0f];
    lineHeader1.textColor = [UIColor colorWithRed:44/255.0f
                                            green:107/255.0f
                                             blue:84/255.0f
                                            alpha:1.0f];
    lineHeader1.onTap = ^{
        [self goToDetalheClippingViewController:[NSMutableArray arrayWithObjects:title,pDate,@"0",content,comment,pID,status,pUrl,ary, nil]];
    };
    
    [section.topLines addObject:lineHeader1];
    //FIM Titulo Clipping
    
    NSString * data = [NSString stringWithFormat:@"%@ - %@", waffleHeader2 , waffle2];
    // stuff
    MGLineStyled *lineHeader2 = [MGLineStyled multilineWithText:data  font:NORMAL_FONT width:304
                                                        padding:UIEdgeInsetsMake(7, 16, 7, 16)];
    lineHeader2.borderStyle &= ~MGBorderEtchedTop;
    lineHeader2.backgroundColor = [UIColor colorWithRed:240/255.0f
                                                  green:240/255.0f
                                                   blue:240/255.0f
                                                  alpha:1.0f];
    lineHeader2.textColor = [UIColor colorWithRed:102/255.0f
                                            green:102/255.0f
                                             blue:102/255.0f
                                            alpha:1.0f];
    lineHeader2.onTap = ^{
        [self goToDetalheClippingViewController:[NSMutableArray arrayWithObjects:title,pDate,@"0",content,comment,pID,status,pUrl,ary, nil]];
    };
    [section.topLines addObject:lineHeader2];
    
    [scroller scrollToView:section withMargin:8];
}


-(void)addBoxWithNoImage:(NSString*)title pDate:(NSString*)pDate shortDesc:(NSString*)desc fullContent:(NSString*)content jsonComment:(NSString*)comment postID:(NSString*)pID comment_status:(NSString*)status pUrl:(NSString*)pUrl extra:(NSArray*)ary{
    //CGSize rowSize = (CGSize){304, 40};
    
    
    MGTableBoxStyled *section = MGTableBoxStyled.box;
    section.margin = UIEdgeInsetsMake(20.0, 7.0, 0.0, 0.0);
    [scroller.boxes addObject:section];
    
    UIEdgeInsets titleInsets = UIEdgeInsetsMake(10, 0.0, 5.0, 0.0);
    section.padding = titleInsets;
    
    
    
    
    id waffle2 = desc;
    
   
    
    
    
    
    // a header row
    id waffleHeader
    = title;
    id waffleHeader2 = pDate;
    
    // stuff
    MGLineStyled *lineHeader1 = [MGLineStyled multilineWithText:[self decodeHTMLCharacterEntities:waffleHeader] font:HEADER_FONT width:304
                                                        padding:UIEdgeInsetsMake(0, 16, 3, 16)];
    lineHeader1.borderStyle &= ~MGBorderEtchedBottom;
    
    lineHeader1.onTap = ^{
       [self goToDetailViewController:[NSArray arrayWithObjects:title,pDate,@"0",content,comment,pID,status,pUrl,ary, nil]];
    };
    
    [section.topLines addObject:lineHeader1];
    
    // stuff
    MGLineStyled *lineHeader2 = [MGLineStyled multilineWithText:waffleHeader2 font:NORMAL_FONT width:304
                                                        padding:UIEdgeInsetsMake(0, 16, 7, 16)];
    lineHeader2.borderStyle &= ~MGBorderEtchedTop;
    
    lineHeader2.onTap = ^{
        [self goToDetailViewController:[NSArray arrayWithObjects:title,pDate,@"0",content,comment,pID,status,pUrl,ary, nil]];
    };
    [section.topLines addObject:lineHeader2];
    
    if(useWebBrowserAsDetail == NO)
    {
    
    // stuff
    MGLineStyled *line2 = [MGLineStyled multilineWithText:[self decodeHTMLCharacterEntities:waffle2] font:NORMAL_FONT width:304
                                                  padding:UIEdgeInsetsMake(8, 16, 16, 16)];
    line2.borderStyle &= ~MGBorderEtchedTop;
    
    line2.onTap = ^{
       [self goToDetailViewController:[NSArray arrayWithObjects:title,pDate,@"0",content,comment,pID,status,pUrl,ary, nil]];
    };
    [section.topLines addObject:line2];
    }
    
    [scroller scrollToView:section withMargin:8];
}



-(void)addBoxWithTopImage:(NSString*)title pDate:(NSString*)pDate imageUrl:(NSString*)url shortDesc:(NSString*)desc fullContent:(NSString*)content jsonComment:(NSString*)comment postID:(NSString*)pID comment_status:(NSString*)status pUrl:(NSString*)pUrl extra:(NSArray*)ary{
    //CGSize rowSize = (CGSize){304, 40};
    
    
    MGTableBoxStyled *section = MGTableBoxStyled.box;
    section.margin = UIEdgeInsetsMake(20.0, 7.0, 0.0, 0.0);
    [scroller.boxes addObject:section];
   
    UIEdgeInsets titleInsets = UIEdgeInsetsMake(0.0, 0.0, 5.0, 0.0);
    section.padding = titleInsets;
    
    
    
    
    id waffle2 = desc;

    
    PhotoBox *box = [PhotoBox photoAddBoxWithSize:CGSizeMake(305,305) pictureURL:url];
    
    box.onTap = ^{
        [self goToDetailViewController:[NSArray arrayWithObjects:title,pDate,url,content,comment,pID,status,pUrl,ary, nil]];
    };
    
    [section.topLines addObject:box];
    
    
    
    
    // a header row
    id waffleHeader
    = title;
    id waffleHeader2 = pDate;
    
    // stuff
    MGLineStyled *lineHeader1 = [MGLineStyled multilineWithText:[self decodeHTMLCharacterEntities:waffleHeader] font:HEADER_FONT width:304
                                                        padding:UIEdgeInsetsMake(20, 16, 3, 16)];
    lineHeader1.borderStyle &= ~MGBorderEtchedBottom;
    
    lineHeader1.onTap = ^{
       [self goToDetailViewController:[NSArray arrayWithObjects:title,pDate,url,content,comment,pID,status,pUrl,ary, nil]];
    };
    
    [section.topLines addObject:lineHeader1];
    
    // stuff
    MGLineStyled *lineHeader2 = [MGLineStyled multilineWithText:waffleHeader2 font:NORMAL_FONT width:304
                                                        padding:UIEdgeInsetsMake(0, 16, 7, 16)];
    lineHeader2.borderStyle &= ~MGBorderEtchedTop;
    
    lineHeader2.onTap = ^{
        [self goToDetailViewController:[NSArray arrayWithObjects:title,pDate,url,content,comment,pID,status,pUrl,ary, nil]];
    };
    [section.topLines addObject:lineHeader2];
    
    
    // stuff
    MGLineStyled *line2 = [MGLineStyled multilineWithText:[self decodeHTMLCharacterEntities:waffle2] font:NORMAL_FONT width:304
                                                  padding:UIEdgeInsetsMake(8, 16, 16, 16)];
    line2.borderStyle &= ~MGBorderEtchedTop;
    
    line2.onTap = ^{
        [self goToDetailViewController:[NSArray arrayWithObjects:title,pDate,url,content,comment,pID,status,pUrl,ary, nil]];
    };
    [section.topLines addObject:line2];
    
    
    [scroller scrollToView:section withMargin:8];
}



-(void)addBoxWithImage:(NSString*)title pDate:(NSString*)pDate imageUrl:(NSString*)url shortDesc:(NSString*)desc fullContent:(NSString*)content jsonComment:(NSString*)comment postID:(NSString*)pID comment_status:(NSString*)status pUrl:(NSString*)pUrl extra:(NSArray*)ary{
    
    
    
    MGTableBoxStyled *section = MGTableBoxStyled.box;
    section.margin = UIEdgeInsetsMake(20.0, 7.0, 0.0, 0.0);
    [scroller.boxes addObject:section];
    UIEdgeInsets titleInsets = UIEdgeInsetsMake(7.0, 0.0, 5.0, 0.0);
    section.padding = titleInsets;
    
    // a header row
    id waffleHeader
    = title;
    id waffleHeader2 = pDate;
    
    // stuff
    MGLineStyled *lineHeader1 = [MGLineStyled multilineWithText:[self decodeHTMLCharacterEntities:waffleHeader] font:HEADER_FONT width:304
                                                  padding:UIEdgeInsetsMake(0, 16, 3, 16)];
    lineHeader1.borderStyle &= ~MGBorderEtchedBottom;
    
    lineHeader1.onTap = ^{
       
        [self goToDetailViewController:[NSArray arrayWithObjects:title,pDate,url,content,comment,pID,status,pUrl,ary    , nil]];
    };
    
    [section.topLines addObject:lineHeader1];
    
    // stuff
    MGLineStyled *lineHeader2 = [MGLineStyled multilineWithText:waffleHeader2 font:NORMAL_FONT width:304
                                                  padding:UIEdgeInsetsMake(0, 16, 7, 16)];
    lineHeader2.borderStyle &= ~MGBorderEtchedTop;
    
    lineHeader2.onTap = ^{
            [self goToDetailViewController:[NSArray arrayWithObjects:title,pDate,url,content,comment,pID,status,pUrl,ary, nil]];
    };
    [section.topLines addObject:lineHeader2];
    
    
    id waffle2 = desc;
  
    
     PhotoBox *box = [PhotoBox photoAddBoxWithSize:CGSizeMake(305,305) pictureURL:url];
    
    box.onTap = ^{
          [self goToDetailViewController:[NSArray arrayWithObjects:title,pDate,url,content,comment,pID,status,pUrl,ary, nil]];
    };
    
    [section.topLines addObject:box];
    
    // stuff
    MGLineStyled *line2 = [MGLineStyled multilineWithText:[self decodeHTMLCharacterEntities:waffle2] font:NORMAL_FONT width:304
                                                  padding:UIEdgeInsetsMake(8, 16, 16, 16)];
    line2.borderStyle &= ~MGBorderEtchedTop;
    
    line2.onTap = ^{
           [self goToDetailViewController:[NSArray arrayWithObjects:title,pDate,url,content,comment,pID,status,pUrl,ary, nil]];
    };
    [section.topLines addObject:line2];
    
    
  
    [scroller scrollToView:section withMargin:8];
}


-(void)addBoxClippings:(NSString*)title pDate:(NSString*)pDate shortDesc:(NSString*)desc fullContent:(NSString*)content jsonComment:(NSString*)comment postID:(NSString*)pID comment_status:(NSString*)status pUrl:(NSString*)pUrl extra:(NSArray*)ary{
    //CGSize rowSize = (CGSize){304, 40};
    
    MGTableBoxStyled *section = MGTableBoxStyled.box;
    section.margin = UIEdgeInsetsMake(1.0, 7.0, 0.0, 0.0);
    [scroller.boxes addObject:section];
    
    UIEdgeInsets titleInsets = UIEdgeInsetsMake(0, 0.0, 5.0, 0.0);
    section.padding = titleInsets;
    
    id waffle2 = desc;
    //title -> titulo
    //pDate -> cmp_veiculo_nome
    //pID ->id_clipping
    //content -> classificacao_nome
    //NSLog(@"-=--> %@",[NSString stringWithFormat:@"%@ - %@ - %@ - %@", content , comment, comment, pUrl]);
    
    // a header row
    id waffleHeader
    = title;
    id waffleHeader2 = pDate;
    
    NSString *trimmedString = [content stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    
    //Header dos Clippings nome Classificacao
    if([trimmedString length] > 0 )
    {
        id nome_classificacao
        = content;
        // stuff

        MGLineStyled *lineHeader0 = [MGLineStyled multilineWithText:[self decodeHTMLCharacterEntities:nome_classificacao] font:HEADER_FONT_CLASSIFICACAO width:304
                                                            padding:UIEdgeInsetsMake(8, 16, 8, 16) ];
        lineHeader0.borderStyle &= ~MGBorderEtchedBottom;
        lineHeader0.backgroundColor = [UIColor colorWithRed:17/255.0f
                                                      green:126/255.0f
                                                       blue:84/255.0f
                                                      alpha:1.0f];
        lineHeader0.textColor = UIColor.whiteColor;
        [section.topLines addObject:lineHeader0];
    }
    //FIM Header dos Clippings nome Classificacao
    
    //Titulo Clipping
    // stuff
    MGLineStyled *lineHeader1 = [MGLineStyled multilineWithText:[self decodeHTMLCharacterEntities:waffleHeader] font:HEADER_FONT width:304
                                                        padding:UIEdgeInsetsMake(0, 16, 3, 16)];
    lineHeader1.borderStyle &= ~MGBorderEtchedBottom;
    lineHeader1.backgroundColor = [UIColor colorWithRed:204/255.0f
                                                  green:204/255.0f
                                                   blue:204/255.0f
                                                  alpha:1.0f];
    lineHeader1.textColor = [UIColor colorWithRed:44/255.0f
                                            green:107/255.0f
                                             blue:84/255.0f
                                            alpha:1.0f];
    lineHeader1.onTap = ^{
        [self goToDetalheClippingViewController:[NSMutableArray arrayWithObjects:title,pDate,@"0",content,comment,pID,status,pUrl,ary, nil]];
    };
    
    [section.topLines addObject:lineHeader1];
    //FIM Titulo Clipping
    
    NSString * data = [NSString stringWithFormat:@"%@ - %@", waffleHeader2 , waffle2];
    // stuff
    MGLineStyled *lineHeader2 = [MGLineStyled multilineWithText:data  font:NORMAL_FONT width:304
                                                        padding:UIEdgeInsetsMake(7, 16, 7, 16)];
    lineHeader2.borderStyle &= ~MGBorderEtchedTop;
    lineHeader2.backgroundColor = [UIColor colorWithRed:240/255.0f
                                                  green:240/255.0f
                                                   blue:240/255.0f
                                                  alpha:1.0f];
    lineHeader2.textColor = [UIColor colorWithRed:102/255.0f
                                            green:102/255.0f
                                             blue:102/255.0f
                                            alpha:1.0f];
    lineHeader2.onTap = ^{
        [self goToDetalheClippingViewController:[NSMutableArray arrayWithObjects:title,pDate,@"0",content,comment,pID,status,pUrl,ary, nil]];
    };
    [section.topLines addObject:lineHeader2];
    
    [scroller scrollToView:section withMargin:8];
}



- (NSString *)decodeHTMLCharacterEntities:(NSString*)str {
    if ([str rangeOfString:@"&"].location == NSNotFound) {
        return str;
    } else {
        NSMutableString *escaped = [NSMutableString stringWithString:str];
        NSArray *codes = [NSArray arrayWithObjects:
                          @"&nbsp;", @"&iexcl;", @"&cent;", @"&pound;", @"&curren;", @"&yen;", @"&brvbar;",
                          @"&sect;", @"&uml;", @"&copy;", @"&ordf;", @"&laquo;", @"&not;", @"&shy;", @"&reg;",
                          @"&macr;", @"&deg;", @"&plusmn;", @"&sup2;", @"&sup3;", @"&acute;", @"&micro;",
                          @"&para;", @"&middot;", @"&cedil;", @"&sup1;", @"&ordm;", @"&raquo;", @"&frac14;",
                          @"&frac12;", @"&frac34;", @"&iquest;", @"&Agrave;", @"&Aacute;", @"&Acirc;",
                          @"&Atilde;", @"&Auml;", @"&Aring;", @"&AElig;", @"&Ccedil;", @"&Egrave;",
                          @"&Eacute;", @"&Ecirc;", @"&Euml;", @"&Igrave;", @"&Iacute;", @"&Icirc;", @"&Iuml;",
                          @"&ETH;", @"&Ntilde;", @"&Ograve;", @"&Oacute;", @"&Ocirc;", @"&Otilde;", @"&Ouml;",
                          @"&times;", @"&Oslash;", @"&Ugrave;", @"&Uacute;", @"&Ucirc;", @"&Uuml;", @"&Yacute;",
                          @"&THORN;", @"&szlig;", @"&agrave;", @"&aacute;", @"&acirc;", @"&atilde;", @"&auml;",
                          @"&aring;", @"&aelig;", @"&ccedil;", @"&egrave;", @"&eacute;", @"&ecirc;", @"&euml;",
                          @"&igrave;", @"&iacute;", @"&icirc;", @"&iuml;", @"&eth;", @"&ntilde;", @"&ograve;",
                          @"&oacute;", @"&ocirc;", @"&otilde;", @"&ouml;", @"&divide;", @"&oslash;", @"&ugrave;",
                          @"&uacute;", @"&ucirc;", @"&uuml;", @"&yacute;", @"&thorn;", @"&yuml;",@"&rarr;", nil];
        
        NSUInteger i, count = [codes count];
        
        // Html
        for (i = 0; i < count; i++) {
            NSRange range = [str rangeOfString:[codes objectAtIndex:i]];
            if (range.location != NSNotFound) {
                unichar codeValue0 = 160 + i;
                [escaped replaceOccurrencesOfString:[codes objectAtIndex:i]
                                         withString:[NSString stringWithFormat:@"%C", codeValue0]
                                            options:NSLiteralSearch
                                              range:NSMakeRange(0, [escaped length])];
            }
        }
        
        // The following five are not in the 160+ range
        
        // @"&amp;"
        NSRange range = [str rangeOfString:@"&amp;"];
        if (range.location != NSNotFound) {
             unichar codeValue1 = 38;
            [escaped replaceOccurrencesOfString:@"&amp;"
                                     withString:[NSString stringWithFormat:@"%C", codeValue1]
                                        options:NSLiteralSearch
                                          range:NSMakeRange(0, [escaped length])];
        }
        
        // @"&lt;"
        range = [str rangeOfString:@"&lt;"];
        if (range.location != NSNotFound) {
            unichar codeValue2 = 60;
            [escaped replaceOccurrencesOfString:@"&lt;"
                                     withString:[NSString stringWithFormat:@"%C", codeValue2]
                                        options:NSLiteralSearch
                                          range:NSMakeRange(0, [escaped length])];
        }
        
        // @"&gt;"
        range = [str rangeOfString:@"&gt;"];
        if (range.location != NSNotFound) {
            unichar codeValue3 = 62;
            [escaped replaceOccurrencesOfString:@"&gt;"
                                     withString:[NSString stringWithFormat:@"%C", codeValue3]
                                        options:NSLiteralSearch
                                          range:NSMakeRange(0, [escaped length])];
        }
        
        // @"&apos;"
        range = [str rangeOfString:@"&apos;"];
        if (range.location != NSNotFound) {
            unichar codeValue4 = 39;
            [escaped replaceOccurrencesOfString:@"&apos;"
                                     withString:[NSString stringWithFormat:@"%C", codeValue4]
                                        options:NSLiteralSearch
                                          range:NSMakeRange(0, [escaped length])];
        }
        
        // @"&quot;"
        range = [str rangeOfString:@"&quot;"];
        if (range.location != NSNotFound) {
            unichar codeValue5 = 34;
            [escaped replaceOccurrencesOfString:@"&quot;"
                                     withString:[NSString stringWithFormat:@"%C", codeValue5]
                                        options:NSLiteralSearch
                                          range:NSMakeRange(0, [escaped length])];
        }
        
        // @"&hellip;"
        range = [str rangeOfString:@"&hellip;"];
        if (range.location != NSNotFound) {
            
            [escaped replaceOccurrencesOfString:@"&hellip;"
                                     withString:[NSString stringWithFormat:@"%@", @"..."]
                                        options:NSLiteralSearch
                                          range:NSMakeRange(0, [escaped length])];
        }
        
        // Decimal & Hex
        NSRange start, finish, searchRange = NSMakeRange(0, [escaped length]);
        i = 0;
        
        while (i < [escaped length]) {
            start = [escaped rangeOfString:@"&#"
                                   options:NSCaseInsensitiveSearch
                                     range:searchRange];
            
            finish = [escaped rangeOfString:@";"
                                    options:NSCaseInsensitiveSearch
                                      range:searchRange];
            
            if (start.location != NSNotFound && finish.location != NSNotFound &&
                finish.location > start.location) {
                NSRange entityRange = NSMakeRange(start.location, (finish.location - start.location) + 1);
                NSString *entity = [escaped substringWithRange:entityRange];
                NSString *value = [entity substringWithRange:NSMakeRange(2, [entity length] - 2)];
                
                [escaped deleteCharactersInRange:entityRange];
                
                if ([value hasPrefix:@"x"]) {
                    unsigned tempInt = 0;
                    unichar se = tempInt;
                    NSScanner *scanner = [NSScanner scannerWithString:[value substringFromIndex:1]];
                    [scanner scanHexInt:&tempInt];
                    [escaped insertString:[NSString stringWithFormat:@"%C", se] atIndex:entityRange.location];
                } else {
                    unichar se2 = [value intValue];
                    [escaped insertString:[NSString stringWithFormat:@"%C", se2] atIndex:entityRange.location];
                } i = start.location;
            } else { i++; }
            searchRange = NSMakeRange(i, [escaped length] - i);
        }
        
        return escaped;    // Note this is autoreleased
    }
}


-(void)setGoDetailType:(BOOL)type
{
    useWebBrowserAsDetail = type;
  
        
}


-(void)goToDetailViewController:(NSArray*)data{
    
    
    if(useWebBrowserAsDetail == YES)
    {
        
        
        
        iPhoneWebView *ip = [[iPhoneWebView alloc] init];
        NSString *bump5 = [[data objectAtIndex:3] stringByReplacingOccurrencesOfString:@"www.facebook" withString:@"m.facebook"];
        [ip loadUrlInWebView:bump5];
    
        [self.navigationController  pushViewController:ip animated:YES];
        
        
    }
    else
    {
          NSLog(@"Problem 1 ");
    FullStoryViewController *det = [[FullStoryViewController alloc] initWithNibName:@"FullStoryViewController" bundle:nil];
    [det setShowCommment:YES];
    [det insertData:data];
        
      
    det.title = [data objectAtIndex:0];
    [self.navigationController pushViewController:det animated:YES];
         NSLog(@"Problem 2 ");
    }
    
    [[AppDelegate instance] refreshAdMobBanner];
}

//DETALHE DO CLIPPING
-(void)goToDetalheClippingViewController:(NSMutableArray*)data{
    
    
    if(useWebBrowserAsDetail == YES)
    {
        
        
        
        iPhoneWebView *ip = [[iPhoneWebView alloc] init];
        NSString *bump5 = @"teste";//[[data objectAtIndex:3] stringByReplacingOccurrencesOfString:@"www.facebook" withString:@"m.facebook"];
        [ip loadUrlInWebView:bump5];
        
        [self.navigationController  pushViewController:ip animated:YES];
        
    }
    else
    {
        // NSString *post =[[NSString alloc] initWithFormat:@"acesso=%@&userUid_pessoa=%@",@"classificacao",@"806"];
        NSString *post =[[NSString alloc] initWithFormat:@"acesso=%@&userUid_pessoa=%@&classificacao_id=%@",@"consulta_detalhe",@"806",[data objectAtIndex:5]];
        
        //NSString *post =[[NSString alloc] initWithFormat:@"nome=%@&password=%@&tag=login",@"edenred_dea",@"edenred_dea"];
        
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:@"http://www.sinosistema.net/sgc/android_webservice/index_ios.php"];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        //Recebe
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==<=>> %@", responseData);
        
        SBJsonParser *jsonParser = [SBJsonParser new];
        NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
        NSLog(@"--<=>> %@",jsonData);
        
        //Fim Recebe
        //FIM JSON
        
       /* NSArray *classificacao_nome = [jsonData valueForKey:@"classificacao_nome"];
        
        NSArray *cmp_clipping_id = [jsonData valueForKey:@"cmp_clipping_id"];
        NSArray *titulo_clipping = [jsonData valueForKey:@"titulo"];
        NSArray *cmp_veiculo_nome = [jsonData valueForKey:@"cmp_veiculo_nome"];
        NSArray *data_publicacao = [jsonData valueForKey:@"data_publicacao"];
        
        
        
        //int size = [idArray count];
        //NSLog(@"there are %d objects in the array", size);
        
        // With a traditional for loop
        NSString *control_cabecalho_classificacao = @"";
        NSString *cabecalho_classificacao = @"";
        
        for (int i=0; i<[cmp_clipping_id count]; i++) {
            
            NSString * str_nome_classificacao = classificacao_nome[i];
            if([control_cabecalho_classificacao isEqualToString: str_nome_classificacao])
            {
                cabecalho_classificacao = @"";
            }
            else
            {
                //NSLog(@"---> %@",[NSString stringWithFormat:@"%@%@", control_cabecalho_classificacao , classificacao_nome[i]]);
                control_cabecalho_classificacao = str_nome_classificacao;
                cabecalho_classificacao = str_nome_classificacao;
            }
            
           // [recentPost addObject:[NSArray arrayWithObjects: cmp_clipping_id[i], titulo_clipping[i], data_publicacao[i], @"0",cabecalho_classificacao, cmp_veiculo_nome[i],@"3",@"close",@"1",@"2",@"",@"",@"",@"",@"",@"", nil]];
        }*/
        
        NSString *cmp_clipping_descricao = [jsonData valueForKey:@"descricao"];
        NSString *cmp_clipping_header = [jsonData valueForKey:@"header"];
  
        [data replaceObjectAtIndex:3 withObject:cmp_clipping_descricao];
        [data replaceObjectAtIndex:1 withObject:cmp_clipping_header];

          NSLog(@"--<=>> %@",cmp_clipping_header);
                  NSLog(@"--<=>> %@",[data objectAtIndex:1]);
        NSLog(@"--<=>> %@",[data objectAtIndex:2]);
                          NSLog(@"--<=>> %@",[data objectAtIndex:3]);
                          NSLog(@"--<=>> %@",[data objectAtIndex:4]);
                          NSLog(@"--<=>> %@",[data objectAtIndex:5]);
                          NSLog(@"--<=>> %@",[data objectAtIndex:6]);
                                  NSLog(@"--<=>> %@",[data objectAtIndex:7]);
                                  NSLog(@"--<=>> %@",[data objectAtIndex:8]);
        NSLog(@"Problem 1 ");
        FullStoryViewController *det = [[FullStoryViewController alloc] initWithNibName:@"FullStoryViewController" bundle:nil];
        [det setShowCommment:YES];
       // [det insertDataClipping:data];
        //[det insertData:data];
        
        
        
        det.title = [data objectAtIndex:0];
        [self.navigationController pushViewController:det animated:YES];
        NSLog(@"Problem 2 ");
    }
    
   // [[AppDelegate instance] refreshAdMobBanner];
}
//FIM DETALHE DO CLIPPING

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UIScrollViewDelegate Method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = [self tableScrollOffset];
    
    if (offset >= 0.0f) {
       
          [[[AppDelegate instance] getUILabel] setText:NSLocalizedString(@"home_load_more", nil)];
        
    } else if (offset <= 0 && offset >= -fixedHeight) {
        
        if([self detectEndofScroll])
        {
         
               [[[AppDelegate instance] getUILabel] setText:NSLocalizedString(@"home_release", nil)];
        }
        else
        {
           [[[AppDelegate instance] getUILabel] setText:NSLocalizedString(@"home_pull", nil)]; 
        }
        
        
    } else {
        
       
    }

}


-(void)changeToDefaultViewController{
    NSLog(@"Back To Default");
    [mapGroup.view removeFromSuperview];
   
    [self viewDidLoad];
}

-(void)changeToMapController:(NSArray*)ary{
    NSLog(@"%@",ary);
    [scroller removeFromSuperview];
    [mapGroup.view removeFromSuperview];
    
    [self performSelectorOnMainThread:@selector(initMapViewMainThread:) withObject:ary waitUntilDone:YES];
    
}

-(void)initMapViewMainThread:(NSArray*)ary{
   

    
mapGroup = [[mapViewViewController alloc] initWithNibName:@"mapViewViewController" bundle:nil];
[mapGroup addMultiAnnotation:ary];
[self.view addSubview:mapGroup.view];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //if (isLoading) return;
    
    

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
   // [(id)scrollView snapToNearestBox];
    
    
    
    
    
}


- (CGFloat)tableScrollOffset {
    
    CGFloat offset = 0.0f;
    
    if ([scroller contentSize].height < CGRectGetHeight([scroller frame])) {
        
        offset = -[scroller contentOffset].y;
        
    } else {
        
        offset = ([scroller contentSize].height - [scroller contentOffset].y) - CGRectGetHeight([scroller frame]);
    }
    
    return offset;
}


- (BOOL)detectEndofScroll{
    
    BOOL scrollResult;
    CGPoint offset = scroller.contentOffset;
    CGRect bounds = scroller.bounds;
    CGSize size =scroller.contentSize;
    UIEdgeInsets inset = scroller.contentInset;
    float yaxis = offset.y + bounds.size.height - inset.bottom;
    float h = size.height+50;
    if(yaxis > h) {
        scrollResult = YES;
    }else{
        scrollResult = NO;
    }
    
    return scrollResult;
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    
    
    
    
    if ([self detectEndofScroll]){
        
        if([[AppDelegate instance] getTotalPage] == [[AppDelegate instance] getCurrentPage])
        {
            
        }
        else
        {
        
            if([[AppDelegate instance] getTweetIndi] == YES)
            {
                [self performSelectorOnMainThread:@selector(endlessTwitter) withObject:nil waitUntilDone:FALSE];
            }
            else
            {
            
        [self performSelectorOnMainThread:@selector(endless) withObject:nil waitUntilDone:FALSE];
            }
        currentOldPost = [[[AppDelegate instance] getRecentPostArray] count]+1;
            
        }
       
        
    }
    else {
        
               
    }
}


- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if(useWebBrowserAsDetail == YES)
        {
            if([[AppDelegate instance] getTweetIndi] == YES)
            {
                [[AppDelegate instance] goToTwitterPage:[[[AppDelegate instance] getTwitterArray] objectAtIndex:0] pName:[[[AppDelegate instance] getTwitterArray] objectAtIndex:1]];
            }
            else
            {
                
            }
            
        }
        else
        {
            if([[AppDelegate instance] getHomeIndicator] == YES)
            {
            [[AppDelegate instance] downloadScrollBlogSettings];
            [[AppDelegate instance] setMethodUrl:[NSString stringWithFormat:@"get_recent_post&cat=%@",[[[AppDelegate instance] getSettingArray] objectAtIndex:0]]];
            }
            [[AppDelegate instance] downloadRecentPostJson];
        
        
        
        [self refreshLayout];
        }
        [refreshControl endRefreshing];
    });
}

-(void)goToTop{
    
    [scroller setContentOffset:CGPointMake(scroller.contentOffset.x, 0)
                             animated:YES];
}


//Monta lista interna do menu principal
-(void)refreshLayout{
    
    datelabeltipo.hidden = YES;
    datelabel.hidden = YES;
    btn_buscar.hidden = YES;
    
        [scroller.boxes removeAllObjects];
        for(int i = 0;i<[[[AppDelegate instance] getRecentPostArray] count];i++)
        {
            
          /*  [self addBoxClippings:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
            */
            
            if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:8] intValue] == 1)
            {
                
                if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] isEqualToString:@"0"])
                {
                    //LISTA DE CLASSIFICACOES
                     [self addBoxClippings:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                }
                else
                {
                    [self addBoxWithImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] imageUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] shortDesc:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                    
                }
                
            }
            else if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:8] intValue] == 2)
            {
                if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] isEqualToString:@"0"])
                {
                    
                    [self addBoxWithNoImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                }
                else
                {
                    [self fullImageBox:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] title:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                    
                }
                
                
            }
            else if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:8] intValue] == 3)
            {
                if([[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] isEqualToString:@"0"])
                {
                    
                    [self addBoxWithNoImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] shortDesc:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                }
                else
                {
                    [self addBoxWithTopImage:[self decodeHTMLCharacterEntities:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:1]] pDate:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:5] imageUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:3] shortDesc:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:2] fullContent:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:4] jsonComment:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:6] postID:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:0] comment_status:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:7] pUrl:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:9] extra:[NSArray arrayWithObjects:[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:10],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:11],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:12],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:13],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:14],[[[[AppDelegate instance] getRecentPostArray] objectAtIndex:i] objectAtIndex:15], nil]];
                    
                }
                
                
            }
             
         
        }
        
        if([[AppDelegate instance] getTotalPage] == [[AppDelegate instance] getCurrentPage])
        {
            
        }
        else
        {
            [self loadMore];
        }
        
        
        [scroller layoutWithSpeed:0.3 completion:nil];
        
  
    
}

-(void)refreshLayoutFiltro{
   
    [scroller.boxes removeAllObjects];
    [scroller layoutWithSpeed:0.3 completion:nil];
    
    btn_buscar = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn_buscar.frame = CGRectMake(200, 5,80,40); //The position and size of the button (x,y,width,height)
    [btn_buscar setBackgroundImage:[UIImage imageNamed:@"btn_padrao.png"] forState:UIControlStateNormal];
    [btn_buscar setTitle:@"Buscar" forState:UIControlStateNormal];
    [btn_buscar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_buscar addTarget:self
                       action:@selector(buscaclipping)
             forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.view addSubview:btn_buscar];
    
    //CAMPO DATA TIPO
    datelabeltipo = [[UILabel alloc] init];
    datelabeltipo.frame = CGRectMake(5, 50, 310, 40);
    datelabeltipo.textColor = [UIColor grayColor];
    datelabeltipo.font = [UIFont fontWithName:@"Verdana-Bold" size: 20.0];
    datelabeltipo.textAlignment = UITextAlignmentCenter;
    datelabeltipo.text = [NSString stringWithFormat:@"Filtrar por: Publicação"];
    
    datelabeltipo.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MostraDateTipo)];
    [datelabeltipo addGestureRecognizer:tapGesture2];
    [self.view addSubview:datelabeltipo];
    
    
    //Campo DATA
    datelabel = [[UILabel alloc] init];
    datelabel.frame = CGRectMake(5, 5, 180, 40);
    datelabel.textColor = [UIColor grayColor];
    datelabel.font = [UIFont fontWithName:@"Verdana-Bold" size: 20.0];
    datelabel.textAlignment = UITextAlignmentCenter;
    
    datelabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MostraDatePicker)];
    [datelabel addGestureRecognizer:tapGesture];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    datelabel.text = [NSString stringWithFormat:@"%@",
                      [df stringFromDate:[NSDate date]]];
    [self.view addSubview:datelabel];

    
}

-(void)MostraDatePicker{
    
    dateTipoPicker.hidden = YES;
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 250, 325, 300)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = NO;
    datePicker.date = [NSDate date];
    datePicker.maximumDate = [NSDate date];
    [datePicker addTarget:self
                   action:@selector(LabelChange:)
         forControlEvents:UIControlEventValueChanged ];
    
    //Aqui seta o valor que estiver na label
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd'/'MM'/'yyyy"];
    NSDate *anyDate = [dateFormat dateFromString:datelabel.text];
    [datePicker setDate:anyDate];
    //Aqui seta o valor que estiver na label
    
    [self.view addSubview:datePicker];
}

- (void)LabelChange:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    datelabel.text = [NSString stringWithFormat:@"%@",
                      [df stringFromDate:datePicker.date]];
}

-(void)MostraDateTipo{
    
    datePicker.hidden = YES;
    NSInteger *data_tipo = nil;
    
    NSString *data_tipo_select = datelabeltipo.text;
    if ([data_tipo_select isEqualToString:@"Filtrar por: Publicação"])
    {
        data_tipo = 0;
    }
    else
    {
        data_tipo = 1;
    }
    
    pickerDataTipo = [[NSMutableArray alloc] initWithObjects:@"Publicação", @"Inserção", nil];
    
    dateTipoPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 200, 300, 200)];
    dateTipoPicker.showsSelectionIndicator = YES;
    dateTipoPicker.hidden = NO;
    dateTipoPicker.delegate = self;
    [dateTipoPicker selectRow:data_tipo inComponent:0 animated:YES];
    [self.view addSubview:dateTipoPicker ];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView; {
    return 1;
}
//Rows in each Column

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component; {
    return 2;
}

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
-(NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerDataTipo objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    switch(row)
    {
            
        case 0:

            datelabeltipo.text = @"Filtrar por: Publicação"; //cmp_clipping_data_publicacao
            dateTipoPicker.hidden = YES;

        break;
        
        case 1:
            
            datelabeltipo.text = @"Filtrar por: Inserção"; //cmp_clipping_data_materia
            dateTipoPicker.hidden = YES;
            
        break;
    }
}


-(void)buscaclipping{
    
    [scroller.boxes removeAllObjects];
    
    //Pega data selecionada pelo usuario
    NSString *DataFiltro = datelabel.text;
    NSString *data_tipo = nil;
    
    NSString *data_tipo_select = datelabeltipo.text;
    if ([data_tipo_select isEqualToString:@"Filtrar por: Publicação"]) 
    {
        data_tipo = @"cmp_clipping_data_publicacao";
    }
    else
    {
        data_tipo = @"cmp_clipping_data_materia";
    }

    
    NSString *post =[[NSString alloc] initWithFormat:@"acesso=%@&userUid_pessoa=%@&user_data_busca=%@&data_tipo=%@",@"busca_clipping_classificacao",@"806",DataFiltro,data_tipo];
    NSLog(@"PostData: %@",post);
    
    NSURL *url=[NSURL URLWithString:@"http://www.sinosistema.net/sgc/android_webservice/index_ios.php"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    //Recebe
    NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"Response ==> %@", responseData);
    
    SBJsonParser *jsonParser = [SBJsonParser new];
    NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
    NSLog(@"--> %@",jsonData);
    
    //Fim Recebe
    //FIM JSON
    
    current_page = 1;
    total_page = 1;
    
    NSArray *classificacao_nome = [jsonData valueForKey:@"classificacao_nome"];
    
    NSArray *cmp_clipping_id = [jsonData valueForKey:@"cmp_clipping_id"];
    NSArray *titulo_clipping = [jsonData valueForKey:@"titulo"];
    //NSArray *cmp_veiculo_nome = [jsonData valueForKey:@"cmp_veiculo_nome"];
    NSArray *data_publicacao = [jsonData valueForKey:@"data_publicacao"];
    NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
    
    NSString *control_cabecalho_classificacao = @"";
    NSString *cabecalho_classificacao = @"";
    
    if(success == 1)
    {
    
    for (int i=0; i<[cmp_clipping_id count]; i++) {
        
        NSString * str_nome_classificacao = classificacao_nome[i];
        if([control_cabecalho_classificacao isEqualToString: str_nome_classificacao])
        {
            cabecalho_classificacao = @"";
        }
        else
        {
            control_cabecalho_classificacao = str_nome_classificacao;
            cabecalho_classificacao = str_nome_classificacao;
        }
        
        [self fullImageBox2:nil title:titulo_clipping[i] pDate:data_publicacao[i] fullContent:nil jsonComment:nil postID:nil comment_status:nil pUrl:nil extra:nil];
        datePicker.hidden = YES;
    }
        
    }
    else
    {
        [self alertStatus:@"Nenhum Clipping para esta data" :@"Consulta:"];
    }
    
    [scroller layoutWithSpeed:0.3 completion:nil];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) alertStatus:(NSString *)msg :(NSString *) title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
