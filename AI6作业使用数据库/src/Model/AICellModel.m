//
//  AICellModel.m
//  AI6作业使用数据库
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AICellModel.h"

@implementation AICellModel
+(instancetype)createModelWithResult:(FMResultSet*)result{
    AICellModel *model = [[AICellModel alloc]init];
    model.name = [result stringForColumn:@"name"];
    model.age = @([result intForColumn:@"age"]);
    model.uid = @([result intForColumn:@"id"]);
    model.imagedata = [result dataForColumn:@"image"];
    return model;
}


@end
