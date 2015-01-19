//
//  PersonalSettingViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/5.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "PersonalSettingViewController.h"

@implementation PersonalSettingViewController
@synthesize touchFreqSelector;
@synthesize l_timeButton;
-(void)viewDidLoad{
    [super viewDidLoad];
    //验证码按钮初始化
    [l_timeButton addTarget:self action:@selector(startTime)
           forControlEvents:UIControlEventTouchUpInside];
    //初始化选择框
    touchFreqArray = [NSArray arrayWithObjects:@"15",@"30",@"45", nil];
    touchFreqSelector.delegate = self;
    touchFreqSelector.dataSource = self;
    [touchFreqSelector selectedRowInComponent:0];
    
    //添加navigation bar
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 58)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    
    //设置导航栏的内容
    [navItem setTitle:@"个人设置"];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    
    //把左右两个按钮添加到导航栏集合中去
    [self.view addSubview:navBar];
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
}

//提供多少个选择框
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [touchFreqArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [touchFreqArray objectAtIndex:row];
}

-(IBAction)savePersonalSetting:(id)sender{
    
    NSInteger row = [touchFreqSelector selectedRowInComponent:0];
    NSString *selectedTouchFreq = [touchFreqArray objectAtIndex:row];
    NSString *urgent_name = self.urgent_name.text;
    NSString *urgent_telno = self.urgent_telno.text;
    NSString *randomCode = self.randomCode.text;
    if(urgent_name==nil||[urgent_name isEqualToString:@""]){
        [self showAlertMsgBox:@"紧急联系姓名不能为空"];
    }else if(urgent_telno==nil||[urgent_telno isEqualToString:@""]){
        [self showAlertMsgBox:@"紧急联系电话不能为空"];
    }else if(randomCode==nil||[randomCode isEqualToString:@""]){
        [self showAlertMsgBox:@"验证码不能为空"];
    }else{
        //跳转到服务列表页面
        [self performSegueWithIdentifier:@"kiteAllService" sender:self];
    }
    
    NSLog(@"选中的频率为:%@",selectedTouchFreq);
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
@end
