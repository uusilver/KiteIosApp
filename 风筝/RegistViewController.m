//
//  RegistViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/8.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "RegistViewController.h"

@implementation RegistViewController
@synthesize l_timeButton;
-(void)viewDidLoad{
    [super viewDidLoad];
    //验证码按钮初始化
    [l_timeButton addTarget:self action:@selector(startTime)
           forControlEvents:UIControlEventTouchUpInside];
    
    //初始化密码输入框的输入状态
    self.password.secureTextEntry = YES;
    self.password1.secureTextEntry = YES;
    //添加navigation bar
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 58)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //创建一个左边回退按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotBackToLogin)];
    
    //设置导航栏的内容
    [navItem setTitle:@"风筝注册"];
    
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
-(void)gotBackToLogin{
    [self performSegueWithIdentifier:@"loginPage" sender:self];
}

-(IBAction)gotoNextSetp:(id)sender{
    NSLog(@"用户注册");
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    NSString *password1 = self.password1.text;
    NSString *randomCode = self.randomCode.text;
    
    
    if(username==nil||[username isEqualToString:@""]){
        [self showAlertMsgBox:@"用户名不能为空"];
    }else if(![self validateMobile:username]){
        [self showAlertMsgBox:@"请输入正确的手机号为用户名"];
    }else if(password==nil||[password isEqualToString:@""]){
        [self showAlertMsgBox:@"密码不能为空"];
    }else if(password1==nil||[password1 isEqualToString:@""]){
        [self showAlertMsgBox:@"重复的密码不能为空"];
    }else if(![password isEqualToString:password1]){
        [self showAlertMsgBox:@"两次输入的密码不一致，请检查"];
    }else if(randomCode==nil||[randomCode isEqualToString:@""]){
        [self showAlertMsgBox:@"随即码不能为空"];
    }else{
        //TODO 调用注册的restservice，成功跳转到个人设置页面
        [self performSegueWithIdentifier:@"step2" sender:self];
    }
    
    
}
-(IBAction)resetFields:(id)sender{
    NSLog(@"清空注册信息");
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"清空所有输入框"message:@"清空所有输入框?" delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"确认",nil];
    [alert show];
}

//确认关闭选择
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        //用户选择Yes
        self.username.text=@"";
        self.password.text=@"";
        self.password1.text=@"";
        self.randomCode.text=@"";
    }
    //index == 1, 代表用户选择no，没有任何操作
}

//验证码按钮倒计时
-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [l_timeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                l_timeButton.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [l_timeButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                l_timeButton.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

//统一显示错误信息的提示框
-(void)showAlertMsgBox:(NSString*) msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登陆信息" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alertView show];
}

//验证手机号
- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}



- (IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
}

@end
