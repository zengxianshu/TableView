//
//  MainViewController.h
//  ComboBox
//
//  Created by Eric Che on 7/17/13.
//  Copyright (c) 2013 Eric Che. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+DataSourceBlocks.h"
@class TableViewWithBlock;
@interface MainViewController : UIViewController{
    BOOL isOpened;
}

@property (strong, nonatomic) IBOutlet UIButton *openButton;
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;
@property (strong, nonatomic) IBOutlet TableViewWithBlock *tb;
- (IBAction)changeOpenStatus:(id)sender;

@end
