//
//  KiteServiceSelectorViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/7.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "KiteServiceSelectorViewController.h"

@implementation KiteServiceSelectorViewController
@synthesize serviceType;
- (void)viewDidLoad {
    [super viewDidLoad];
    //TODO 判断用户的服务状态，如果开启长线风筝服务则跳转到相关页面
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    startImgPoint=imageView.frame.origin;
    startTouchPoint=[[[[event allTouches] allObjects] objectAtIndex:0] locationInView:self.view];
    if (startTouchPoint.x>startImgPoint.x&&
        startTouchPoint.x<startImgPoint.x+imageView.frame.size.width&&
        startTouchPoint.y>startImgPoint.y&&
        startTouchPoint.y<startImgPoint.y+imageView.frame.size.height) {
        draging=YES;
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!draging) {
         return;
     }
    
    CGPoint currentTouchPoint=[[[[event allTouches] allObjects] objectAtIndex:0] locationInView:self.view];
    CGRect currentFrame=imageView.frame;
    
    currentFrame.origin.x=startImgPoint.x+currentTouchPoint.x-startTouchPoint.x;
    currentFrame.origin.y=startImgPoint.y+currentTouchPoint.y-startTouchPoint.y;
    
    if (currentFrame.origin.x<0) {
        currentFrame.origin.x=0;
    }
    if (currentFrame.origin.y<0) {
        currentFrame.origin.y=0;
    }
    if (currentFrame.origin.x>480-currentFrame.size.width) {
        currentFrame.origin.x=480-currentFrame.size.width;
    }
    if (currentFrame.origin.y>640-currentFrame.size.height) {
        currentFrame.origin.y=640-currentFrame.size.height;
    }
    imageView.frame=currentFrame;

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //获得设备的屏幕尺寸
    UIScreen *currentScreen = [UIScreen mainScreen];
    float scrrenHeight = currentScreen.applicationFrame.size.height;
    float highSkyHeight = scrrenHeight*0.3;
    float lowSkyHeight = scrrenHeight*0.6;
    NSLog(@"高点%lf,低点%lf",highSkyHeight,lowSkyHeight);
    //获得图片最后的落点
    CGRect lastFrame = imageView.frame;
    //float lx = lastFrame.origin.x;
    float ly = lastFrame.origin.y;
    if(ly<highSkyHeight){
        //NSLog(@"长线风筝");
        serviceType = 1;
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"服务确认?"message:@"是否开启长线风筝?" delegate:self cancelButtonTitle:@"确认"otherButtonTitles:@"取消",nil];
        [alert show];
    }else if(ly>=highSkyHeight && ly<lowSkyHeight){
        //NSLog(@"短线风筝");
        serviceType = 0;
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"服务确认?"message:@"是否开启短线风筝?" delegate:self cancelButtonTitle:@"确认"otherButtonTitles:@"取消",nil];
        [alert show];
    }else{
        //是否需要提示用户选择有问题
        
    }
    //NSLog(@"图片落点在 : %f, %f\n", lx, ly);
    draging=NO;
}

//确认关闭选择
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        //用户选择Yes
        NSLog(@"用户最终选择的服务方式为:%ld",serviceType);
        if(serviceType==1){
            [self performSegueWithIdentifier:@"longKiteSerice" sender:self];
        }else if(serviceType==0){
            [self performSegueWithIdentifier:@"shortKiteService" sender:self];
        }
    }
    //index == 1, 代表用户选择no，没有任何操作
}


@end
