//
//  ChangePasswordViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/31.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController()

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *nPassword;
@property (strong, nonatomic) IBOutlet UITextField *nPassword1;

@end

@implementation ChangePasswordViewController
@synthesize nPassword;
@synthesize nPassword1;

-(void)viewDidLoad{
    [super viewDidLoad];
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
}

-(IBAction)finishChange:(id)sender{
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改登录密码" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
}
@end
