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
    //添加navigation bar
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 58)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //loading图标初始化
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    UIBarButtonItem *loadingItem = [[UIBarButtonItem alloc]initWithCustomView:self.loadingView];
    
    //创建一个右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(gotoRegisterPage)];
    
    //设置导航栏的内容
    [navItem setTitle:@"登录"];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    
    //把左右两个按钮添加到导航栏集合中去
    [navItem setLeftBarButtonItem:loadingItem];
    [navItem setRightBarButtonItem:rightButton];
    [self.view addSubview:navBar];
    
//    [self.loadingView startAnimation];
    
    
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
    
    //TODO 开发结束后清理这段代码
    //如果是tableview
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back-568h"]];
//    imgView.frame = self.view.bounds;
//    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [self.tableView setBackgroundView:imgView];
    
    wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number" accessGroup:@"YOUR_APP_ID_HERE.com.yourcompany.AppIdentifier"];
    
    
    //TODO放开测试..
    //清空Wrapper设置
//    [wrapper resetKeychainItem];
    
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
    //验证文本框内容不为空
    if(usernameCode==nil||[usernameCode isEqualToString:@""]){
        [self showAlertMsgBox:@"用户名不能为空"];
    }else if(passwordCode==nil||[passwordCode isEqualToString:@""]){
        [self showAlertMsgBox:@"密码不能为空"];
    }else{
        //登录逻辑校验
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
            [self showAlertMsgBox:@"用户名或密码错误，请检查后重新输入"];
            password.text = @"";
            NSLog(@"密码错误，返回登陆页面");
        }//登录逻辑结束

    }
    
}

//跳转至注册页面
-(void)gotoRegisterPage{
    NSLog(@"用户点击去注册页面");
    [self performSegueWithIdentifier:@"registerPage" sender:self];
    
}



//统一显示错误信息的提示框
-(void)showAlertMsgBox:(NSString*) msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登陆信息" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
