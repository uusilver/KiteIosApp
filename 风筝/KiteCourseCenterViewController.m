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
- (void)viewDidLoad

{
    
    [super viewDidLoad];
    //添加背景图片
    UIImage *backImage = [UIImage imageNamed:@"bg.jpg"];
    UIImageView *drawBackImageOnBg = [[UIImageView alloc]initWithImage:backImage];
    drawBackImageOnBg.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:drawBackImageOnBg atIndex:0];
    
    [DataTable setDelegate:self];
    
    [DataTable setDataSource:self];
    
    [self.view addSubview:DataTable];

    dataArray1 = [[NSMutableArray alloc] initWithObjects:@"中国", @"美国", @"英国", nil];

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
    //TODO 根据选择的内容框来跳转到相应的页面
    NSString *titileString = [dataArray1 objectAtIndex:[indexPath row]];  //这个表示选中的那个cell上的数据
    [self performSegueWithIdentifier:@"loadWebSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"loadWebSegue"]) //"goView2"是SEGUE连线的标识
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"http://www.sina.com.cn/" forKey:@"urlVal"];
    }
}
@end
