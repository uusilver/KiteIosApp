//
//  RegistViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/8.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "RegistViewController.h"

@implementation RegistViewController

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
    [navItem setTitle:@"注册"];
    
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
    NSLog(@"返回用户登录界面");
    [self performSegueWithIdentifier:@"loginPage" sender:self];
}
-(IBAction)registAction:(id)sender{
    NSLog(@"用户注册");
    
}
@end
