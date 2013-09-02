//
//  NoConnectivityViewController.h
//  ScrollBlog
//
//  Created by Fahmi on 3/10/13.
//  Copyright (c) 2013 kruk8989. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoConnectivityViewController : UIViewController
@property(nonatomic,retain) IBOutlet UIButton *noInternetBtn;
@property(nonatomic,retain)IBOutlet UILabel *desc;
-(IBAction)noInternetBtn:(id)sender;

@end
