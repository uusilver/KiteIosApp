//
//  PersonalSettingViewController.m
//  风筝
//
//  Created by Mac on 15/2/4.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "PersonalSettingViewController.h"
#import "ChangeSafeQuestionsViewController.h"

@interface PersonalSettingViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITableView *listTable;
@property (weak, nonatomic) IBOutlet UILabel *mobileNo;
@property (weak, nonatomic) IBOutlet UILabel *remainSMS;
@property (weak, nonatomic) IBOutlet UILabel *urgent_name;
@property (weak, nonatomic) IBOutlet UIButton *changeSafeBtn;
@property (weak, nonatomic) IBOutlet UILabel *urgent_telno;

@end

@implementation PersonalSettingViewController

NSString *logoutTitle = @"退出风筝";
NSString *logoutMessage = @"确认退出风筝";
NSString *ValidatePasswordTitle = @"验证登录密码";
NSString *WrongPasswordTitle = @"密码错误,请重新输入密码";
NSString *ValidatePasswordMessage = @"为保障你的数据安全，修改前请填写您的登录密码。";

//static int changUrgentContactIndex = 1;
static int changeSafeQuestionIndex = 2;
static int changeLoginPasswordIndex = 3;
static int changeServiceCodeIndex = 4;
//static NSString *changUrgentContactSegue = @"goChangUrgentContact";
static NSString *changeSafeQuestionSegue = @"goChangSafeQuestion";
static NSString *changeLoginPasswordSegue = @"goChangLoginPassword";
static NSString *changeServiceCodeSegue = @"goChangServiceCode";


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //头像以圆形展示
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 3.0f;
    self.profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.listTable setDelegate:self];
    [self.listTable setDataSource:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if([indexPath row] == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"urgentContact"];
    }else if([indexPath row] == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"safeQuestion"];
    }else if([indexPath row] == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"password"];
    }else if([indexPath row] == 3){
        cell = [tableView dequeueReusableCellWithIdentifier:@"serviceCode"];
    }else if([indexPath row] == 4){
        cell = [tableView dequeueReusableCellWithIdentifier:@"quitBtn"];
    }
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(IBAction)logoutKite:(id)sender{
    NSLog(@"退出风筝");
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:logoutTitle message:logoutMessage delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"确认",nil];
    [alert show];
}
//[self showValidateLoginPasswordAlert:@""];

-(IBAction)changeSafeQuestion:(id)sender{
    [self validateLoginPassword:ValidatePasswordTitle toChangeType:changeSafeQuestionIndex];
}

-(IBAction)changeServiceCode:(id)sender{
    [self validateLoginPassword:ValidatePasswordTitle toChangeType:changeServiceCodeIndex];
}

-(IBAction)changeLoginPassword:(id)sender{
    [self validateLoginPassword:ValidatePasswordTitle toChangeType:changeLoginPasswordIndex];
}

//定制弹出框
//用户在修改登录密码／服务密码／安全问题前，需要验证登录密码
-(void)validateLoginPassword:(NSString *)title toChangeType:(int)changeType{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:ValidatePasswordMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [[alert textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[alert textFieldAtIndex:0] becomeFirstResponder];
    [alert show];
    changeTypeIndex = changeType;
    NSLog(@"changeTypeIndex:%d", changeTypeIndex);
}


//确认关闭选择
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //显示登出确认框
    if([alertView.title isEqualToString:logoutTitle]){
        if(buttonIndex == 1){
            NSLog(@"执行具体的登出代码");
            //用户选择Yes
            //TODO 调用登出的webservice
            //初始化全局变量
            AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            
            NSMutableString *mStr = [NSMutableString stringWithCapacity:50];
            [mStr appendString:@"/rest/logout/"];
            [mStr appendString:delegate.username];
            [mStr appendString:@"/"];
            [mStr appendString:@"clientType"];
            NSLog(@"登出rest地址:%@",(NSString *)mStr);
            //清空用户的Wrapper设置
            [wrapper resetKeychainItem];
            
            [self performSegueWithIdentifier:@"back2login" sender:self];
        }
        //index == 1, 代表用户选择no，没有任何操作
    }
    
    //显示登录密码校验框
    if([alertView.title isEqualToString:ValidatePasswordTitle] || [alertView.title isEqualToString:WrongPasswordTitle ]){
        if(buttonIndex == 1){
            //用户选择确认
            NSString *serviceCode = [alertView textFieldAtIndex:0].text;
            if([serviceCode compare:@"1234"]==NSOrderedSame){
                NSLog(@"密码正确");
                //跳转去指定页面
                if(changeTypeIndex == changeSafeQuestionIndex){
                    [self performSegueWithIdentifier:@"showChangeSafeQuestion" sender:self];
                }else if(changeTypeIndex == changeLoginPasswordIndex){
                    [self performSegueWithIdentifier:@"showChangeLoginPassword" sender:self];
                }else if(changeTypeIndex == changeServiceCodeIndex){
                    [self performSegueWithIdentifier:@"showChangeServiceCode" sender:self];
                }
            }else{
                NSLog(@"密码错误");
                [self validateLoginPassword:WrongPasswordTitle toChangeType:changeTypeIndex];
            }
            //TODO关闭服务的真正逻辑
            
        }
        //index == 0, 代表用户选择no，没有任何操作
    }
}

@end
