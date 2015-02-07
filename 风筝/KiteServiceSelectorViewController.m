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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    //设置导航栏的内容
    [navItem setTitle:@"服务选择"];
    //把导航栏集合添加到导航栏中
    [navBar pushNavigationItem:navItem animated:NO];
    [self.view addSubview:navBar];

    //TODO
    //添加遮盖层点击事件
    UITapGestureRecognizer *coverViewTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toMainViewAction:)];
    [self.coverView addGestureRecognizer:coverViewTapped];
    
    //判断用户的服务状态，如果开启长线风筝服务则跳转到相关页面
    
}

- (void)viewWillAppear:(BOOL)animated{
    //若遮盖层已经显示过，则取消显示
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *showCoverView = [defaults objectForKey:@"showCoverView"];
    
    if(showCoverView==nil || [showCoverView isEqualToString:@"YES"]){
        //设置不再显示遮盖层
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"showCoverView"];
        [self showCoverView];
    }else{
        [self hideCoverView];
    }
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
    [self drawline];
}

//主页面checkbox点击事件
- (IBAction)noshowCheckboxBtnAction:(id)sender {
    [self hideCoverView];
}

//checkbox点击事件
- (IBAction)showCheckboxBtnAction:(id)sender {
    [self showCoverView];
}

//显示遮盖层，并隐藏画线
- (void)showCoverView{
    self.coverView.hidden = NO;
    self.mainView.hidden = YES;
    //隐藏画线页面
    self.imgLines.hidden = YES;
}

//显示主页面，并画线
- (void)hideCoverView{
    self.coverView.hidden = YES;
    self.mainView.hidden = NO;
    //画线
    [self drawline];
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
