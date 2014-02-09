//
//  ReversiGesuture.h
//  ios_reversi
//
//  Created by Shuetsu Ito on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReversiGesuture : NSObject
@property (nonatomic, readonly)CGPoint location;
@property (nonatomic, readonly)BOOL touching;
@property (nonatomic, readonly)BOOL decide;
- (void)touchesBegan:(NSSet*)touches view:(UIView*)view;
- (void)touchesMoved:(NSSet*)touches view:(UIView*)view;
- (void)touchesEnded:(NSSet*)touches view:(UIView*)view;
- (void)nextFrame;
@end
