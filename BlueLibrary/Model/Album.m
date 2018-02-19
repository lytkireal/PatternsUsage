//
//  Album.m
//  BlueLibrary
//
//  Created by macbook air on 19/02/2018.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import "Album.h"

@implementation Album

- (id)initWithTitle:(NSString *)title
             artist:(NSString *)artist
           coverUrl:(NSString *)coverUrl
               year:(NSString *)year
{
  self = [super init];
  if (self)
  {
    _title = title;
    _artist = artist;
    _coverUrl = coverUrl;
    _year = year;
    _genre = @"Pop";
  }
  return self;
}

@end
