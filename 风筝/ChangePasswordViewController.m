//
//  ChangePasswordViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/31.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "ChangePasswordViewController.h"

@implementation ChangePasswordViewController
@synthesize password;
@synthesize nPassword;
@synthesize nPassword1;

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
    password.frame = CGRectMake(134, 96, 221, 30);
    [password setPlaceholder:@"请输入您的登陆密码"];
    [password setBorderStyle:UITextBorderStyleRoundedRect];
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    
    //安全问题输入框控件
    nPassword = [[UITextField alloc]init];
    nPassword.frame = CGRectMake(134, 350, 221, 30);
    [nPassword setPlaceholder:@"请输入您的新密码"];
    [nPassword setBorderStyle:UITextBorderStyleRoundedRect];
    [nPassword setEnabled:NO];
    nPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //安全答案输入框控件
    nPassword1 = [[UITextField alloc]init];
    nPassword1.frame = CGRectMake(134, 387, 221, 30);
    [nPassword1 setPlaceholder:@"请重复您的新密码"];
    [nPassword1 setBorderStyle:UITextBorderStyleRoundedRect];
    [nPassword1 setEnabled:NO];
    nPassword1.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    //添加完成安全密码修改按钮
    UIButton *finishChangeServiceCodeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    finishChangeServiceCodeBtn.frame = CGRectMake(200, 425, 60, 30);
    [finishChangeServiceCodeBtn setTitle:@"完成修改" forState:UIControlStateNormal];
    [finishChangeServiceCodeBtn addTarget:self action:@selector(finishChange:) forControlEvents:UIControlEventTouchDown];
    
    //添加控件到view上
    [self.view addSubview:validatePasswordBtn];
    [self.view addSubview:password];
    [self.view addSubview:nPassword];
    [self.view addSubview:nPassword1];
    [self.view addSubview:finishChangeServiceCodeBtn];
    
}


-(void)validatePassword:sender{
    NSString *password = self.password.text;
    if([password compare:@"1234"]==NSOrderedSame){
        //允许编辑
        NSLog(@"密码验证通过");
        [nPassword setEnabled:YES];
        [nPassword1 setEnabled:YES];
    }else{
        [self showAlertMsgBox:@"登陆密码错误，请重新输入"];
    }
    
}

-(void)finishChange:sender{
    NSString *q1 = self.nPassword.text;
    NSString *q2 = self.nPassword1.text;
    
    if(q1==nil||[q1 isEqualToString:@""]){
        [self showAlertMsgBox:@"新密码不能为空"];
    }else if(q2==nil||[q2 isEqualToString:@""]){
        [self showAlertMsgBox:@"重复的密码不能为空"];
    }else if([q1 compare:q2] != NSOrderedSame){
        [self showAlertMsgBox:@"两次输入密码不一致，请修改"];
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

@end
