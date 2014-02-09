//
//  ReversiLib.h
//  ios_reversi
//
//  Created by Shuetsu Ito on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ReversiPosition;

@interface ReversiLib : NSObject
+(EStoneType)opponent:(EStoneType)player;
+(CGRect)stageRect:(CGRect)viewRect;
+(CGRect)cellRect:(CGRect)stageRect pos:(ReversiPosition*)pos;
+(CGRect)stoneRect:(CGRect)cellRect;
+ (ReversiPosition*)selectedPos:(CGRect)stageRect location:(CGPoint)location;
@end
