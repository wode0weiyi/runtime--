//
//  ViewController.m
//  runtime运行时
//
//  Created by 胡志辉 on 2018/7/11.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import "UIImage+URL.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  
    [super viewDidLoad];
    
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([Person class], &count);
    NSLog(@"count = %d",count);
    for (int i = 0; i < count; i ++) {
        NSString * propertyName = @(property_getName(properties[i]));
        NSString * attribute = @(property_getAttributes(properties[i]));
        NSLog(@"propertyName = %@  attribute = %@",propertyName,attribute);
    }
    Person *person = [[Person alloc] init];
    [person run];
    [Person eat];
    [person performSelector:@selector(jump) withObject:@"20"];
//    class_addMethod([Person class], @selector(jump), (IMP)jump1, "v@:");

    UIImage * image = [UIImage imageNamed:@"123"];
    NSLog(@"%@",image);
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    person = [Person modelWithDict:dic];
    NSLog(@"person = %@",person.description);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
