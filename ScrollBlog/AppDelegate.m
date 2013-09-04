
#import "AppDelegate.h"
#import "StartAnimationController.h"
#import "ViewController.h"
#import "PPRevealSideViewController.h"
#import "SBJson.h"
#import "PushToLeftViewController.h"
#import "MGScrollView.h"
#import "MGTableBoxStyled.h"
#import "MGLineStyled.h"
#import "PhotoBox.h"
#import "FullStoryViewController.h"
#import "iPhoneWebView.h"
#import "ContactUsViewController.h"
#import "Reachability.h"
#import "NoConnectivityViewController.h"

@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end

@implementation AppDelegate

//static NSString *url = @"http://www.aemob.com"; //change your wordpress url here
static NSString *url = @"http://scrollblog.practison.com";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
     
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    enableLandscapeMode = NO;
    
    #if !TARGET_IPHONE_SIMULATOR
    NSString *UUID = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    [self sendAnalyticsDeviceData:@"insert" deviceID:UUID deviceType:@"iPhone" deviceToken:@""];
    #endif
    
    
    
    [self defaultViewController];
    
    
    afterLaunch = launchOptions;
   
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window

{
        if(enableLandscapeMode == YES)
        {
        return UIInterfaceOrientationMaskAllButUpsideDown;
        }
        else{
           return UIInterfaceOrientationMaskPortrait;
        }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	
#if !TARGET_IPHONE_SIMULATOR
    
    
    NSLog(@"remote notification: %@",[userInfo description]);
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    
    NSString *alert = [apsInfo objectForKey:@"alert"];
    NSLog(@"Received Push Alert: %@", alert);
    
    
    
 
    
    NSString *messageBody = [[apsInfo objectForKey:@"alert"] objectForKey:@"body"];
    NSString *postID = [[apsInfo objectForKey:@"alert"] objectForKey:@"postID"];
    NSString *type = [[apsInfo objectForKey:@"alert"] objectForKey:@"type"];
    pushedPostID = postID;
    pushedType = type;
    NSLog(@"%@ %@",messageBody,postID);
    
    if([type isEqualToString:@"none"])
    {
        UIAlertView *noti = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns_title", nil)
                                                       message:messageBody
                                                      delegate:nil
                                             cancelButtonTitle:NSLocalizedString(@"apns_close_btn", nil)
                                             otherButtonTitles:nil];
        [noti show];
    }
    else
    {
    UIAlertView *noti = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns_title", nil)
                                                    message:messageBody
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"apns_close_btn", nil)
                                          otherButtonTitles:NSLocalizedString(@"apns_action_btn", nil),nil];
    [noti show];
    }
    
    
#endif
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"user pressed Button Indexed Close");
        // Any action can be performed here
    }
    else
    {
        NSLog(@"user pressed Button Indexed View");
        // Any action can be performed here
        
        if([pushedType isEqualToString:@"post"])
        {
        [self goToPost:pushedPostID];
        }
        else if([pushedType isEqualToString:@"page"])
        {
            [self goToPage:pushedPostID categoryName:@"Page"];
        }
        else if([pushedType isEqualToString:@"link"])
        {
            [self goCustomWeb:pushedPostID pName:pushedPostID];
        }
    }
}

-(void)getPushedNotification:(NSDictionary*)launchOptions{
    
    NSDictionary* userInfo = [launchOptions valueForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    
    
    NSString *messageBody = [[apsInfo objectForKey:@"alert"] objectForKey:@"body"];
     NSString *postID = [[apsInfo objectForKey:@"alert"] objectForKey:@"postID"];
    NSString *type = [[apsInfo objectForKey:@"alert"] objectForKey:@"type"];
    pushedPostID = postID;
    pushedType = type;
  
    if([messageBody length] > 0)
    {
        if([type isEqualToString:@"none"])
        {
            UIAlertView *noti = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns_title", nil)
                                                           message:messageBody
                                                          delegate:nil
                                                 cancelButtonTitle:NSLocalizedString(@"apns_close_btn", nil)
                                                 otherButtonTitles:nil];
            [noti show];
        }
        else
        {
            UIAlertView *noti = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns_title", nil)
                                                           message:messageBody
                                                          delegate:self
                                                 cancelButtonTitle:NSLocalizedString(@"apns_close_btn", nil)
                                                 otherButtonTitles:NSLocalizedString(@"apns_action_btn", nil),nil];
            [noti show];
        }
        
    }


}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
	
#if !TARGET_IPHONE_SIMULATOR
    
    
    NSString *deviceToken = [[[[devToken description]
                               stringByReplacingOccurrencesOfString:@"<"withString:@""]
                              stringByReplacingOccurrencesOfString:@">" withString:@""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"%@",deviceToken);
    
    NSString *UUID = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    [self sendAnalyticsDeviceData:@"update" deviceID:UUID deviceType:@"iPhone" deviceToken:deviceToken];
    
	//[self.viewController showHideRightBar:false];
    [self downloadScrollBlogSettings];
    NSLog(@"Subscribe");
#endif
}



/**
 * Failed to Register for Remote Notifications
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	
#if !TARGET_IPHONE_SIMULATOR
	
    
    NSLog(@"FailResgisterRemote Notification");
	
#endif
}



#pragma mark - PPRevealSideViewController delegate

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller willPushController:(UIViewController *)pushedController {
    
}

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller didPushController:(UIViewController *)pushedController {
    
}

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller willPopToController:(UIViewController *)centerController {
    
}

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller didPopToController:(UIViewController *)centerController {
    
}

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller didChangeCenterController:(UIViewController *)newCenterController {
    
}

- (BOOL) pprevealSideViewController:(PPRevealSideViewController *)controller shouldDeactivateDirectionGesture:(UIGestureRecognizer*)gesture forView:(UIView*)view {
    return NO;
}

- (PPRevealSideDirection)pprevealSideViewController:(PPRevealSideViewController*)controller directionsAllowedForPanningOnView:(UIView*)view {
    
    if ([view isKindOfClass:NSClassFromString(@"UIWebBrowserView")]) return PPRevealSideDirectionLeft | PPRevealSideDirectionRight;
    
    return PPRevealSideDirectionLeft | PPRevealSideDirectionRight | PPRevealSideDirectionTop | PPRevealSideDirectionBottom;
}


+ (AppDelegate *) instance {
	return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

-(void)setLandscapeMode:(BOOL)enable{
    
    enableLandscapeMode = enable;
}

-(void)turnOffSlideAnywhereSlide{
    
    PPRevealSideInteractions inter = PPRevealSideInteractionNone;
    
    inter |= PPRevealSideInteractionNavigationBar;
    
    self.revealSideViewController.panInteractionsWhenClosed = inter;
    
}


-(void)anywhereSlide{
    /*
    PPRevealSideInteractions inter = PPRevealSideInteractionNone;
    
    inter |= PPRevealSideInteractionNavigationBar;
    
    inter |= PPRevealSideInteractionContentView;
    
    self.revealSideViewController.panInteractionsWhenClosed = inter;
     */
     
}

-(void)pushLeftBtn{
    [self.revealSideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

-(NSString*)getURL{
    return url;
}

-(void)initScrollBlog{
    recentPost = [[NSMutableArray alloc] init];
    previous_total_per_page = [[NSMutableArray alloc] init];
    pageMenu = [[NSMutableArray alloc] init];
    homeIndcator = YES;
    twitterIndicator = NO;
    
    [self setMethodUrl:[NSString stringWithFormat:@"get_recent_post&cat=%@",[scrollBlogSettings objectAtIndex:0]]];
}

-(void)setIndicatorTwitter:(BOOL)twiInd{
    
    twitterIndicator = twiInd;
    
}

-(BOOL)getTweetIndi{
    return twitterIndicator;
}

-(void)downloadPageMenu{
     [pageMenu removeAllObjects];
    NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?scrollblogkruk=pagemenu&parentID=0",url]];
    NSData *sa = [NSData dataWithContentsOfURL:urls];
    NSString *jsonString = [[NSString alloc] initWithData:sa encoding:NSUTF8StringEncoding];
    NSDictionary *result = [jsonString JSONValue];
    NSArray* menus = [result objectForKey:@"menu"];
    
    
     [pageMenu addObject:[NSArray arrayWithObjects:NSLocalizedString(@"home_btn", nil),@"homeBtn",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"", nil]];
     [pageMenu addObject:[NSArray arrayWithObjects:NSLocalizedString(@"classificacao_btn", nil),@"classificacaoBtn",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"", nil]];
     [pageMenu addObject:[NSArray arrayWithObjects:NSLocalizedString(@"filtro_btn", nil),@"filtroBtn",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"", nil]];
     /*[pageMenu addObject:[NSArray arrayWithObjects:NSLocalizedString(@"developers_btn", nil),@"developerBtn",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"", nil]];*/
    
     for (NSDictionary *menu in menus) {
         
        [pageMenu addObject:[NSArray arrayWithObjects:[menu objectForKey:@"name"],[menu objectForKey:@"type"],[menu objectForKey:@"objectID"],[menu objectForKey:@"parentID"],[menu objectForKey:@"postID"],[menu objectForKey:@"link"],[menu objectForKey:@"order"],[menu objectForKey:@"childcheck"],[menu objectForKey:@"child"],[menu objectForKey:@"thumb"],[menu objectForKey:@"twitter_page"],[menu objectForKey:@"oneclickcallnumber"],[menu objectForKey:@"oneclickmail"],[menu objectForKey:@"contact_us"], nil]];
     }
}

-(void)setTwitterArray:(NSArray*)ary{
    
    twitter = ary;
    
}

-(NSArray*)getTwitterArray{
    
    return twitter;
}

-(void)goToTwitterPage:(NSString*)link pName:(NSString*)pName{
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    
    [self.window addSubview:HUD];
    
    self.viewController.title = pName;
    [HUD showWhileExecuting:@selector(getTwitterFeed:) onTarget:self withObject:[NSArray arrayWithObjects:link, nil] animated:YES];
    
    
}

-(void)getTwitterFeed:(NSArray*)arg{
    
    [recentPost removeAllObjects];
    [previous_total_per_page removeAllObjects];
    
    
    current_page = 1;
    total_page = 18;
    
    NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=%@",[arg objectAtIndex:0]]];
    NSData *sa = [NSData dataWithContentsOfURL:urls];
    NSString *jsonString = [[NSString alloc] initWithData:sa encoding:NSUTF8StringEncoding];
    NSArray *results = [jsonString JSONValue];
   
     for (NSDictionary *result in results) {
         
         [recentPost addObject:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",@"0"],[NSString stringWithFormat:@"%@",[result objectForKey:@"text"]],@"",@"0",[NSString stringWithFormat:@"https://twitter.com/%@/status/%@",[arg objectAtIndex:0],[result objectForKey:@"id_str"]],[NSString stringWithFormat:@"%@",[result objectForKey:@"created_at"]],@"0",@"close",@"1",[NSString stringWithFormat:@"https://twitter.com/%@/status/%@",[arg objectAtIndex:0],[result objectForKey:@"id_str"]],@"",@"",@"",@"",@"",@"", nil]];
     }
    
    [previous_total_per_page addObject:[NSString stringWithFormat:@"18"]];
    
    [self performSelectorOnMainThread:@selector(refreswe) withObject:nil waitUntilDone:NO];
}

/* --------------------------- FILTRO ------------------------------------- */
//Nome do header no conteudo de primeiro nivel FILTRO
-(void)goToFiltro:(NSString*)link pName:(NSString*)pName{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    [self.window addSubview:HUD];
    self.viewController.title = @"Filtro";
    
    [HUD showWhileExecuting:@selector(getFiltro:) onTarget:self withObject:[NSArray arrayWithObjects:link, nil] animated:YES];
}

//Monta a lista de FILTRO
-(void)getFiltro:(NSArray*)arg{
    
    [recentPost removeAllObjects];
    [previous_total_per_page removeAllObjects];
    
    
   // [recentPost addObject:[NSArray arrayWithObjects: @"TESTE", @"TESTE @",@"",@"0",@"data",@"test",@"3",@"close",@"4",@"2",@"",@"",@"",@"",@"",@"", nil]];
    
    [self performSelectorOnMainThread:@selector(refreshFiltro) withObject:nil waitUntilDone:NO];
    
}

/* --------------------------- FILTRO ------------------------------------- */

//Nome do header no conteudo de primeiro nivel
-(void)goToRss:(NSString*)link pName:(NSString*)pName{
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    
    [self.window addSubview:HUD];
     self.viewController.title = pName;
    [HUD showWhileExecuting:@selector(getRSSFeed:) onTarget:self withObject:[NSArray arrayWithObjects:link, nil] animated:YES];

}

//Nome do header no conteudo de primeiro nivel
-(void)goToClassificacao:(NSString*)link pName:(NSString*)pName{

    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    [self.window addSubview:HUD];
    self.viewController.title = @"Classificações";
    
    [HUD showWhileExecuting:@selector(getClasificacoes:) onTarget:self withObject:[NSArray arrayWithObjects:link, nil] animated:YES];

}

//Monta a lista de clasificacoes
-(void)getClasificacoes:(NSArray*)arg{
    NSLog(@"Your message here3");
    [recentPost removeAllObjects];
    [previous_total_per_page removeAllObjects];
    //NSString *stringURL = [arg objectAtIndex:0];
    // NSURL  *urlsss = [NSURL URLWithString:stringURL];
    // NSData *urlData = [NSData dataWithContentsOfURL:urlsss];
    
    //JSON
    //data.put("acesso", "classificacao");
	//data.put("userUid_pessoa", SinoConstants.uid_pessoa);//uid_pessoa->583  // 806
    
    //Busca ID do usuario
    NSString *id_usuario = nil;
    NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask,
                                                             YES) objectAtIndex:0];
    NSString *dbPath = [dirPath stringByAppendingPathComponent:@"sino.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK)
    {
        const char *sql = "SELECT * FROM tbl_usuario";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Erro ao consultar banco");
        }
        else
        {
            while (sqlite3_step(sqlStatement)==SQLITE_ROW)
            {
                id_usuario = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,3)];
            }
        }
    }
    sqlite3_close(db);
    //FECHA Busca ID do usuario
    
    //NSString *post =[[NSString alloc] initWithFormat:@"acesso=%@&userUid_pessoa=%@",@"classificacao",@"806"];
    NSString *post =[[NSString alloc] initWithFormat:@"acesso=%@&userUid_pessoa=%@",@"seleciona_clipping_classificacao",id_usuario];
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
    
    //
    // NSData *sa = [NSData dataWithContentsOfURL:url];
    // NSString *jsonString = [[NSString alloc] initWithData:sa encoding:NSUTF8StringEncoding];
    //NSArray *results = [jsonString JSONValue];
    
    /*  for (NSDictionary *result in results) {
     
     [recentPost addObject:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",@"0"],[NSString stringWithFormat:@"%@",[result objectForKey:@"classificacao_titulo"]],[NSString stringWithFormat:@"%@",@"0"],[NSString stringWithFormat:@"%@",@"0"],[NSString stringWithFormat:@"https://twitter.com/%@/status/%@",[arg objectAtIndex:0],[result objectForKey:@"id_str"]],[NSString stringWithFormat:@"%@",[result objectForKey:@"created_at"]],@"0",@"close",@"1",[NSString stringWithFormat:@"https://twitter.com/%@/status/%@",[arg objectAtIndex:0],[result objectForKey:@"id_str"]],@"",@"",@"",@"",@"",@"", nil]];
     // NSLog(@"Response ==> %@", [NSString stringWithFormat:@"%@",[result objectForKey:@"classificacao_titulo"]]);
     [recentPost addObject:[NSArray arrayWithObjects: @"Classificacao 1",@"Titulo 1",@"description 1",@"0",@"data",@"test",@"0",@"close",@"1",@"2",@"",@"",@"",@"",@"",@"", nil]];
     }*/
    //
    
    //Recebe
    NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    NSLog(@"Response ==> %@", responseData);
    
    SBJsonParser *jsonParser = [SBJsonParser new];
    NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
    NSLog(@"--> %@",jsonData);
    
    //  NSString *idValues = [jsonData valueForKey:@"classificacao_id"];
    //  NSString *classificacaoValues = [jsonData valueForKey:@"classificacao_titulo"];
    
    // NSArray *idArray = [idValues componentsSeparatedByString:@","];
    // NSArray *classificacaoArray = [classificacaoValues componentsSeparatedByString:@","];
    
    
    
    // NSLog(@"----> %@",values);
    //    NSArray *existingSection2 =[jsonData valueForKey:@"classificacao_id"];
    NSArray *keys;
    int i, count;
    id key, value;
    
    keys = [jsonData allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [jsonData objectForKey: key];
        NSLog (@"Key: %@ for value: => %@", key, value);
    }
    
    for (NSString *result in jsonData) {
        
        /* [recentPost addObject:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",@"0"],[NSString stringWithFormat:@"%@",[result objectForKey:@"classificacao_titulo"]],[NSString stringWithFormat:@"%@",@"0"],[NSString stringWithFormat:@"%@",@"0"],[NSString stringWithFormat:@"https://twitter.com/%@/status/%@",[arg objectAtIndex:0],[result objectForKey:@"id_str"]],[NSString stringWithFormat:@"%@",[result objectForKey:@"created_at"]],@"0",@"close",@"1",[NSString stringWithFormat:@"https://twitter.com/%@/status/%@",[arg objectAtIndex:0],[result objectForKey:@"id_str"]],@"",@"",@"",@"",@"",@"", nil]];*/
        // NSLog(@"Response ==> %@", [NSString stringWithFormat:@"%@",[result objectForKey:@"classificacao_titulo"]]);
        //    [recentPost addObject:[NSArray arrayWithObjects: @"Classificacao 1",[jsonData objectForKey:@"classificacao_titulo"],@"description 1",@"0",@"data",@"test",@"0",@"close",@"1",@"2",@"",@"",@"",@"",@"",@"", nil]];
    }
    
    //Fim Recebe
    //FIM JSON
    
    current_page = 1;
    total_page = 1;
    
    /*RXMLElement *rxml = [RXMLElement elementFromXMLData:urlData];
     [rxml iterate:@"channel.item" with: ^(RXMLElement *sa) {
     [recentPost addObject:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",@"0"],[NSString stringWithFormat:@"%@",[sa child:@"title"]],[NSString stringWithFormat:@"%@",[sa child:@"description"]],@"0",[NSString stringWithFormat:@"%@",[sa child:@"link"]],[NSString stringWithFormat:@"%@",[sa child:@"pubDate"]],@"0",@"close",@"1",[NSString stringWithFormat:@"%@",[sa child:@"link"]],@"",@"",@"",@"",@"",@"", nil]];
     }];*/
    
    NSArray *classificacao_nome = [jsonData valueForKey:@"classificacao_nome"];
    
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
        
        [recentPost addObject:[NSArray arrayWithObjects: cmp_clipping_id[i], titulo_clipping[i], data_publicacao[i], @"0",cabecalho_classificacao, cmp_veiculo_nome[i],@"3",@"close",@"1",@"2",@"",@"",@"",@"",@"",@"", nil]];
    }
    
    [self performSelectorOnMainThread:@selector(refreswe) withObject:nil waitUntilDone:NO];
}


-(void)getRSSFeed:(NSArray*)arg{
    
    [recentPost removeAllObjects];
    [previous_total_per_page removeAllObjects];
    NSString *stringURL = [arg objectAtIndex:0];
    NSURL  *urlsss = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:urlsss];
    
    current_page = 1;
    total_page = 1;
    
    RXMLElement *rxml = [RXMLElement elementFromXMLData:urlData];
    
    
    
    [rxml iterate:@"channel.item" with: ^(RXMLElement *sa) {
        
        [recentPost addObject:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",@"0"],[arg objectAtIndex:0] ,  [arg objectAtIndex:0] ,@"0",[NSString stringWithFormat:@"%@",[sa child:@"link"]],[NSString stringWithFormat:@"%@",[sa child:@"pubDate"]],@"0",@"close",@"1",[NSString stringWithFormat:@"%@",[sa child:@"link"]],@"",@"",@"",@"",@"",@"", nil]];
        
        
    }];

    [self performSelectorOnMainThread:@selector(refreswe) withObject:nil waitUntilDone:NO];
}   
-(void)addIndicator:(BOOL)ind{
    
    homeIndcator = ind;
}

-(BOOL)getHomeIndicator{
    
    return homeIndcator;
}

-(NSString *) stringByStrippingHTML:(NSString*)des {
    NSRange r;
    NSString *s = des;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

-(NSMutableArray*)getPageMenuArray{
    
    return pageMenu;
}


-(void)setMethodUrl:(NSString*)method{
    
    methodJson = method;
    NSLog(@"%@",methodJson);
}

-(NSString*)getCurrentMethodJson{
    
    return methodJson;
}


-(void)setDetailGoDetailType:(BOOL)is{
 
    [self.viewController setGoDetailType:is];
}

-(void)goCustomWeb:(NSString*)link pName:(NSString*)pageName{
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    
    [self.window addSubview:HUD];
    
    
    [HUD showWhileExecuting:@selector(customWebExe:) onTarget:self withObject:[NSArray arrayWithObjects:link,pageName, nil] animated:YES];
    
}

-(void)customWebExe:(NSArray*)arg{
    
    
    
     [self performSelectorOnMainThread:@selector(customWebExe2:) withObject:arg waitUntilDone:NO];
    
}

-(void)customWebExe2:(NSArray*)arg{
    iPhoneWebView *ip = [[iPhoneWebView alloc] init];
    [ip loadUrlInWebView:[arg objectAtIndex:0]];
    [self.revealSideViewController popViewControllerAnimated:YES];
    [self.viewController.navigationController  pushViewController:ip animated:YES];
}


-(void)goToPost:(NSString*)postID{
    
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    
    [self.window addSubview:HUD];
    
    
    [HUD showWhileExecuting:@selector(downloadPostContent:) onTarget:self withObject:[NSArray arrayWithObjects:postID, nil] animated:YES];
    
    
}



-(void)downloadPostContent:(NSArray*)data{
    NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?json=get_post&id=%@",url,[data objectAtIndex:0]]];
    NSData *sa = [NSData dataWithContentsOfURL:urls];
    NSString *jsonString = [[NSString alloc] initWithData:sa encoding:NSUTF8StringEncoding];
    NSDictionary *result = [jsonString JSONValue];
    NSDictionary* attribute = [result objectForKey:@"post"];
    
    id thumbnail = [attribute objectForKey:@"thumbnail"];
    NSString *featuredImage = @"";
    if (thumbnail != [NSNull null])
    {
        featuredImage = (NSString *)thumbnail;
    }
    else
    {
        featuredImage = @"0";
    }
    
    
    
    [self performSelectorOnMainThread:@selector(goToPostRe:) withObject:[NSArray arrayWithObjects:[attribute objectForKey:@"title"],[attribute objectForKey:@"date"],featuredImage,[attribute objectForKey:@"content"],[attribute objectForKey:@"comments"],[attribute objectForKey:@"id"],[attribute objectForKey:@"comment_status"],[attribute objectForKey:@"url"],[NSArray arrayWithObjects:[attribute objectForKey:@"specialBtn"],[attribute objectForKey:@"btnNameScrollBlog"],[attribute objectForKey:@"latScrollBlog"],[attribute objectForKey:@"longScrollBlog"],[attribute objectForKey:@"openWebUrlScrollBlog"],[attribute objectForKey:@"gallery"], nil], nil] waitUntilDone:NO];
}


-(void)goToPostRe:(NSArray*)arg{
    FullStoryViewController *det = [[FullStoryViewController alloc] initWithNibName:@"FullStoryViewController" bundle:nil];
   
    [det insertData:arg];
    det.title = [arg objectAtIndex:0];
    [self.revealSideViewController popViewControllerAnimated:YES];
    [self.viewController.navigationController pushViewController:det animated:YES];
}



-(void)goToPage:(NSString*)pageID categoryName:(NSString*)pageName{
    
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    
    [self.window addSubview:HUD];
    
    
    [HUD showWhileExecuting:@selector(downloadSinglePageContent:) onTarget:self withObject:[NSArray arrayWithObjects:pageID,pageName, nil] animated:YES];
    
    
}

-(void)downloadScrollBlogSettings{
    
     NSString *UUID = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?scrollblogkruk=settings-api&deviceID=%@",url,UUID]];
    NSData *sa = [NSData dataWithContentsOfURL:urls];
    NSString *jsonString = [[NSString alloc] initWithData:sa encoding:NSUTF8StringEncoding];
    NSDictionary *result = [jsonString JSONValue];
    NSDictionary* attribute = [result objectForKey:@"settings"];
    
    scrollBlogSettings = [NSArray arrayWithObjects:[attribute objectForKey:@"ExcludeCategories"],[attribute objectForKey:@"subscribe"],[attribute objectForKey:@"adMob"],[attribute objectForKey:@"removeAdsInAppPurchase"], nil];
    
    
}

-(void)downloadSinglePageContent:(NSArray*)data{
    NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?json=get_page&id=%@",url,[data objectAtIndex:0]]];
    NSData *sa = [NSData dataWithContentsOfURL:urls];
    NSString *jsonString = [[NSString alloc] initWithData:sa encoding:NSUTF8StringEncoding];
    NSDictionary *result = [jsonString JSONValue];
    NSDictionary* attribute = [result objectForKey:@"page"];
    
    id thumbnail = [attribute objectForKey:@"thumbnail"];
    NSString *featuredImage = @"";
    if (thumbnail != [NSNull null])
    {
        featuredImage = (NSString *)thumbnail;
    }
    else
    {
        featuredImage = @"0";
    }
   
    
    
    [self performSelectorOnMainThread:@selector(goToPageRe:) withObject:[NSArray arrayWithObjects:[attribute objectForKey:@"title"],@"",featuredImage,[attribute objectForKey:@"content"],[attribute objectForKey:@"comments"],[attribute objectForKey:@"id"],@"close",[attribute objectForKey:@"url"],[NSArray arrayWithObjects:[attribute objectForKey:@"specialBtn"],[attribute objectForKey:@"btnNameScrollBlog"],[attribute objectForKey:@"latScrollBlog"],[attribute objectForKey:@"longScrollBlog"],[attribute objectForKey:@"openWebUrlScrollBlog"],[attribute objectForKey:@"gallery"], nil], nil] waitUntilDone:NO];
}

-(void)goToPageRe:(NSArray*)arg{
    FullStoryViewController *det = [[FullStoryViewController alloc] initWithNibName:@"FullStoryViewController" bundle:nil];
    [det setShowCommment:NO];
    [det insertData:arg];
    det.title = [arg objectAtIndex:0];
    [self.revealSideViewController popViewControllerAnimated:YES];
    [self.viewController.navigationController pushViewController:det animated:YES];
}

-(void)getPostByID:(NSString*)ID{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    
    [self.window addSubview:HUD];
    
    
    [HUD showWhileExecuting:@selector(getPostByIDExe:) onTarget:self withObject:[NSArray arrayWithObjects:ID, nil] animated:YES];
    
}

-(void)getPostByIDExe:(NSArray*)ary{
    
    NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?json=get_post&id=%@",url,[ary objectAtIndex:0]]];
    NSData *sa = [NSData dataWithContentsOfURL:urls];
    NSString *jsonString = [[NSString alloc] initWithData:sa encoding:NSUTF8StringEncoding];
    
    
    NSDictionary *result = [jsonString JSONValue];
    NSDictionary* attribute = [result objectForKey:@"post"];
  
    
 
    
    id thumbnail = [attribute objectForKey:@"thumbnail"];
    NSString *featuredImage = @"";
    if (thumbnail != [NSNull null])
    {
        featuredImage = (NSString *)thumbnail;
    }
    else
    {
        featuredImage = @"0";
    }

    
    
    [self performSelectorOnMainThread:@selector(goFullStoryModeDetail:) withObject:[NSArray arrayWithObjects:[attribute objectForKey:@"title"],[attribute objectForKey:@"date"],featuredImage,[attribute objectForKey:@"content"],[attribute objectForKey:@"comments"],[attribute objectForKey:@"id"],[attribute objectForKey:@"comment_status"],[attribute objectForKey:@"url"],[NSArray arrayWithObjects:[attribute objectForKey:@"specialBtn"],[attribute objectForKey:@"btnNameScrollBlog"],[attribute objectForKey:@"latScrollBlog"],[attribute objectForKey:@"longScrollBlog"],[attribute objectForKey:@"openWebUrlScrollBlog"],[attribute objectForKey:@"gallery"], nil], nil] waitUntilDone:NO];
}


-(void)goFullStoryModeDetail:(NSArray*)arg{
    FullStoryViewController *det = [[FullStoryViewController alloc] initWithNibName:@"FullStoryViewController" bundle:nil];
    [det setShowCommment:YES];
    [det insertData:arg];
    det.title = [arg objectAtIndex:0];
    [self.revealSideViewController popViewControllerAnimated:YES];
    [self.viewController.navigationController pushViewController:det animated:YES];
}

-(void)backToHome{
     
    self.viewController.title = NSLocalizedString(@"home_title", nil);
    
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    
    [self.window addSubview:HUD];
    
    
    [HUD showWhileExecuting:@selector(exeChangeCat:) onTarget:self withObject:[NSArray arrayWithObjects:@"",@"", nil] animated:YES];
    
    
}

-(void)changeViewControllerTitle:(NSString*)str{
    
     self.viewController.title = str;
}

-(void)searchPost:(NSString*)searchString{
    
    [self setMethodUrl:[NSString stringWithFormat:@"get_search_results&search=%@",searchString]];
   
    
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    
    [self.window addSubview:HUD];
    
    
    [HUD showWhileExecuting:@selector(exeChangeCat2:) onTarget:self withObject:[NSArray arrayWithObjects:@"",@"", nil] animated:YES];
    
    
}


-(void)changeCategory:(NSString*)currentID categoryName:(NSString*)name{
    
     [self setMethodUrl:[NSString stringWithFormat:@"get_category_posts&id=%@",currentID]];
    self.viewController.title = name;
    
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    
    [self.window addSubview:HUD];
    
    
    [HUD showWhileExecuting:@selector(exeChangeCat2:) onTarget:self withObject:[NSArray arrayWithObjects:currentID,name, nil] animated:YES];

    
}

-(void)exeChangeCat2:(NSArray*)arg{
    
    [self downloadRecentPostJson];
    [self performSelectorOnMainThread:@selector(refreswe) withObject:nil waitUntilDone:NO];

}


-(void)exeChangeCat:(NSArray*)arg{
   
    [[AppDelegate instance] downloadScrollBlogSettings];
    [[AppDelegate instance] setMethodUrl:[NSString stringWithFormat:@"get_recent_post&cat=%@",[[[AppDelegate instance] getSettingArray] objectAtIndex:0]]];
    
    [self downloadRecentPostJson];
  
    
    
    
    
   [self performSelectorOnMainThread:@selector(refreswe) withObject:nil waitUntilDone:NO];
    
       
}

-(NSArray*)getSettingArray{
    
    return scrollBlogSettings;
}

-(void)refreswe{
   
    
        [self.viewController refreshLayout];
        [self.revealSideViewController popViewControllerAnimated:YES];
        [self.viewController goToTop];
        [self.viewController.navigationController popToRootViewControllerAnimated:YES];
}

-(void)refreshFiltro{
    
    
    [self.viewController refreshLayoutFiltro];
    [self.revealSideViewController popViewControllerAnimated:YES];
    [self.viewController goToTop];
    [self.viewController.navigationController popToRootViewControllerAnimated:YES];
}

-(void)setCurrentMGScrollView:(MGScrollView*)sc{
    
    currentScrollView = sc;
}

-(MGScrollView*)getCurrentScrollView{
    
    return currentScrollView;
}

-(void)downloadRecentPostJson{
    
    [recentPost removeAllObjects];
    [previous_total_per_page removeAllObjects];
   
    
    NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?json=%@",url,methodJson]];
    NSData *sa = [NSData dataWithContentsOfURL:urls];
     NSString *jsonString = [[NSString alloc] initWithData:sa encoding:NSUTF8StringEncoding];
    
    
    NSDictionary *result = [jsonString JSONValue];
    NSArray* posts = [result objectForKey:@"posts"];
    total_page = [[result objectForKey:@"pages"] intValue];
    total_post_per_page = [[result objectForKey:@"count"] intValue];
    
    [previous_total_per_page addObject:[result objectForKey:@"count"]];
    
    current_page = 1;
    
    for (NSDictionary *post in posts) {
       
        id thumbnail = [post objectForKey:@"thumbnail"];
        NSString *featuredImage = @"";
        if (thumbnail != [NSNull null])
        {
            featuredImage = (NSString *)thumbnail;
        }
        else
        {
            featuredImage = @"0";
        }
        
        
      
        
        [recentPost addObject:[NSArray arrayWithObjects:[post objectForKey:@"id"],[post objectForKey:@"title_plain"],[post objectForKey:@"excerpt"],featuredImage,[post objectForKey:@"content"],[post objectForKey:@"date"],[post objectForKey:@"comments"],[post objectForKey:@"comment_status"],[post objectForKey:@"scrollBlogTemplate"],[post objectForKey:@"url"],[post objectForKey:@"specialBtn"],[post objectForKey:@"btnNameScrollBlog"],[post objectForKey:@"latScrollBlog"],[post objectForKey:@"longScrollBlog"],[post objectForKey:@"openWebUrlScrollBlog"],[post objectForKey:@"gallery"], nil]];
        
    }

  
    
   
    
}
-(void)endlessRecentTwitterJson{
    
    int plus1 = current_page +1;
    
    current_page = plus1;
    NSLog(@"Delegate Current Page %d",current_page);
    NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=%@&page=%d",[[self getTwitterArray] objectAtIndex:0],current_page]];
    
    NSData *sa = [NSData dataWithContentsOfURL:urls];
    NSString *jsonString = [[NSString alloc] initWithData:sa encoding:NSUTF8StringEncoding];
    NSArray *results = [jsonString JSONValue];
    
    
    total_page = 20;
    
    [previous_total_per_page addObject:[NSString stringWithFormat:@"18"]];
      NSLog(@"problem");
    for (NSDictionary *result in results) {
               
        [recentPost addObject:[NSArray arrayWithObjects:
                               @"0",
                               [result objectForKey:@"text"],
                               @"",
                               @"0",
                               @"",
                               [result objectForKey:@"created_at"],
                               @"",
                               @"close",
                               @"0",
                              [NSString stringWithFormat:@"https://twitter.com/%@/status/%@",[[self getTwitterArray] objectAtIndex:0],[result objectForKey:@"id_str"]],
                               @"",
                               nil]];
          
        
    }



   
    
}

-(void)endlessRecentPostJson{
    int plus1 = current_page +1;
    
    current_page = plus1;
    NSLog(@"Delegate Current Page %d",current_page);
    NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?json=%@&page=%d",url,methodJson,current_page]];
    NSData *sa = [NSData dataWithContentsOfURL:urls];
    NSString *jsonString = [[NSString alloc] initWithData:sa encoding:NSUTF8StringEncoding];
    
    
    NSDictionary *result = [jsonString JSONValue];
    NSArray* posts = [result objectForKey:@"posts"];
    total_page = [[result objectForKey:@"pages"] intValue];
    [previous_total_per_page addObject:[result objectForKey:@"count"]];
    
    for (NSDictionary *post in posts) {
        
        
        
        id thumbnail = [post objectForKey:@"thumbnail"];
        NSString *featuredImage = @"";
        if (thumbnail != [NSNull null])
        {
            featuredImage = (NSString *)thumbnail;
        }
        else
        {
            featuredImage = @"0";
        }
        
        [recentPost addObject:[NSArray arrayWithObjects:[post objectForKey:@"id"],[post objectForKey:@"title_plain"],[post objectForKey:@"excerpt"],featuredImage,[post objectForKey:@"content"],[post objectForKey:@"date"],[post objectForKey:@"comments"],[post objectForKey:@"comment_status"],[post objectForKey:@"scrollBlogTemplate"],[post objectForKey:@"url"],[post objectForKey:@"specialBtn"],[post objectForKey:@"btnNameScrollBlog"],[post objectForKey:@"latScrollBlog"],[post objectForKey:@"longScrollBlog"],[post objectForKey:@"openWebUrlScrollBlog"],[post objectForKey:@"gallery"], nil]];
        
    
        
    }
    
    
   
    
}

-(void)setCurrentPostID:(NSString*)pID{
    
    currentPostID = pID;
}

-(NSString*)getCurrentPostID{
    
    return currentPostID;
}

-(NSMutableArray*)getRecentPostArray{
    return recentPost;
}

-(NSMutableArray*)getPreviTotalArray{
    return previous_total_per_page;
}

-(void)setUiLabelLoadMore:(UILabel*)label{
    loadMore = label;
}

-(UILabel*)getUILabel{
    
    return loadMore;
}




-(void)setIndicatorView:(UIActivityIndicatorView*)ind{
    activityLoadMore = ind;
}

-(UIActivityIndicatorView*)getIndicatorView{
    
    return activityLoadMore;
}

-(int)getTotalPage{
    return total_page;
}

-(int)getCurrentPage{
    return current_page;
}

-(int)get_total_post_per_page{
    
    return total_post_per_page;
}

- (BOOL)hasFourInchDisplay {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}


-(void)postCommentiPhone:(NSData*)postData
{
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    
    [self.window addSubview:HUD];
    
    
    [HUD showWhileExecuting:@selector(postCommentExeiPhone:) onTarget:self withObject:[NSArray arrayWithObjects:postData, nil] animated:YES];
    
    
    
    
}

-(BOOL)checkSaveFileExist{
    
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* foofile = [documentsPath stringByAppendingPathComponent:@"saveString.dat"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
    
    if(fileExists == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    
}

-(NSMutableArray*)getFileSave{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //2) Create the full file path by appending the desired file name
    NSString *yourArrayFileName = [documentsDirectory stringByAppendingPathComponent:@"saveString.dat"];
    
    //Load the array
    NSMutableArray *tempStringArray = [[NSMutableArray alloc] initWithContentsOfFile: yourArrayFileName];
    
    return tempStringArray;
}

-(void)setSharedWebView:(UIWebView*)shared{
    
    sharedWebView = shared;
}


-(void)postCommentExeiPhone:(NSArray*)argArray{
    NSString *postLength = [NSString stringWithFormat:@"%d", [[argArray objectAtIndex:0] length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/wp-comments-post.php",[self getURL]]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[argArray objectAtIndex:0]];
    
    NSURLResponse *response;
    NSError *err;
    [NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
    
    
    [self performSelectorOnMainThread:@selector(reloadcomment) withObject:nil waitUntilDone:NO];
    
    
    
}

-(void)sendAnalyticsDeviceData:(NSString*)type deviceID:(NSString*)deviceID deviceType:(NSString*)deviceType deviceToken:(NSString*)token{
    
    NSString *post =[NSString stringWithFormat:@"deviceID=%@&device=%@&pushTokenID=%@",deviceID,deviceType,token];
    
    

    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/?scrollblogkruk=analytics&type=%@",[self getURL],type]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLResponse *response;
    NSError *err;
    [NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
}


-(void)reloadcomment{
     [sharedWebView stringByEvaluatingJavaScriptFromString:@"reloadComment();"];
   /*
    UIScrollView *scroll = [sharedWebView.subviews lastObject];
    if ([scroll isKindOfClass:[UIScrollView class]]) {
        
        CGPoint bottomOffset = CGPointMake(0, scroll.contentSize.height - scroll.bounds.size.height);
        [scroll setContentOffset:bottomOffset animated:YES];
    }
    */
    
}

-(void)initadsMod{
    
   
    if([self checkPurchase] == NO)
    {
        if([[[[self getSettingArray] objectAtIndex:2] objectForKey:@"type"] intValue] == 0)
        {
            //No Banner
            adIndicator = NO;
       NSLog(@"AdMob Type 0");
        }
        else if([[[[self getSettingArray] objectAtIndex:2] objectForKey:@"type"] intValue] == 1)
        {
            NSLog(@"AdMob Type 1");
            bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
            bannerView_.adUnitID = [[[self getSettingArray] objectAtIndex:2] objectForKey:@"publishKey"];
            bannerView_.rootViewController = self.viewController;
            bannerView_.frame = CGRectMake(0, 63, 320, 50);
            adIndicator = YES;
        }
        else
        {
            bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
            bannerView_.adUnitID = [[[self getSettingArray] objectAtIndex:2] objectForKey:@"publishKey"];
            bannerView_.rootViewController = self.viewController;
            bannerView_.frame = CGRectMake(0, 63, 320, 50);
            adIndicator = YES;

            
        }
    }
    else
    {
           adIndicator = NO;
    }
    
    
    
    
}

-(void)setLogicAdMob:(BOOL)logic
{
    adIndicator = logic;
}

-(BOOL)getAdIndicator{
    return adIndicator;
}

-(void)refreshAdMobBanner{
    
    
    
  
    if([self checkPurchase] == NO)
    {
    
    if([[[[self getSettingArray] objectAtIndex:2] objectForKey:@"type"] intValue] == 0)
    {
        //No Banner
       
    }
    else if([[[[self getSettingArray] objectAtIndex:2] objectForKey:@"type"] intValue] == 1)
    {
          [bannerView_ loadRequest:[GADRequest request]];
    }
     else if([[[[self getSettingArray] objectAtIndex:2] objectForKey:@"type"] intValue] == 2)
    {
    
    [bannerView_ loadRequest:[GADRequest request]];
    interstitial_ = [[GADInterstitial alloc] init];
    interstitial_.adUnitID = [[[self getSettingArray] objectAtIndex:2] objectForKey:@"publishKey"];
    interstitial_.delegate = self;
        GADRequest *request = [GADRequest request];
        
    [interstitial_ loadRequest:request];
        
    
        
    }
    }
    
}

-(GADBannerView*)getAdmobBanner{
    
    return bannerView_;
}

#pragma PPSLideInstannce Method
-(void)contentRevealSwicthOn{
    PPRevealSideInteractions inter = PPRevealSideInteractionNone;
       inter |= PPRevealSideInteractionNavigationBar;
    inter |= PPRevealSideInteractionContentView;
    
    self.revealSideViewController.panInteractionsWhenClosed = inter;
    
}


#pragma GADInterstitial Delegate
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial;
{
    NSLog(@"Ads Ready");
    [interstitial_ presentFromRootViewController:root];
    
}

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error{
    NSLog(@"Ads Failed");
    
    
    
}

-(void)removeAdsFunction{
    [self inAppPurchaseStoreFile];
    adIndicator = NO;
    bannerView_.hidden = YES;
    [self.viewController backToOrginScroller];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"inapppurchase_success_title", nil)
                                                    message:[NSString stringWithFormat:NSLocalizedString(@"inapppurchase_success_detail", nil)]
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"inapppurchase_success_btn", nil)
                                          otherButtonTitles:nil];
    [alert show];
    
    
    
}

-(void)inAppPurchaseStoreFile{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[NSString stringWithFormat:@"removeAds"]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //2) Create the full file path by appending the desired file name
    NSString *yourArrayFileName = [documentsDirectory stringByAppendingPathComponent:@"boughtRemoveAds.dat"];
    
    [array writeToFile:yourArrayFileName atomically:YES];
    NSLog(@"Save Successfully");
}


-(BOOL)checkPurchase{
    
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* foofile = [documentsPath stringByAppendingPathComponent:@"boughtRemoveAds.dat"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
    
    if(fileExists == YES)
    {
        return YES;
    }
    else
    {
        
        return NO;
    }
}


-(void)inAppPurchaseActivate{
    NSMutableArray *bundleID = [[NSMutableArray alloc] init];
    [bundleID addObject:[[[self getSettingArray] objectAtIndex:3] objectForKey:@"productID"]];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:bundleID]];
    
    request.delegate = self;
    [request start];
}

#pragma StoreKit Delegate

-(void)readyToBuy{
    
    if ([SKPaymentQueue canMakePayments])
    {
        
        
        NSLog(@"Ready to buy %@",[inAppPurchaseArray objectAtIndex:3]);
        SKPayment *payment = [SKPayment paymentWithProduct:prods];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else
    {
        // Warn the user that purchases are disabled.
        NSLog(@"Purchase is disable");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"inapppurchase_disable_title", nil)
                                                        message:NSLocalizedString(@"inapppurchase_disable_detail", nil)
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"inapppurchase_disable_btn", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }

}

-(void)retoreButton{
    
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

-(NSArray*)inAppPurchaseArray{
    return inAppPurchaseArray;
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
  
    for (SKProduct *prod in response.products)
    {
        prods = prod;
        inAppPurchaseArray = [NSArray arrayWithObjects:prod.localizedTitle,prod.localizedDescription,prod.price,prod.productIdentifier, nil];
    }
    
    
}

-(void)requestDidFinish:(SKRequest *)request
{
    NSLog(@"Request done");
}

-(void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"Failed to connect with error: %@", [error localizedDescription]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"inapppurchase_connection_title", nil)
                                                    message:[NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"inapppurchase_connection_detail", nil),[error localizedDescription]]
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"inapppurchase_connection_btn", nil)
                                          otherButtonTitles:nil];
    [alert show];
}



- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"restoreTransaction...");
    
    
    [self recordTransaction: transaction];
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"inapppurchase_failed_transaction_title", nil)
                                                        message:[NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"inapppurchase_failed_transaction_detail", nil),transaction.error.localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"inapppurchase_failed_transaction_btn", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

- (void)recordTransaction:(SKPaymentTransaction *)transaction {
    // TODO: Record the transaction on the server side...
    
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"Prepare to restore");
     [self removeAdsFunction];
}



- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
                
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Payment Processing");
                
                
                break;
            case SKPaymentTransactionStatePurchased:
                NSLog(@"Bought");
                
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"Failed");
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Start to restore");
                [self restoreTransaction:transaction];
                break;
            default:
                
                break;
        }
        
        
    }
}


- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    
    
    
    if([self verifyReceipt:transaction] == TRUE)
    {
        [self removeAdsFunction];
        [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
       
        [self performSelectorOnMainThread:@selector(completTransExe:) withObject:[NSArray arrayWithObjects:[self encode:(uint8_t *)transaction.transactionReceipt.bytes length:transaction.transactionReceipt.length], nil] waitUntilDone:NO];
    }
    else
    {
        NSLog(@"Jail break");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"inapppurchase_failed_receipt_title", nil)
                                                        message:NSLocalizedString(@"inapppurchase_failed_receipt_detail", nil)
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"inapppurchase_failed_receipt_btn", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }

    
    
}

-(void)completTransExe:(NSArray*)arg{
    
    
    NSString *UUID = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    [self sendAnalyticsDeviceData:@"purchased" deviceID:UUID deviceType:@"iPhone" deviceToken:[arg objectAtIndex:0]];
    
    
    
    
}

- (BOOL)verifyReceipt:(SKPaymentTransaction *)transaction {
    NSString *jsonObjectString = [self encode:(uint8_t *)transaction.transactionReceipt.bytes length:transaction.transactionReceipt.length];
    
    //receiptData = jsonObjectString;
    NSString *completeString = [NSString stringWithFormat:@"%@/?scrollblogkruk=purchasevalidation&receipt=%@", url,jsonObjectString];
    NSURL *urlForValidation = [NSURL URLWithString:completeString];
    NSMutableURLRequest *validationRequest = [[NSMutableURLRequest alloc] initWithURL:urlForValidation];
    [validationRequest setHTTPMethod:@"GET"];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:validationRequest returningResponse:nil error:nil];
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
    NSInteger response = [responseString integerValue];
    
    return (response == 0);
}

- (NSString *)encode:(const uint8_t *)input length:(NSInteger)length {
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData *data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *output = (uint8_t *)data.mutableBytes;
    
    for (NSInteger i = 0; i < length; i += 3) {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger index = (i / 3) * 4;
        output[index + 0] =                    table[(value >> 18) & 0x3F];
        output[index + 1] =                    table[(value >> 12) & 0x3F];
        output[index + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[index + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}


-(void)noInternetConnectivityAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"no_internet_alert_title", nil)
                                                    message:NSLocalizedString(@"no_internet_alert_desc", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"no_internet_alert_btn", nil) otherButtonTitles:nil];
    [alert show];

    
}


-(void)checkConnectivity{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if(networkStatus == NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"no_internet_alert_title", nil)
                                                        message:NSLocalizedString(@"no_internet_alert_desc", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"no_internet_alert_btn", nil) otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
        self.startController = [[StartAnimationController alloc] initWithNibName:@"StartAnimationController" bundle:nil];
        self.window.rootViewController = self.startController;
        
        
    }

    
}

-(void)defaultViewController{
    
    
    
    
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if(networkStatus == NotReachable)
    {
        NoConnectivityViewController *noInternet = [[NoConnectivityViewController alloc] initWithNibName:@"NoConnectivityViewController" bundle:nil];
        
        self.window.rootViewController = noInternet;
    }
    else
    {
    self.startController = [[StartAnimationController alloc] initWithNibName:@"StartAnimationController" bundle:nil];
    self.window.rootViewController = self.startController;
    
        
    }
    
    /*
    
    */
}

-(void)startApp{
    
    //Initialize ScrollBlog
    [self downloadScrollBlogSettings];
    [self initScrollBlog];
    [self downloadRecentPostJson];
    [self downloadPageMenu];
    
    
        
    
    
    
    
    self.viewController = [[ViewController alloc] init];
    [self setDetailGoDetailType:NO];
    self.viewController.title = NSLocalizedString(@"home_title", nil);
    root = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    root.navigationBar.barStyle = UIBarStyleBlack;
    _revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:root];
    
    _revealSideViewController.delegate = self;
    
    PushToLeftViewController *c = [[PushToLeftViewController alloc] initWithNibName:@"PushToLeftViewController" bundle:nil ];
    [c setTableData:[self getPageMenuArray]];
    [c setShowODRefresh:YES];
    UINavigationController *er = [[UINavigationController alloc] initWithRootViewController:c];
    [er setNavigationBarHidden:YES];
    [self.revealSideViewController preloadViewController:er forSide:PPRevealSideDirectionLeft withOffset:68];
    // self.window.rootViewController = _revealSideViewController;
    
    [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionNone];
    
    
    
    [self.startController curtainRevealViewController:_revealSideViewController transitionStyle:RECurtainTransitionHorizontal];
    
    
    
    //AdsMob View
    
    /*if([self checkPurchase] == NO)
    {
        adIndicator = YES;
        [self initadsMod];
        [root.view addSubview:[self getAdmobBanner]];
        
        [bannerView_ loadRequest:[GADRequest request]];
        
        
    }
    else
    {
        adIndicator = NO;
    }*/
    
    //In app Purchase activation
    if([[[[self getSettingArray] objectAtIndex:3] objectForKey:@"activation"] intValue] == 1)
    {
        [self inAppPurchaseActivate];
        
    }
    
    [self getPushedNotification:afterLaunch];

    
    
    
}

-(void)changeMapControllerLoad:(NSString*)str{
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.window];
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"loading", nil);
    HUD.detailsLabelText = NSLocalizedString(@"Please_wait", nil);
    
    [self.window addSubview:HUD];
    
    [self.revealSideViewController popViewControllerAnimated:YES];
    [HUD showWhileExecuting:@selector(MapControllerRe:) onTarget:self withObject:[NSArray arrayWithObjects:str, nil] animated:YES];
}


-(void)backTodefaultController{
    
    [self.viewController changeToDefaultViewController];
}

-(void)MapControllerRe:(NSArray*)ary{
   
    [self.viewController changeToMapController:[self downloadAllMapData:[ary objectAtIndex:0]]];
  
    [self.viewController.navigationController popToRootViewControllerAnimated:YES];
    
}





-(NSArray*)findNearestMe:(NSString*)query{
    NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?scrollblogkruk=get_map_post&type=findnearme&%@",url,query]];
    NSData *sa = [NSData dataWithContentsOfURL:urls];
    NSString *jsonString = [[NSString alloc] initWithData:sa encoding:NSUTF8StringEncoding];
    NSDictionary *result = [jsonString JSONValue];
    NSArray* attribute = [result objectForKey:@"post"];
    
    
    
    return attribute;
    
    
}

-(void)setGlobalCategory:(NSString*)cat{
    
    globalPostCategory = cat;
}

-(NSString*)getGlobalCategory{
    return globalPostCategory;
}

-(NSArray*)downloadAllMapData:(NSString*)query{
    NSURL *urls;
    if([query isEqualToString:@"All"])
    {
        urls = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?scrollblogkruk=get_map_post",url]];
    }
    else
    {
        urls = [NSURL URLWithString:[NSString stringWithFormat:@"%@/?scrollblogkruk=get_map_post&cat=%@",url,query]];
    }
        NSData *sa = [NSData dataWithContentsOfURL:urls];
    NSString *jsonString = [[NSString alloc] initWithData:sa encoding:NSUTF8StringEncoding];
    NSDictionary *result = [jsonString JSONValue];
    NSArray* attribute = [result objectForKey:@"post"];
    
    
    
    return attribute;
    
   
}

-(void)goToContactUsTemplate:(NSArray*)ary{
    ContactUsViewController *conts = [[ContactUsViewController alloc] initWithNibName:@"ContactUsViewController" bundle:nil];
    NSDictionary *contactUS = [ary objectAtIndex:1];
    NSString *latLongName = [NSString stringWithFormat:@"%@,%@",[contactUS objectForKey:@"lat"],[contactUS objectForKey:@"long"]];
    
    
    [conts initContactUsTemplate:[NSArray arrayWithObjects:latLongName,[contactUS objectForKey:@"lat"],[contactUS objectForKey:@"long"],[contactUS objectForKey:@"name"],[contactUS objectForKey:@"address"],[contactUS objectForKey:@"phone_number"],[contactUS objectForKey:@"email_address"], nil]];
    
    
    
    conts.title = [NSString stringWithFormat:@"%@",[ary objectAtIndex:0]];
 
    [self.revealSideViewController popViewControllerAnimated:YES];
    [self.viewController.navigationController  pushViewController:conts animated:YES];
}

@end
