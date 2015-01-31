//
//  ValidateUrgentInfoViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/31.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "ValidateUrgentInfoViewController.h"

@implementation ValidateUrgentInfoViewController
@synthesize username;
@synthesize urgent_name;
@synthesize urgent_telno;

-(void)viewDidLoad{
    [super viewDidLoad];
    //添加navigation bar
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 58)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //创建一个左边回退按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotBackToLogin)];
    
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

-(void)gotBackToLogin{
    [self performSegueWithIdentifier:@"goBackLogin4ChangePwd" sender:self];
}

-(IBAction)validateUrInfo :(id)sender{
    NSString *uname = self.username.text;
    NSString *urtelno = self.urgent_telno.text;
    NSString *urname = self.urgent_name.text;
    
    
    if(uname==nil||[uname isEqualToString:@""]){
        [self showAlertMsgBox:@"用户登录的手机号不能为空"];
    }else if(![self validateMobile:uname]){
        [self showAlertMsgBox:@"请输入正确的手机号为用户名"];
    }else if(urtelno==nil||[urtelno isEqualToString:@""]){
        [self showAlertMsgBox:@"紧急联系人电话不能为空"];
    }else if(urname==nil||[urname isEqualToString:@""]){
        [self showAlertMsgBox:@"紧急联系人姓名不能为空"];
    }else{
        //TODO 发起校验
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        delegate.username = self.username.text;
        [self performSegueWithIdentifier:@"changePwd" sender:self];
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
