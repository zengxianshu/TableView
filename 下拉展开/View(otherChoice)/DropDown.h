//
//  DropDown.h
//  wxMBT
//
//  Created by 曾宪书 on 15/5/29.
//  Copyright (c) 2015年 名兵团. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDown : UIView<UITableViewDelegate,UITableViewDataSource> {
    UITableView *tv;//下拉列表
    NSArray *tableArray;//下拉列表数据
    UITextField *textField;//文本输入框
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table下拉列表的高度
    CGFloat frameHeight;//frame的高度
}

@property (nonatomic,retain) UITableView *tv;
@property (nonatomic,retain) NSArray *tableArray;
@property (nonatomic,retain) UITextField *textField;


@end

//使用方法
/*
 
DropDown *dd1 = [[DropDown alloc] initWithFrame:CGRectMake(lastFied.left, lastFied.bottom+lastFied.height*2/5, lastFied.width, lastFied.height)];
dd1.textField.placeholder = @"选择楼盘";
NSMutableArray *arr = [NSMutableArray array];
AppDelegate * app = [[UIApplication sharedApplication] delegate];
for (HouseIdModel *model in  app.housesIdArray) {
    [arr addObject:model.name];
}
dd1.tableArray = arr;
[self.view addSubview:dd1];
 
 */
 



