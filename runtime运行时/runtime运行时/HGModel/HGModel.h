//
//  HGModel.h
//  runtime运行时
//
//  Created by 胡志辉 on 2018/7/27.
//  Copyright © 2018年 胡志辉. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HGModel : NSObject<NSCoding>
/**
 * @func 字典转模型方法
 * @param dict 获取的json数据
 */
+(instancetype)modelWithDict:(NSDictionary *)dict;

/**
 * @func 字典里面包含数组的时候，数组里面的对象对应的是什么model，在这里表明，比如users代表的是User模型数组
 * 返回值的格式是@{@"users":@"User"}，其中users是获取的json数据中的字段，User代表的是users数组里面对象对应的模型model
 * 这个方法返回值可以直接在HGModel.m文件呢里面进行修改添加。也可以在子类中继承重写
 */
+(NSDictionary *)arrayContainModelClass;

/**
 * @func 对获取的json数据中的字段和自己定义的属性名不一致的时候，在这里返回出来
 * @des  返回值的格式是@{@"birthday":@"birth"},birthday表示的是自己定义的属性名，birth是json数据中对应的字段
 */
+(NSDictionary *)modelCustomPropertyMapper;
@end
