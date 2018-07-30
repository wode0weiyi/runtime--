//
//  Person.m
//  runtime运行时
//
//  Created by 胡志辉 on 2018/7/27.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

void jump1(id self,SEL sel){
    NSLog(@"跳起来");
}

void jump2(id self,SEL sel, NSString* metter){
    NSLog(@"跳了%@米",metter);
}

@implementation Person
- (void)run{
    NSLog(@"跑起来");
}
+(void)eat{
    NSLog(@"吃起来");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSString * selStr = NSStringFromSelector(sel);
    if ([selStr isEqualToString:@"jump"]) {
        unsigned int count;
        class_copyMethodList(self, &count);
        NSLog(@"%u",count);
        class_addMethod([Person class], sel, (IMP)jump2, "v@:@");
        class_copyMethodList(self, &count);
        NSLog(@"%u",count);
        return YES;
    }

    

    return NO;
    
}

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"birthday":@"birth"};
}

-(NSString *)description{
    return [NSString stringWithFormat:@"name=%@,age=%@,birthday=%@,sex=%@,user = %@",self.name,self.age,self.birthday,self.sex,self.user.description];
}


@end
