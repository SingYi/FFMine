//
//  FFGameModel.m
//  FFLandmine
//
//  Created by 燚 on 2017/12/6.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import "FFGameModel.h"

@interface FFGameModel ()


@end

static FFGameModel *model = nil;
@implementation FFGameModel


+ (FFGameModel *)sharedModel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (model == nil) {
            model = [[FFGameModel alloc] init];
        }
    });

    return model;
}




#pragma mark - setter
- (void)setLevel:(FFGameLevel)level {
    _level = level;
    switch (_level) {
        case FFPrimaryLevel: {
            _rowNumber = 9;
            _colNumber = 9;
            self.mapWidth = _rowNumber * _cellWidth;
            self.mapHeight = _colNumber * _cellWidth;
        }
            break;
        case FFMiddleLevel: {

        }
            break;
        case FFHeightLevel: {

        }
            break;
        default:

            break;
    }
}

- (void)setSceneWidth:(CGFloat)sceneWidth {
    _sceneWidth = sceneWidth;
    self.cellWidth = sceneWidth / 9;
}

#pragma mark - getter
- (BOOL)canScrollMap {
    if (_mapWidth > _sceneWidth || _mapHeight > _sceneWidth) {
        return YES;
    } else {
        return NO;
    }
}



@end
