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

#define GridOfWidth kSCREEN_WIDTH / 9.0

@interface GameScene ()

@property (nonatomic, strong) SKSpriteNode *mapBackgroundNode;
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

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    // Get label node from scene and store it for use later
    _label = (SKLabelNode *)[self childNodeWithName:@"title"];
//
    _label.alpha = 1;
    [_label runAction:[SKAction fadeInWithDuration:2.0]];
    NSLog(@"node label == %@",_label);
//
    CGFloat w = (self.size.width + self.size.height) * 0.05;
//
    // Create shape node to use during mouse interaction
    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w, w) cornerRadius:w * 0.3];
    _spinnyNode.lineWidth = 2.5;

    [_spinnyNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:1]]];
    [_spinnyNode runAction:[SKAction sequence:@[
                                                [SKAction waitForDuration:3],
                                                [SKAction fadeOutWithDuration:3],
                                                [SKAction removeFromParent],
                                                ]]];

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

    [self initUserInterface];

}

- (void)initUserInterface {
    [self addChild:self.mapBackgroundNode];
//    [self.mapBackgroundNode addChild:[FFMapScene creatMapSceneWithLevel:FFPrimaryLevel]];
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



//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    // Run 'Pulse' action from 'Actions.sks'
//    [_label runAction:[SKAction actionNamed:@"Pulse"] withKey:@"fadeInOut"];
//        NSLog(@"width == %lf",self.size.width);
//    NSLog(@"scrren width == %lf",kSCREEN_WIDTH);
//
//
//    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
//
////    startTime = [touches anyObject].timestamp;
//    UITouch *touch = [touches anyObject];
//    CGPoint location = [touch locationInNode:self];
//    lastPoint = location;
//
//    NSLog(@"location.x ===== %lf",location.x);
////    NSLog(@"touch began");
//}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        [self touchMovedToPoint:[t locationInNode:self]];
    }

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];

    CGPoint addPoint = CGPointMake(location.x - lastPoint.x, location.y - lastPoint.y);
    lastPoint = location;

    FFMineNode *node = (FFMineNode *)[self childNodeWithName:@"testPoint"];
//    NSLog(@"node == %@",node);
    CGPoint originPoint = backGround.position;
    CGPoint afterPoint = CGPointMake(originPoint.x + addPoint.x, originPoint.y);
    backGround.position = afterPoint;


//    NSLog(@"point: x === %lf    y === %lf",location.x,location.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}

    // 获得点击的点
    UITouch *touch = [touches anyObject];


    if (touch.tapCount == 2) {
        NSLog(@"2");
    } else {
        NSLog(@"tap Count ==== %lu",(unsigned long)touch.tapCount);
    }

    NSLog(@"toucuo  time  == %f",touch.timestamp);

    CGPoint location = [touch locationInNode:self];
    lastPoint = location;
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
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
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










-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}





#pragma mark - geter
- (SKSpriteNode *)mapBackgroundNode {
    if (!_mapBackgroundNode) {
        _mapBackgroundNode = [[SKSpriteNode alloc] initWithColor:[UIColor whiteColor] size:CGSizeMake(750, 750)];
        _mapBackgroundNode.position = CGPointMake(0, 0);
        _mapBackgroundNode.name = @"mapBackgroundNode";

        FFMineNode *node = [[FFMineNode alloc] init];
        node.position = CGPointMake(-300, -300);
        [_mapBackgroundNode addChild:node];
    }
    return _mapBackgroundNode;
}








@end






