//
//  DCMPhotoManager.h
//  Basic Pic Grabber
//
//  Created by Dave on 2/19/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCMPhotoManager : NSObject
@property(nonatomic, strong) NSString *farm;
@property(nonatomic, strong) NSString *server;
@property(nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *photo_id;

@property (nonatomic, strong) NSDictionary *photosDictionary;
-(int)getRandomPhotoNumber;

-(NSURL *)buildPhotoURL;

@end
