

@interface DCMWebTransfer : UIViewController <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate, NSURLSessionDataDelegate>

@property (nonatomic) NSURLSession *session1;

-(void)startDownload;
-(BOOL)cancelDownload;
@end
