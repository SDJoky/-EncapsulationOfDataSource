//
//  DataCenter.h
//  1016_ZuoYe
//
//  Created by LSD on 15/10/17.
//  Copyright (c) 2015年 李思娣. All rights reserved.
//

#import "FMDatabase.h"
#import <UIKit/UIKit.h>
@class SDPersonModel;

@interface DataCenter : FMDatabase
//获取单例类的对象
+(instancetype)sharedInstance;
-(instancetype)initWithFM;

-(void)deleteAllInfo;

-(void)excuteUpdataWithUid:(NSString *)uid andName:(NSString *)name andImageURL:(NSString *)url andLast:(NSString *)lastactivity;

-(void)excuteWithModel:(SDPersonModel *)model;

-(int)searchData;

@end
