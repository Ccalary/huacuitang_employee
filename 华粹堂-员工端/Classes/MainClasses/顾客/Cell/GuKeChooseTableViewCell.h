//
//  GuKeChooseTableViewCell.h
//  华粹堂-员工端
//
//  Created by 李强 on 2017/2/16.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuKeChooseTableViewCell : UITableViewCell

@property (nonatomic, weak) UILabel *titleLabel;

+ (GuKeChooseTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end
