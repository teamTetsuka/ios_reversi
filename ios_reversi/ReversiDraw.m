//
//  ReversiDraw.m
//  ios_reversi
//
//  Created by Shuetsu Ito on 2014/02/09.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiDraw.h"
#import "ReversiLib.h"
#import "ReversiMap.h"
#import "ReversiPosition.h"

@implementation ReversiDraw

+ (void)drawBoard:(CGRect)boardRect
{
    [[UIColor colorWithRed:0 green:1 blue:0 alpha:1] setStroke];
    for(int r = 0;r <= ROWS;r++){
        int y = boardRect.origin.y + (CELL_SIZE * r);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(boardRect.origin.x, y)];
        [path addLineToPoint:CGPointMake(boardRect.origin.x + boardRect.size.width, y)];
        [path stroke];
    }
    for(int c = 0;c <= COLS;c++){
        int x = boardRect.origin.x + (CELL_SIZE * c);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(x, boardRect.origin.y)];
        [path addLineToPoint:CGPointMake(x, boardRect.origin.y + boardRect.size.height)];
        [path stroke];
    }    
}

+ (void)drawStone:(CGRect)stoneRect type:(EStoneType)type reverse:(float)reverse
{
    CGRect _rect = stoneRect;
    EStoneType _type = type;
    if (reverse != 0) {
        int h = sin(M_PI * reverse) * stoneRect.size.height / 2;
        int r = cos(M_PI * reverse) * stoneRect.size.height / 2;
        int y = stoneRect.origin.y + stoneRect.size.height / 2;
        if (r == 0) {
            _rect = CGRectMake(stoneRect.origin.x, y - h,
                               stoneRect.size.width, 1);
        }else{
            _rect = CGRectMake(stoneRect.origin.x, y - r - h,
                               stoneRect.size.width, r * 2);
        }
        if (r < 0){
            _type = [ReversiLib opponent:_type];
        }
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_rect];
    switch (_type){
    case STONE_BLACK:
        [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] setFill];
        [[UIColor colorWithRed:1 green:1 blue:1 alpha:1] setStroke];
        [path fill];
        [path stroke];
        break;
    case STONE_WHITE:
        [[UIColor colorWithRed:1 green:1 blue:1 alpha:1] setFill];
        [[UIColor colorWithRed:1 green:1 blue:1 alpha:1] setStroke];
        [path fill];
        [path stroke];
        break;
    default:
        break;
    }
}

+ (void)drawStone:(CGRect)stoneRect type:(EStoneType)type
{
    [ReversiDraw drawStone:stoneRect type:type reverse:0];
}

+ (void)drawSelectableCell:(CGRect)cellRect phase:(float)phase
{
    float _phase = phase * 2;
    if (_phase > 1) {
        _phase = 2.0 - _phase;
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:cellRect];
    [[UIColor colorWithRed:0.2 green:0.2 blue:0.5 alpha:_phase] setFill];
    [path fill];
}

+ (void)drawSelectedCell:(CGRect)cellRect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:cellRect];
    [[UIColor colorWithRed:0.5 green:0.2 blue:0.2 alpha:1] setFill];
    [path fill];
}

+ (void)drawTurnIndicate:(CGRect)boardRect
           currentPlayer:(EStoneType)currentPlayer
                  player:(EStoneType)player
                   phase:(float)phase
{
    if (player == STONE_BLACK) {
        CGRect rect = CGRectMake(boardRect.origin.x,
                                 boardRect.origin.y - STONE_SIZE - 10,
                                 STONE_SIZE + 46, STONE_SIZE + 4);
        [[UIColor colorWithRed:1 green:0 blue:0 alpha:1] setStroke];
        UIBezierPath* path = [UIBezierPath bezierPathWithRect:rect];
        [path stroke];
    }
    if (player == STONE_WHITE) {
        CGRect rect = CGRectMake(boardRect.origin.x + boardRect.size.width
                                 - STONE_SIZE - 46,
                                 boardRect.origin.y - STONE_SIZE - 10,
                                 STONE_SIZE + 46, STONE_SIZE + 4);
        [[UIColor colorWithRed:1 green:0 blue:0 alpha:1] setStroke];
        UIBezierPath* path = [UIBezierPath bezierPathWithRect:rect];
        [path stroke];
    }
    {
        CGRect rect = CGRectMake(boardRect.origin.x + 6,
                                 boardRect.origin.y - STONE_SIZE - 8,
                                 STONE_SIZE, STONE_SIZE);
        [ReversiDraw drawStone:rect type:STONE_BLACK];
    }
    {
        CGRect rect = CGRectMake(boardRect.origin.x + boardRect.size.width
                                 - STONE_SIZE - 6,
                                 boardRect.origin.y - STONE_SIZE - 8,
                                 STONE_SIZE, STONE_SIZE);
        [ReversiDraw drawStone:rect type:STONE_WHITE];
    }
    if (currentPlayer == STONE_BLACK) {
        int x = boardRect.origin.x + STONE_SIZE + 6 + 5;
        int y = boardRect.origin.y - STONE_SIZE - 8;
        float alpha = phase;
        for (int i = 0; i < 3; i++) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(x + 10, y)];
            [path addLineToPoint:CGPointMake(x, y + STONE_SIZE / 2)];
            [path addLineToPoint:CGPointMake(x + 10, y + STONE_SIZE)];
            [[UIColor colorWithRed:1 green:1 blue:1 alpha:alpha] setFill];
            [path fill];
            alpha += 0.25;
            if (alpha > 1) alpha -= 1.0;
            x += 10;
        }
    }
    if (currentPlayer == STONE_WHITE) {
        int x = boardRect.origin.x + boardRect.size.width - STONE_SIZE - 11;
        int y = boardRect.origin.y - STONE_SIZE - 8;
        float alpha = phase;
        for (int i = 0; i < 3; i++) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(x - 10, y)];
            [path addLineToPoint:CGPointMake(x, y + STONE_SIZE / 2)];
            [path addLineToPoint:CGPointMake(x - 10, y + STONE_SIZE)];
            [[UIColor colorWithRed:1 green:1 blue:1 alpha:alpha] setFill];
            [path fill];
            alpha += 0.25;
            if (alpha > 1) alpha -= 1.0;
            x -= 10;
        }
    }
}

+ (void)drawStoneCount:(CGRect)boardRect boardMap:(id)boardMap
{
    int blackCount = 0;
    int whiteCount = 0;
    for (int r = 0; r < ROWS; r++) {
        for (int c = 0; c < COLS; c++) {
            EStoneType t = [boardMap getInt:[ReversiPosition posWithRow:r col:c]];
            if (t == STONE_BLACK) {
                blackCount++;
            }else if (t == STONE_WHITE){
                whiteCount++;
            }
        }
    }
    {
        CGRect rect = CGRectMake(boardRect.origin.x,
                                 boardRect.origin.y + boardRect.size.height + 4,
                                 30, 30);
        [[NSString stringWithFormat:@"%d", blackCount] drawInRect:rect
                                           withAttributes:[ReversiDraw centerAttrs]];
    }
    {
        CGRect rect = CGRectMake(boardRect.origin.x + boardRect.size.width - 30,
                                 boardRect.origin.y + boardRect.size.height + 4,
                                 30, 30);
        [[NSString stringWithFormat:@"%d", whiteCount] drawInRect:rect
                                           withAttributes:[ReversiDraw centerAttrs]];
    }
    {
        int w = (boardRect.size.width - 60) * blackCount / (ROWS * COLS);
        CGRect rect = CGRectMake(boardRect.origin.x + 30,
                                 boardRect.origin.y + boardRect.size.height + 9,
                                 w, 10);
        UIBezierPath* path = [UIBezierPath bezierPathWithRect:rect];
        [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] setFill];
        [[UIColor colorWithRed:1 green:1 blue:1 alpha:1] setStroke];
        [path fill];
        [path stroke];
    }
    {
        int w = (boardRect.size.width - 60) * whiteCount / (ROWS * COLS);
        CGRect rect = CGRectMake(boardRect.origin.x + boardRect.size.width - 30 - w,
                                 boardRect.origin.y + boardRect.size.height + 9,
                                 w, 10);
        UIBezierPath* path = [UIBezierPath bezierPathWithRect:rect];
        [[UIColor colorWithRed:1 green:1 blue:1 alpha:1] setFill];
        [[UIColor colorWithRed:1 green:1 blue:1 alpha:1] setStroke];
        [path fill];
        [path stroke];
    }
}

+ (NSDictionary*)centerAttrs
{
    [[UIColor whiteColor] set];
    NSMutableParagraphStyle *p = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [p setAlignment:NSTextAlignmentCenter];
    return @{NSForegroundColorAttributeName: [UIColor whiteColor],
             NSFontAttributeName: [UIFont systemFontOfSize:15.0f],
             NSParagraphStyleAttributeName: p};
    
}

@end
