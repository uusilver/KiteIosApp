//
//  RegistViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/8.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface RegistViewController : UIViewController{
    AppDelegate *delegate;
}


@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *password1;
@property (strong, nonatomic) IBOutlet UITextField *randomCode;
@property (strong, nonatomic) IBOutlet UIButton *l_timeButton;
@end
