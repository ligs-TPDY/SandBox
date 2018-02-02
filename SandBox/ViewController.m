//
//  ViewController.m
//  SandBox
//
//  Created by 李广帅 on 2018/2/2.
//  Copyright © 2018年 天蓬大元. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "PList.h"
#import "File.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建沙盒，注意沙盒是单例
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //存储数据
    //a,对象的存储
    //- (void)setObject:(nullable id)value forKey:(NSString *)defaultName;
    //- (void)setURL:(nullable NSURL *)url forKey:(NSString *)defaultName API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
    //字符串
    [userDefaults setObject:@"hello,world" forKey:@"first"];
    [userDefaults synchronize];//flash闪存
    //数组或字典
    NSArray *arr = @[@"xiaoMing",@"xiaoGang",@"xiaoFang"];
    [userDefaults setObject:arr forKey:@"arr"];
    [userDefaults synchronize];
    //注意，沙盒不能存储自定义的对象！只能存储其对应的属性
    Person *p1 = [[Person alloc] init];
    p1.name = @"xiaoMing";
    [userDefaults setObject:p1.name forKey:@"name"];
    [userDefaults synchronize];//flash闪存
    //b,基本数据类型的存储
    //- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;
    //- (void)setFloat:(float)value forKey:(NSString *)defaultName;
    //- (void)setDouble:(double)value forKey:(NSString *)defaultName;
    //- (void)setBool:(BOOL)value forKey:(NSString *)defaultName;
    
    
    //Library/PreferencePanes
    // 1，先获取Library目录
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES)[0];
    // 2，再拼接Preferences目录
    NSString *prePath = [libPath stringByAppendingPathComponent:@"Preferences"];
    
    NSError *error = nil;
    NSFileManager *file = [NSFileManager defaultManager];
    //深度便利
    NSArray *array = [file subpathsOfDirectoryAtPath:prePath error:&error];
    if(error){
        NSLog(@"error=%@",error);
    }else{
        NSLog(@"array = %@",array);
    }
    
    NSString *prePath0 = [libPath stringByAppendingPathComponent:@"Preferences/LG.SandBox.plist"];
    
    //1. 通过数组方式获取plist文件数据
    NSArray *arr2 = [NSArray arrayWithContentsOfFile: prePath0];
    //2.通过字典方式获取plist文件数据
    NSDictionary *dic2 = [NSDictionary dictionaryWithContentsOfFile: prePath0];
    //因为prePath路径下的plist是以数组方式写入，所以只能通过数组读取
    NSLog(@"arr2 = %@,dic2=%@",arr2,dic2);
    
    /*沙盒存储的plist文件。默认会以字典的方式存储数据，所以，即便多次存储数据，其实还是在更改plist文件中的可变字典
     */
    
    
    
    //--plist--//
    PList *pp = [[PList alloc]init];
    NSLog(@"%@",pp);
    
    //--NSFileManager--//
    File *ff = [[File alloc]init];
    NSLog(@"%@",ff);
    
    //--归解档--//
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *pathData = [path stringByAppendingPathComponent:@"/data.txt"];
    
    Person *xiaoM = [[Person alloc] init];
    xiaoM.name = @"xiaoMing";
    xiaoM.age  = 18;

    //参数1: 归档内容  参数2: 归档的路径
    //archiveRootObject：归档到文件－>encodeWithCoder
    if([NSKeyedArchiver archiveRootObject:xiaoM toFile:pathData])
    {
        NSLog(@"归档成功");
    }
    
    Person *obj = [NSKeyedUnarchiver unarchiveObjectWithFile:pathData];
    NSLog(@"解档后：%@",obj);
    
    //归档到数据流
    //归档到数据流->encodeWithCoder
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:xiaoM];
    Person *obj2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"数据流解档后:%@",obj2);
    
    
}

@end
