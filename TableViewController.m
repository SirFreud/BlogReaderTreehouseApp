//
//  TableViewController.m
//  BlogReader
//

#import "TableViewController.h"
#import "BlogPost.h"
#import "WebViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // This allows me to get data from the web
    NSURL *blogURL = [NSURL URLWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];
    
    // I'm parsing the JSON
    NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
    
    // I'm creating an error handler
    NSError *error = nil;
    
    // Creating a dictionary to handle the JSON data
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    // NSLog(@"%@",dataDictionary);
    
    // Creating a Mutable array where I'll append the data
    self.blogPosts = [[NSMutableArray alloc] init];
    
    // Adding the posts as objects to an array
    NSArray *blogPostsArray = [dataDictionary objectForKey:@"posts"];
    
    // I'm looping through the above array to add all the keys necessary for my custom class for blog posts (this is the most
    // confusing part, I may need to review the video on this one).
    for (NSDictionary *bpDictionary in blogPostsArray) {
        BlogPost *blogPost = [BlogPost blogPostWithTitle:[bpDictionary objectForKey:@"title"]];
        blogPost.author = [bpDictionary objectForKey:@"author"];
        blogPost.thumbnail = [bpDictionary objectForKey:@"thumbnail"];
        blogPost.date = [bpDictionary objectForKey:@"date"];
        blogPost.url = [NSURL URLWithString:[bpDictionary objectForKey:@"url"]];
        [self.blogPosts addObject:blogPost];
        
    // Oh wait, in the above loop I created an array of dictionaries!! ^^ (lines 53 - 58)
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.blogPosts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Telling the table view to display my BlogPost objects
    BlogPost *blogPost = [self.blogPosts objectAtIndex: indexPath.row];
    
    //Use the if statement so if the website doesn't return an NSString, I can default to a defacto image of my choosing
    if ([blogPost.thumbnail isKindOfClass:[NSString class]]) {
        
        // Creating the NSData object to fetch from the web
        NSData *imageData = [NSData dataWithContentsOfURL: blogPost.thumbnailURL];
        
        // Converting the NSData object into a UIImage so I can display it. I actually don't even need this
        // if I use the imageWithData overloaded method on the UIImage class on the cell.imageView.image
        UIImage *image = [UIImage imageWithData:imageData];
        
        // Displaying the thumbnail image
        cell.imageView.image = [UIImage imageWithData:imageData];
        // OR: cell.imageView.image = image (this is also valid using above UIImage declaration)
        
    } else {
        cell.imageView.image = [UIImage imageNamed:@"BlankMan.jpg"];
    }
    
   
  
    // Displaying the blog title
    cell.textLabel.text = blogPost.title;
    
    // Displaying the blog author and date using string concatenation
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", blogPost.author, [blogPost formattedDate]];
    
    // Return cell to the UI
    return cell;
   
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showBlogPost"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BlogPost *blogPost = [self.blogPosts objectAtIndex: indexPath.row];
        WebViewController *wbc = (WebViewController *) segue.destinationViewController;
        wbc.blogPostURL = blogPost.url;
    }
    
    
}
@end
