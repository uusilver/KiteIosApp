//
//  RealChangePwdViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/31.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface RealChangePwdViewController : UIViewController

@property(nonatomic,weak)NSString *username;
@property(nonatomic, strong) IBOutlet UITextField *password;
@property(nonatomic, strong) IBOutlet UITextField *password1;

@end
