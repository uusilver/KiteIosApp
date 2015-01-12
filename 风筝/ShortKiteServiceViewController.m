//
//  ShortKiteServiceViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/10.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "ShortKiteServiceViewController.h"

@implementation ShortKiteServiceViewController
@synthesize serviceBtn;
@synthesize timer;
@synthesize alertUrgentPersonTimer;
@synthesize voiceRecordTimer;

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
    //初始化录音服务
    NSLog(@"初始化录音服务");
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
}

-(void)loadView{
    [super loadView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressBtn:)];
    [longPress setDelegate:self];
    longPress.minimumPressDuration = 0.5;
    [serviceBtn addGestureRecognizer:longPress];

    
}

//长按钮事件的设置
-(void)longPressBtn:(UILongPressGestureRecognizer *)gestureRecognizer

{
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        //长按事件开始
        NSLog(@"长按事件开始");
        //调用定时任务来开启短线风筝的具体服务
        //当前默认5秒
        timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(shortKiteTimerTask4GPSandDirection) userInfo:nil repeats:YES];
    }
    
    else if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        
        //长按事件结束后需要用户输入服务密码来关闭服务
        [self showCloseServiceAlert:@"请输入服务密码"];
        //TODO同时纪录用户已经松开了按钮，如果在规定时间内未能输入正确的服务密码，则后台服务需要通知紧急联系人
        //调用alertUrgentPersonTimer,初始化任务事件，如果未在时间内关闭则运行, 5*60 = 300秒
        int sTime = 300;
        alertUrgentPersonTimer = [NSTimer scheduledTimerWithTimeInterval:sTime target:self selector:@selector(askServerToAlertUrgentPerson) userInfo:nil repeats:NO];
    }
}


//短线风筝任务的具体逻辑代码
-(void)shortKiteTimerTask4GPSandDirection{
    NSLog(@"定位服务，前进服务");
    //调用gps
    [_locationManager startUpdatingLocation];
    //调用方向
    [_headManager startUpdatingHeading];
    
    
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

//通知服务器联系紧急联系人
-(void)askServerToAlertUrgentPerson{
    NSLog(@"准备开始录音");
    //启动用户的录音设备，录音30秒
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   
                                   [NSNumber numberWithFloat: 44100.0],AVSampleRateKey, //采样率
                                   
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数默认 16
                                   
                                   
                                   [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,//通道的数目
                                   
                                   [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,//大端还是小端是内存的组织方式
                                   
                                   [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,nil];//采样信号是整数还是浮点数
    
    
    //TODO 需要测试Temp文件是否会被删除
    recordedTmpFile = [NSURL fileURLWithPath:[self audioRecordingPath]];  //文件名的设置
    //手机震动提示用户开始录音
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    recorder = [[AVAudioRecorder alloc] initWithURL:recordedTmpFile settings:recordSetting error:nil];
    [recorder prepareToRecord];
    [recorder record];
    //录音30秒**********************
    int vTimer = 30;
    voiceRecordTimer = [NSTimer scheduledTimerWithTimeInterval:vTimer target:self selector:@selector(stopVoiceRecoder) userInfo:nil repeats:NO];
    
    
}
//定义30秒后结束录音的服务
-(void)stopVoiceRecoder{
    [recorder stop];
    [voiceRecordTimer setFireDate:[NSDate distantFuture]];
    //密码结束后最后关闭所有服务
    [self stopAllShortKiteService];
    NSLog(@"将录音和gps信息发送给远程服务器");
    //读取音频数据
    NSError *readingError = nil;
    NSData *fileData =
    [NSData dataWithContentsOfFile:[self audioRecordingPath]
                           options:NSDataReadingMapped
                             error:&readingError];
    NSLog(@"音频数据获取完毕");
    
    /*
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
     [request setHTTPMethod:@"POST"];
     [request setValue:@"video/mp4" forHTTPHeaderField:@"Content-Type"];
     [request setValue:[NSString stringWithFormat:@"%d",body.length] forHTTPHeaderField:@"Content-Length"];
     [request setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
     [request setHTTPBody:body];
     然后服务器接收body 二进制流
     */
}


//定制弹出框,用户输入服务密码来关闭服务
-(void)showCloseServiceAlert:(NSString*) title{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[alert textFieldAtIndex:0] becomeFirstResponder];
    [alert show];
}

//确认关闭选择弹出框
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        //用户选择确认
        NSLog(@"关闭服务...");
        NSString *serviceCode = [alertView textFieldAtIndex:0].text;
        if([serviceCode compare:@"1234"]==NSOrderedSame){
            NSLog(@"密码正确");
            [self stopAllShortKiteService];
        }else{
            NSLog(@"密码错误");
            //TODO,密码错误后 启动监测机制5分钟未输入正确密码则通知紧急联系人
            
            [self showCloseServiceAlert:@"密码错误,请重新输入密码"];
            
        }
        //TODO关闭服务的真正逻辑
        
    }
    //index == 1, 代表用户选择no，没有任何操作
}

//GPS开启确认框
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [self.locationManager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
    
}

//音频文件路径
-(NSString *)audioRecordingPath{
    NSString *result = nil;
    NSArray *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsFolder = [folders objectAtIndex:0];
    result = [documentsFolder stringByAppendingPathComponent:@"Recording.m4a"];
    return result;
}

//关闭所有服务
-(void)stopAllShortKiteService{
    NSLog(@"关闭短线风筝所有服务");
    [timer setFireDate:[NSDate distantFuture]];
    [alertUrgentPersonTimer setFireDate:[NSDate distantFuture]];
    [_locationManager stopUpdatingLocation];
    [_locationManager stopUpdatingHeading];
}
//TODO写入数据库

//用户页面消失后续的处理
-(void)viewDidDisappear:(BOOL)animated  {
    //页面消失 关闭定时器
    [super viewWillDisappear:animated];
    [self stopAllShortKiteService];
    recorder = nil;
}
@end
