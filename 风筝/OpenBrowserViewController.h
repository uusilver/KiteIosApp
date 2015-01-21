//
//  OpenBrowserViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/21.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenBrowserViewController : UIViewController{
//    UIWebView *webView; 
}
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property(weak, nonatomic) NSString *urlVal;
@end
