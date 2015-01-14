//
//  ViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/4.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import "KeychainItemWrapper.h"
#import "PersonalSettingViewController.h"
#import "AppDelegate.h"

@interface ViewController : UIViewController{
    KeychainItemWrapper *wrapper;
}
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UISwitch *rememberFlag;



-(IBAction)loginCheck:(id)sender;
@end

