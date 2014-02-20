//
//  DCMPhotoViewerViewController.h
//  Basic Pic Grabber
//
//  Created by Dave on 2/20/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCMPhotoViewerViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong)  NSURL *photoURL;

@end
