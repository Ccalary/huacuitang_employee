//
//  SecretLiftVC.m
//  华粹堂-员工端
//
//  Created by caohouhong on 17/2/28.
//  Copyright © 2017年 LiQiang. All rights reserved.
//

#import "SecretLiftVC.h"

@interface SecretLiftVC ()

@end

@implementation SecretLiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"私密生活";
    self.view.backgroundColor = COLOR_BackgroundColor;
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)drawView{
    UIView *topHoldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    topHoldView.backgroundColor = COLOR_BG_DARK_BLUE;
    [self.view addSubview:topHoldView];
    
    UILabel *textlabel = [[UILabel alloc] init];
    textlabel.text = @"体现消费能力，情感交流信息";
    textlabel.font = SYSTEM_FONT_(14);
    textlabel.textColor = COLOR_TEXT_DARK_BLUE;
    [self.view addSubview:textlabel];
    
    textlabel.sd_layout
    .leftEqualToView(self.view).offset(15)
    .topSpaceToView(self.view,0)
    .widthRatioToView(self.view,1)
    .heightIs(35);
    
    
}

@end
