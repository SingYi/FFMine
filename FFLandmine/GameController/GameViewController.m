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

@interface GameViewController () <FFStartSceneDelegate>

@property (nonatomic, strong) GameScene *testScene;

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


#pragma mark - delegate
- (void)FFStartScene:(FFStartScene *)scene didClickStart:(FFGameLevel)level {
    [FFGameModel sharedModel].sceneWidth = self.testScene.size.width;
    [FFGameModel sharedModel].level = level;
    [self.testScene startGamesWith:level];
    [(SKView *)self.view presentScene:self.testScene transition:[SKTransition doorsOpenHorizontalWithDuration:0.3]];
}

#pragma mark - getter
- (GameScene *)testScene {
    if (!_testScene) {
//        _testScene = [GameScene nodeWithFileNamed:@"GameScene"];
        _testScene = [[GameScene alloc] initWithSize:CGSizeMake(kSCREEN_WIDTH * 2, kSCREEN_HEIGHT * 2)];
        _testScene.scaleMode = SKSceneScaleModeFill;
        _testScene.anchorPoint = CGPointZero;
    }
    return _testScene;
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
