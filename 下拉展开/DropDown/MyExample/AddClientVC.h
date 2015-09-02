//
//  AddClientVC.h
//  wxMBT
//
//  Created by 曾宪书 on 15/5/22.
//  Copyright (c) 2015年 名兵团. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddClientVC;

@interface AddClientVC : UIViewController
//singleton_interface(AddClientVC)
@property (nonatomic , assign) NSInteger  housesId;
@property (strong, nonatomic) UIButton *openButton;
@property (strong, nonatomic) UITextField *inputTextField;

@end
