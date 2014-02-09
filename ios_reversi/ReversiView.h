//
//  ReversiView.h
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReversiGame;

@interface ReversiView : UIView
@property (nonatomic, readonly)ReversiGame *game;
- (id)initWithFrame:(CGRect)frame game:(ReversiGame*)game;
@end
