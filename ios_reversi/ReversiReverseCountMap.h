//
//  ReversiReverseMap.h
//  ios_reversi
//
//  Created by Shuetsu Ito on 2014/02/09.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiMap.h"

@interface ReversiReverseCountMap : ReversiMap
-(id)initWithStageMap:(ReversiMap*)stageMap player:(EStoneType)player;
@end
