//
//  HGModel.m
//  runtime运行时
//
//  Created by 胡志辉 on 2018/7/27.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import "HGModel.h"
#import <objc/runtime.h>

@implementation HGModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
//    创建当前类的实例变量
    id objc = [[self alloc] init];
    id idself = self;
    unsigned int count;
    
//    获取类中所有的属性变量
    Ivar * ivarList = class_copyIvarList(self, &count);
//    遍历所有的属性变量
    for (int i = 0; i < count; i ++) {
//        根据下标获取成员变量
        Ivar ivar = ivarList[i];
//        获取成员变量名称
        NSString * name = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        获取当前的成员变量的类型
        NSString * ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
//        对类型type进行处理
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];

//        处理获取到的变量名——>对获取的name进行截取（name第一位为_）
        NSString * key = [name substringFromIndex:1];
//        当字典中的字段和定义属性名不一致的时候，需要对key进行转换，以取得字典中的数据
        id idkey = [idself modelCustomPropertyMapper][key];
        if (idkey == nil) {
            idkey = key;
        }
//        根据key值获取字典中对应的value
        id value = dict[idkey];
//        判断当前的value是不是字典
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            //        获取type的类型
            Class methodClass = NSClassFromString(ivarType);
//            如果typeClass存在，则
            if (methodClass) {
                value = [methodClass modelWithDict:value];
            }
        }
//        判断当前的value 是不是数组
        if ([value isKindOfClass:[NSArray class]]) {
//            获取到数组value的type
            NSString *type = [idself arrayContainModelClass][key];
//            生成模型
            Class methodClass = NSClassFromString(type);
            NSMutableArray * mulary= [NSMutableArray array];
//            遍历字典数组，生成模型数组
            for (NSDictionary * dic in value) {
//                字典转模型
                id model = [methodClass modelWithDict:dic];
                [mulary addObject:model];
            }
            value = mulary;
        }
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    
    return objc;
}
/**
 * @func 字典里面包含数组的时候，数组里面的对象对应的是什么model，在这里表明，比如users代表的是User模型数组
 * 返回值的格式是@{@"users":@"User"}，其中users是获取的json数据中的字段，User代表的是users数组里面对象对应的模型model
 */
+(NSDictionary *)arrayContainModelClass{
    return @{@"users":@"User"};
}

/**
 * @func 对获取的json数据中的字段和自己定义的属性名不一致的时候，在这里返回出来
 * @des  返回值的格式是@{@"birthday":@"birth"},birthday表示的是自己定义的属性名，birth是json数据中对应的字段
 */
+(NSDictionary *)modelCustomPropertyMapper{
    return @{};
}


/**
 *@func runtime进行归档解档
 */

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count;
//        获取成员变量
        Ivar *ivarList = class_copyIvarList([self class], &count);
//        遍历
        for (int i = 0; i < count; i ++) {
//            取出对应下标的属性
            Ivar ivar = ivarList[i];
//            查看成员变量
            const char *name = ivar_getName(ivar);
//            归档
            NSString * key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            if (value) {
                [self setValue:value forKey:key];
            }else{
                [self setValue:@"" forKey:key];
            }
        }
        free(ivarList);//这里是自我释放
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
//    获取当前model的所有成员变量
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
//    遍历ivarList，取出具体的属性
    for (int i = 0; i < count; i ++) {
//        根据下标取出成员变量
        Ivar ivar = ivarList[i];
//        获取成员变量的名称
        const char *name = ivar_getName(ivar);
//        归档
        NSString * key = [NSString stringWithUTF8String:name];
        NSString * value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivarList);
}



@end
