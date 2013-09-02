

#import "PushToLeftViewController.h"
#import "StyledTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
@interface PushToLeftViewController ()

@end

@implementation PushToLeftViewController
@synthesize tableViews,searchBars;
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
    [tableViews setRowHeight:45.0];
    [tableViews setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableViews setSeparatorColor:[UIColor colorWithWhite:0.7 alpha:1]];
    //tableViews.backgroundColor = [UIColor clearColor];
    searchBars.placeholder = NSLocalizedString(@"search_placeholder", nil);
	
    if(showODRefresh == YES)
    {
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:tableViews];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
    [tableViews selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
    
    mapIndicator = NO;
   
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[AppDelegate instance] downloadPageMenu];
        NSMutableArray * re = [[AppDelegate instance] getPageMenuArray];
        [self setTableData:re];
       
        [refreshControl endRefreshing];
         [tableViews reloadData];
        
       
    });

    
}

-(void)setShowODRefresh:(BOOL)arg{
    showODRefresh = arg;
}
-(void)setTableData:(NSMutableArray*)array{
    
    //tableData = [[AppDelegate instance] getPageMenuArray];
    tableData = array;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    StyledTableViewCell *cell = (StyledTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[StyledTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell.textLabel setTextColor:[UIColor grayColor]];
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [cell.textLabel setHighlightedTextColor:[UIColor whiteColor]];
        //[cell setStyledTableViewCellSelectionStyle:StyledTableViewCellSelectionStylePurple];
        
        NSMutableArray *colors = [NSMutableArray array];
        [colors addObject:(id)[[UIColor colorWithRed:109/255.0 green:110/255.0 blue:106/255.0 alpha:1] CGColor]];
        [colors addObject:(id)[[UIColor colorWithRed:76/255.0 green:77/255.0 blue:73/255.0 alpha:0.53] CGColor]];
        [colors addObject:(id)[[UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:0.77] CGColor]];
        [cell setSelectedBackgroundViewGradientColors:colors];
        
        [cell setDashWidth:5 dashGap:3 dashStroke:1];
    }

    
   cell.textLabel.text = [NSString stringWithFormat:@"%@",[[tableData objectAtIndex:indexPath.row] objectAtIndex:0]];
    
    if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"homeBtn"])
    {
        //Coloca o icon do botao Home no menu izquerdo
        cell.imageView.image = [UIImage imageNamed:NSLocalizedString(@"home_btn_icon", nil)];
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"backBtn"])
    {
        
    }
    else
    {
    [cell.imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[tableData objectAtIndex:indexPath.row] objectAtIndex:9]]] placeholderImage:[UIImage imageNamed:NSLocalizedString(@"home_no_icon_placeholder_icon", nil)]];
    }
    return cell;
}


- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:7] intValue] == 0)
    {
        return UITableViewCellAccessoryDisclosureIndicator;
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:7] intValue] == -1)
    {
        return UITableViewCellAccessoryNone;
    }
    else
    {
        return UITableViewCellAccessoryDetailDisclosureButton;
        
    }
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *menusArray = [[NSMutableArray alloc] init];
    NSArray *menus = [[tableData objectAtIndex:indexPath.row] objectAtIndex:8];
   // NSArray* menus = [result objectForKey:@"menu"];
    
    
    for (NSDictionary *menu in menus) {
        
        [menusArray addObject:[NSArray arrayWithObjects:[menu objectForKey:@"name"],[menu objectForKey:@"type"],[menu objectForKey:@"objectID"],[menu objectForKey:@"parentID"],[menu objectForKey:@"postID"],[menu objectForKey:@"link"],[menu objectForKey:@"order"],[menu objectForKey:@"childcheck"],[menu objectForKey:@"child"],[menu objectForKey:@"thumb"],[menu objectForKey:@"twitter_page"], nil]];

    }

    [menusArray addObject:[NSArray arrayWithObjects:NSLocalizedString(@"back_btn", nil),@"backBtn",@"0",@"0",@"0",@"0",@"0",@"-1",@"0",@"0",@"", nil]];
    
    PushToLeftViewController *child = [[PushToLeftViewController alloc] init];
    [child setTableData:menusArray];
    [child setShowODRefresh:NO];
    [self.navigationController pushViewController:child animated:YES];
     
    
}


#pragma mark - Table view delegate
//ACHO Q MOSTRA O CONTEUDO DO MENU CLICADO 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if(networkStatus == NotReachable)
    {
        [[AppDelegate instance] noInternetConnectivityAlert];
    }
    else
    {
    
    //Puxa o conteudo do menu
    if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"category"])
    {
        
        if(mapIndicator == YES)
        {
            [[AppDelegate instance] backTodefaultController];
            mapIndicator = NO;
        }
        
         [[AppDelegate instance] setIndicatorTwitter:NO];
        [[AppDelegate instance] addIndicator:NO];
     [[AppDelegate instance] setDetailGoDetailType:NO];
         [[AppDelegate instance] setGlobalCategory:@""];
        [[AppDelegate instance] changeCategory:[[tableData objectAtIndex:indexPath.row] objectAtIndex:2] categoryName:[[tableData objectAtIndex:indexPath.row] objectAtIndex:0]];
    
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"categoryPostMap"])
    {
        [[AppDelegate instance] changeViewControllerTitle:[NSString stringWithFormat:@"%@",[[tableData objectAtIndex:indexPath.row] objectAtIndex:0]]];
        mapIndicator = YES;
        [[AppDelegate instance] setGlobalCategory:[[tableData objectAtIndex:indexPath.row] objectAtIndex:2]];
        [[AppDelegate instance] changeMapControllerLoad:[[tableData objectAtIndex:indexPath.row] objectAtIndex:2]];
        
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"page"])
    {
        if(mapIndicator == YES)
        {
            [[AppDelegate instance] backTodefaultController];
            mapIndicator = NO;
        }
        [[AppDelegate instance] setIndicatorTwitter:NO];
         [[AppDelegate instance] addIndicator:NO];
         [[AppDelegate instance] setDetailGoDetailType:NO];
         [[AppDelegate instance] setGlobalCategory:@""];
    [[AppDelegate instance] goToPage:[[tableData objectAtIndex:indexPath.row] objectAtIndex:2] categoryName:[[tableData objectAtIndex:indexPath.row] objectAtIndex:0]];
    
    }else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"custom"]){
        
        if(mapIndicator == YES)
        {
            [[AppDelegate instance] backTodefaultController];
            mapIndicator = NO;
        }
        
         [[AppDelegate instance] setIndicatorTwitter:NO];
         [[AppDelegate instance] addIndicator:NO];
           [[AppDelegate instance] setDetailGoDetailType:NO];
         [[AppDelegate instance] setGlobalCategory:@""];
    [[AppDelegate instance] goCustomWeb:[[tableData objectAtIndex:indexPath.row] objectAtIndex:5] pName:[[tableData objectAtIndex:indexPath.row] objectAtIndex:0]];
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"RSS"]){
        if(mapIndicator == YES)
        {
            [[AppDelegate instance] backTodefaultController];
            mapIndicator = NO;
        }
        
        [[AppDelegate instance] setIndicatorTwitter:NO];
        [[AppDelegate instance] addIndicator:NO];
          [[AppDelegate instance] setDetailGoDetailType:YES];
         [[AppDelegate instance] setGlobalCategory:@""];
        [[AppDelegate instance] goToRss:[[tableData objectAtIndex:indexPath.row] objectAtIndex:5] pName:[[tableData objectAtIndex:indexPath.row] objectAtIndex:0]];
    
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"TwitterPage"]){
        
        if(mapIndicator == YES)
        {
            [[AppDelegate instance] backTodefaultController];
            mapIndicator = NO;
        }
        
        [[AppDelegate instance] setTwitterArray:[NSArray arrayWithObjects:[[tableData objectAtIndex:indexPath.row] objectAtIndex:10],[[tableData objectAtIndex:indexPath.row] objectAtIndex:0], nil]];
        
        [[AppDelegate instance] setIndicatorTwitter:YES];
        [[AppDelegate instance] addIndicator:NO];
        [[AppDelegate instance] setDetailGoDetailType:YES];
         [[AppDelegate instance] setGlobalCategory:@""];
        [[AppDelegate instance] goToTwitterPage:[[tableData objectAtIndex:indexPath.row] objectAtIndex:10] pName:[[tableData objectAtIndex:indexPath.row] objectAtIndex:0]];
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"PostMap"]){
        
        
        
        NSLog(@"Full Map");
         [[AppDelegate instance] setGlobalCategory:@""];
         [[AppDelegate instance] changeViewControllerTitle:[NSString stringWithFormat:@"%@",[[tableData objectAtIndex:indexPath.row] objectAtIndex:0]]];
        mapIndicator = YES;
        [[AppDelegate instance] changeMapControllerLoad:@"All"];
        
       
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"OneClickCall"]){
        
        
        
      
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[tableData objectAtIndex:indexPath.row] objectAtIndex:11]]]];
        
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"OneClickMail"]){
        
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
       
        
        [mailer setToRecipients:[NSArray arrayWithObject:[[tableData objectAtIndex:indexPath.row] objectAtIndex:12]]];
       
       
        [self presentModalViewController:mailer animated:YES];
        
        
       
        
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"ContactUs"]){
       
        
        [[AppDelegate instance] goToContactUsTemplate:[NSArray arrayWithObjects:[[tableData objectAtIndex:indexPath.row] objectAtIndex:0],[[tableData objectAtIndex:indexPath.row] objectAtIndex:13], nil]];
        
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"backBtn"]){
         [[AppDelegate instance] setIndicatorTwitter:NO];
        [[AppDelegate instance] setDetailGoDetailType:NO];
       [self.navigationController popViewControllerAnimated:YES];
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"homeBtn"])
    {
        //Mostra o conteudo da home ao clicar no botao Home do menu
        if(mapIndicator == YES)
        {
            [[AppDelegate instance] backTodefaultController];
            mapIndicator = NO;
        }
         [[AppDelegate instance] setGlobalCategory:@""];
         [[AppDelegate instance] setIndicatorTwitter:NO];
         [[AppDelegate instance] addIndicator:YES];
        [[AppDelegate instance] setDetailGoDetailType:NO];
     
        
        [[AppDelegate instance] backToHome];
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"classificacaoBtn"])
    {
        if(mapIndicator == YES)
        {
            [[AppDelegate instance] backTodefaultController];
            mapIndicator = NO;
        }
        
        [[AppDelegate instance] setIndicatorTwitter:NO];
        [[AppDelegate instance] addIndicator:NO];
        [[AppDelegate instance] setDetailGoDetailType:NO];
        [[AppDelegate instance] setDetailGoDetailType:NO];
        [[AppDelegate instance] setGlobalCategory:@""];
        [[AppDelegate instance] goToClassificacao:[[tableData objectAtIndex:indexPath.row] objectAtIndex:5] pName:[[tableData objectAtIndex:indexPath.row] objectAtIndex:0]];
        
    }
    else if([[[tableData objectAtIndex:indexPath.row] objectAtIndex:1] isEqualToString:@"filtroBtn"])
    {
        if(mapIndicator == YES)
        {
            [[AppDelegate instance] backTodefaultController];
            mapIndicator = NO;
        }
        
        [[AppDelegate instance] setIndicatorTwitter:NO];
        [[AppDelegate instance] addIndicator:NO];
        [[AppDelegate instance] setDetailGoDetailType:NO];
        [[AppDelegate instance] setDetailGoDetailType:NO];
        [[AppDelegate instance] setGlobalCategory:@""];
        [[AppDelegate instance] goToFiltro:[[tableData objectAtIndex:indexPath.row] objectAtIndex:5] pName:[[tableData objectAtIndex:indexPath.row] objectAtIndex:0]];
        
    }
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

#pragma UISEARCHBARDELEGATE

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    searchBar.showsCancelButton = YES;
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
     searchBar.showsCancelButton = NO;
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Cancel");
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Search");
    
    NSString *bump5 = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    [[AppDelegate instance] searchPost:bump5];
    [[AppDelegate instance] changeViewControllerTitle:searchBar.text];
    [searchBar resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
