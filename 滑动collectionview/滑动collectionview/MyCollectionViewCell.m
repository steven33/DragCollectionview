//
//  MyCollectionViewCell.m
//  Demo
//
//  Created by Scott on 2016/10/10.
//  Copyright © 2016年 Scott. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _titleLab.backgroundColor = [UIColor yellowColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLab];
    }
    return self;
}

@end
