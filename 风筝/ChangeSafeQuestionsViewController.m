//
//  ChangeSafeQuestionsViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/31.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "ChangeSafeQuestionsViewController.h"

@implementation ChangeSafeQuestionsViewController
@synthesize safeAnswer;
@synthesize safeQuestion;
@synthesize registQuestionSelector;

-(void)viewDidLoad{
    [super viewDidLoad];
    //初始化全局变量
    delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
    
    //初始化选择框
    registQuestionArray = [[NSMutableArray alloc]init];
    [registQuestionArray addObject:@"您父亲的姓名"];
    [registQuestionArray addObject:@"您母亲的姓名"];
    [registQuestionArray addObject:@"您就读的小学的名称"];
    registQuestionSelector.delegate = self;
    registQuestionSelector.dataSource = self;
    [registQuestionSelector selectedRowInComponent:0];
    //registQuestionSelector.font = [UIFont systemFontOfSize:10];//设置选择框的字体大小跟页面一致
    safeQuestion.text = registQuestionArray[0];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

-(IBAction)finishChange:(id)sender{
    NSString *safeQuestionText = self.safeQuestion.text;
    NSString *safeAnswerText = self.safeAnswer.text;

    if(safeQuestionText==nil||[safeQuestionText isEqualToString:@""]){
        [self showAlertMsgBox:@"安全问题不能为空"];
    }else if(safeAnswerText==nil||[safeAnswerText isEqualToString:@""]){
        [self showAlertMsgBox:@"安全问题答案不能为空"];
    }else{
        NSMutableString *mStr = [NSMutableString stringWithCapacity:50];
        [mStr appendString:@"/rest/userProfile/saveSecurityInfo/"];
        [mStr appendString:delegate.username];
        [mStr appendString:@"/"];
        [mStr appendString:safeQuestionText];
        [mStr appendString:@"/"];
        [mStr appendString:safeAnswerText];
        [mStr appendString:@"/"];
        [mStr appendString:@"clientType"];
        NSLog(@"修改安全问题，答案rest地址:%@",(NSString *)mStr);
        NSLog(@"完成安全问题修改");
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
    NSString *questionInSelector =  registQuestionArray[row];
    safeQuestion.text = questionInSelector;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *mycom = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 250.0f, 30.0f)];
    
    NSString *imgstr = [registQuestionArray objectAtIndex:row];
    mycom.text = imgstr;
    mycom.font = [UIFont systemFontOfSize: 18];
    return mycom;
}

//统一显示错误信息的提示框
-(void)showAlertMsgBox:(NSString*) msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改服务密码" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alertView show];
}

- (IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
}

@end
