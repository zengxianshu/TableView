//
//  AddClientVC.m
//  wxMBT
//
//  Created by 曾宪书 on 15/5/22.
//  Copyright (c) 2015年 名兵团. All rights reserved.
//
#import "TableViewWithBlock.h"
#import "HouseIdModel.h"
#import "AddClientVC.h"
#import "DropDown.h"
#import "SelectionCell.h"

@interface AddClientVC ()<UITextFieldDelegate,UIActionSheetDelegate>
{
    BOOL isOpened;
}

@property (nonatomic , strong) UITextField  *name ;//客户姓名
@property (nonatomic , strong) UITextField  *mobile ;//客户电话
@property (nonatomic , strong) UITextField  *idcard ;//客户身份证号码
@property (nonatomic , strong) UITextField  *buildinginfoID ;//推荐楼盘
@property (nonatomic , strong) UITextField  *remark ;//备注信息
@property (nonatomic , strong) NSArray  *fieldArray ;//文本框数组
@property (nonatomic , strong) UIPickerView *pickerView;//楼盘选择表示图
@property (strong, nonatomic)  TableViewWithBlock *tb;
@property (nonatomic , strong) UIButton *isZhiDai; //是否自带
@property (nonatomic , assign) BOOL zhiDai;
@end

@implementation AddClientVC
//singleton_implementation(AddClientVC)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子视图
    [self addSubView];
    
    [self.view bringSubviewToFront:_tb];
}




//改变是否自带状态
-(void)changeIfZhiDai{
    if (_zhiDai == NO) {
        [_isZhiDai setBackgroundImage:[UIImage imageNamed:@"click"] forState:UIControlStateNormal];
    }else {
        [_isZhiDai setBackgroundImage:[UIImage imageNamed:@"null"] forState:UIControlStateNormal];
    }
    _zhiDai =!_zhiDai;
}

//推荐
-(void)addClient{
    NSString *housesID = [NSString stringWithFormat:@"%d",self.housesId] ;
    NSDictionary *dict = @{@"action":@"addclient",@"name":@"张三", @"mobile" : @"130",@"buildinginfoID" : housesID,@"memberID" : @"37946",@"remark" : @"remark",@"tjType" : @"1",@"idcard" : @"411",};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
    NSString *url=[[NSString stringWithFormat:@"%@%@",SERVERURL,INTENTPHP] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id jsonObj) {
        NSLog(@"%@",jsonObj);
        if ([jsonObj objectForKey:@"status"] == 0) {
            [MBProgressHUD showSuccess:[jsonObj objectForKey:@"msg"]];
        }else{
            [MBProgressHUD showError:[jsonObj objectForKey:@"msg"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {   SHOWERROR   }];    
}

-(NSArray *)fieldArray{
    if (_fieldArray == nil) {
        _fieldArray = @[@"客户姓名",@"客户电话",@"客户身份证号码",@"备注信息",@"选择楼盘"];
    }
    return _fieldArray;
}

-(void)addSubView
{
    // 1.尺寸
    CGFloat appW = [ UIScreen mainScreen ].applicationFrame.size.width-60;
    CGFloat appH = 0;
    if (IPHONE5) {
        appH = 35;
    }else if(IPHONE6) {
        appH = 40;
    }else if(IPHONE6_Plus) {
        appH = 45;
    }else { appH = 30;}
    
    // 2.间隙
    CGFloat marginX = 30;
    CGFloat marginY = appH*2/5;
    CGFloat originY = 80;

    for (int i = 0; i < self.fieldArray.count ; i++) {
        UITextField *_textFiled = [[UITextField alloc] initWithFrame:CGRectMake(marginX, originY+appH*i+marginY*i, appW, appH)];
        _textFiled.tag = 100+i;
        _textFiled.delegate = self; // 设置代理
//        _textFiled.textColor = [UIColor redColor];
        _textFiled.placeholder = _fieldArray[i];
        _textFiled.adjustsFontSizeToFitWidth = YES;//自适应内容的宽度
        //    _textFiled.clearsOnBeginEditing = YES;//第一次输入的信息在第二次编辑的时候就会清除掉
        _textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;//4种类型 该类型右边带有叉按钮
        _textFiled.returnKeyType = UIReturnKeyNext;//键盘返回按钮 GO Send 等
        _textFiled.autocapitalizationType = UITextAutocapitalizationTypeNone;//自动大小写类型
        //        _textFiled.background = [UIImage imageNamed:@"navigation"];//背景图
        _textFiled.borderStyle = UITextBorderStyleRoundedRect;//边框的样式
        [self.view addSubview:_textFiled];
    }
    
    self.inputTextField = (UITextField *)[self.view viewWithTag:100+self.fieldArray.count-1];
    self.inputTextField.enabled = NO;
    UITextField *lastFied =(UITextField *)[self.view viewWithTag:100+self.fieldArray.count-2];
    
    //添加下拉菜单
    self.tb = [[TableViewWithBlock alloc]initWithFrame:CGRectMake(self.inputTextField.left+2, self.inputTextField.bottom-1, self.inputTextField.width-4, 1)];
    isOpened=NO;
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    [_tb initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView,NSInteger section){
        return app.housesIdArray.count;
        
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        HouseIdModel *model = app.housesIdArray[indexPath.row];
        [cell.lb setText:model.name];
        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        SelectionCell *cell=(SelectionCell*)[tableView cellForRowAtIndexPath:indexPath];
        _inputTextField.text=cell.lb.text;
        [_openButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    [_tb.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_tb.layer setBorderWidth:2];
    [self.view addSubview:_tb];

    //右侧点击按钮
    UIButton *clickHouses = [UIButton buttonWithType:UIButtonTypeCustom];
    clickHouses.tag = 201;
    clickHouses.frame = CGRectMake(lastFied.right-lastFied.height, lastFied.bottom+lastFied.height*2/5, lastFied.height, lastFied.height);
    [clickHouses addTarget:self action:@selector(changeOpenStatus:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickHouses];
    self.openButton = clickHouses ;
    UIImage *openImage=[UIImage imageNamed:@"dropdown.png"];
    [_openButton setImage:openImage forState:UIControlStateNormal];

    

    
    //是否自带
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(lastFied.left, lastFied.bottom+lastFied.height+lastFied.height*4/5, lastFied.width/2, lastFied.height)];
    label.backgroundColor = [UIColor redColor];
    label.text = @"是否自带:" ;
    _isZhiDai = [UIButton buttonWithType:UIButtonTypeCustom];
    _isZhiDai.frame = CGRectMake(0, 0, label.height, label.height);
    _isZhiDai.center = CGPointMake(label.right + label.width/2, label.center.y);
    [_isZhiDai setBackgroundImage:[UIImage imageNamed:@"null"] forState:UIControlStateNormal];
    [_isZhiDai addTarget:self action:@selector(changeIfZhiDai) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:label];
    [self.view addSubview:_isZhiDai];
    
    //推荐
    UIButton *addClient = [UIButton buttonWithType:UIButtonTypeSystem];
    addClient.frame = CGRectMake(lastFied.left, _isZhiDai.bottom+marginY, lastFied.width, lastFied.height);
    addClient.backgroundColor = [UIColor colorWithRed:0.391 green:0.498 blue:0.813 alpha:1.000];
    [addClient setTitle:@"推荐" forState:UIControlStateNormal];
    [addClient addTarget:self action:@selector(addClient) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addClient];
    

}

- (void)changeOpenStatus:(id)sender {
    if (isOpened) {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"dropdown.png"];
            [_openButton setImage:closeImage forState:UIControlStateNormal];
            CGRect frame=_tb.frame;
            frame.size.height=1;
            [_tb setFrame:frame];
        } completion:^(BOOL finished){
            isOpened=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"dropup.png"];
            [_openButton setImage:openImage forState:UIControlStateNormal];
            CGRect frame=_tb.frame;
            frame.size.height=200;
            [_tb setFrame:frame];
        } completion:^(BOOL finished){
            isOpened=YES;
        }];
    }
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{   //开始编辑时，整体上移
    //键盘高度 ：216
    if (textField.bottom >self.view.height-216-40) {
        self.view.transform=CGAffineTransformMakeTranslation(0,-40);
    }}
-(void)textFieldDidEndEditing:(UITextField *)textField{     //结束编辑时，仿射归零
    self.view.transform=CGAffineTransformMakeTranslation(0, 0);
}

#pragma mark UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UITextField *nextTextFiled = (UITextField *)[self.view viewWithTag:textField.tag+1];
    if (textField.tag < self.fieldArray.count+100-1) {
        [nextTextFiled becomeFirstResponder];
    }else {
        [self changeOpenStatus:nil];
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_pickerView removeFromSuperview];
    _pickerView = nil ;
    //退出键盘
    [self.view endEditing:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
