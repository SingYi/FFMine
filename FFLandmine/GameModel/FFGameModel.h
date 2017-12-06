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
/** game cell width */
@property (nonatomic, assign) CGFloat cellWidth;
/** number of mines */
@property (nonatomic, assign) int numberOfMines;
/** mines array */
@property (nonatomic, strong) NSArray *minesArray;


/** single model*/
+ (FFGameModel *)sharedModel;








@end








