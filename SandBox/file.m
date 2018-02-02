//
//  file.m
//  SandBox
//
//  Created by 李广帅 on 2018/2/2.
//  Copyright © 2018年 天蓬大元. All rights reserved.
//

#import "File.h"

@implementation File

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSFileManager *file = [NSFileManager defaultManager];
        NSArray*paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
        NSString*path=[paths objectAtIndex:0];
        //获取错误信息
        NSError *error = nil;  //NSError：
        //1，浅度便利，只获取当前目录下的文件，不会主动获取子文件下的文件
        //参数1: 遍历路径   参数2: 获取错误信息
        NSArray *array = [file contentsOfDirectoryAtPath:path error:&error];
        //遍历后，判断是否有错误，有则打印错误信息，没有则打印数组
        if(error) {
            NSLog(@"NSFileManager//error = %@",error);
        }else{
            NSLog(@"NSFileManager//array = %@",array);
        }
        //2，深度便利，不仅获取当前目录下的文件，还会主动获取子文件下的文件
        NSArray *array1 = [file subpathsOfDirectoryAtPath: path error:&error];
        if(error){
            NSLog(@"NSFileManager//error=%@",error);
        }else{
            NSLog(@"NSFileManager//array1 = %@",array1);
        }
        
        //创建文件
        //然后拼接完整的路径
        NSString *pathNewHome = [path stringByAppendingString:@"/NewHome.txt"];
        //判断文件是否存在
        BOOL bval = [file fileExistsAtPath:pathNewHome];
        //如果返回值为YES，则文件存在，否则文件不存在，则创建
        if(bval){
            NSLog(@"文件已存在");
        }else{
            //参数1:文件路径   参数2:文件内容 nil  参数3:属性信息  nil
            bval = [file createFileAtPath:pathNewHome contents:nil attributes:nil];
            if(bval){  //返回值为YES，说明创建文件成功，否则失败
                NSLog(@"创建文件成功");
            }else{
                NSLog(@"创建文件失败");
            }
        }
        NSArray *arrayQ = [file contentsOfDirectoryAtPath:path error:&error];
        //遍历后，判断是否有错误，有则打印错误信息，没有则打印数组
        if(error) {
            NSLog(@"NSFileManager//error = %@",error);
        }else{
            NSLog(@"NSFileManager//array = %@",arrayQ);
        }
        
        //创建目录
        NSString *pathItom = [path stringByAppendingString:@"/New/New.txt"];
        //判断文件是否存在
        BOOL bvalItom = [file fileExistsAtPath:pathItom];
        //如果目录存在，则无须创建
        if(bvalItom) {
            NSLog(@"目录已存在");
        }else{
            //参数1: 路径  参数2:是否需中间路径 YES 参数3: 属性 nil  参数4:错误提示
            //中间路径：需创建几层路径
            [file createDirectoryAtPath:pathItom withIntermediateDirectories:YES attributes:nil error:&error];
            if(error){
                NSLog(@"error=%@",error);
            }else{
                NSLog(@"目录创建成功");
            }
        }
        NSArray *arrayItom = [file contentsOfDirectoryAtPath:path error:&error];
        //遍历后，判断是否有错误，有则打印错误信息，没有则打印数组
        if(error) {
            NSLog(@"NSFileManager//error = %@",error);
        }else{
            NSLog(@"NSFileManager//array = %@",arrayItom);
        }
        
        
        
        
        
    }
    return self;
}

@end
