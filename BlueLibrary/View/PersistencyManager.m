//
//  PersistencyManager.m
//  BlueLibrary
//
//  Created by macbook air on 19/02/2018.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import "PersistencyManager.h"

@interface PersistencyManager() {
  NSMutableArray *albums;
}

@end

@implementation PersistencyManager

- (instancetype)init {
  self = [super init];
  if (self) {
    albums = [NSMutableArray arrayWithArray:@[[[Album alloc] initWithTitle:@"Best of Bowie"
                                                                    artist:@"David Bowie"
                                                                  coverUrl:@"https://s3.amazonaws.com/CoverProject/album/album_david_bowie_best_of_bowie.png"
                                                                      year:@"1992"],
                                              
                                              [[Album alloc] initWithTitle:@"It's My Life"
                                                                    artist:@"No Doubt"
                                                                  coverUrl:@"https://s3.amazonaws.com/CoverProject/album/album_no_doubt_its_my_life_bathwater.png"
                                                                      year:@"2003"],
                                              
                                              [[Album alloc] initWithTitle:@"Nothing Like The Sun"
                                                                    artist:@"Sting"
                                                                  coverUrl:@"https://s3.amazonaws.com/CoverProject/album/album_sting_nothing_like_the_sun.png"
                                                                      year:@"1999"],
                                              
                                              [[Album alloc] initWithTitle:@"Staring at the Sun"
                                                                    artist:@"U2"
                                                                  coverUrl:@"https://s3.amazonaws.com/CoverProject/album/album_u2_staring_at_the_sun.png"
                                                                      year:@"2000"],
                                              
                                              [[Album alloc] initWithTitle:@"American Pie"
                                                                    artist:@"Madonna"
                                                                  coverUrl:@"https://s3.amazonaws.com/CoverProject/album/album_madonna_american_pie.png"
                                                                      year:@"2000"]]];
  }
  return self;
}

- (NSArray *)albums {
  return albums;
}

- (void)addAlbum:(Album *)album atIndex:(NSUInteger)index {
  if (albums.count > index) {
    [albums insertObject:album atIndex:index];
  } else {
    [albums addObject:album];
  }
}

- (void)deleteAlbumAtIndex:(NSUInteger)index {
  [albums removeObjectAtIndex:index];
}

@end




























