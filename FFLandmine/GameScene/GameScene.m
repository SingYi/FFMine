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



@property (nonatomic, assign) BOOL isMove;
@property (nonatomic, assign) BOOL isOneClick;
@property (nonatomic, assign) BOOL isDoubuleClick;


@end

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *_label;
    CGPoint lastPoint;
    FFMineNode *backGround;
}

- (void)didMoveToView:(SKView *)view {

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _isMove = NO;
    _isOneClick = NO;
    _isDoubuleClick = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (MODEL.canScrollMap) {

    }

    [self scrollMapbackground:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];

    if (_isMove) {
        return;
    }

    CGFloat view_height = self.size.height;
    CGFloat view_width = self.size.width;

    SKNode *node =  [self nodeAtPoint:location];
    NSString *idx = [node.name substringFromIndex:8];


    if ((location.y < (view_height + view_width) / 2) && (location.y > (view_height - view_width) / 2)) {
        if (touch.tapCount == 1) {
            [self clickGridWithIndex:idx.integerValue];
        } else if(touch.tapCount == 2) {
            [self doubleClickGridWIthIndex:idx.integerValue];
            syLog(@"2");
        }
        syLog(@"index === %@",idx);
    }


    if ([node.name isEqualToString:@"GameBack"]) {
        if (self.gameDelegate && [self.gameDelegate respondsToSelector:@selector(GameScene:didBackButton:)]) {
            [self.gameDelegate GameScene:self didBackButton:nil];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {


}



#pragma amrk - method
- (void)scrollMapbackground:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    CGPoint preveriousLocation = [touch previousLocationInNode:self];

    CGFloat deltaY = location.y - preveriousLocation.y;
    CGFloat deltaX = location.x - preveriousLocation.x;

    CGPoint originPoint = self.mapBackgroundNode.position;

    CGFloat afterX = 0.0;
    CGFloat afterY = 0.0;

    if (!_isMove && (sqrt(deltaX * deltaX + deltaY * deltaY) > 1)) {
        _isMove = YES;
    }

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


- (void)clickGridWithIndex:(NSInteger)idx {
    if (MODEL.isStar == NO) {
        [MODEL gameStartWithIndex:idx];
    }

    [MODEL clickTheGridWithIndex:idx];


    for (int i = 0; i < MODEL.showArray.count; i++) {
        SKSpriteNode *node = MODEL.nodeArray[i];
        if (MODEL.showArray[i].integerValue == 1) {
            NSString *mineNumStr = [NSString stringWithFormat:@"%@", MODEL.minesArray[i]];
            node.texture = [SKTexture textureWithImageNamed:mineNumStr];
        } else {
            node.texture = [SKTexture textureWithImageNamed:@"11"];
        }
    }
}

- (void)doubleClickGridWIthIndex:(NSInteger)idx {
    [MODEL doubleClickTheGridWithIndex:idx];
    for (int i = 0; i < MODEL.showArray.count; i++) {
        SKSpriteNode *node = MODEL.nodeArray[i];
        if (MODEL.showArray[i].integerValue == 1) {
            NSString *mineNumStr = [NSString stringWithFormat:@"%@", MODEL.minesArray[i]];
            node.texture = [SKTexture textureWithImageNamed:mineNumStr];
        } else {
            node.texture = [SKTexture textureWithImageNamed:@"11"];
        }
    }
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


    for (int i = 0; i < MODEL.colNumber * MODEL.rowNumber; i++) {
        SKSpriteNode *node = MODEL.nodeArray[i];
        node.position = CGPointMake((MODEL.cellWidth) * (i % MODEL.rowNumber),MODEL.mapHeight - MODEL.cellWidth * ((i / MODEL.rowNumber) + 1));
        node.texture = [SKTexture textureWithImageNamed:@"11"];
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
        _mapBackgroundNode.texture = [SKTexture textureWithImageNamed:@"backGround"];
    }
    return _mapBackgroundNode;
}















@end






