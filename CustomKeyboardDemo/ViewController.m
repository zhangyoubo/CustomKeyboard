//
//  ViewController.m
//  CustomKeyboardDemo
//
//  Created by lihongcheng on 16/4/12.
//  Copyright © 2016年 lihongcheng. All rights reserved.
//

#import "ViewController.h"
#import "KeyBoardView.h"

@interface ViewController ()<UITextFieldDelegate,KeyBoardViewDelegate>

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic, strong) KeyBoardView *keyboard;
@property (nonatomic,assign) NSInteger flag;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, 250, 30)];
    self.textField.delegate = self;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"请输入你要输入的内容";
    [self.view addSubview:self.textField];
    
    KeyBoardView *keyboard = [[KeyBoardView alloc] init];
    keyboard.delegate = self;
    self.keyboard = keyboard;
    self.textField.inputView = self.keyboard; //设置自定义键盘
    
    
    // 加载到键盘的上方
    UILabel *titleLable=[[UILabel alloc ]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    titleLable.backgroundColor=[UIColor grayColor];
    titleLable.text=@"上海掌富网路技术有限公司";
    titleLable.font=[UIFont systemFontOfSize:24];
    titleLable.textAlignment=NSTextAlignmentCenter;
    self.textField.inputAccessoryView = titleLable;
    
}
//textField 显示值
- (void)keyboard:(KeyBoardView *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string {
        self.textField.text = string;
}
//回到系统键盘
-(void)changeKeyboardType
{
    [self.textField resignFirstResponder];
    self.textField.inputView = nil;
    [self.textField becomeFirstResponder];
    self.flag = 1;
    self.textField.delegate = self;
}
//隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}
//回收系统键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return YES;
}
//重新调出自定义键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.flag == 1) {
        KeyBoardView *keyboard = [[KeyBoardView alloc] init];
        keyboard.delegate = self;
        keyboard.string = [NSMutableString stringWithFormat:@"%@", self.textField.text];
        self.keyboard = keyboard;
        self.textField.inputView = self.keyboard;
    }
    self.flag = 0;
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
