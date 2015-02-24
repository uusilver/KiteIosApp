//
//  PersonalSettingViewController.h
//  风筝
//
//  Created by Mac on 15/2/4.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "AppDelegate.h"

@interface PersonalSettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    KeychainItemWrapper *wrapper;
    int changeTypeIndex;
}

@end
