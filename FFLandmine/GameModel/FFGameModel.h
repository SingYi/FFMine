//
//  FFGameModel.h
//  FFLandmine
//
//  Created by 燚 on 2017/12/6.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

#define Mind_name @"mineNode%d"

typedef enum : NSUInteger {
    FFPrimaryLevel = 0,
    FFMiddleLevel,
    FFHeightLevel,
} FFGameLevel;




@interface FFGameModel : NSObject

/** game level */
@property (nonatomic, assign) FFGameLevel level;
/** number of mines */
@property (nonatomic, assign) int numberOfMines;


/** game map width */
@property (nonatomic, assign) CGFloat mapWidth;
/** game map height */
@property (nonatomic, assign) CGFloat mapHeight;
/** game row */
@property (nonatomic, assign) NSInteger rowNumber;
/** game col */
@property (nonatomic, assign) NSInteger colNumber;
/** game cell width */
@property (nonatomic, assign) CGFloat cellWidth;
/** game scene width */
@property (nonatomic, assign) CGFloat sceneWidth;
/** can scroll */
@property (nonatomic, assign) BOOL canScrollMap;

/** node array */
@property (nonatomic, strong) NSMutableArray<SKSpriteNode *> *nodeArray;
/** maps array */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *minesArray;
/** show array */
@property (nonatomic, strong) NSMutableArray<NSNumber *> *showArray;



@property (nonatomic, assign) BOOL isStar;

/** single model*/
+ (FFGameModel *)sharedModel;


#pragma mark - logic operation
- (BOOL)gameStartWithIndex:(NSUInteger)idx;

/** Clicked the grid */
- (void)clickTheGridWithIndex:(NSInteger)idx;

/** Clicked with a grid of numbers */
- (void)clickNumberCellWithIndex:(NSInteger)idx;

/** Clicked on the blank grid */
- (void)clickNoMineCellWithIndex:(NSInteger)idx;

/** Click the grid with the mine */
- (void)clickTheGridWithTheMineWithIndex:(NSInteger)idx;

/** Double click the grid with index */
- (void)doubleClickTheGridWithIndex:(NSInteger)idx;



@end








