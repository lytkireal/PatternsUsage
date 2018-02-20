//
//  ViewController.m
//  BlueLibrary
//
//  Created by Eli Ganem on 31/7/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import "ViewController.h"

#import "LibraryAPI.h"
#import "Album+TableRepresentation.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
  UITableView *_dataTable;
  NSArray *_allAlbums;
  NSDictionary *_currentAlbumData;
  int _currentAlbumIndex;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // 1
  self.view.backgroundColor = [UIColor colorWithRed:0.76f green:0.81f blue:0.87f alpha:1.f];
  _currentAlbumIndex = 0;
  
  //2
  _allAlbums = [[LibraryAPI sharedInstance] albums];
  
  // 3 UITableView
  CGRect frame = CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height - 120);
  _dataTable = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
  _dataTable.delegate = self;
  _dataTable.dataSource = self;
  _dataTable.backgroundView = nil;
  [self.view addSubview:_dataTable];
  
  // 4
  [self showDataForAlbumAtIndex:_currentAlbumIndex];
}

- (void)showDataForAlbumAtIndex:(int)albumIndex {
  if (albumIndex < _allAlbums.count) {
    Album *album = _allAlbums[albumIndex];
    _currentAlbumData = [album tr_tableRepresentation];
  } else {
    _currentAlbumData = nil;
  }
  [_dataTable reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_currentAlbumData[@"titles"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
  }
  
  cell.textLabel.text = _currentAlbumData[@"titles"][indexPath.row];
  cell.detailTextLabel.text = _currentAlbumData[@"values"][indexPath.row];
  
  return cell;
}

@end
































