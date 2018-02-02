//
//  Person.h
//  SandBox
//
//  Created by 李广帅 on 2018/2/2.
//  Copyright © 2018年 天蓬大元. All rights reserved.
//

#import <Foundation/Foundation.h>

//遵守归档协议<NSCoding>
@interface Person : NSObject<NSCoding>

@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger age;

@end
