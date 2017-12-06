//
//  GameViewController.m
//  FFLandmine
//
//  Created by 燚 on 2017/12/5.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@interface GameViewController ()

@property (nonatomic, strong) GameScene *testScene;

@end

@implementation GameViewController


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (_testScene.size.width > _testScene.size.height) {
        _testScene.size = CGSizeMake(_testScene.size.height, _testScene.size.width);
    } else {
        _testScene.size = CGSizeMake(_testScene.size.width, _testScene.size.height);
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUserInterface];
}


- (void)initUserInterface {
    self.navigationItem.title = @"选择游戏难度";
    SKView *view  = [[SKView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    self.view = view;
    [view presentScene:self.testScene];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - getter
- (GameScene *)testScene {
    if (!_testScene) {
        _testScene = [GameScene nodeWithFileNamed:@"GameScene"];
//        _testScene = [[GameScene alloc] initWithSize:CGSizeMake(kSCREEN_WIDTH, kSCREEN_HEIGHT)];
//        _testScene.size = CGSizeMake(kSCREEN_WIDTH, kSCREEN_HEIGHT);
        _testScene.scaleMode = SKSceneScaleModeAspectFill;
    }
    return _testScene;
}





@end
