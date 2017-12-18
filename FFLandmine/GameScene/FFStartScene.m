//
//  FFStartScene.m
//  FFLandmine
//
//  Created by 燚 on 2017/12/7.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import "FFStartScene.h"

@implementation FFStartScene

- (void)willMoveFromView:(SKView *)view {


}

- (void)didMoveToView:(SKView *)view {
    [self initUserInterface];
}

- (void)initUserInterface {

}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    // 获得点击的点
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKLabelNode *node = (SKLabelNode *)[self nodeAtPoint:location];

    NSString *index = [node.name substringFromIndex:node.name.length - 1];

    NSLog(@"star index === %@",index);
    if (self.startDelegate && [self.startDelegate respondsToSelector:@selector(FFStartScene:didClickStart:)]) {
        [self.startDelegate FFStartScene:self didClickStart:(FFGameLevel)(index.integerValue)];
    }

}








@end







