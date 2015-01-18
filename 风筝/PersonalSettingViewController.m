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

-(void)viewDidLoad{
    [super viewDidLoad];
    touchFreqArray = [NSArray arrayWithObjects:@"15",@"30",@"45", nil];
    touchFreqSelector.delegate = self;
    touchFreqSelector.dataSource = self;
    
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
    NSLog(@"选中的频率为:%@",selectedTouchFreq);
}
@end
