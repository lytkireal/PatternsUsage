//
//  LibraryAPI.m
//  BlueLibrary
//
//  Created by macbook air on 19/02/2018.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import "LibraryAPI.h"

#import "PersistencyManager.h"
#import "HTTPClient.h"

@interface LibraryAPI () {
  PersistencyManager *_persistencyManager;
  HTTPClient *_httpClient;
  BOOL _isOnline;
}

@end

@implementation LibraryAPI

#pragma mark - Lifecycle

- (instancetype)init {
  self = [super init];
  if (self) {
    _persistencyManager = [PersistencyManager new];
    _httpClient = [HTTPClient new];
    _isOnline = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadImage:) name:@"BLDownloadImageNotification" object:nil];
  }
  return self;
}

+ (LibraryAPI *)sharedInstance {
  
  static LibraryAPI *sharedInstance = nil;
  
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    sharedInstance = [LibraryAPI new];
  });
  
  return sharedInstance;
}

#pragma mark - User Interaction with API

- (NSArray*)albums {
  return [_persistencyManager albums];
}

- (void)addAlbum:(Album *)album atIndex:(NSUInteger)index {
  [_persistencyManager addAlbum:album atIndex:index];
  if (_isOnline) {
    [_httpClient postRequest:@"/api/addAlbum" body:[album description]];
  }
}

- (void)deleteAlbumAtIndex:(NSUInteger)index {
  [_persistencyManager deleteAlbumAtIndex:index];
  if (_isOnline) {
    [_httpClient postRequest:@"/api/deleteAlbum" body:[@(index) description]];
  }
}

- (void)downloadImage:(NSNotification *)notification {
  // 1
  NSString *coverUrl = notification.userInfo[@"coverUrl"];
  UIImageView *imageView = notification.userInfo[@"imageView"];
  
  // 2
  imageView.image = [_persistencyManager getImage:[coverUrl lastPathComponent]];
  
  if (imageView.image == nil) {
    // 3
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      UIImage *image = [_httpClient downloadImage:coverUrl];
      // 4
      dispatch_sync(dispatch_get_main_queue(), ^{
        imageView.image = image;
        [_persistencyManager saveImage:image fileName:[coverUrl lastPathComponent]];
      });
    });
  }
  
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end


























