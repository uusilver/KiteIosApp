//
//  KiteCourseCenterViewController.m
//  风筝
//
//  Created by 李俊英 on 15/1/21.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import "KiteCourseCenterViewController.h"

@implementation KiteCourseCenterViewController
@synthesize DataTable;
- (void)viewDidLoad{
    [super viewDidLoad];
    //创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 58)];
    //创建一个导航栏集合
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    //设置导航栏的内容
    [navItem setTitle:@"风筝讲堂"];
    //把导航栏集合添加到导航栏中，设置动画关闭
    [navBar pushNavigationItem:navItem animated:NO];
    [self.view addSubview:navBar];
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
    
    [DataTable setDelegate:self];
    
    [DataTable setDataSource:self];
    
    [self.view addSubview:DataTable];
    
    //TODO 调用新闻列表web service来读取相关
    dataArray1 = [[NSMutableArray alloc] init];
    [dataArray1 addObject:@"百度"];
    [dataArray1 addObject:@"西祠"];
    [dataArray1 addObject:@"腾讯"];
    websiteArray = [[NSMutableArray alloc] init];
    [websiteArray addObject:@"http://www.baidu.com"];
    [websiteArray addObject:@"http://www.xici.com"];
    [websiteArray addObject:@"http://www.qq.com"];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = dataArray1[indexPath.row];
    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height + 20;/*这里再加20是为了避免出现...的现象*/
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray1 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"mycell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = dataArray1[indexPath.row];
    cell.textLabel.numberOfLines = 0;/*numberOfLine=0表示可以多行，默认是1行*/
    cell.textLabel.font = [UIFont systemFontOfSize:15];/**这里字体大小最好设置成和heightForRowAtIndexPath中一样的大小**/
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//点击cell事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *selectedVisitWebSite = [websiteArray objectAtIndex:[indexPath row]];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:selectedVisitWebSite]];
}

@end
