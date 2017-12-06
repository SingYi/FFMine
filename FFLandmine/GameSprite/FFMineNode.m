//
//  FFMineNode.m
//  FFLandmine
//
//  Created by 燚 on 2017/12/6.
//  Copyright © 2017年 Yi Shi. All rights reserved.
//

#import "FFMineNode.h"

@implementation FFMineNode


- (instancetype)init
{
    self = [super initWithColor:[UIColor grayColor] size:CGSizeMake(kSCREEN_WIDTH / 4, kSCREEN_WIDTH / 4)];
    if (self) {
        [self initUserInterface];
    }
    return self;
}




- (void)initUserInterface {
    self.userInteractionEnabled = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"1111111111111111111");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"???????????????");
}



@end
