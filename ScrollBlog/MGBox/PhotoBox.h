

#import "MGBox.h"

@interface PhotoBox : MGBox
{
    
}

+ (PhotoBox *)photoAddBoxWithSize:(CGSize)size pictureURL:(NSString*)url;

+ (PhotoBox *)fullImageBox:(CGSize)size pictureURL:(NSString*)url title:(NSString*)pTitle pDate:(NSString*)pDate;
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize source:(UIImage*)sourceImages;
+ (PhotoBox *)loadMore:(CGSize)size;

@end
