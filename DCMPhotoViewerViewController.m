//
//  DCMPhotoViewerViewController.m
//  Basic Pic Grabber
//
//  Created by Dave on 2/20/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import "DCMPhotoViewerViewController.h"

@interface DCMPhotoViewerViewController ()

@end

@implementation DCMPhotoViewerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
   // self.webView.delegate = self;
    
    //  NSURL *url =[NSURL URLWithString:self.urlString];
    //  NSURL *url = [NSURL URLWithString:@"www.microsoft.com"];
    
  //  NSString *formattedURLString = [self formattedURLString:self.urlString];
    
    
  //  NSURL *photoURL = [NSURL URLWithString:self.urlString];
    
    
    NSURLRequest *request =[NSURLRequest requestWithURL:self.photoURL];
    
    
     NSLog(@"URL Photo:  %@", self.photoURL);
    
    //  NSError *error;
    

    [NSURLConnection sendAsynchronousRequest:request queue:Nil completionHandler:nil];
    
    [self.webView loadRequest:request];
    
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
