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
-(IBAction)savePersonalSetting:(id)sender;
@end
