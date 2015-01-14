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
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"blue_sky.jpeg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
    
    //TODO 开发结束后清理这段代码
    //如果是tableview
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
//    imgView.frame = self.view.bounds;
//    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [self.tableView setBackgroundView:imgView];
    
    wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number"
                                                  accessGroup:@"YOUR_APP_ID_HERE.com.yourcompany.AppIdentifier"];
    
    
    //TODO放开测试..
    //清空Wrapper设置
//    [wrapper resetKeychainItem];
    
    // Do any additional setup after loading the view, typically from a nib.
    password.secureTextEntry = YES;
    //初始化默认记住用户
    rememberFlag.on = YES;
    NSString* username = @"";
    NSString* password = @"";
    //TODO放开测试..
//    username = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
//    password = [wrapper objectForKey:(__bridge id)kSecValueData];
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
            //TODO 等待测试
//            [wrapper setObject:usernameCode forKey:(__bridge id)(kSecAttrAccount)];
//            [wrapper setObject:passwordCode forKey:(__bridge id)(kSecValueData)];
            
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
