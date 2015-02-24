//
//  ChangeServiceCodeViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/29.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ChangeServiceCodeViewController : UIViewController{
    AppDelegate *delegate;
}

@property (strong, nonatomic) IBOutlet UITextField *serviceCode;

@end
