//
//  Person.h
//  runtime运行时
//
//  Created by 胡志辉 on 2018/7/27.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "HGModel.h"


@interface Person : HGModel
/*注释*/
@property (nonatomic , copy) NSString *name;
/*注释*/
@property (nonatomic , copy) NSString *age;
/*注释*/
@property (nonatomic , copy) NSString *sex;
/*注释*/
@property (nonatomic , copy) NSString *birthday;
/*注释*/
@property (nonatomic,strong) NSArray *users;
/*注释*/
@property (nonatomic,strong) User *user;

- (void)run;
+(void)eat;

@end
