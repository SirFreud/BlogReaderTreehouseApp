//
//  BlogPost.h
//  BlogReader
//

#import <Foundation/Foundation.h>

@interface BlogPost : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *thumbnail;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSURL *url;

// Designated initializer - this is rather complciated, may need to review video
-(id) initWithTitle: (NSString *) title;
+(id) blogPostWithTitle: (NSString *) title;

// Used to fetch the image data from the web - see method
-(NSURL *) thumbnailURL;
-(NSString *) formattedDate;
@end
