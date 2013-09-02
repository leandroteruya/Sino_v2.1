
#import "MGLineStyled.h"

#define DEFAULT_SIZE (CGSize){304, 40}

@implementation MGLineStyled

- (void)setup {
  [super setup];

  // default styling
  self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1];
  self.padding = UIEdgeInsetsMake(0, 16, 0, 16);

  // use MGBox borders instead of the maybe-to-be-deprecated solidUnderline
  self.borderStyle = MGBorderEtchedTop | MGBorderEtchedBottom;
}

+ (id)line {
  return [self boxWithSize:DEFAULT_SIZE];
}

+(id)newLayout{
    MGLineStyled *line = [self lineWithSize:(CGSize){300, 300}];
    
    
    UIImageView *see = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"add.png"]];
    see.frame = CGRectMake(0, 0, 300, 300);
    id sae = [UIImage imageNamed:@"threemake.png"];
    line.middleItems = sae;
    
     line.maxHeight = 0;
    

    return line;
}

@end
