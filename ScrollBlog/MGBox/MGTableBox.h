
#import "MGBox.h"

@interface MGTableBox : MGBox

@property (nonatomic, retain) NSMutableOrderedSet *topLines;
@property (nonatomic, retain) NSMutableOrderedSet *middleLines;
@property (nonatomic, retain) NSMutableOrderedSet *bottomLines;

- (NSOrderedSet *)allLines;

@end
