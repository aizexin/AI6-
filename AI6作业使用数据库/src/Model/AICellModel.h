//
//  AICellModel.h
//  AI6作业使用数据库
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
@interface AICellModel : UIView

/**
 *  主键
 */
@property(nonatomic,assign)NSNumber * uid;
/**
 *  名字
 */
@property(nonatomic ,copy)NSString *name;
/**
 *  年龄
 */
@property(nonatomic,assign)NSNumber * age;
/**
 *  照片二进制文件
 */
@property(nonatomic,strong)NSData *imagedata;

+(instancetype)createModelWithResult:(FMResultSet*)result;
@end
