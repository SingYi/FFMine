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
    _testScene.size = CGSizeMake(kSCREEN_WIDTH, kSCREEN_HEIGHT);
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUserInterface];
    // Load the SKScene from 'GameScene.sks'
//    GameScene *testScene2 = [GameScene nodeWithFileNamed:@"GameScene"];
    _testScene = [[GameScene alloc] initWithSize:CGSizeMake(kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    _testScene.backgroundColor = [UIColor orangeColor];
    // Set the scale mode to scale to fit the window
    _testScene.scaleMode = SKSceneScaleModeAspectFill;

    SKView *view  = [[SKView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    self.view = view;
    // Present the scene
    [view presentScene:_testScene];


//    GameScene *testScene2 = [[GameScene alloc] initWithSize:CGSizeMake(kSCREEN_WIDTH, kSCREEN_HEIGHT)];
//    testScene2.backgroundColor = [UIColor grayColor];
//    testScene2.position = CGPointMake(kSCREEN_WIDTH / 2, kSCREEN_HEIGHT / 2);
////    testScene2.scaleMode = skscene
//    [view presentScene:testScene2];


//    [view presentScene:_testScene];

//    [view presentScene:testScene2 transition:[SKTransition flipHorizontalWithDuration:1]];



    view.showsFPS = YES;
    view.showsNodeCount = YES;

    
}


- (void)initUserInterface {
    self.navigationItem.title = @"选择游戏难度";
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

@end
