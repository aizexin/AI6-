//
//  AIDBManager.m
//  AI6作业使用数据库
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#import "AIDBManager.h"

#import "AIDefine.h"
@interface AIDBManager ()

@end
@implementation AIDBManager

+(instancetype)shareManager{
    AIDBManager *manager = nil;
    if (!manager) {
        manager = [[AIDBManager alloc]init];
    }
    return manager;
}

//创建数据库
-(void)createDBWithName:(NSString*)dbName{
    //1.在沙盒路径下创建数据库
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path = [doc stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",dbName]];
    NSString *createTabelSql = @"create table if not exists userInfo(id integer primary key autoincrement,name varchar(256),age integer,image blob)";
    _fmdb = [[FMDatabase alloc]initWithPath:path];
    if ([_fmdb open]) {
        AILog(@"打开成功");
    }else{
        AILog(@"%@",_fmdb.lastErrorMessage);
    }
    if ([_fmdb executeUpdate:createTabelSql]) {
        AILog(@"创建表成功");
    }else{
        AILog(@"创建表不成功");
    }
    [_fmdb close];
}
//增、删、该
-(void)operateWithSql:(NSString*)sql{
    [_fmdb open];
    if (![_fmdb executeUpdate:sql]) {
        AILog(@"%@",_fmdb.lastErrorMessage);
    }
    [_fmdb close];
}
//查询操作
-(FMResultSet*)selectDBWithSql:(NSString*)sql{
    [_fmdb open];
    FMResultSet *result = nil;
    result = [_fmdb executeQuery:sql];
//    if () {
//        AILog(@"%@",_fmdb.lastErrorMessage);
//    }
    [_fmdb close];
    return result;
}
@end
