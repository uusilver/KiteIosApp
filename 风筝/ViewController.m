//
//  ViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/4.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) BOOL *showIntroViews;

@end

@implementation ViewController

@synthesize username;
@synthesize password;
@synthesize rememberFlag;

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加navigation bar
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 58)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //loading图标初始化
    self.loadingView = [[HYCircleLoadingView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    UIBarButtonItem *loadingItem = [[UIBarButtonItem alloc]initWithCustomView:self.loadingView];
    
    //创建一个右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(gotoRegisterPage)];
    
    //设置导航栏的内容
    [navItem setTitle:@"风筝登录"];
    
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    
    //把左右两个按钮添加到导航栏集合中去
    [navItem setLeftBarButtonItem:loadingItem];
    [navItem setRightBarButtonItem:rightButton];
    [self.view addSubview:navBar];
    
//    [self.loadingView startAnimation];
    
    
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
    
    wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number" accessGroup:@"YOUR_APP_ID_HERE.com.yourcompany.AppIdentifier"];
    
    
    password.secureTextEntry = YES;
    //初始化默认记住用户
    rememberFlag.on = YES;
    NSString* _username = @"";
    NSString* _password = @"";
    //TODO放开测试..
//    username = [wrapper objectForKey:(__bridge id)kSecAttrAccount];
//    password = [wrapper objectForKey:(__bridge id)kSecValueData];
    if((_username==nil||[_username isEqualToString:@""])&&(_password==nil||[_password isEqualToString:@""])){
        NSLog(@"用户名密码为空，正常登录");
    }else{
        NSLog(@"有保存的用户名和密码，直接登录");
    }
}

-(IBAction)loginCheck:(id)sender{
    NSString *usernameCode = username.text;
    NSString *passwordCode = password.text;
    //验证文本框内容不为空
    if(usernameCode==nil||[usernameCode isEqualToString:@""]){
        [self showAlertMsgBox:@"用户名不能为空"];
    }else if(![self validateMobile:usernameCode]){
        [self showAlertMsgBox:@"请输入正确的手机号码"];
    }else if(passwordCode==nil||[passwordCode isEqualToString:@""]){
        [self showAlertMsgBox:@"密码不能为空"];
    }else{
        //登录逻辑校验
        if([self callLoginRestService:usernameCode password:passwordCode]){
            NSLog(@"密码校验通过");
            //设置相关全局变量
            AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
            delegate.isLogin = YES;
            
            if(rememberFlag.on){
                //TODO 等待测试
                //            [wrapper setObject:usernameCode forKey:(__bridge id)(kSecAttrAccount)];
                //            [wrapper setObject:passwordCode forKey:(__bridge id)(kSecValueData)];
                
            }
            //跳转进入服务列表页面
            [self performSegueWithIdentifier:@"KiteServiceList" sender:self];
            
        }else{
            //TODO web service的错误信息中包含，用户名不存在，密码错误，以及密码错误的次数提示
            [self showAlertMsgBox:@"用户名或密码错误，请检查后重新输入"];
            password.text = @"";
        }//登录逻辑结束

    }
    
}
//TODO 调用登陆的web service
-(BOOL)callLoginRestService:(NSString*) usernameCode password:(NSString*) passwordCode{
    //测试json数据读取，用国家天气预报接口，后续等待替换
    NSError *error;
    NSMutableString *mStr = [NSMutableString stringWithCapacity:50];
    [mStr appendString:@"http://www.weather.com.cn/data/cityinfo/"];
    [mStr appendString:@"101190101.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:(NSString *)mStr ]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
    NSLog(@"%@",weatherDic);
    NSLog(@"城市为:%@, 天气:%@, 最高温度:%@, 最低温度:%@, 时间:%@",
          [weatherInfo objectForKey:@"city"],
          [weatherInfo  objectForKey:@"weather"],
          [weatherInfo objectForKey:@"temp1"],
          [weatherInfo objectForKey:@"temp2"],
          [weatherInfo objectForKey:@"ptime"]);
    NSLog(@"天气读取完毕");
    
    //加密测试
    NSString *str = [NSString stringWithFormat:@"YWE="];
    NSString *str1 = [NSString stringWithFormat:@"aa"];
    NSLog(@"解密后的字符串========%@",[Base64Handler textFromBase64String:str]);
    NSLog(@"加密后的字符串=========%@",[Base64Handler base64StringFromText:str1]);
    
    /***************************/
    if(passwordCode!=nil && [passwordCode compare:@"1234"]==NSOrderedSame
       && usernameCode!=nil && [usernameCode compare:@"13851483034"]==NSOrderedSame){
        return YES;
    }else{
        return NO;
    }
}

-(IBAction)goForgetPws:(id)sender{
    [self performSegueWithIdentifier:@"go2ForgetPwd" sender:self];
}

//跳转至注册页面
-(void)gotoRegisterPage{
    NSLog(@"用户点击去注册页面");
    [self performSegueWithIdentifier:@"registerPage" sender:self];
    
}

//统一显示错误信息的提示框
-(void)showAlertMsgBox:(NSString*) msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登陆信息" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//显示介绍页面
-(void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *showIntroViews = [defaults objectForKey:@"showIntroViews"];
    
    NSLog(@"showIntroViewsFlag:%@", showIntroViews);
    
    if(showIntroViews==nil || [showIntroViews isEqualToString:@"YES"]){
        //set the flag and not show intro views next time
        [defaults setObject:@"NO" forKey:@"showIntroViews"];
        
        //STEP 1: Construct Panels
        //1-1 长线风筝
        MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"girl"] title:@"好担心。。。" description:@"好漫长的旅途，遇到坏人可怎么办呀？？？"];
        //1-2 短线风筝
        MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"girl"] title:@"好害怕。。。" description:@"天好黑，前面有个黑巷子。。。过？？？还是，不过？？？"];
        //1-3 风筝侠横空出世
        MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"Fzxia"] title:@"噔噔噔~~~" description:@"菇凉别怕，风筝侠来也～"];
        
        //STEP 2: Create IntroductionView
        MYIntroductionView *introductionView = [[MYIntroductionView alloc]
                                                initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                headerText:@"风筝安全卫士"
                                                panels:@[panel1, panel2, panel3]
                                                languageDirection:MYLanguageDirectionLeftToRight];
        [introductionView setBackgroundImage:[UIImage imageNamed:@"introBackground"]];
        
        //Set delegate to self for callbacks (optional)
        introductionView.delegate = self;
        
        //STEP 3: Show introduction view
        [introductionView showInView:self.view];
    }
    
}

//验证手机号
- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
}

@end
