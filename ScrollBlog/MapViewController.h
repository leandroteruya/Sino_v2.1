





#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<UIActionSheetDelegate,MKMapViewDelegate,MKAnnotation>
{
    MKMapView *mapView;
    double lat;
    double longti;
    NSArray *places;
    CLLocationDegrees zoomLevel;
}

-(void)addSingleAnntonation:(NSArray*)anntonationValue;




@end
