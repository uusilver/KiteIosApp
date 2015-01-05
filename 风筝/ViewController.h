//
//  ViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/4.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalSettingViewController.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;



-(IBAction)loginCheck:(id)sender;
@end

