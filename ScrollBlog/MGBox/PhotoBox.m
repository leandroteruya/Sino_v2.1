

#import "PhotoBox.h"
#import "UIImageView+WebCache.h"
@implementation PhotoBox

#pragma mark - Init

- (void)setup {

 

  // background
  self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1];

  // shadow
  self.layer.shadowColor = [UIColor colorWithWhite:0.12 alpha:1].CGColor;
  self.layer.shadowOffset = CGSizeMake(0, 0.5);
  self.layer.shadowRadius = 1;
  self.layer.shadowOpacity = 1;
}

#pragma mark - Factories

+ (PhotoBox *)photoAddBoxWithSize:(CGSize)size pictureURL:(NSString*)url{

  // basic box
  PhotoBox *box = [PhotoBox boxWithSize:size];

  // style and tag
  box.backgroundColor = [UIColor colorWithRed:0.74 green:0.74 blue:0.75 alpha:1];
  box.tag = -1;

    
    
    
  // add the add image
  //UIImage *add = [UIImage imageNamed:url];
  UIImageView *_addView = [[UIImageView alloc] init];
    
   
    __weak UIImageView *addView = _addView;
    
    addView.frame = CGRectMake(8, 8, size.width, size.height);
    
   
    
    [addView setImageWithURL:[NSURL URLWithString:url]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                              
                              
                              
                              [addView setImage:[self imageByScalingAndCroppingForSize:CGSizeMake(305, 305) source:image]];
                          
                          }];
    
    
  
    
    
  [box addSubview:addView];
  addView.center = (CGPoint){box.width / 2, box.height / 2};
  addView.alpha = 1;
  addView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
      | UIViewAutoresizingFlexibleRightMargin
      | UIViewAutoresizingFlexibleBottomMargin
      | UIViewAutoresizingFlexibleLeftMargin;

  return box;
}




+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize source:(UIImage*)sourceImages
{
	UIImage *sourceImage = sourceImages;
	UIImage *newImage = nil;
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO)
	{
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
		
        if (widthFactor > heightFactor)
			scaleFactor = widthFactor; // scale to fit height
        else
			scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
		
        // center the image
        if (widthFactor > heightFactor)
		{
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		}
        else
			if (widthFactor < heightFactor)
			{
				thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
			}
	}
	
	UIGraphicsBeginImageContext(targetSize); // this will crop
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	if(newImage == nil)
        NSLog(@"could not scale image");
	
	//pop the context to get back to the default
	UIGraphicsEndImageContext();
	return newImage;
}




+ (PhotoBox *)fullImageBox:(CGSize)size pictureURL:(NSString*)url title:(NSString*)pTitle pDate:(NSString*)pDate{
    // positioning
  

    // basic box
    PhotoBox *box = [PhotoBox boxWithSize:size];
    
    // style and tag
    box.backgroundColor = [UIColor colorWithRed:0.74 green:0.74 blue:0.75 alpha:1];
    box.tag = -1;
    
    // add the add image
    
    UIImageView *_addView = [[UIImageView alloc] init];
    
    
    __weak UIImageView *addView = _addView;

    addView.frame = CGRectMake(0, 0, size.width, size.height);
    [addView setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                       
                       addView.image = [self imageByScalingAndCroppingForSize:CGSizeMake(305, 305) source:image];
                       
                   }];
    
    addView.frame = CGRectMake(0, 0, size.width, size.height);
    addView.layer.cornerRadius = 4.0;
    addView.layer.masksToBounds = YES;
    
    
    UITextView *title = [[UITextView alloc] initWithFrame:CGRectMake(10, 205, size.width-10, 60)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:21];
    title.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    title.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    title.layer.shadowOpacity = 1.0f;
    title.layer.shadowRadius = 1.0f;
    
    
    title.text = pTitle;
    [addView addSubview:title];
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, size.width-20, 50)];
    
    time.backgroundColor = [UIColor clearColor];
    time.textColor = [UIColor whiteColor];
    time.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    time.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    time.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    time.layer.shadowOpacity = 1.0f;
    time.layer.shadowRadius = 1.0f;
    
    
    time.text = pDate;
    [addView addSubview:time];
    
    
    [box addSubview:addView];
    addView.center = (CGPoint){box.width / 2, box.height / 2};
    addView.alpha = 1;
    addView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin;
    
    
    
    
    
    
    return box;
}

+ (PhotoBox *)loadMore:(CGSize)size {
    
    PhotoBox *box = [PhotoBox boxWithSize:size];
    box.backgroundColor = [UIColor colorWithRed:0.74 green:0.74 blue:0.75 alpha:1];
    

   UILabel *loadMore = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, 40)];
    
    loadMore.backgroundColor = [UIColor clearColor];
    loadMore.textColor = [UIColor darkGrayColor];
    loadMore.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    
    
    
    loadMore.text = @"Load More";
    loadMore.textAlignment = NSTextAlignmentCenter;
  
    [box addSubview:loadMore];
    
    
    UIActivityIndicatorView *ind = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    ind.center = CGPointMake(size.width / 2,size.height / 2);
    [ind stopAnimating];
    [ind hidesWhenStopped];
    [box addSubview:ind];
    
    
    
    [[AppDelegate instance] setUiLabelLoadMore:loadMore];
    [[AppDelegate instance] setIndicatorView:ind];
    
     return box;
}



#pragma mark - Layout

- (void)layout {
  [super layout];

  // speed up shadows
  self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

@end
