//
//  ReversiSceneOperation.h
//  IOS_reversi
//
//  Created by KaYosh on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReversiScene.h"

@interface ReversiSceneOperation : NSObject <ReversiScene>
- (id)initWithPlayer:(EStoneType)player;
@end
