//
//  PList.m
//  SandBox
//
//  Created by 李广帅 on 2018/2/2.
//  Copyright © 2018年 天蓬大元. All rights reserved.
//

#import "PList.h"

@implementation PList

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //NSNumber  数字类  存储数字的一个类
        //初始化NSNumber对象： 类方法、对象方法
        //可将int、float、double、char等类型变量转NSNumber对象类型
        int a = 12;
        NSNumber *numA = [NSNumber numberWithInt:a];
        NSNumber *numB = @5;  //直接初始化NSNumber对象
        NSArray *array = @[@"aa",numA,numB,@"bb"];
        
        //Library
        NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString*path=[paths objectAtIndex:0];
        //然后拼接完整的路径
        NSString *pathNew = [path stringByAppendingString:@"/write.plist"];
        NSFileManager *file1 = [NSFileManager defaultManager];
        //判断文件是否存在
        BOOL bval = [file1 fileExistsAtPath:pathNew];
        //如果返回值为YES，则文件存在，否则文件不存在，则创建
        if(bval){
            NSLog(@"文件已存在");
        }else{
            //参数1:文件路径   参数2:文件内容 nil  参数3:属性信息  nil
            bval = [file1 createFileAtPath:pathNew contents:nil attributes:nil];
            if(bval){  //返回值为YES，说明创建文件成功，否则失败
                NSLog(@"创建文件成功");
            }else{
                NSLog(@"创建文件失败");
            }
        }
        
        //深度便利
        NSError *error = nil;
        NSFileManager *file = [NSFileManager defaultManager];
        NSArray *arr = [file subpathsOfDirectoryAtPath:pathNew error:&error];
        if(error){
            NSLog(@"error=%@",error);
        }else{
            NSLog(@"array = %@",arr);
        }
        
        
        //将数组写入到plist文件
        if([array writeToFile: pathNew atomically:YES]){
            NSLog(@"写入plist成功");
        }else{
            NSLog(@"写入失败");
        }
        
        //1. 通过数组方式获取plist文件数据
        NSArray *arr2 = [NSArray arrayWithContentsOfFile: pathNew];
        //2.通过字典方式获取plist文件数据
        NSDictionary *dic2 = [NSDictionary dictionaryWithContentsOfFile: pathNew];
        //因为prePath路径下的plist是以数组方式写入，所以只能通过数组读取
        NSLog(@"arr2 = %@,dic2=%@",arr2,dic2);
        
    }
    return self;
}

@end
