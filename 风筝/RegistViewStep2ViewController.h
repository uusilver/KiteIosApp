//
//  RegistViewStep2ViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/28.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistViewStep2ViewController : UIViewController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>{
    
    NSMutableArray *registQuestionArray;
}

@property (strong, nonatomic) IBOutlet UITextField *serviceCode;
@property (strong, nonatomic) IBOutlet UITextField *safeQuestion;
@property (strong, nonatomic) IBOutlet UITextField *safeAnswer;
@property (strong, nonatomic) IBOutlet UIPickerView *registQuestionSelector;
@end
