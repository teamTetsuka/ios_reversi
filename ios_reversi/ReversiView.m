//
//  ReversiView.m
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiView.h"
#import "ReversiGame.h"

@implementation ReversiView

- (id)initWithFrame:(CGRect)frame game:(ReversiGame *)game{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        _game = game;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self.game draw];
}

@end
