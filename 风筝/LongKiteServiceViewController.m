//
//  LongKiteServiceViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/13.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "LongKiteServiceViewController.h"

@implementation LongKiteServiceViewController
@synthesize touchFreqSelector;
-(void)viewDidLoad{
    [super viewDidLoad];
    //添加navigation bar
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 58)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    
    
    //创建一个左边回退按钮
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(gotBackToServicePool)];
    
    //设置导航栏的内容
    [navItem setTitle:@"注册"];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    
    //把左右两个按钮添加到导航栏集合中去
    [navItem setLeftBarButtonItem:backButton];
    [self.view addSubview:navBar];
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
    
    //初始化选择框
    touchFreqArray = [NSArray arrayWithObjects:@"15",@"30",@"45", nil];
    touchFreqSelector.delegate = self;
    touchFreqSelector.dataSource = self;
    [touchFreqSelector selectedRowInComponent:0];
    
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

-(void)gotBackToServicePool{
    NSLog(@"返回风筝选择界面");
    [self performSegueWithIdentifier:@"longBack2ServicePool" sender:self];
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
    //获得用户的设置时间
    NSInteger row = [touchFreqSelector selectedRowInComponent:0];
    NSString *selectedTouchFreq = [touchFreqArray objectAtIndex:row];
    NSLog(@"用户设定的访问时间为:%@",selectedTouchFreq);
    //按分钟调用
    int lTime = 5; //秒
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

//提供多少个选择框
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [touchFreqArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [touchFreqArray objectAtIndex:row];
}


-(void)viewDidDisappear:(BOOL)animated{
    //页面消失，清空相关服务
}

@end
