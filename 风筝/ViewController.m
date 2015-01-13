//
//  ViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/4.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize username;
@synthesize password;
@synthesize rememberFlag;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    password.secureTextEntry = YES;
    //初始化默认记住用户
    rememberFlag.on = YES;
    NSString* username = @"";
    NSString* password = @"";
    if((username==nil||[username isEqualToString:@""])&&(password==nil||[password isEqualToString:@""])){
        NSLog(@"用户名密码为空，正常登录");
    }else{
        NSLog(@"有保存的用户名和密码，直接登录");
    }
}

-(IBAction)loginCheck:(id)sender{
    NSString *usernameCode = username.text;
    NSString *passwordCode = password.text;
    //NSLog(@"确定服务密码按钮被点击,输入密码为%@",serviceCodeTxt);
    if(passwordCode!=nil && [passwordCode compare:@"1234"]==NSOrderedSame
                         && usernameCode!=nil && [usernameCode compare:@"13851483034"]==NSOrderedSame){
        NSLog(@"密码校验通过");
        //设置相关全局变量
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        delegate.isLogin = YES;
        if(rememberFlag.on){
            //keychain保存密码
            NSLog(@"记住我打开，保存密码");
            
        }
        //在storyboard拖拽中，定义segue的id，这里的identifier和定义的id相同完成跳转!
        //跳转进入服务列表页面
        [self performSegueWithIdentifier:@"KiteServiceList" sender:self];
        NSLog(@"进入服务列表页面");
        
    }else{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登陆信息" message:@"用户名或者密码错误，请重新输入" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
        //清空密码输入栏
        password.text = @"";
//        [self performSegueWithIdentifier:@"Login" sender:self];
        NSLog(@"密码错误，返回登陆页面");
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
