//
//  GameScene.h
//  FFLandmine
//
//  Created by 燚 on 2017/12/5.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class GameScene;


@protocol GameSceneDelegate <NSObject>

- (void)GameScene:(GameScene *)scene didBackButton:(id)info;


@end

@interface GameScene : SKScene


@property (nonatomic, weak) id<GameSceneDelegate> gameDelegate;

- (void)startGamesWith:(FFGameLevel)level;


@end
