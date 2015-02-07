//
//  KiteServiceSelectorViewController.h
//  风筝
//
//  Created by 李俊英 on 15/1/7.
//  Copyright (c) 2015年 VaniLi. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DrawLineView.h"
@interface KiteServiceSelectorViewController : UIViewController
{
    CGPoint startImgPoint;
    CGPoint startTouchPoint;
    //IBOutlet UIImageView *imageView;
    bool draging;
    
}

@property(nonatomic, assign) NSInteger serviceType;

@end
