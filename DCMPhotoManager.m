//
//  DCMPhotoManager.m
//  Basic Pic Grabber
//
//  Created by Dave on 2/19/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//
//http://farmX.static.flickr.com/server/id_secret.jpg


#import "DCMPhotoManager.h"

@implementation DCMPhotoManager

-(DCMPhotoManager *)init
{
    if(!self)
    {
      //  self.photosDictionary = [[NSDictionary alloc]init];
    }
    return self;
}

-(int)getRandomPhotoNumber
{
        NSInteger numberOfPhotos = [_photosDictionary count];
    
  int randomNum =  arc4random_uniform(numberOfPhotos);

    NSLog(@"Random Number: %d",randomNum);
    return randomNum;
}



-(NSURL *)buildPhotoURL
{
    int numOfPhotosInArray = 0;
     numOfPhotosInArray = [self.photosDictionary count];
    
    int photoIndex =  [self getRandomPhotoNumber];
  //  NSArray *photoArray = [[NSArray alloc]init];
    
    int photoCounter =0;
    
    NSDictionary *randomPhotoDictionary = [[NSDictionary alloc]init];
    
    for(NSDictionary *tmpDictionary in self.photosDictionary  )
    {
        if (photoCounter == photoIndex)
        {
            randomPhotoDictionary = tmpDictionary;
            break;
        
        }
        else{
            photoCounter ++;
        }
    }

    
    self.farm = [NSString stringWithFormat:@"%@",[randomPhotoDictionary objectForKey:@"farm"]];
    self.server = [NSString stringWithFormat:@"%@",[randomPhotoDictionary objectForKey:@"server"]];
    self.photo_id = [NSString stringWithFormat:@"%@",[randomPhotoDictionary objectForKey:@"id"]];
    self.secret = [NSString stringWithFormat:@"%@",[randomPhotoDictionary objectForKey:@"secret"]];
    
    NSString *baseURLstring = @".static.flickr.com/";
    NSString *urlString = @"http://farm";
    NSString *dirURLString = @"/";
    NSString *underScoreString = @"_";
    NSString *fileTypeString = @".jpg";
    
    //DEBUG
    NSLog(@"Farm: %@", self.farm);
    NSLog(@"Server: %@", self.server);
    NSLog(@"Farm: %@", self.photo_id);
    NSLog(@"Farm: %@", self.secret);
    
    urlString = [urlString stringByAppendingString:_farm];
    urlString = [urlString stringByAppendingString:baseURLstring];
   urlString = [urlString stringByAppendingString:self.server];
    urlString = [urlString stringByAppendingString:dirURLString];
    urlString = [urlString stringByAppendingString:self.photo_id];
    urlString = [urlString stringByAppendingString:underScoreString];
    urlString = [urlString stringByAppendingString:self.secret];
    urlString = [urlString stringByAppendingString:fileTypeString];
    
    NSLog(@"Photo URL STRING: %@", urlString);
    
  
    NSURL *photoURL =[NSURL URLWithString:urlString];
    
    NSLog(@"Photo URL: %@",photoURL);
    
    return photoURL;
}


@end