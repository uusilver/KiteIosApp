//
//  KiteCourseCenterViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/21.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KiteCourseCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
     
     NSMutableArray *dataArray1;
     NSMutableArray *websiteArray;
}
@property (strong, nonatomic) IBOutlet UITableView *DataTable;

@end
