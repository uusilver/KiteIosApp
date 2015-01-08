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
    //获得图片最后的落点
    CGRect lastFrame = imageView.frame;
    //float lx = lastFrame.origin.x;
    float ly = lastFrame.origin.y;
    if(ly<109.0f){
        //NSLog(@"长线风筝");
        serviceType = 1;
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"服务确认?"message:@"是否开启长线风筝?" delegate:self cancelButtonTitle:@"YES"otherButtonTitles:@"NO",nil];
        [alert show];
    }else if(ly>=109.0f && ly<207.0f){
        //NSLog(@"短线风筝");
        serviceType = 0;
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"服务确认?"message:@"是否开启短线风筝?" delegate:self cancelButtonTitle:@"YES"otherButtonTitles:@"NO",nil];
        [alert show];
    }else{
        //是否需要提示用户选择有问题
        
    }
    //NSLog(@"图片落点在 : %f, %f\n", lx, ly);
    draging=NO;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        //用户选择Yes
        NSLog(@"用户最终选择的服务方式为:%ld",serviceType);
    }
    //index == 1, 代表用户选择no，没有任何操作
}


@end
