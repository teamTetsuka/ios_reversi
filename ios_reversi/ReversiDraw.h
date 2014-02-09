//
//  ReversiDraw.h
//  ios_reversi
//
//  Created by Shuetsu Ito on 2014/02/09.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ReversiMap;

@interface ReversiDraw : NSObject
+(void)drawStage:(CGRect)stageRect;
+(void)drawStone:(CGRect)stoneRect type:(EStoneType)type reverse:(float)reverse;
+(void)drawStone:(CGRect)stoneRect type:(EStoneType)type;
+(void)drawSelectableCell:(CGRect)cellRect phase:(float)phase;
+(void)drawSelectedCell:(CGRect)cellRect;
+(void)drawTurnIndicate:(CGRect)stageRect
                   turn:(EStoneType)turn
                 myself:(EStoneType)myself
                  phase:(float)phase;
+(void)drawStoneCount:(CGRect)stageRect stageMap:(ReversiMap*)stageMap;
@end
