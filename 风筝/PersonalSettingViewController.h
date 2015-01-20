//
//  PersonalSettingViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/5.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalSettingViewController : UIViewController<UIActionSheetDelegate, UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>{
    
    NSArray *touchFreqArray;
}

@property (strong, nonatomic) IBOutlet UIPickerView *touchFreqSelector;

@property (strong, nonatomic) IBOutlet UITextField *urgent_name;
@property (strong, nonatomic) IBOutlet UITextField *urgent_telno;

@property (strong, nonatomic) IBOutlet UITextField *randomCode;

@property (strong, nonatomic) IBOutlet UIButton *l_timeButton;

-(IBAction)savePersonalSetting:(id)sender;

@end
