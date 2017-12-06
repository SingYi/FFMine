//
//  FFMineNode.m
//  FFLandmine
//
//  Created by 燚 on 2017/12/6.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import "FFMineNode.h"

@implementation FFMineNode


- (instancetype)init {
    self = [super initWithColor:[UIColor grayColor] size:CGSizeMake(kSCREEN_WIDTH / 9, kSCREEN_WIDTH / 9)];
    if (self) {
        [self initUserInterface];
    }
    return self;
}


- (void)initUserInterface {

}




@end
