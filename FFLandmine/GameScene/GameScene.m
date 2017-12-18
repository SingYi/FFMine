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
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node =  [self nodeAtPoint:location];

    NSLog(@"node name === %@",node.name);


    if ([node.name isEqualToString:@"GameBack"]) {
        if (self.gameDelegate && [self.gameDelegate respondsToSelector:@selector(GameScene:didBackButton:)]) {
            [self.gameDelegate GameScene:self didBackButton:nil];
        }
        NSLog(@"111111111111111111111111");
    }

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (MODEL.canScrollMap) {
    }
    [self scrollMapbackground:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
//
//    // 获得点击的点
//    UITouch *touch = [touches anyObject];
//
//
//    if (touch.tapCount == 2) {
//        NSLog(@"2");
//    } else {
//        NSLog(@"tap Count ==== %lu",(unsigned long)touch.tapCount);
//    }
//
//    NSLog(@"toucuo  time  == %f",touch.timestamp);
//
//    CGPoint location = [touch locationInNode:self];
//    lastPoint = location;
//    CGPoint nodePosition = [self recentNode:location];
//    NSLog(@"point: x === %lf    y === %lf",location.x,location.y);

//    SKNode *node = [self nodeAtPoint:nodePosition];
//    if ([node.name isEqual:@"GridNode"]) {
//        SKSpriteNode *newNode = (SKSpriteNode *)node;
//        if (time > 0.3) {
//            newNode.name = @"sureMine";
//            newNode.texture = [SKTexture textureWithImageNamed:@"红旗"];
//        }else {
//            self.userInteractionEnabled = NO;
////            [self dealWithGridNode:node];
//        }
//    }else if ([node.name isEqualToString:@"sureMine"]) {
//        SKSpriteNode *newNode = (SKSpriteNode *)node;
//        if (time > 0.3) {
//            newNode.name = @"GridNode";
//            newNode.texture = [SKTexture textureWithImageNamed:@"方块"];
//        }
//    }else {
//        self.userInteractionEnabled = YES;
//    }
//    NSLog(@"touch end");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}


// 判断点击的地方是否在节点上
//- (CGPoint)recentNode:(CGPoint)location {
//    CGFloat GridW = kSCREEN_WIDTH / 9.0;
//    NSInteger countX = (location.x - self.origin.x) / GridW;
//    NSInteger countY = (location.y - self.origin.y) / GridW;
//    CGFloat x = self.origin.x + countX * GridW + GridW / 2.0;
//    CGFloat y = self.origin.y + countY * GridW + GridW / 2.0;
//    return CGPointMake(x, y);
//}



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
        FFMineNode *node = [[FFMineNode alloc] initWithColor:[UIColor grayColor] size:CGSizeMake(MODEL.cellWidth - 1, MODEL.cellWidth - 1)];
        node.name = [NSString stringWithFormat:Mind_name,i];

        node.position = CGPointMake((MODEL.cellWidth) * (i % MODEL.rowNumber),MODEL.mapHeight - MODEL.cellWidth * ((i / MODEL.rowNumber) + 1));
        [self.mapBackgroundNode addChild:node];
        [MODEL.nodeArray addObject:node];
    }


//    [cropNode addChild:self.mapBackgroundNode];
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






