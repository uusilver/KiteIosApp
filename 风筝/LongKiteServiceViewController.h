//
//  LongKiteServiceViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/13.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LongKiteServiceViewController : UIViewController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>
{
    UIButton *serviceButton;
    BOOL serviceFlag;
    NSTimer *serviceTimer;
    
    NSArray *touchFreqArray;
    
    float lati;
    float longti;
    float heading;
    
    int passwordWrongTime;


}
@property (strong, nonatomic) IBOutlet UIPickerView *touchFreqSelector;
@property (nonatomic, strong) CLLocationManager  *locationManager;
@property (nonatomic, strong) CLLocationManager  *headManager;

@end
