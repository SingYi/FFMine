//
//  FFMapScene.m
//  FFLandmine
//
//  Created by 燚 on 2017/12/6.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import "FFMapScene.h"


@implementation FFMapScene


+ (FFMapScene *)creatMapSceneWithLevel:(FFGameLevel)level {
    FFMapScene *scene = [[FFMapScene alloc] initWithSize:CGSizeMake(750, 750)];
    scene.backgroundColor = [UIColor orangeColor];
    scene.position = CGPointMake(0, 0);

    return scene;
}


- (void)didMoveToView:(SKView *)view {


}





@end
