//
//  LogoutKiteViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/21.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "LogoutKiteViewController.h"

@implementation LogoutKiteViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"确认退出风筝");
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"确认退出"message:@"确认退出风筝?" delegate:self cancelButtonTitle:@"确认"otherButtonTitles:@"取消",nil];
    [alert show];
    
}

//确认关闭选择
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        //用户选择Yes
        NSLog(@"执行登出代码");
        //清空用户的Wrapper设置
        [wrapper resetKeychainItem];
    }
    //index == 1, 代表用户选择no，没有任何操作
}
@end
