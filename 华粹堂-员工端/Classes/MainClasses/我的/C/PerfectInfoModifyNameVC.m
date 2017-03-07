//
//  PerfectInfoModifyNameVC.m
//  lingdaozhe
//
//  Created by liqiang on 16/5/19.
//  Copyright © 2016年 bckj. All rights reserved.
//

#import "PerfectInfoModifyNameVC.h"

@interface PerfectInfoModifyNameVC ()<UITextFieldDelegate>

@property (nonatomic, weak) UITextField *textField;

@end

@implementation PerfectInfoModifyNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"真实姓名";
    
    self.view.backgroundColor = COLOR_BackgroundColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChangedValu:) name:UITextFieldTextDidChangeNotification object:nil];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    rightBarButton.tintColor = COLOR_darkGray;
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self drawView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"%@释放了",NSStringFromClass(self.class));
}

- (void)drawView
{
    UIView *bgv = [[UIView alloc] init];
    bgv.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgv];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
//    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
//    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.textColor = COLOR_Black;
    textField.delegate = self;
    textField.font = FONT_TEXTSIZE_Big;
    textField.text = [ModelMember sharedMemberMySelf].name;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [bgv addSubview:textField];
    self.textField = textField;
    
    bgv.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,20)
    .heightIs(40);
    
    textField.sd_layout
    .leftSpaceToView(bgv,20)
    .rightSpaceToView(bgv,20)
    .topSpaceToView(bgv,0)
    .bottomSpaceToView(bgv,0);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing: YES];
}

- (void)save
{
    if (!self.textField.text.length)
    {
        [LCProgressHUD showFailure:@"请填写名称"];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[ModelMember sharedMemberMySelf].memberId forKey:@"employeeId"];
    [params setValue:self.textField.text forKey:@"name"];
    
    [[LQHTTPSessionManager sharedManager] LQPost:@"employee/modifyName" parameters:params showTips:@"正在修改..." success:^(id responseObject) {
        [LCProgressHUD showSuccess:@"修改成功"];
        
        ModelMember *member = [ModelMember sharedMemberMySelf];
        member.name = self.textField.text;
        
        NSMutableDictionary *dic = [[ModelMember sharedMemberMySelf] mj_keyValues];
        NSLog(@"---->%@",dic);
        [ModelMember doLoginWithMemberDic:dic];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } successBackfailError:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -
#pragma mark ================= NSNotification =================
- (void)textFieldChangedValu:(NSNotification *)notification
{
    UITextField *textField = (UITextField *)notification.object;
    
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            [self judgeTextFieldLengthWithTextField:textField];
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else
        {
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        [self judgeTextFieldLengthWithTextField:textField];
    }
}

- (void)judgeTextFieldLengthWithTextField:(UITextField  *)textField
{
    NSString *toBeString = textField.text;
    
    if ([toBeString length] > 16)
    {
        textField.text = [toBeString substringToIndex:16];
    }
}

#pragma mark -
#pragma mark ================= UITextFieldDelegate =================
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"@"])
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self.view endEditing:YES];
    
    return YES;
}

@end
