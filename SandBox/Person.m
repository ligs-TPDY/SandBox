//
//  Person.m
//  SandBox
//
//  Created by 李广帅 on 2018/2/2.
//  Copyright © 2018年 天蓬大元. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)description
{
    return [NSString stringWithFormat:@"name=%@,age=%ld", _name,_age];
}

//归档,实现归档协议的方法
- (void)encodeWithCoder:(NSCoder *)coder
{
    NSLog(@"进入归档");
    //将name属性进行归档;key自定义，解档时要完全匹配
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeInteger:_age forKey:@"age"];
}

//解档，实现解档协议的方法
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [[Person alloc] init];
    if (self) {
        NSLog(@"进入解档");
        //获取解档的属性值
        self.name = [coder decodeObjectForKey:@"name"];
        self.age = [coder decodeIntegerForKey:@"age"];
    }
    return self;
}

@end
