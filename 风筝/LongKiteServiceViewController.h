//
//  LongKiteServiceViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/13.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LongKiteServiceViewController : UIViewController
{
    UIButton *serviceButton;
    BOOL serviceFlag;
    NSTimer *serviceTimer;
}
@property (nonatomic, strong) CLLocationManager  *locationManager;
@property (nonatomic, strong) CLLocationManager  *headManager;

@end
