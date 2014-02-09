//
//  ReversiGesuture.m
//  ios_reversi
//
//  Created by Shuetsu Ito on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiGesuture.h"

@implementation ReversiGesuture

-(id)init
{
    self = [super init];
    if (self) {
        _touching = FALSE;
        _decide = FALSE;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches view:(UIView *)view
{
    UITouch *touch = [touches anyObject];
    _location = [touch locationInView:view];
    _touching = TRUE;
}

- (void)touchesMoved:(NSSet *)touches view:(UIView *)view
{
    UITouch *touch = [touches anyObject];
    _location = [touch locationInView:view];
}

- (void)touchesEnded:(NSSet *)touches view:(UIView *)view
{
    _touching = FALSE;
    _decide = TRUE;
}

- (void)nextFrame
{
    _decide = FALSE;
}

@end
