//
//  LongKiteServiceViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/13.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "LongKiteServiceViewController.h"

@implementation LongKiteServiceViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //开启GPS服务
    if([CLLocationManager locationServicesEnabled]){
        NSLog(@"初始化GPS服务");
        self.locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        _locationManager.distanceFilter = 10;
        [_locationManager requestWhenInUseAuthorization];
        //[_locationManager startUpdatingLocation];
    }
    //开启方向服务
    if([CLLocationManager headingAvailable]){
        NSLog(@"初始化定位方向服务");
        self.headManager = [[CLLocationManager alloc]init];
        _headManager.delegate=self;
        _headManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        _headManager.distanceFilter = 10;
        [_headManager requestWhenInUseAuthorization];
        
        
    }
    
    //根据用户的长线风筝服务状态来初始化用户的按钮图标
    CGRect frame = CGRectMake(90, 200, 200, 60);
    serviceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    serviceButton.backgroundColor = [UIColor clearColor];
    if(YES){
        [serviceButton setTitle:@"开启服务" forState:UIControlStateNormal];
        serviceFlag = YES;
    }else{
        
    }
    serviceButton.frame = frame;
    [serviceButton addTarget:self action:@selector(serviceButtonClick) forControlEvents:UIControlEventTouchDown];
     [self.view addSubview:serviceButton];
}

-(void)serviceButtonClick{
    if(serviceFlag){
        [self startLongKiteService];
        [serviceButton setTitle:@"关闭服务" forState:UIControlStateNormal];
        serviceFlag = NO;
    }else{
        [self stopLongKiteService];
        [serviceButton setTitle:@"开启服务" forState:UIControlStateNormal];
        serviceFlag = YES;
    }
    
    
}

//开启长线风筝服务，按用户设定的频率读取gps信息
-(void)startLongKiteService{
    NSLog(@"开启服务....");
    //按分钟调用
    int lTime = 5;
    serviceTimer = [NSTimer scheduledTimerWithTimeInterval:lTime target:self selector:@selector(callRealKiteService) userInfo:nil repeats:YES];
    
}

-(void)callRealKiteService{
    //调用gps
    [_locationManager startUpdatingLocation];
    //调用方向
    [_headManager startUpdatingHeading];
}

//关闭长线风筝服务
-(void)stopLongKiteService{
    //关闭相关服务
    [_locationManager stopUpdatingLocation];
    [_headManager stopUpdatingHeading];
    //关闭timer
    [serviceTimer setFireDate:[NSDate distantFuture]];
    NSLog(@"关闭服务....");
}

//获取GPS服务
- (void) locationManager: (CLLocationManager *) manager
      didUpdateLocations:(NSArray *)locations{
    
    //NSLog(@"GPS服务进行中...");
    CLLocation *currLocation = [locations lastObject];
    NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    //全局变量中的保存地理信息
    
}
//GPS 出错处理代码
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
}

//获取前进方向服务
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if(newHeading.headingAccuracy>0){
        NSLog(@"方向获取中....");
        CLLocationDirection theHeding = newHeading.trueHeading;
        NSString *heading = [NSString stringWithFormat:@"%lf度",theHeding];
        NSLog(@"%@",heading);
        
    }
}


-(void)viewDidDisappear:(BOOL)animated{
    //页面消失，清空相关服务
}

@end
