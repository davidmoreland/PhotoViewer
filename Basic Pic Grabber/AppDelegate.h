//
//  DCMAppDelegate.h
//  Basic Pic Grabber
//
//  Created by Dave on 2/18/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy) void (^backgroundSessionCompletionHandler)();

@end
