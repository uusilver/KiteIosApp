//
//  ChangeServiceCodeViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/29.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "ChangeServiceCodeViewController.h"

@implementation ChangeServiceCodeViewController
@synthesize serviceCode;


-(void)viewDidLoad{
    [super viewDidLoad];
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
    
}


-(IBAction)finishChange:(id)sender{
    NSString *serviceCodeText = self.serviceCode.text;
    if(serviceCodeText==nil||[serviceCodeText isEqualToString:@""]){
        [self showAlertMsgBox:@"服务密码不能为空"];
    }else if(![self validateServiceCode:serviceCodeText]){
        [self showAlertMsgBox:@"服务密码格式不对，请输入纯数字"];
    }else if([serviceCodeText length]>5){
        [self showAlertMsgBox:@"服务密码长度过长，请输入小于等于5位"];
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

-(BOOL)validateServiceCode:(NSString*) serviceCodeText{
    NSString *reg = @"^[0-9]*$";
    NSPredicate *regextServiceCode = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    if([regextServiceCode evaluateWithObject:serviceCodeText]==YES){
        return YES;
    }else{
        return NO;
    }
}

- (IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
}

@end
