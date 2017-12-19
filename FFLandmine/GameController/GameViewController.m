//
//  GameViewController.m
//  FFLandmine
//
//  Created by 燚 on 2017/12/5.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "FFStartScene.h"

@interface GameViewController () <FFStartSceneDelegate, GameSceneDelegate>

@property (nonatomic, strong) GameScene *gameScene;

@property (nonatomic, strong) FFStartScene *startScene;



@end

@implementation GameViewController



- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUserInterface];
}


- (void)initUserInterface {
    self.navigationItem.title = @"选择游戏难度";
    SKView *view  = [[SKView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    self.view = view;
    [view presentScene:self.startScene];
    view.showsFPS = YES;
    view.showsNodeCount = YES;
}


- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}


#pragma mark - game start delegate
- (void)FFStartScene:(FFStartScene *)scene didClickStart:(FFGameLevel)level {
    [FFGameModel sharedModel].sceneWidth = self.gameScene.size.width;
    [FFGameModel sharedModel].level = level;
    [FFGameModel sharedModel].nodeArray = nil;
    [FFGameModel sharedModel].isStar = NO;
    [self.gameScene startGamesWith:level];
    [(SKView *)self.view presentScene:self.gameScene transition:[SKTransition doorsOpenHorizontalWithDuration:0.3]];
}

#pragma mark - game scene delegate
- (void)GameScene:(GameScene *)scene didBackButton:(id)info {
    [(SKView *)self.view presentScene:self.startScene transition:[SKTransition doorsCloseHorizontalWithDuration:0.3]];
}

#pragma mark - getter
- (GameScene *)gameScene {
    if (!_gameScene) {
        _gameScene = [GameScene nodeWithFileNamed:@"GameScene"];
        _gameScene.scaleMode = SKSceneScaleModeFill;
        _gameScene.anchorPoint = CGPointZero;
        _gameScene.gameDelegate = self;
    }
    return _gameScene;
}

- (FFStartScene *)startScene {
    if (!_startScene) {
        _startScene = [FFStartScene nodeWithFileNamed:@"FFStartScene"];
        _startScene.scaleMode = SKSceneScaleModeAspectFill;
        _startScene.startDelegate = self;
    }
    return _startScene;
}



- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


@end
