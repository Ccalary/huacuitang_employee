//
//  MainOneTypeCell.h
//  华粹堂-员工端
//
//  Created by liqiang on 2016/11/14.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeInfoModel.h"

@interface MainOneTypeCell : UITableViewCell

@property (nonatomic, strong) HomeInfoModel *model;

+ (MainOneTypeCell *)cellWithTableView:(UITableView *)tableView;

@end
