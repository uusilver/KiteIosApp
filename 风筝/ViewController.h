//
//  ViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/4.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//  用户登录页面
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import "KeychainItemWrapper.h"
#import "PersonalSettingViewController.h"
#import "AppDelegate.h"
#import "HYCircleLoadingView.h"
#import "MYIntroductionView.h"

#import "Base64Handler.h"

@interface ViewController : UIViewController <MYIntroductionDelegate>{
    KeychainItemWrapper *wrapper;
    
}
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UISwitch *rememberFlag;
//引入loading文件
@property (nonatomic, strong) HYCircleLoadingView *loadingView;


//登录检查
-(IBAction)loginCheck:(id)sender;
@end

