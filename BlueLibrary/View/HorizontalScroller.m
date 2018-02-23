//
//  HorizontalScroller.m
//  BlueLibrary
//
//  Created by macbook air on 21/02/2018.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import "HorizontalScroller.h"

// 1
#define VIEW_PADDING 10
#define VIEW_DIMENSIONS 100
#define VIEW_OFFSET 100

// 2
@interface HorizontalScroller () <UIScrollViewDelegate>

@end

// 3
@implementation HorizontalScroller {
  UIScrollView *scroller;
}

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  if (self) {
    scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scroller.delegate = self;
    UITapGestureRecognizer *gestureReconizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollerTapped:)];
    [scroller addGestureRecognizer:gestureReconizer];
    [self addSubview:scroller];
  }
  return self;
}

#pragma mark - View lifecycle

- (void)didMoveToSuperview {
  [self reload];
}

#pragma mark - Interactions

- (void)scrollerTapped:(UITapGestureRecognizer *)gesture {
  CGPoint location = [gesture locationInView:gesture.view];
  for (int index = 0; index < [self.delegate numberOfViewsForHorizontalScroller:self]; index ++) {
    UIView *view = scroller.subviews[index];
    if (CGRectContainsPoint(view.frame, location)) {
      [self.delegate horizontalScroller:self clickedViewAtIndex:index];
      CGPoint offset = CGPointMake(view.frame.origin.x - self.frame.size.width/2 + view.frame.size.width/2, 0);
      [scroller setContentOffset:offset animated:YES];
      break;
    }
  }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (!decelerate) {
    [self centerCurrentView];
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  [self centerCurrentView];
}

#pragma mark - Reload scroller

- (void)reload {
  // 1 - If there isn't delegate, nothing to load:
  if (self.delegate == nil) return;
  
  // 2 - Remove all subviews:
  [scroller.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [obj removeFromSuperview];
  }];
  
  // 3 - xValue - start point of all subviews in scroller:
  CGFloat xValue = VIEW_OFFSET;
  for (int i = 0; i < [self.delegate numberOfViewsForHorizontalScroller:self];i++) {
    // 4 - Add subview in appropriate position:
#warning ???
    xValue += VIEW_PADDING;
    UIView *view = [self.delegate horizontalScroller:self viewAtIndex:i];
    view.frame = CGRectMake(xValue, VIEW_PADDING, VIEW_DIMENSIONS, VIEW_DIMENSIONS);
    [scroller addSubview:view];
    xValue += VIEW_DIMENSIONS + VIEW_PADDING;
  }
  
  // 5
  [scroller setContentSize:CGSizeMake(xValue +VIEW_OFFSET, self.frame.size.height)];
  
  // 6 - If there is initial view we center this in scroller:
  if ([self.delegate respondsToSelector:@selector(initialViewIndexForHorizontalScroller:)]) {
    NSInteger initialView = [self.delegate initialViewIndexForHorizontalScroller:self];
    CGPoint offset = CGPointMake(initialView * (VIEW_DIMENSIONS + (2 * VIEW_PADDING)), 0);
    [scroller setContentOffset:offset animated:YES];
  }
}

#pragma mark - Scrolling

- (void)centerCurrentView {
  int xFinal = scroller.contentOffset.x + (VIEW_OFFSET / 2) + VIEW_PADDING;
  int viewIndex = xFinal / (VIEW_DIMENSIONS + (2 * VIEW_PADDING));
  //xFinal = viewIndex * (VIEW_DIMENSIONS + (2 * VIEW_PADDING));
  //[scroller setContentOffset:CGPointMake(xFinal, 0) animated:YES];

  
//  UIView *view = [self.delegate horizontalScroller:self viewAtIndex:viewIndex];
//  CGPoint offset = CGPointMake(view.frame.origin.x - self.frame.size.width/2 + view.frame.size.width/2, 0);
//  [scroller setContentOffset:offset animated:YES];
  
  for (int index = 0; index < [self.delegate numberOfViewsForHorizontalScroller:self]; index ++) {
    UIView *view = scroller.subviews[viewIndex];
    [self.delegate horizontalScroller:self clickedViewAtIndex:index];
    CGPoint offset = CGPointMake(view.frame.origin.x - self.frame.size.width/2 + view.frame.size.width/2, 0);
    [scroller setContentOffset:offset animated:YES];
    [self.delegate horizontalScroller:self clickedViewAtIndex:viewIndex];
    break;
  }
}

@end
























