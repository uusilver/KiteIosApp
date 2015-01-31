//
//  ChangeServiceCodeViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/29.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "ChangeServiceCodeViewController.h"

@implementation ChangeServiceCodeViewController
@synthesize serviceCode;
@synthesize password;

-(void)viewDidLoad{
    [super viewDidLoad];
        //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
    //添加验证密码控件
    UIButton *validatePasswordBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    validatePasswordBtn.frame=CGRectMake(233, 150, 60, 30);
    [validatePasswordBtn setTitle:@"验证密码" forState:UIControlStateNormal];
    [validatePasswordBtn addTarget:self action:@selector(validatePassword:) forControlEvents:UIControlEventTouchDown];
    
    //添加密码输入框控件
    password = [[UITextField alloc]init];
    password.frame = CGRectMake(67, 96, 221, 30);
    [password setPlaceholder:@"请输入您的登陆密码"];
    [password setBorderStyle:UITextBorderStyleRoundedRect];
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //添加安全校验码输入框控件
    serviceCode = [[UITextField alloc]init];
    serviceCode.frame = CGRectMake(67, 268, 221, 30);
    [serviceCode setPlaceholder:@"请输入小于5位数字的服务密码"];
    [serviceCode setBorderStyle:UITextBorderStyleRoundedRect];
    serviceCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    //初始设置为不可用
    [serviceCode setEnabled:NO];
    
    //添加完成安全密码修改按钮
    UIButton *finishChangeServiceCodeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    finishChangeServiceCodeBtn.frame = CGRectMake(218, 361, 60, 30);
    [finishChangeServiceCodeBtn setTitle:@"完成修改" forState:UIControlStateNormal];
    [finishChangeServiceCodeBtn addTarget:self action:@selector(finishChange:) forControlEvents:UIControlEventTouchDown];
    
    //添加控件到view上
    [self.view addSubview:validatePasswordBtn];
    [self.view addSubview:password];
    [self.view addSubview:serviceCode];
    [self.view addSubview:finishChangeServiceCodeBtn];
    
}


-(void)validatePassword:sender{
    NSString *password = self.password.text;
    if([password compare:@"1234"]==NSOrderedSame){
        //允许编辑
        NSLog(@"密码验证通过");
        [serviceCode setEnabled:YES];
    }else{
        [self showAlertMsgBox:@"登陆密码错误，请重新输入"];
    }
    
}

-(void)finishChange:sender{
    NSString *serviceCode = self.serviceCode.text;
    if(serviceCode==nil||[serviceCode isEqualToString:@""]){
        [self showAlertMsgBox:@"服务密码不能为空"];
    }else if(![self validateServiceCode:serviceCode]){
        [self showAlertMsgBox:@"服务密码格式不对，请输入纯数字"];
    }else if([serviceCode length]>5){
        [self showAlertMsgBox:@"服务密码长度过长，请输入小于等于5位"];
    }else{
        NSLog(@"完成修改");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//统一显示错误信息的提示框
-(void)showAlertMsgBox:(NSString*) msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改服务密码" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alertView show];
}

-(BOOL)validateServiceCode:(NSString*) serviceCode{
    NSString *reg = @"^[0-9]*$";
    NSPredicate *regextServiceCode = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    if([regextServiceCode evaluateWithObject:serviceCode]==YES){
        return YES;
    }else{
        return NO;
    }
}

@end
