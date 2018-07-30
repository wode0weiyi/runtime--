//
//  User.m
//  runtime运行时
//
//  Created by 胡志辉 on 2018/7/27.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "User.h"

@implementation User
-(NSString *)description{
    return [NSString stringWithFormat:@"name=%@,age=%d",self.name,self.age];
}
@end
