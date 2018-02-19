//
//  Album+TableRepresentation.m
//  BlueLibrary
//
//  Created by macbook air on 19/02/2018.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import "Album+TableRepresentation.h"

@implementation Album (TableRepresentation)

- (NSDictionary *)tr_tableRepresentation {
  return @{@"titles":@[@"Исполнитель", @"Альбом", @"Жанр", @"Год"],
           @"values":@[self.artist, self.title, self.genre, self.year]
           };
}

@end
