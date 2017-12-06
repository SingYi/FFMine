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

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initDataSource];
    }
    return self;
}

- (void)initDataSource {
    _level = FFPrimaryLevel;
    _cellWidth = kSCREEN_WIDTH / 9;
    _numberOfMines = 10;
}









@end
