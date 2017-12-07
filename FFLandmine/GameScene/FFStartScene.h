//
//  FFStartScene.h
//  FFLandmine
//
//  Created by 燚 on 2017/12/7.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class FFStartScene;

@protocol FFStartSceneDelegate <NSObject>


- (void)FFStartScene:(FFStartScene *)scene didClickStart:(FFGameLevel)level;



@end


@interface FFStartScene : SKScene


@property (nonatomic, weak) id<FFStartSceneDelegate> startDelegate;


@end
