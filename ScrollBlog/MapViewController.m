

#import "MapViewController.h"
#import "MapViewAnnotation.h"
#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360
@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        mapView = [[MKMapView alloc] init];
        mapView.delegate = self;
        if([[AppDelegate instance] hasFourInchDisplay])
        {
            mapView.frame = CGRectMake(0, 0, 320, 510);
        }
        else
        {
            mapView.frame = CGRectMake(0, 0, 320, 420);
        }
        
        [self.view addSubview:mapView];
         }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    
    
}

-(void)addSingleAnntonation:(NSArray*)anntonationValue{
  

    CLLocationCoordinate2D location;
	location.latitude = [[anntonationValue objectAtIndex:1] doubleValue];
	location.longitude = [[anntonationValue objectAtIndex:2] doubleValue];
    
    lat = [[anntonationValue objectAtIndex:1] doubleValue];
    longti = [[anntonationValue objectAtIndex:2] doubleValue];
	// Add the annotation to our map view
	MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:[NSString stringWithFormat:@"%@",[anntonationValue objectAtIndex:0]] andCoordinate:location];
	[mapView addAnnotation:newAnnotation];
    
    [self zoomMapViewToFitAnnotations:mapView animated:YES];
}





- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString* BridgeAnnotationIdentifier = @"bridgeAnnotationIdentifier";
    
    MKPinAnnotationView* customPinView = [[MKPinAnnotationView alloc]
                                          initWithAnnotation:annotation reuseIdentifier:BridgeAnnotationIdentifier];
  
    customPinView.animatesDrop = YES;
    customPinView.canShowCallout = YES;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    [customPinView setRightCalloutAccessoryView:rightButton];
    
    return customPinView;//[kml viewForAnnotation:annotation];
}


- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    [self openActionSheet];
}

-(void)openActionSheet{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"map_actionsheet_title", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"map_actionsheet_cancel_btn", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"map_actionsheet_apple_btn", nil), NSLocalizedString(@"map_actionsheet_google_btn", nil),NSLocalizedString(@"map_actionsheet_waze_btn", nil), nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
		NSLog(@"Apple Map");
        
       
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat,longti);
        
        //create MKMapItem out of coordinates
        MKPlacemark* placeMark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
        MKMapItem* destination =  [[MKMapItem alloc] initWithPlacemark:placeMark];
        
        if([destination respondsToSelector:@selector(openInMapsWithLaunchOptions:)])
        {
            //using iOS6 native maps app
            [destination openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
            
        } else{
            
            //using iOS 5 which has the Google Maps application
            NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%f,%f", lat, longti];
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        }
        
        
	} else if (buttonIndex == 1) {
        NSLog(@"Google Map");
        NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%f,%f", lat, longti];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        
	} else if (buttonIndex == 2) {
		NSLog(@"Waze");
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"waze://"]]) {
            //Waze is installed. Launch Waze and start navigation
            NSString *urlStr = [NSString stringWithFormat:@"waze://?ll=%f,%f&navigate=yes", lat, longti];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        } else {
            //Waze is not installed. Launch AppStore to install Waze app
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/id323229106"]];
        }
        
        
	}
    else{
        NSLog(@"Cancel");
        
    }
    
}



- (void)zoomMapViewToFitAnnotations:(MKMapView *)mapViews animated:(BOOL)animated
{
    NSArray *annotations = mapViews.annotations;
    int count = [mapViews.annotations count];
    if ( count == 0) { return; } //bail if no annotations
    
    //convert NSArray of id <MKAnnotation> into an MKCoordinateRegion that can be used to set the map size
    //can't use NSArray with MKMapPoint because MKMapPoint is not an id
    MKMapPoint points[count]; //C array of MKMapPoint struct
    for( int i=0; i<count; i++ ) //load points C array by converting coordinates to points
    {
        CLLocationCoordinate2D coordinate = [(id <MKAnnotation>)[annotations objectAtIndex:i] coordinate];
        points[i] = MKMapPointForCoordinate(coordinate);
    }
    //create MKMapRect from array of MKMapPoint
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:points count:count] boundingMapRect];
    //convert MKCoordinateRegion from MKMapRect
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    
    //add padding so pins aren't scrunched on the edges
    region.span.latitudeDelta  *= ANNOTATION_REGION_PAD_FACTOR;
    region.span.longitudeDelta *= ANNOTATION_REGION_PAD_FACTOR;
    //but padding can't be bigger than the world
    if( region.span.latitudeDelta > MAX_DEGREES_ARC ) { region.span.latitudeDelta  = MAX_DEGREES_ARC; }
    if( region.span.longitudeDelta > MAX_DEGREES_ARC ){ region.span.longitudeDelta = MAX_DEGREES_ARC; }
    
    //and don't zoom in stupid-close on small samples
    if( region.span.latitudeDelta  < MINIMUM_ZOOM_ARC ) { region.span.latitudeDelta  = MINIMUM_ZOOM_ARC; }
    if( region.span.longitudeDelta < MINIMUM_ZOOM_ARC ) { region.span.longitudeDelta = MINIMUM_ZOOM_ARC; }
    //and if there is a sample of 1 we want the max zoom-in instead of max zoom-out
    if( count == 1 )
    {
        region.span.latitudeDelta = MINIMUM_ZOOM_ARC;
        region.span.longitudeDelta = MINIMUM_ZOOM_ARC;
    }
    [mapViews setRegion:region animated:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
   
    //or maybe you would do the call above in the code path that sets the annotations array
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
