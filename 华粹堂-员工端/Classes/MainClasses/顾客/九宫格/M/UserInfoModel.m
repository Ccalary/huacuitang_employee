//
//  UserInfoModel.m
//  华粹堂-员工端
//
//  Created by baichun on 17/3/2.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"sid" : @"id"};
}
@end
