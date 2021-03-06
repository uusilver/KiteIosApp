//
//  PersonalSettingViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/5.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "ChangeUrgentInfoViewController.h"

@implementation ChangeUrgentInfoViewController
@synthesize l_timeButton;
-(void)viewDidLoad{
    [super viewDidLoad];
    //初始化全局变量
    delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
    
    //验证码按钮初始化
    [l_timeButton addTarget:self action:@selector(startTime)
           forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction)savePersonalSetting:(id)sender{
    
    NSString *urgent_name = self.urgent_name.text;
    NSString *urgent_telno = self.urgent_telno.text;
    NSString *randomCode = self.randomCode.text;
    if(urgent_name==nil||[urgent_name isEqualToString:@""]){
        [self showAlertMsgBox:@"紧急联系姓名不能为空"];
    }else if(urgent_telno==nil||[urgent_telno isEqualToString:@""]){
        [self showAlertMsgBox:@"紧急联系电话不能为空"];
    }else if(![self validateMobile:urgent_telno]){
        [self showAlertMsgBox:@"请输入正确的紧急联系人电话号码"];
    }else if(randomCode==nil||[randomCode isEqualToString:@""]){
        [self showAlertMsgBox:@"验证码不能为空"];
    }else{
        //跳转到服务列表页面
        NSMutableString *mStr = [NSMutableString stringWithCapacity:50];
        [mStr appendString:@"/rest/userProfile/saveUrgentUserInfo"];
        [mStr appendString:delegate.username];
        [mStr appendString:@"/"];
        [mStr appendString:urgent_name];
        [mStr appendString:@"/"];
        [mStr appendString:urgent_telno];
        [mStr appendString:@"/"];
        [mStr appendString:@"clientType"];
        NSLog(@"修改紧急联系人rest地址:%@",(NSString *)mStr);
        NSLog(@"完成紧急联系人信息修改");	
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//确认关闭选择
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        NSLog(@"执行具体的登出代码");
        //用户选择Yes
        //TODO 调用登出的webservice
        
        //清空用户的Wrapper设置
        [wrapper resetKeychainItem];
        
        [self performSegueWithIdentifier:@"back2login" sender:self];
        
//        [self.navigationController popToRootViewControllerAnimated:YES];
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
