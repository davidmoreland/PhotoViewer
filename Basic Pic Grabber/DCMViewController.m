//
//  DCMViewController.m
//  Basic Pic Grabber
//
//  Created by Dave on 2/18/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import "DCMViewController.h"
#import "DCMPhotoManager.h"

//#import "Constants.h"
//#import <NSJson
#import "DCMWebTransfer.h"
#import "DCMPhotoViewerViewController.h"

@interface DCMViewController ()
@property(nonatomic, strong) NSMutableArray *photoCache;
@property(nonatomic, strong) NSMutableArray *photoIDArray;
@property (nonatomic, strong) DCMPhotoManager *photoManager;
@property (nonatomic, strong) NSDictionary *photosDictionary;
@property (nonatomic, strong) NSURL *photoURL;
@end

@implementation DCMViewController


-(id)init
{
    
//self.currentImage.image = @"
    if(!self)
    {
        
  //  DCMWebTransfer *webTransfer = [[DCMWebTransfer alloc]init];
        self.photosDictionary = [[NSArray alloc]init];
   //     self.photoManager = [[DCMPhotoManager alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *searchString = @"";
    
  //  [self loadFlickrPhotos:searchString];
    [self refreshPhotos];
   // [self loadPhoto:(NSArray *)
 //   [self.photoManager buildPhotoURL];
   
}



- (void)refreshPhotos
{
    //API KEY -- Expired??  83e6915af3ba89ab2166a69f7dde4c07
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *photoDir = [NSString stringWithFormat: @"http://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1ee0d7513ebb8be626ebed81e5174654&format=json&nojsoncallback=1"];
    NSURL *url = [NSURL URLWithString:photoDir];
    
    DCMWebTransfer *fetchPhotos = [[DCMWebTransfer alloc]init];
    
    [[fetchPhotos.session1 dataTaskWithURL:url completionHandler:^(NSData
                                                       *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResp =
            (NSHTTPURLResponse*) response;
            if (httpResp.statusCode == 200) {
                
                NSError *jsonError;
                
                NSDictionary *filesJSON = [NSJSONSerialization
            JSONObjectWithData:data
            options:NSJSONReadingAllowFragments
            error:&jsonError];
           
                
               NSDictionary *photosDictionary = [[NSDictionary alloc]init];
                photosDictionary = [filesJSON objectForKey:@"photos"];
                NSLog(@"Photos: %@",photosDictionary);
                
             //   self.photosDictionary = [[NSDictionary alloc]init];
             //   self.photosDictionary = [self.photosDictionary objectForKey:@"photo"];
                
           //     NSDictionary *flickrPhotosDic = [[filesJSON objectForKey:@"photos"] objectForKey:@"photo"];
                self.photosDictionary = [[filesJSON objectForKey:@"photos"] objectForKey:@"photo"];
                
                NSLog(@"Number of Photos: %lu", (unsigned long)[self.photosDictionary count]);
                
          //      NSArray *photoArray = [filesJSON objectForKey:@"photo"];
                NSMutableArray *strippedMetaData =
                [[NSMutableArray alloc] init];
                
                NSLog(@"Data Found: %@",filesJSON);
                
                
                NSDictionary *metaData;
                NSDictionary *photoMetaData;
                if(!metaData )
                {
                    NSDictionary *fileMetaData = [[NSDictionary alloc]init];
                    NSDictionary *photoMetaData = [[NSDictionary alloc]init];
                }
                
                int numberOfPics = 0;
                
                if (!jsonError) {
                    for (NSDictionary *tmpPhotoDic in
                         self.photosDictionary) {
                        numberOfPics ++;
                        NSLog(@"Number of Pictures: %d",[self.photosDictionary count]);
                        NSLog(@"Dictionary fileMetaData: %@",tmpPhotoDic);
                      
                        [self stripPhotoID:tmpPhotoDic];
                      
                    }
                    // Completion Handler
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                        
                          DCMPhotoManager *photoManager = [[DCMPhotoManager alloc]init];
                           photoManager.photosDictionary = self.photosDictionary;
                           NSURL *onlinePhotoURL = [photoManager buildPhotoURL];
                        
                        NSLog(@" ONLINE PHOTO URL: %@",onlinePhotoURL);
                        
                        [self fetchPhoto:onlinePhotoURL];

                    });
                }
            } else {
                // HANDLE BAD RESPONSE //
            }
        } else {
            NSLog(@"WebTransfer Error:  %@",error);
        }
    }]
     
     resume];
    NSLog(@"Photos Dictionary: %@", self.photosDictionary);
}

-(void)fetchPhoto:(NSURL *)photoURL
{
   // DCMPhotoViewerViewController *photoViewVC = [[DCMPhotoViewerViewController alloc]init];
   // photoViewVC.photoURL = photoURL;
    [self performSegueWithIdentifier:@"PhotoNavController" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PhotoNavController"])
    {
        DCMPhotoViewerViewController *destinationViewController = (DCMPhotoViewerViewController *) segue.destinationViewController;
        destinationViewController.photoURL = self.photoURL;
    }
 
}

-(NSArray *)stripPhotoID:(NSDictionary *)metaData
{
    
  if (!self.photoIDArray)
  {
      self.photoIDArray = [[NSMutableArray alloc]init];
  }
    NSString *photoID = [metaData objectForKey:@"id"];
        [self.photoIDArray addObject:[metaData objectForKey:@"id"]];
        
    return self.photoIDArray;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
