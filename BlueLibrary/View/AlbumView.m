//
//  AlbumView.m
//  BlueLibrary
//
//  Created by macbook air on 19/02/2018.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import "AlbumView.h"

@implementation AlbumView {
  UIImageView * coverImage;
  UIActivityIndicatorView * indicator;
}

- (id)initWithFrame:(CGRect)frame
         albumCover:(NSString *)albumCover
{
  self = [super initWithFrame:frame];
  if (self)
  {
    // Устанавливаем чёрный фон:
    self.backgroundColor = [UIColor blackColor];
    
    // Создаём изображение с небольшим отступом - 5 пикселей от края:
    coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width-10, frame.size.height-10)];
    [self addSubview:coverImage];
    
    // Добавляем индикатор активности:
    indicator = [[UIActivityIndicatorView alloc] init];
    indicator.center = self.center;
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [indicator startAnimating];
    [self addSubview:indicator];
  }
  return self;
}

@end
