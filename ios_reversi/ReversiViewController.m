//
//  ReversiViewController.m
//  ios_reversi
//
//  Created by Shuetsu Ito on 2014/02/08.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "ReversiViewController.h"
#import "ReversiGame.h"
#import "ReversiView.h"
#import "ReversiGesuture.h"

@interface ReversiViewController ()
{
    ReversiGame *_game;
}

@end

@implementation ReversiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *data;
    {
        NSURLRequest *request =
         [NSURLRequest requestWithURL:[NSURL URLWithString:
                          [NSString stringWithFormat:@"%@/s", SERVER_URL]]];
        NSData *_data =
         [NSURLConnection sendSynchronousRequest:request
                               returningResponse:nil error:nil];
        data = [NSJSONSerialization JSONObjectWithData:_data
                                               options:0
                                                 error:nil];
        NSLog(@"id=%@, p=%@", data[@"id"], data[@"p"]);
    }
    _game = [[ReversiGame alloc] initWithFrame:self.view.bounds
                                     sessionId:data[@"id"]
                                        player:[data[@"p"] integerValue]];
    [self.view addSubview:_game.view];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_game.gesture touchesBegan:touches view:_game.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_game.gesture touchesMoved:touches view:_game.view];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_game.gesture touchesEnded:touches view:_game.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
