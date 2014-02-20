/// DCM Web Transfer
// IOS 7 using  URL Session Class
// Background Transfers
//
// By David Moreland
// 2.18.14
//

#import "DCMWebTransfer.h"
//#import "NSFileManager+AXPExtensions.h"
//#import "NSData+AXPExtensions.h"
//#import "SGDataSource.h"

#define kResponseTimeOut = 20;

//static NSString *part1URLString = kFetchedPhotDataBASEURLString;
//static NSString *part2URLString = kFetchedAppDataURLString2;
//static NSString *part3URLString = kFetchedAppDataURLString3;
static NSString *getRecentPhotosURLString =  @"http://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=83e6915af3ba89ab2166a69f7dde4c07&format=json&nojsoncallback=1";

@interface DCMWebTransfer ()
{
  
}

//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic)double downloadProgress;

@property (nonatomic) NSURLSession *session2;
@property (nonatomic) NSURLSession *session3;

@property (nonatomic) NSURLSessionDownloadTask *downloadTask1;
@property (nonatomic) NSURLSessionDataTask *dataTask1;
@property (nonatomic) NSURLSessionDownloadTask *downloadTask2;
@property (nonatomic) NSURLSessionDownloadTask *downloadTask3;
@property (nonatomic, strong) NSDate *startDownloadTime;
@property (nonatomic) int fileSize;
@property (nonatomic) int responseWatchDog;
@end


@implementation DCMWebTransfer

-(DCMWebTransfer *)init
{
   // _responseWatchDog = 0;
    self.session1 = [self createSession];
    
    [self startDownload];
   
  //  self.startDownloadTime = [NSDate date];
    //DEBUG
    // NSLog(@"Start Time: %@",self.startDownloadTime);
    
    return self;
}


- (void)startDownload
{
    NSURL *downloadURL1 = [NSURL URLWithString:getRecentPhotosURLString];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:downloadURL1];

    NSLog(@"Photo URL: %@",downloadURL1);
    
     // [self.session1 dataTaskWithRequest:request1];
    
    [self.session1 dataTaskWithRequest:request1
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if(error) {
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                if (httpResp.statusCode == 200) {
                    // 3
                  //  NSString *text =
                    [[NSString alloc]initWithData:data
                                         encoding:NSUTF8StringEncoding];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                        NSLog (@"Data: %@",data);
                    });
                    
                } else {
                    // HANDLE BAD RESPONSE /}
                }
                } }];
                
    
    [self.dataTask1 resume];
  }


- (NSURLSession *)createSession
{
    
	static NSURLSession *session = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                                                    
                                                    session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        configuration.timeoutIntervalForRequest = 20;
        
	});
    
return session;
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
    if (downloadTask == self.downloadTask1)
    {
        double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
        self.downloadProgress = progress;
        
      /***  [[NSNotificationCenter defaultCenter] postNotificationName:kSGDownloadProgressNotification
                                                            object:self
                                                          userInfo:@{@"progress" :@((self.downloadProgress))}];
       ***/
      
        NSLog(@"EXPECTED BYTES: %f", progress);
        
        }
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)downloadURL
{
   
    NSLog(@"Download URL: %@", downloadURL);
  /***
    NSURLSessionDataTask *dataTask =
    [self.session1 dataTaskWithURL:downloadURL
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    if (!error) {
                        NSLog(@"Data Downloaded: %@",data);
                    }
                    else
                    { // ERROR
                        NSLog(@"Download Error: %@",error.description);
                    }
                }];
   ****/
    
    // 3  
 //   [dataTask resume];
    
    
    /*
     The download completed, you need to copy the file at targetPath before the end of this block.
     As an example, copy the file to the Documents directory of your app.
    */
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSArray *URLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = URLs[0];

    NSURL *originalURL = [[downloadTask originalRequest] URL];
    NSURL *destinationURL = [documentsDirectory URLByAppendingPathComponent:[originalURL lastPathComponent]];
    NSError *errorCopy;

        BOOL success = [fileManager copyItemAtURL:downloadURL toURL:destinationURL error:&errorCopy];
    
    
    if (success)
    {
        
        // NSLog(@"File Copy SUCCESS !");
        //dispatch_async(dispatch_get_main_queue(), ^{
           // Unpack
            // 1. Lock Access to Affected DBs.
            // 2. Unpack Downloaded File
       //     [self  updateFlightDataWithNewArchiveAtPath:destinationURL];
            // 3.Erase OLD DBs
            // 4. Move New DB files to App Data Directory
        // Remove downloaded Flight Data Archieve Files
        
      //  });
    }
    else
    {
        /*
         In the general case, what you might do in the event of failure depends on the error and the specifics of your application.
         */
        // NSLog(@"File Copy FALURE: %@", [errorCopy localizedDescription]);
    }
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{

  
    if (error == nil)
    {
            NSString *lastUpdated = [[NSUserDefaults standardUserDefaults] stringForKey:@"SGLatestAvailable"];
            [[NSUserDefaults standardUserDefaults] setValue:lastUpdated forKey:@"SGLastUpdated"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        /***
            [[NSNotificationCenter defaultCenter] postNotificationName:kSGDataAvailabilityUpdated
                                                                object:self
                                                              userInfo:nil];
            ***/
     /**
        AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        [appDelegate.progressView.superview removeFromSuperview];
 ***/
        
     //   } else {
   
     //   }
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    else
    {
        // NSLog(@"Task: %@ completed with error: %@", task, [error localizedDescription]);
        
        [self cancelDownload];
    }
	
  
 //   self.downloadTask1 = nil;
}


/*
 If an application has received an -application:handleEventsForBackgroundURLSession:completionHandler: message, the session delegate will receive this message to indicate that all messages previously enqueued for this session have been delivered. At this time it is safe to invoke the previously stored completion handler, or to begin any internal updates that will result in invoking the completion handler.
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.backgroundSessionCompletionHandler) {
        void (^completionHandler)() = appDelegate.backgroundSessionCompletionHandler;
        appDelegate.backgroundSessionCompletionHandler = nil;
        completionHandler();
      
        // NSLog(@"\n\n");
        // NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
        // NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
        // NSLog(@"END BackGround Session #1 ");
        // NSLog(@"\n\n");
        // NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
        // NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
    }

 }


-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
  //    BLog();
}

-(BOOL)cancelDownload
{
    if (_downloadTask1.state == NSURLSessionTaskStateRunning) {
        [_downloadTask1 cancel];
        return YES;
}
    else return NO;
}



-(void)dealloc
{
}
@end
