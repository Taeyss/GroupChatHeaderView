//
//  GroupChatHeaderView.m
//  GroupChatHeaderView
//
//  Created by liang wang on 16/8/15.
//  Copyright © 2016年 liang wang. All rights reserved.
//

#import "GroupChatHeaderView.h"

@implementation GroupChatHeaderView {
    NSMutableDictionary *dataDic;
}

- (id)init {
    self = [super init];
    if (self) {
        //
        dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}

/*
 *将数据处理为多维数组，对应布局的格式
 */
- (void)handleData:(NSArray *)members {
    NSUInteger count = members.count;
    if (count>9) {
        count = 9;
    }
    NSString *key = [NSString stringWithFormat:@"%@",[NSNumber numberWithUnsignedInteger:count]];
    
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:0];
    ///
    if (count <= 2) {
        NSArray *tempArray = members;
        [values addObject:tempArray];
        [dataDic setObject:values forKey:key];
        return;
    }
    NSUInteger row = 1;
    NSUInteger column = 1;
    if (count <= 4) {
        column = 2;
    } else {
        column = 3;
    }
    
    row = ceilf((CGFloat)count/(CGFloat)column);
    
    NSUInteger tempCount = 0;
    ///从最后1行开始填充数据
    for (NSUInteger i = row; i>0; i--) {
        ///填充列数据
        NSMutableArray *tempRowArray = [NSMutableArray arrayWithCapacity:0];
        for (NSUInteger j = column; j>0; j--) {
            //
            if (tempCount==count) {
                break;
            }
            
            id dataObject = [members objectAtIndex:count-tempCount-1];
            [tempRowArray insertObject:dataObject atIndex:0];
            tempCount++;
        }
        
        [values insertObject:tempRowArray atIndex:0];
    }
    [dataDic setObject:values forKey:key];
    
    return;
}

/*
 *布局
 */
- (void)initViewWithFrame:(CGRect)frame members:(NSArray *)members {
    [self handleData:members];
    NSUInteger count = members.count;
    if (count>9) {
        count = 9;
    }
    NSString *key = [NSString stringWithFormat:@"%@",[NSNumber numberWithUnsignedInteger:count]];
    NSArray *values = [dataDic objectForKey:key];
    
    CGFloat itemWidth = 0;
    CGFloat itemHeight = 0;
    
    if (count == 1) {
        itemWidth = frame.size.width;
        itemHeight = frame.size.height;
        
        UIImageView *itemImageView = [[UIImageView alloc] init];
        itemImageView.frame = CGRectMake(0, 0, itemWidth, itemHeight);
        itemImageView.backgroundColor = [UIColor redColor];
        [self addSubview:itemImageView];
        return;
    }
    CGFloat internet = 2.0;
    
    NSUInteger index = 0;
    
    CGRect rect = [self calculationItemWidth:values];
    itemWidth = rect.size.width;
    itemHeight = rect.size.height;
    CGFloat tempY = 0;
    tempY+=(frame.size.height-values.count*itemHeight-(values.count-1)*internet)/2.0;
    for (NSUInteger i = 0; i < values.count; i++) {
        NSArray *rowData = [values objectAtIndex:i];
        CGFloat leftMargin = (frame.size.width-rowData.count*itemWidth-(rowData.count-1)*internet)/2.0;
        CGFloat tempX = 0;
        tempX+=leftMargin;
        for (NSUInteger j = 0; j < rowData.count; j++) {
            //
            UIImageView *itemImageView = [[UIImageView alloc] init];
            itemImageView.frame = CGRectMake(tempX, tempY, itemWidth, itemHeight);
            itemImageView.backgroundColor = [UIColor redColor];
            [self addSubview:itemImageView];
            
            tempX+=itemWidth;
            tempX+=internet;
            
            index++;
        }
        tempY+=itemHeight;
        tempY+=internet;
    }
}

- (CGRect)calculationItemWidth:(NSArray *)values {
    CGRect rect = CGRectZero;
    NSArray *lastRowData = [values lastObject];
    CGFloat itemWidth = 0;
    CGFloat itemHeight = 0;
    CGFloat internet = 2.0;

    itemWidth = (self.frame.size.width-(lastRowData.count+1)*internet)/lastRowData.count;
    itemHeight = itemWidth;
    rect.size.width = itemWidth;
    rect.size.height = itemHeight;
    return rect;
}

@end
