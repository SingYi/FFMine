//
//  FFGameModel.h
//  FFLandmine
//
//  Created by 燚 on 2017/12/6.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import <UIKit/UIKit.h>

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
/** mines array */
@property (nonatomic, strong) NSArray *minesArray;

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


/** single model*/
+ (FFGameModel *)sharedModel;








@end








