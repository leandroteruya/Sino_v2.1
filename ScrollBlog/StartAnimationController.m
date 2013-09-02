
#import "StartAnimationController.h"

@interface StartAnimationController ()

@end

@implementation StartAnimationController
@synthesize logo,activity;
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
    // Do any additional setup after loading the view from its nib.
    logo.alpha = 0.0;
    activity.hidden = NO;
     [activity startAnimating];
    [self fadeInImage];
}

- (void)fadeInImage
{
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:2.0];
    //bigLogo.alpha = 1.0;
    logo.alpha = 1.0;
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(aniDone:finished:context:)];
    [UIView commitAnimations];
    
}

- (void) aniDone:(NSString *) aniname finished:(BOOL) finished context:(void *) context
{
   
   
    
   sleep(1.5);
    
    [self performSelectorOnMainThread:@selector(startExe) withObject:nil waitUntilDone:NO];
}

-(void)startExe{
    [[AppDelegate instance] startApp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
