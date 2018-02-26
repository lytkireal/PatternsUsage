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
               year:(NSString *)year {
  
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

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.year forKey:@"year"];
  [aCoder encodeObject:self.title forKey:@"title"];
  [aCoder encodeObject:self.artist forKey:@"artist"];
  [aCoder encodeObject:self.coverUrl forKey:@"coverUrl"];
  [aCoder encodeObject:self.genre forKey:@"genre"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    _year = [aDecoder decodeObjectForKey:@"year"];
    _title = [aDecoder decodeObjectForKey:@"title"];
    _artist = [aDecoder decodeObjectForKey:@"artist"];
    _coverUrl = [aDecoder decodeObjectForKey:@"coverUrl"];
    _genre = [aDecoder decodeObjectForKey:@"genre"];
  }
  return self;
}



@end
