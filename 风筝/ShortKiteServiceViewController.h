//
//  ShortKiteServiceViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/10.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreAudio/CoreAudioTypes.h>


@interface ShortKiteServiceViewController : UIViewController<CLLocationManagerDelegate>
{
    AVAudioRecorder *recorder;
    NSURL *recordedTmpFile;
    
    float lati;
    float longti;
    float heading;
    
    int passwordWrongTime;
}

@property (strong, nonatomic) IBOutlet UIButton *serviceBtn;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic, strong) CLLocationManager  *locationManager;
@property (nonatomic, strong) CLLocationManager  *headManager;
@property (nonatomic,strong) NSTimer *alertUrgentPersonTimer;
@property (nonatomic,strong) NSTimer *voiceRecordTimer;



@end
