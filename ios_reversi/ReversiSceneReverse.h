//
//  ReversiSceneReverse.h
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReversiScene.h"
@class ReversiPosition;

@interface ReversiSceneReverse : NSObject <ReversiScene>
- (id)initWithPlayer:(EStoneType)player
          decidedPos:(ReversiPosition*)decidedPos
     reverseCountMap:(NSDictionary*) reverseCountMap;
@end
