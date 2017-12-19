//
//  GameScene.m
//  FFLandmine
//
//  Created by 燚 on 2017/12/5.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import "GameScene.h"
#import "FFMineNode.h"
#import "FFMapScene.h"

#define MODEL [FFGameModel sharedModel]

#define MAP_BACKGROUND_NAME @"mapBackgroundNode"

@interface GameScene ()


@property (nonatomic, strong) FFMapScene *mapBackgroundNode;
/**
 坐标原点
 */
@property (nonatomic,assign) CGPoint origin;


@end

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    CGPoint lastPoint;
    FFMineNode *backGround;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    // Get label node from scene and store it for use later
//    _label = (SKLabelNode *)[self childNodeWithName:@"title"];
////
//    _label.alpha = 1;
//    [_label runAction:[SKAction fadeInWithDuration:2.0]];
//    NSLog(@"node label == %@",_label);
////
//    CGFloat w = (self.size.width + self.size.height) * 0.05;
////
//    // Create shape node to use during mouse interaction
//    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];
//    _spinnyNode.lineWidth = 2.5;
//
//    [_spinnyNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:1]]];
//    [_spinnyNode runAction:[SKAction sequence:@[
//                                                [SKAction waitForDuration:3],
//                                                [SKAction fadeOutWithDuration:3],
//                                                [SKAction removeFromParent],
//                                                ]]];

//    [_spinnyNode addtar]
//
//    backGround = [[FFMineNode alloc] initWithColor:[UIColor whiteColor] size:CGSizeMake(kSCREEN_WIDTH * 2, kSCREEN_WIDTH)];
//    backGround.position = CGPointMake(kSCREEN_WIDTH / 2, kSCREEN_HEIGHT / 2);
//    [self addChild:backGround];
//
//
//    FFMineNode *node = [[FFMineNode alloc] init];
////    node.position = CGPointMake(kSCREEN_WIDTH / 2, kSCREEN_HEIGHT / 2);
//    node.position = CGPointZero;
//    node.name = @"testPoint";
//
//    [backGround addChild:node];

//    [self initUserInterface];

}

- (void)initUserInterface {

}



- (void)touchDownAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor greenColor];
    [self addChild:n];
}

- (void)touchMovedToPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor blueColor];
    [self addChild:n];
}

- (void)touchUpAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor redColor];
    [self addChild:n];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (MODEL.canScrollMap) {
    }
    [self scrollMapbackground:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];

    NSLog(@"count === %@",@(touch.tapCount));//短时间内的点击次数
    if (touch.tapCount == 1) {
        syLog(@"1");
    } else {
        syLog(@"2");
    }

    CGFloat view_height = self.size.height;
    CGFloat view_width = self.size.width;

    SKNode *node =  [self nodeAtPoint:location];
    if ((location.y < (view_height + view_width) / 2) && (location.y > (view_height - view_width) / 2)) {
        syLog(@"node name === %@",node.name);

        NSString *idx = [node.name substringFromIndex:8];
        syLog(@"idx === %@",idx);

//        NSArray *array = [MODEL selectTheItemAround8itemsWithIndex:idx.integerValue];

        [MODEL gameStartWithIndex:idx.integerValue];
        for (int i = 0; i < MODEL.minesArray.count; i++) {
            SKSpriteNode *node = MODEL.nodeArray[i];
            NSString *mineNumStr = [NSString stringWithFormat:@"%@", MODEL.minesArray[i]];
            node.texture = [SKTexture textureWithImageNamed:mineNumStr];
        }

        syLog(@"array === %@",MODEL.minesArray);
    }





    if ([node.name isEqualToString:@"GameBack"]) {
        if (self.gameDelegate && [self.gameDelegate respondsToSelector:@selector(GameScene:didBackButton:)]) {
            [self.gameDelegate GameScene:self didBackButton:nil];
        }
        NSLog(@"111111111111111111111111");
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}



#pragma amrk - method
- (void)scrollMapbackground:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    CGPoint preveriousLocation = [touch previousLocationInNode:self];

    CGFloat deltaY = location.y - preveriousLocation.y;
    CGFloat deltaX = location.x - preveriousLocation.x;

    CGPoint originPoint = self.mapBackgroundNode.position;

//    NSLog(@"originPoint.x == %lf, originPoint.y = %lf",originPoint.x,originPoint.y);

    CGFloat afterX = 0.0;
    CGFloat afterY = 0.0;

    if (originPoint.x + deltaX >=0 ) {
        afterX = 0;
    } else if (originPoint.x + deltaX <= -MODEL.mapWidth + MODEL.sceneWidth) {
        afterX = -MODEL.mapWidth + MODEL.sceneWidth;
    } else {
        afterX = originPoint.x + deltaX;
    }

    if (originPoint.y + deltaY >= 0 ) {
        afterY = 0;
    } else if (originPoint.y + deltaY <= -MODEL.mapHeight + MODEL.sceneWidth) {
        afterY = -MODEL.mapHeight + MODEL.sceneWidth;
    } else {
        afterY = originPoint.y + deltaY;
    }

    self.mapBackgroundNode.position = CGPointMake(afterX,  afterY);

}






- (void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

#pragma mark - This code is mine
- (void)startGamesWith:(FFGameLevel)level {
//    [self removeAllChildren];
    [self startPrimaryLevelGame];
}

- (void)startPrimaryLevelGame {
    [self.mapBackgroundNode removeAllChildren];
    [self.mapBackgroundNode removeFromParent];

    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;

    SKCropNode *cropNode = [[SKCropNode alloc] init];
    SKSpriteNode *bgNode = [[SKSpriteNode alloc] initWithColor:[UIColor orangeColor] size:CGSizeMake(width, width)];
    bgNode.anchorPoint = CGPointZero;
    bgNode.position = CGPointMake(0, 0);
    cropNode.maskNode = bgNode;
    cropNode.position = CGPointMake(0, (height - width) / 2);

    SKSpriteNode *backNode = [[SKSpriteNode alloc] initWithColor:[UIColor whiteColor] size:CGSizeMake(width, width)];
    backNode.anchorPoint = CGPointZero;
    backNode.position = CGPointZero;

    [cropNode addChild:backNode];

    self.mapBackgroundNode.size = CGSizeMake(MODEL.mapWidth, MODEL.mapHeight);
    self.mapBackgroundNode.position = CGPointZero;

    NSLog(@"map width === %lf",MODEL.mapWidth);

    for (int i = 0; i < MODEL.colNumber * MODEL.rowNumber; i++) {
        SKSpriteNode *node = MODEL.nodeArray[i];
        node.position = CGPointMake((MODEL.cellWidth) * (i % MODEL.rowNumber),MODEL.mapHeight - MODEL.cellWidth * ((i / MODEL.rowNumber) + 1));
        [self.mapBackgroundNode addChild:node];
    }


    [cropNode addChild:self.mapBackgroundNode];
    [self addChild:cropNode];


    SKNode *node = [self childNodeWithName:@"GameBack"];
    [node removeFromParent];
    [self addChild:node];


}




#pragma mark - geter
- (FFMapScene *)mapBackgroundNode {
    if (!_mapBackgroundNode) {
        _mapBackgroundNode = [[FFMapScene alloc] initWithColor:[UIColor whiteColor] size:CGSizeMake(MODEL.sceneWidth, MODEL.sceneWidth)];
        _mapBackgroundNode.name = MAP_BACKGROUND_NAME;
        _mapBackgroundNode.anchorPoint = CGPointZero;
    }
    return _mapBackgroundNode;
}















@end






