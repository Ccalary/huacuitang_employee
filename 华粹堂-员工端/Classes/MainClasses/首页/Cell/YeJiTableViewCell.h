//
//  YeJiTableViewCell.h
//  华粹堂-员工端
//
//  Created by 唐硕 on 16/11/24.
//  Copyright © 2016年 LiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YeJiTableViewCell : UITableViewCell

+(instancetype)cellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UILabel *numLabel;

@end
