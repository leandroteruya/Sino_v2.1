

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MapViewAnnotation.h"
#import <MapKit/MapKit.h>
@interface ContactUsViewController : UIViewController<UIActionSheetDelegate,MFMailComposeViewControllerDelegate,MKMapViewDelegate,MKAnnotation>
{
    IBOutlet MKMapView *mapView;
    double lat;
    double longti;
    NSArray *places;
    CLLocationDegrees zoomLevel;
    NSArray *dataSent;
    NSString *email;
    NSString *pNumber;
}
@property(nonatomic,retain) IBOutlet MKMapView *mapView;
@property(nonatomic,retain) IBOutlet UILabel *titleName;
@property(nonatomic,retain) IBOutlet UILabel *address;
@property(nonatomic,retain) IBOutlet UILabel *blackBack;
@property(nonatomic,retain) IBOutlet UIButton *emailNow;
@property(nonatomic,retain) IBOutlet UIButton *callNow;
-(void)initContactUsTemplate:(NSArray*)ary;
-(IBAction)emailNow:(id)sender;
-(IBAction)callNow:(id)sender;
@end
