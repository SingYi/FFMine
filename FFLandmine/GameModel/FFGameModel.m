//
//  FFGameModel.m
//  FFLandmine
//
//  Created by 燚 on 2017/12/6.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import "FFGameModel.h"

#define ARRAYADDNUMBER(n) [array addObject:[NSNumber numberWithInteger:(n)]];

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
            self.numberOfMines = 10;
        }
            break;
        case FFMiddleLevel: {
            _rowNumber = 16;
            _colNumber = 16;
            self.mapWidth = _rowNumber * _cellWidth;
            self.mapHeight = _colNumber * _cellWidth;
            self.numberOfMines = 40;
        }
            break;
        case FFHeightLevel: {
            _rowNumber = 30;
            _colNumber = 16;
            self.mapWidth = _rowNumber * _cellWidth;
            self.mapHeight = _colNumber * _cellWidth;
            self.numberOfMines = 99;
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



#pragma mark - logic operation
/** start game */
- (BOOL)gameStartWithIndex:(NSUInteger)idx {

    //clear mine array
    self.minesArray = nil;
    self.showArray = nil;
    if (self.minesArray == nil) {
        return NO;
    }

    //randomly generated mines
    BOOL next = [self getMineRandomWithIndex:idx];

    if (next) {
        //Calculate the numbers around the mines
        [self calculateTheNumbersAroundTheMines];

    } else {
        syLog(@"随机生成地雷出错");
        return NO;
    }

    _isStar = YES;

    return YES;
}


/** 随机生成地雷 */
- (BOOL)getMineRandomWithIndex:(NSInteger)idx {
    /*
     *  1.首先计算出选中的下标和下标周围的下标都放到数组 array 里
     *  2.创建一个用于记录下标的数组 indexArray(key = index), indexArray 的 count 等于 modelArray的 count.移除 1. 里得到的下标
     *  3.随机生成地雷
     */

    //1.点击的格子和周围的八个格子
    NSArray *array = [self selectTheItemAround8itemsWithIndex:idx];

    if (array.count == 0) {
        syLog(@"获取周围八个格子出错");
        return NO;
    }

    //2.将选中的下标和周围的下标移除随机地雷
    NSMutableArray *indexArray = [NSMutableArray arrayWithCapacity:_rowNumber * _colNumber];
    for (NSInteger i = 0; i < _rowNumber * _colNumber; i++) {
        [indexArray setObject:[NSNumber numberWithInteger:i] atIndexedSubscript:i];
    }

    [indexArray removeObject:[NSNumber numberWithInteger:idx]];

    for (NSNumber *obj in array) {
        [indexArray removeObject:obj];
    }

    if (indexArray.count != (self.minesArray.count - array.count - 1)) {
        syLog(@"下标数组出错");
        return NO;
    }

    //3.计算地雷
    for (NSInteger i = 0; i < _numberOfMines ; i++) {

        NSInteger indexArrayCount = indexArray.count;
        NSInteger random = arc4random() % indexArrayCount;
        NSNumber *indexNumber = indexArray[random];
        //下标对应的值修改为 10 表示为地雷.
        [self.minesArray replaceObjectAtIndex:indexNumber.integerValue withObject:[NSNumber numberWithInteger:10]];
        //修改完之后删除对应下标
        [indexArray removeObject:indexNumber];
    }

    if (self.minesArray.count == _rowNumber * _colNumber) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)calculateTheNumbersAroundTheMines {
    //循环数组,如果是地雷 , 就将周围的数组全部加1
    if (_minesArray) {
        [_minesArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.integerValue == 10) {
                NSArray *array = [self selectTheItemAround8itemsWithIndex:idx];
                if (array.count != 0) {
                    for (NSNumber *index in array) {
                        if (index.integerValue > 0 && index.integerValue <= _rowNumber * _colNumber) {
                            NSNumber *value = _minesArray[index.integerValue];
                            [_minesArray replaceObjectAtIndex:index.integerValue withObject:[self addOne:value]];
                        } else {
                            syLog(@"row == %ld, col == %ld",_rowNumber,_colNumber);
                            syLog(@"idx == %ld",idx);
                            syLog(@"modelarray[idx] == %@",_minesArray[idx]);
                            syLog(@"%@",array);
                        }
                    }

                }
            }
        }];
    }
    return YES;
}

//数字加一
- (NSNumber *)addOne:(NSNumber *)number {
    NSInteger i = number.integerValue;
    if (i == 10) {
        return number;
    } else {
        i++;
        return [NSNumber numberWithInteger:i];
    }
}

#pragma mark - Flip the grid
- (void)clickTheGridWithIndex:(NSInteger)idx {
    NSNumber *showNumber = self.showArray[idx];
    if (showNumber.integerValue == 1) {
        return;
    }

    NSNumber *mineNumber = self.minesArray[idx];
    if (mineNumber.integerValue == 0) {
        [self clickNoMineCellWithIndex:idx];
    } else if (mineNumber.integerValue == 10) {
        [self clickTheGridWithTheMineWithIndex:idx];
    } else {
        [self clickNumberCellWithIndex:idx];
    }

}


- (void)clickNumberCellWithIndex:(NSInteger)idx {
    [self.showArray replaceObjectAtIndex:idx withObject:[NSNumber numberWithInt:1]];
}

- (void)clickTheGridWithTheMineWithIndex:(NSInteger)idx {
    [self.showArray replaceObjectAtIndex:idx withObject:[NSNumber numberWithInt:1]];
#warning game over
    NSLog(@"game over结束");
}

- (void)doubleClickTheGridWithIndex:(NSInteger)idx {
    NSNumber *showNumber = self.showArray[idx];
    if (showNumber.integerValue == 0) {
        return;
    }

    [self clickNoMineCellWithIndex:idx];

}

/** 翻开下标为0的周围所有格子,如果周围存在还有为0的格子,继续翻开下标为0的格子 */
- (void)clickNoMineCellWithIndex:(NSInteger)index {
    //需要翻开的所有格子
    NSMutableSet<NSNumber *> *alreadySet = [NSMutableSet setWithObject:[NSNumber numberWithInteger:index]];
    //添加周围8个为空的格子
    NSMutableSet<NSNumber *> *allSet = [self findEmptyIndex:index];

    //判断是否计算完毕
    allSet = [self alreadySet:alreadySet allSet:allSet WithMineArray:self.minesArray];

    //添加这些格子的周围8个格子
    for (NSNumber *num in allSet) {
        [alreadySet unionSet:[self findAroundWihtIndex:num.integerValue]];
    }

    //讲显示数组的下标设置为 1
    for (NSNumber *num in alreadySet) {
        self.showArray[num.integerValue] = [NSNumber numberWithInt:1];
    }
}


//计算周围8个方向是否有空
- (NSMutableSet *)findEmptyIndex:(NSInteger)idx {
    NSMutableSet *set = [NSMutableSet set];

    if (self.minesArray[idx].integerValue == 0) {
        [set addObject:[NSNumber numberWithInteger:idx]];
    }

    NSArray *array = [self selectTheItemAround8itemsWithIndex:idx];

    [array enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.minesArray[obj.integerValue].integerValue == 0) {
            [set addObject:obj];
        }
    }];

    return set;

}

/** 判断是否计算完毕 */
- (NSMutableSet *)alreadySet:(NSMutableSet *)alreadySet allSet:(NSMutableSet *)allSet WithMineArray:(NSMutableArray *)mineArray {

    NSMutableSet<NSNumber *> *beingSet = [NSMutableSet setWithSet:allSet];
    [beingSet minusSet:alreadySet];

    if (beingSet.count == 0) {
        return allSet;
    } else {
        [alreadySet unionSet:beingSet];
        for (NSNumber *num in beingSet) {
            [allSet unionSet:[self findEmptyIndex:num.integerValue]];
        }
        allSet = [self alreadySet:alreadySet allSet:allSet WithMineArray:mineArray];
    }
    return allSet;
}

/** 添加周围8个格子 */
- (NSMutableSet *)findAroundWihtIndex:(NSInteger)idx {
    NSMutableSet *set = [NSMutableSet set];
    NSArray *array = [self selectTheItemAround8itemsWithIndex:idx];

    [array enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [set addObject:obj];
    }];

    return set;
}




//根据选中的下标,返回周围8个格子的坐标
- (NSArray *)selectTheItemAround8itemsWithIndex:(NSInteger)idx {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:8];
    if (idx == 0) {
        ARRAYADDNUMBER(idx + 1);
        ARRAYADDNUMBER(idx + _rowNumber + 1);
        ARRAYADDNUMBER(idx + _rowNumber);
    } else if (((idx / _rowNumber) == 0) && (idx != 0) && (idx != (_rowNumber - 1))) {
        ARRAYADDNUMBER(idx + 1);
        ARRAYADDNUMBER(idx + _rowNumber + 1);
        ARRAYADDNUMBER(idx + _rowNumber);
        ARRAYADDNUMBER(idx + _rowNumber - 1);
        ARRAYADDNUMBER(idx - 1);
    } else if (idx == _rowNumber - 1) {
        ARRAYADDNUMBER(idx + _rowNumber);
        ARRAYADDNUMBER(idx + _rowNumber - 1);
        ARRAYADDNUMBER(idx - 1);
    } else if ((idx % _rowNumber == (_rowNumber - 1)) && (idx != _rowNumber - 1) && (idx != ((_rowNumber * _colNumber) - 1))) {
        ARRAYADDNUMBER(idx + _rowNumber);
        ARRAYADDNUMBER(idx + _rowNumber - 1);
        ARRAYADDNUMBER(idx - 1);
        ARRAYADDNUMBER(idx - _rowNumber - 1);
        ARRAYADDNUMBER(idx - _rowNumber);
    } else if (idx == (_rowNumber * _colNumber) - 1) {
        ARRAYADDNUMBER(idx - 1);
        ARRAYADDNUMBER(idx - _rowNumber - 1);
        ARRAYADDNUMBER(idx - _rowNumber);
    } else if ((idx / _rowNumber == (_colNumber - 1)) && (idx % _rowNumber != 0)) {
        ARRAYADDNUMBER(idx - _rowNumber - 1);
        ARRAYADDNUMBER(idx - _rowNumber);
        ARRAYADDNUMBER(idx - _rowNumber + 1);
        ARRAYADDNUMBER(idx + 1);
        ARRAYADDNUMBER(idx - 1);
    } else if (idx / _rowNumber == (_colNumber - 1) && (idx % _rowNumber == 0)) {
        ARRAYADDNUMBER(idx - _rowNumber);
        ARRAYADDNUMBER(idx - _rowNumber + 1);
        ARRAYADDNUMBER(idx + 1);
    } else if ((idx % _rowNumber == 0) && idx != 0 && (idx / _rowNumber != (_colNumber - 1))) {
        ARRAYADDNUMBER(idx - _rowNumber);
        ARRAYADDNUMBER(idx - _rowNumber + 1);
        ARRAYADDNUMBER(idx + 1);
        ARRAYADDNUMBER(idx + _rowNumber + 1);
        ARRAYADDNUMBER(idx + _rowNumber);
    } else {
        ARRAYADDNUMBER(idx - _rowNumber - 1);
        ARRAYADDNUMBER(idx - _rowNumber);
        ARRAYADDNUMBER(idx - _rowNumber + 1);
        ARRAYADDNUMBER(idx + 1);
        ARRAYADDNUMBER(idx + _rowNumber + 1);
        ARRAYADDNUMBER(idx + _rowNumber);
        ARRAYADDNUMBER(idx + _rowNumber - 1);
        ARRAYADDNUMBER(idx - 1);
    }
    return array;
}



#pragma mark - getter
- (BOOL)canScrollMap {
    if (_mapWidth > _sceneWidth || _mapHeight > _sceneWidth) {
        return YES;
    } else {
        return NO;
    }
}

- (NSMutableArray *)nodeArray {
    if (!_nodeArray) {
        _nodeArray = [NSMutableArray arrayWithCapacity:99];
        for (int i = 0; i < 480; i++) {
            SKSpriteNode *node = [[SKSpriteNode alloc] initWithColor:[UIColor grayColor] size:CGSizeMake(self.cellWidth - 1, self.cellWidth - 1)];

            node.name = [NSString stringWithFormat:Mind_name,i];
            node.anchorPoint = CGPointZero;
            [_nodeArray addObject:node];
        }
    }
    return _nodeArray;
}

- (NSMutableArray *)minesArray {
    if (!_minesArray) {
        if (_rowNumber > 8 && _colNumber > 8) {
            _minesArray = [NSMutableArray arrayWithCapacity:_rowNumber * _colNumber];
            for (NSInteger i = 0; i < _rowNumber * _colNumber; i++) {
                [_minesArray setObject:[NSNumber numberWithInteger:0] atIndexedSubscript:i];
            }
        } else {
            _minesArray = nil;
        }
    }
    return _minesArray;
}

- (NSMutableArray<NSNumber *> *)showArray {
    if (!_showArray) {
        _showArray = [NSMutableArray arrayWithCapacity:self.minesArray.count];
        for (NSInteger i = 0; i < _rowNumber * _colNumber; i++) {
            [_showArray setObject:[NSNumber numberWithInteger:0] atIndexedSubscript:i];
        }
    }
    return _showArray;
}






@end




