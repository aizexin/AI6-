//
//  AIDBManager.h
//  AI6作业使用数据库
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface AIDBManager : NSObject
@property(nonatomic,strong)FMDatabase *fmdb;
/**
 *  创建数据库
 *
 *  @param dbName         数据库名字
 *  @param createTabelSql sql语句
 */
-(void)createDBWithName:(NSString*)dbName;
/**
 *  增删改
 *
 *  @param sql sql语句
 */
-(void)operateWithSql:(NSString*)sql;
-(FMResultSet*)selectDBWithSql:(NSString*)sql;
+(instancetype)shareManager;
@end
