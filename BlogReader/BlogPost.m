//
//  BlogPost.m
//  BlogReader
//

#import "BlogPost.h"

@implementation BlogPost

// Overloading the init method for my title method (specifically the setter)
-(id) initWithTitle: (NSString *) title {
    self = [super init];
    if (self) {
        self.title = title;
        self.author = nil;
        self.thumbnail = nil;
    }
    return self;
}

// Class method for the looping on the TableViewController.m class - see Line 53
+(id) blogPostWithTitle: (NSString *) title {
    return [[self alloc] initWithTitle:title];
}

-(NSURL *) thumbnailURL {
    // Handles the URLS for thumbnails
    return [NSURL URLWithString:self.thumbnail];
}

-(NSString *) formattedDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    // Specified format our date was coming in as (string, in this foramt)
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // Parsed the NSString into an NSDate
    NSDate *tempDate = [dateFormatter dateFromString:self.date];
    
    // Reformatted the new NSDate object
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    
    // Output new NSDate object
    return [dateFormatter stringFromDate:tempDate];
}
@end
