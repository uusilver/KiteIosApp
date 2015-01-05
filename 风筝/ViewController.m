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


-(IBAction)loginCheck:(id)sender{
    NSString *usernameCode = username.text;
    NSString *passwordCode = password.text;
    //NSLog(@"确定服务密码按钮被点击,输入密码为%@",serviceCodeTxt);
    if(passwordCode!=nil && [passwordCode compare:@"1234"]==NSOrderedSame
                         && usernameCode!=nil && [usernameCode compare:@"13851483034"]==NSOrderedSame){
        NSLog(@"密码校验通过页面跳转");
        //在storyboard拖拽中，定义segue的id，这里的identifier和定义的id相同完成跳转!
        //跳转进入服务列表页面
        [self performSegueWithIdentifier:@"KiteServiceList" sender:self];
        NSLog(@"进入个人设置页面");
    }else{
        //清空密码输入栏
        [self performSegueWithIdentifier:@"Login" sender:self];
        NSLog(@"密码错误，返回登陆页面");
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    password.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
