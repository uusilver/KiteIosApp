//
//  ChangeSafeQuestionsViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/31.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ChangeSafeQuestionsViewController : UIViewController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>{
    
    NSMutableArray *registQuestionArray;
    
    AppDelegate *delegate;
}


@property (strong, nonatomic)  IBOutlet UITextField *safeQuestion;
@property (strong, nonatomic)  IBOutlet UITextField *safeAnswer;
@property (strong, nonatomic) IBOutlet UIPickerView *registQuestionSelector;

@end
