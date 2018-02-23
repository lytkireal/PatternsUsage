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
#import "HorizontalScroller.h"
#import "AlbumView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, HorizontalScrollerDelegate> {
  UITableView *_dataTable;
  NSArray *_allAlbums;
  NSDictionary *_currentAlbumData;
  int _currentAlbumIndex;
  HorizontalScroller *scroller;
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
  
  // 3.1 HorizontalScroller
  scroller = [[HorizontalScroller alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 120)];
  scroller.backgroundColor = [UIColor colorWithRed:0.24 green:0.35 blue:0.49 alpha:1];
  scroller.delegate = self;
  [self.view addSubview:scroller];
  [self reloadScroller];
  
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
  // Make count of cells from titles key values count:
  return [_currentAlbumData[@"titles"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  // 1 - Try to take dequeue reusable cell with with identifier:
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
  // 2 - If there isn't dequeue reusable cell instantiate new UITableViewCell:
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
  }
  
  // 3 - Configure cell with appropriate data:
  cell.textLabel.text = _currentAlbumData[@"titles"][indexPath.row];
  cell.detailTextLabel.text = _currentAlbumData[@"values"][indexPath.row];
  
  // 4 - Return complete cell:
  return cell;
}

#pragma mark - HorizontalSroller delegates

- (void)horizontalScroller:(HorizontalScroller *)scroller clickedViewAtIndex:(int)index {
  _currentAlbumIndex = index;
  [self showDataForAlbumAtIndex:index];
}

- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller *)scroller {
  return _allAlbums.count;
}

- (UIView *)horizontalScroller:(HorizontalScroller *)scroller viewAtIndex:(int)index {
  Album *album = _allAlbums[index];
  return [[AlbumView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) albumCover:album.coverUrl];
}

#pragma mark - Helpers

- (void)reloadScroller {
  _allAlbums = [[LibraryAPI sharedInstance] albums];
  if (_currentAlbumIndex < 0)
    _currentAlbumIndex = 0;
  else if (_currentAlbumIndex >= _allAlbums.count)
    _currentAlbumIndex = (int)_allAlbums.count - 1;
  [scroller reload];
  [self showDataForAlbumAtIndex:_currentAlbumIndex];
}

@end
































