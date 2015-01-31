//
//  ChangeSafeQuestionsViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/31.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeSafeQuestionsViewController : UIViewController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>{
    
    NSMutableArray *registQuestionArray;
}


@property (strong, nonatomic)  UITextField *password;
@property (strong, nonatomic)  UITextField *safeQuestion;
@property (strong, nonatomic)  UITextField *safeAnswer;
@property (strong, nonatomic) IBOutlet UIPickerView *registQuestionSelector;


@end
