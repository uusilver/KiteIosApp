//
//  KiteServiceSelectorViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/7.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "KiteServiceSelectorViewController.h"

@interface KiteServiceSelectorViewController ()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIButton *noshowCheckboxBtn;
@property (weak, nonatomic) IBOutlet UIButton *showCheckboxBtn;

@property (weak, nonatomic) IBOutlet UIImageView *girlImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic) UIImageView *imgLines;

@end

@implementation KiteServiceSelectorViewController
@synthesize serviceType;
//是否显示遮盖层介绍信息
@synthesize coverview_show_flag;

- (void)viewDidLoad {
    [super viewDidLoad];
    //TODO 判断用户的服务状态，如果开启长线风筝服务则跳转到相关页面
    //添加遮盖层点击事件
    UITapGestureRecognizer *coverViewTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toMainViewAction:)];
    [self.coverView addGestureRecognizer:coverViewTapped];
    
    //初始化不再显示checkbox
    coverview_show_flag = YES;
    [self.noshowCheckboxBtn setImage:[UIImage imageNamed:@"cb_glossy_off"] forState:YES];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    startImgPoint=self.imageView.frame.origin;
    startTouchPoint=[[[[event allTouches] allObjects] objectAtIndex:0] locationInView:self.view];
    if (startTouchPoint.x>startImgPoint.x&&
        startTouchPoint.x<startImgPoint.x+self.imageView.frame.size.width&&
        startTouchPoint.y>startImgPoint.y&&
        startTouchPoint.y<startImgPoint.y+self.imageView.frame.size.height) {
        draging=YES;
    }
    
    NSLog(@"kite0 at: %f, %f", self.imageView.frame.origin.x, self.imageView.frame.origin.y);
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!draging) {
         return;
     }
    
    CGPoint currentTouchPoint=[[[[event allTouches] allObjects] objectAtIndex:0] locationInView:self.view];
    CGRect currentFrame=self.imageView.frame;
    
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
    
    self.imageView.frame=currentFrame;
    
    [self drawline];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //获得设备的屏幕尺寸
    UIScreen *currentScreen = [UIScreen mainScreen];
    float scrrenHeight = currentScreen.applicationFrame.size.height;
    float highSkyHeight = scrrenHeight*0.3;
    float lowSkyHeight = scrrenHeight*0.6;
    NSLog(@"高点%lf,低点%lf",highSkyHeight,lowSkyHeight);
    
    //获得图片最后的落点
    CGRect lastFrame = self.imageView.frame;
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


//遮盖层点击事件
- (IBAction)toMainViewAction:(id)sender {
    self.mainView.hidden = NO;
    self.coverView.hidden = YES;
    [self.showCheckboxBtn setImage:[UIImage imageNamed:@"cb_glossy_off"] forState:NO];
    coverview_show_flag = NO;
}

//checkbox点击事件
- (IBAction)noshowCheckboxBtnAction:(id)sender {
    if(coverview_show_flag == YES){
        [self.noshowCheckboxBtn setImage:[UIImage imageNamed:@"cb_glossy_on"] forState:NO];
    }else{
        [self.noshowCheckboxBtn setImage:[UIImage imageNamed:@"cb_glossy_off"] forState:NO];
    }
    coverview_show_flag = !coverview_show_flag;
}

//checkbox点击事件
- (IBAction)showCheckboxBtnAction:(id)sender {
    if(coverview_show_flag == YES){
        [self.showCheckboxBtn setImage:[UIImage imageNamed:@"cb_glossy_off"] forState:NO];
    }else{
        [self.showCheckboxBtn setImage:[UIImage imageNamed:@"cb_glossy_on"] forState:NO];
        self.mainView.hidden = YES;
        self.coverView.hidden = NO;
    }
    coverview_show_flag = !coverview_show_flag;
}

//画线
- (void)drawline{
    [self.imgLines removeFromSuperview];
    
    self.imgLines =[[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.imgLines];
    
    UIGraphicsBeginImageContext(self.imgLines.frame.size);
    
    //获得上下文
    CGContextRef contex = UIGraphicsGetCurrentContext();
    [self.imgLines.image drawInRect:CGRectMake(0, 0, self.imgLines.frame.size.width, self.imgLines.frame.size.height)];
    CGContextSetLineCap(contex, kCGLineCapSquare); //端点形状
    CGContextSetLineWidth(contex, 2); //线条粗细
    CGContextSetAllowsAntialiasing(contex, YES);
    CGContextSetShouldAntialias(contex, YES);//设置线条平滑，不需要两边像素宽
    CGContextSetStrokeColorWithColor(contex, [UIColor darkGrayColor].CGColor);//设置线条颜色
    CGContextBeginPath(contex);
    
    //设置起点坐标
    //起点坐标为女孩图片的右侧中点
    CGFloat lineStartX = self.girlImageView.frame.origin.x + self.girlImageView.frame.size.width;
    CGFloat lineStartY = self.girlImageView.frame.origin.y + (self.girlImageView.frame.size.height / 2.0f);
    CGContextMoveToPoint(contex, lineStartX, lineStartY);
    //设置终点坐标
    //终坐标为风筝图片的左下角
    CGFloat linEndX = self.imageView.frame.origin.x;
    CGFloat lineEndY = self.imageView.frame.origin.y + self.imageView.frame.size.height;
    CGContextAddLineToPoint(contex, linEndX, lineEndY);
    
    CGContextStrokePath(contex);
    self.imgLines.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
