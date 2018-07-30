//
//  User.h
//  runtime运行时
//
//  Created by 胡志辉 on 2018/7/27.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGModel.h"

@interface User : HGModel
/*注释*/
@property (nonatomic , copy) NSString *name;
/*注释*/
@property (nonatomic , assign) int age;
@end
