//
//  PersistencyManager.h
//  BlueLibrary
//
//  Created by macbook air on 19/02/2018.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import "Album.h"

@interface PersistencyManager : NSObject

- (NSArray*)albums;
- (void)addAlbum:(Album*)album atIndex:(NSUInteger)index;
- (void)deleteAlbumAtIndex:(NSUInteger)index;
- (void)saveImage:(UIImage *)image fileName:(NSString*)fileName;
- (UIImage *)getImage:(NSString *)fileName;

@end
