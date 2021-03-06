//
//  RegistViewStep2ViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/28.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "RegistViewStep2ViewController.h"

@implementation RegistViewStep2ViewController
@synthesize registQuestionSelector;
@synthesize safeQuestion;
@synthesize safeAnswer;
@synthesize userRealName;
-(void)viewDidLoad{
    [super viewDidLoad];
    //初始化全局变量
    delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    //初始化选择框
    registQuestionArray = [[NSMutableArray alloc]init];
    [registQuestionArray addObject:@"您父亲的姓名"];
    [registQuestionArray addObject:@"您母亲的姓名"];
    [registQuestionArray addObject:@"您就读的小学的名称"];
    registQuestionSelector.delegate = self;
    registQuestionSelector.dataSource = self;
    [registQuestionSelector selectedRowInComponent:0];
    safeQuestion.text = registQuestionArray[0];
    
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
    [self performSegueWithIdentifier:@"back2Step1" sender:self];
}

-(IBAction)finishRegist:sender{
    NSString *serviceCode = self.serviceCode.text;
    NSString *safeQuestionText = self.safeQuestion.text;
    NSString *safeAnswerText = self.safeAnswer.text;
    //NSString *userRealName = self.userRealName.text;
    
   if(serviceCode==nil||[serviceCode isEqualToString:@""]){
        [self showAlertMsgBox:@"服务密码不能为空"];
    }else if(![self validateServiceCode:serviceCode]){
        [self showAlertMsgBox:@"服务密码格式不对，请输入纯数字"];
    }else if([serviceCode length]>5){
        [self showAlertMsgBox:@"服务密码长度过长，请输入小于等于5位"];
    }else if(safeQuestionText==nil||[safeQuestionText isEqualToString:@""]){
        [self showAlertMsgBox:@"安全问题不能为空"];
    }else if(safeAnswerText==nil||[safeAnswerText isEqualToString:@""]){
        [self showAlertMsgBox:@"安全答案不能为空"];
    }else{
        //TODO call 注册步骤2
        NSMutableString *mStr = [NSMutableString stringWithCapacity:50];
        [mStr appendString:@"/rest/registRest/servicePwdAndSecurityQASetting/"];
        [mStr appendString:delegate.username];
        [mStr appendString:@"/"];
        [mStr appendString:serviceCode];
        [mStr appendString:@"/"];
        [mStr appendString:safeQuestionText];
        [mStr appendString:@"/"];
        [mStr appendString:safeAnswerText];
        [mStr appendString:@"/"];
        [mStr appendString:@"clientType"];
        NSLog(@"注册步骤2rest地址:%@",(NSString *)mStr);
        
        [self performSegueWithIdentifier:@"personalSetting" sender:self];
    }
    
    
}

//提供多少个选择框
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [registQuestionArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [registQuestionArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *questionInSelector =registQuestionArray[row];
    safeQuestion.text = questionInSelector;

}


//统一显示错误信息的提示框
-(void)showAlertMsgBox:(NSString*) msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登陆信息" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alertView show];
}

-(BOOL)validateServiceCode:(NSString*) serviceCode{
    NSString *reg = @"^[0-9]*$";
    NSPredicate *regextServiceCode = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
    if([regextServiceCode evaluateWithObject:serviceCode]==YES){
        return YES;
    }else{
        return NO;
    }
}

- (IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
}
@end
