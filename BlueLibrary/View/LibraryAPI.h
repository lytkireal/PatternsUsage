//
//  LibraryAPI.h
//  BlueLibrary
//
//  Created by macbook air on 19/02/2018.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Album.h"

@interface LibraryAPI : NSObject

+ (LibraryAPI *)sharedInstance;
- (NSArray*)albums;
- (void)addAlbum:(Album*)album atIndex:(NSUInteger)index;
- (void)deleteAlbumAtIndex:(NSUInteger)index;

@end
