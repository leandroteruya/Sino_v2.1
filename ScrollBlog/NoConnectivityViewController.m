//
//  NoConnectivityViewController.m
//  ScrollBlog
//
//  Created by Fahmi on 3/10/13.
//  Copyright (c) 2013 kruk8989. All rights reserved.
//

#import "NoConnectivityViewController.h"

@interface NoConnectivityViewController ()

@end

@implementation NoConnectivityViewController
@synthesize noInternetBtn,desc;
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
    
    desc.text = NSLocalizedString(@"no_internet_desc", nil);
    noInternetBtn.titleLabel.text = NSLocalizedString(@"no_internet_btn", nil);
}

-(IBAction)noInternetBtn:(id)sender
{
    
    [[AppDelegate instance] checkConnectivity];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
