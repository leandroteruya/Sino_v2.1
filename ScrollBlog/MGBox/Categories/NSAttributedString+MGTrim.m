

#import "NSAttributedString+MGTrim.h"

@implementation NSAttributedString (MGTrim)

- (NSAttributedString *)attributedStringByTrimming:(NSCharacterSet *)set {
  NSCharacterSet *invertedSet = set.invertedSet;
  NSString *string = self.string;
  unsigned loc, len;

  NSRange range = [string rangeOfCharacterFromSet:invertedSet];
  loc = (range.length > 0) ? range.location : 0;

  range = [string rangeOfCharacterFromSet:invertedSet options:NSBackwardsSearch];
  len = (range.length > 0) ? NSMaxRange(range) - loc : string.length - loc;

  return [self attributedSubstringFromRange:NSMakeRange(loc, len)];
}

@end
