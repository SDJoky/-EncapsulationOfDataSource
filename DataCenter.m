//
//  DataCenter.m
//  1016_ZuoYe
//
//  Created by LSD on 15/10/17.
//  Copyright (c) 2015年 李思娣. All rights reserved.
//

#import "DataCenter.h"
#import "SDPersonModel.h"

@implementation DataCenter

//获取单例类的对象
+(instancetype)sharedInstance
{
    return [[self alloc]initWithFM];
}

-(instancetype)initWithFM
{
    if (self == nil) {
        self = [super init];
    }
   
    NSString * path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/user.db"];
    NSLog(@"%@",path);
    self = [super initWithPath:path];
    BOOL isOpen = [self open];
    if(isOpen)
    {
        //[self deleteAllInfo];
        NSLog(@"数据库打开成功");
        //<4>创建表格
        NSString * sql = @"create table if not exists userInfo(uid varchar(256) primary key,username varchar(256),headimage varchar(256),lastactivity varchar(256))";
        BOOL isSuccess = [self executeUpdate:sql];
        isSuccess?NSLog(@"表格创建成功"):NSLog(@"表格创建失败%@",self.lastErrorMessage);
    }
    else
    {
        NSLog(@"数据库打开失败%@",self.lastErrorMessage);
    }
    return self;
}

-(void)excuteWithModel:(SDPersonModel *)model
{
    [self excuteUpdataWithUid:model.uid andName:model.username andImageURL:model.headimage andLast:model.experience];
    //model.lastactivity.stringValue
}

//添加  id  名字  头像 时间  lastactivity下载下来是NSNumber
-(void)excuteUpdataWithUid:(NSString *)uid andName:(NSString *)name andImageURL:(NSString *)url andLast:(NSString *)lastactivity
{
    [self open];
    
    NSString *sql1 = @"select ? from userInfo";
    FMResultSet *result = [self executeQuery:sql1,uid];
    if (result) {
        //NSLog(@"%d已存在",(int)uid);
        return;
    }
    NSString *sql = @"insert into userInfo(uid,username,headimage,lastactivity) values (?,?,?,?)";
    BOOL isSuccess = [self executeUpdate:sql,uid,name,url,lastactivity];
    isSuccess?NSLog(@"数据添加成功"):NSLog(@"数据添加失败%@",self.lastErrorMessage);
}
-(int)searchData
{
    int i = 0;
    [self open];
    FMResultSet *result = [self executeQuery:@"select * from userInfo"];
    while ([result next]) {
        i ++;
    }
    return  i;
}

//删除记录
-(void)deleteAllInfo
{
    [self open];
    NSString * sql = @"delete from userInfo";
    BOOL isSuccess = [self executeUpdate:sql];
    isSuccess?NSLog(@"删除成功"):NSLog(@"删除失败%@",self.lastErrorMessage);
}

@end
