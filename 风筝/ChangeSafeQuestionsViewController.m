//
//  ChangeSafeQuestionsViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/31.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "ChangeSafeQuestionsViewController.h"

@implementation ChangeSafeQuestionsViewController
@synthesize password;
@synthesize safeAnswer;
@synthesize safeQuestion;
@synthesize registQuestionSelector;

-(void)viewDidLoad{
    [super viewDidLoad];
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
    //添加验证密码控件
    UIButton *validatePasswordBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    validatePasswordBtn.frame=CGRectMake(233, 150, 60, 30);
    [validatePasswordBtn setTitle:@"验证密码" forState:UIControlStateNormal];
    [validatePasswordBtn addTarget:self action:@selector(validatePassword:) forControlEvents:UIControlEventTouchDown];
    
    //添加密码输入框控件
    password = [[UITextField alloc]init];
    password.frame = CGRectMake(67, 96, 221, 30);
    [password setPlaceholder:@"请输入您的登陆密码"];
    [password setBorderStyle:UITextBorderStyleRoundedRect];
    password.clearButtonMode = UITextFieldViewModeWhileEditing;
    
   //添加安全问题的滚动框
    registQuestionSelector = [[UIPickerView alloc]init];
    registQuestionSelector.frame = CGRectMake(-116, 188, 600, 162);
    
    //初始化选择框
    registQuestionArray = [[NSMutableArray alloc]init];
    [registQuestionArray addObject:@"您父亲的姓名"];
    [registQuestionArray addObject:@"您母亲的姓名"];
    [registQuestionArray addObject:@"您就读的小学的名称"];
    registQuestionSelector.delegate = self;
    registQuestionSelector.dataSource = self;
    [registQuestionSelector selectedRowInComponent:0];
    safeQuestion.text = registQuestionArray[0];

    //安全问题输入框控件
    safeQuestion = [[UITextField alloc]init];
    safeQuestion.frame = CGRectMake(134, 305, 221, 30);
    [safeQuestion setPlaceholder:@"请输入您的安全问题"];
    [safeQuestion setBorderStyle:UITextBorderStyleRoundedRect];
    [safeQuestion setEnabled:NO];
    safeQuestion.clearButtonMode = UITextFieldViewModeWhileEditing;

    //安全答案输入框控件
    safeAnswer = [[UITextField alloc]init];
    safeAnswer.frame = CGRectMake(134, 387, 221, 30);
    [safeAnswer setPlaceholder:@"请输入您的安全问题答案"];
    [safeAnswer setBorderStyle:UITextBorderStyleRoundedRect];
    [safeAnswer setEnabled:NO];
    safeAnswer.clearButtonMode = UITextFieldViewModeWhileEditing;

    
    //添加完成安全密码修改按钮
    UIButton *finishChangeServiceCodeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    finishChangeServiceCodeBtn.frame = CGRectMake(200, 425, 60, 30);
    [finishChangeServiceCodeBtn setTitle:@"完成修改" forState:UIControlStateNormal];
    [finishChangeServiceCodeBtn addTarget:self action:@selector(finishChange:) forControlEvents:UIControlEventTouchDown];
    
    //添加控件到view上
    [self.view addSubview:validatePasswordBtn];
    [self.view addSubview:password];
    [self.view addSubview:safeQuestion];
    [self.view addSubview:safeAnswer];
    [self.view addSubview:registQuestionSelector];
    [self.view addSubview:finishChangeServiceCodeBtn];
    
}


-(void)validatePassword:sender{
    NSString *password = self.password.text;
    if([password compare:@"1234"]==NSOrderedSame){
        //允许编辑
        NSLog(@"密码验证通过");
                [safeQuestion setEnabled:YES];
        [safeAnswer setEnabled:YES];
    }else{
        [self showAlertMsgBox:@"登陆密码错误，请重新输入"];
    }
    
}

-(void)finishChange:sender{
    NSString *safeQuestion = self.safeQuestion.text;
    NSString *safeAnswer = self.safeAnswer.text;

    if(safeQuestion==nil||[safeQuestion isEqualToString:@""]){
        [self showAlertMsgBox:@"安全问题不能为空"];
    }else if(safeAnswer==nil||[safeAnswer isEqualToString:@""]){
        [self showAlertMsgBox:@"安全问题答案不能为空"];
    }else{
        NSLog(@"完成修改");
        [self.navigationController popViewControllerAnimated:YES];
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改服务密码" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alertView show];
}
@end
