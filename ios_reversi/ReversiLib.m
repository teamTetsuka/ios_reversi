//
//  ReversiLib.m
//  ios_reversi
//
//  Created by Shuetsu Ito on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiLib.h"
#import "ReversiPosition.h"

@implementation ReversiLib

+ (EStoneType)opponent:(EStoneType)player
{
    switch (player) {
        case STONE_BLACK:
            return STONE_WHITE;
            break;
        case STONE_WHITE:
            return STONE_BLACK;
        default:
            return STONE_NONE;
            break;
    }
}

+ (CGRect)boardRect:(CGRect)viewRect
{
    int w = COLS * CELL_SIZE;
    int h = ROWS * CELL_SIZE;
    return CGRectMake((viewRect.size.width - w) / 2,
                      (viewRect.size.height - h) / 2,
                      w, h);
}

+ (CGRect)cellRect:(CGRect)boardRect pos:(ReversiPosition *)pos
{
    return CGRectMake(boardRect.origin.x + pos.col * CELL_SIZE,
                      boardRect.origin.y + pos.row * CELL_SIZE,
                      CELL_SIZE, CELL_SIZE);
}

+ (CGRect)stoneRect:(CGRect)cellRect
{
    return CGRectMake(cellRect.origin.x + (cellRect.size.width - STONE_SIZE) / 2,
                      cellRect.origin.y + (cellRect.size.height - STONE_SIZE) / 2,
                      STONE_SIZE, STONE_SIZE);
}

+ (ReversiPosition*)selectedPos:(CGRect)stageRect location:(CGPoint)location{
    int r = (location.y - stageRect.origin.y) / CELL_SIZE;
    int c = (location.x - stageRect.origin.x) / CELL_SIZE;
    if (r < 0) r = 0;
    if (r >= ROWS) r = ROWS - 1;
    if (c < 0) c = 0;
    if (c >= COLS) c = COLS - 1;
    return [ReversiPosition posWithRow:r col:c];
}

@end
