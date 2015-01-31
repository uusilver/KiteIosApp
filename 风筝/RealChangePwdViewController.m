//
//  RealChangePwdViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/31.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "RealChangePwdViewController.h"

@implementation RealChangePwdViewController
@synthesize username;
@synthesize password;
@synthesize password1;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    password.secureTextEntry = YES;
    password1.secureTextEntry = YES;
    //添加navigation bar
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 58)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //创建一个左边回退按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goLastStep)];
    
    //设置导航栏的内容
    [navItem setTitle:@"风筝密码找回"];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    
    //把左右两个按钮添加到导航栏集合中去
    [navItem setLeftBarButtonItem:backButton];
    [self.view addSubview:navBar];
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
}

-(void)goLastStep{
       [self performSegueWithIdentifier:@"goValidate4Pwd" sender:self];
}

-(IBAction)finishChangePwd :(id)sender{
    NSString *pwd = self.password.text;
    NSString *pwd1 = self.password1.text;
    
    if(pwd==nil||[pwd isEqualToString:@""]){
        [self showAlertMsgBox:@"新密码不能为空"];
    }else if(pwd1==nil||[pwd1 isEqualToString:@""]){
        [self showAlertMsgBox:@"重复的密码不能为空"];
    }else if([pwd compare:pwd1] != NSOrderedSame){
        [self showAlertMsgBox:@"两次输入的密码不一致，请检查"];
    }else{
        //TODO 发起校验
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        username = delegate.username;
        NSLog(@"%@ 的用户新密码设定成功",username);
        [self performSegueWithIdentifier:@"goLogin" sender:self];
    }

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//统一显示错误信息的提示框
-(void)showAlertMsgBox:(NSString*) msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登陆信息" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
}

@end

