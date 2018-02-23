//
//  HorizontalScroller.h
//  BlueLibrary
//
//  Created by macbook air on 21/02/2018.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HorizontalScrollerDelegate;

@interface HorizontalScroller : UIView

@property (weak) id<HorizontalScrollerDelegate> delegate;

- (void)reload;

@end

// Protocol:
@protocol HorizontalScrollerDelegate <NSObject>

@required

/** Ask delegate about how many views we will show in horizontal scroller
 */
- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller*)scroller;

// Ask delegate for its receiving view with index <index>:
- (UIView *)horizontalScroller:(HorizontalScroller*)scroller viewAtIndex:(int)index;

// Notify delegate that view at index <index> is tapped :
- (void)horizontalScroller:(HorizontalScroller*)scroller clickedViewAtIndex:(int)index;

@optional

// Ask delegate about initial presented view index:
- (NSInteger)initialViewIndexForHorizontalScroller:(HorizontalScroller *)scroller;

@end
