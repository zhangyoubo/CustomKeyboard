//
//  NumberKeyBoardView.m
//  MyKeyBoard
//
//  Created by 李洪成 on 15-4-22.
//  Copyright (c) 2015年 李洪成. All rights reserved.
//

#import "NumberKeyBoardView.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width

@implementation NumberKeyBoardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createButton];
    }
    return self;
}

#pragma mark - 创建数字键盘
-(void)createButton
{
    NSMutableArray *arrM = [[NSMutableArray alloc] initWithObjects:@"600",@"1",@"2",@"3",@"X",@"000",@"4",@"5",@"6",@"清空",@"001",@"7",@"8",@"9",@"隐藏",@"300",@"ABC",@"0",@"确定", nil];
    UIImage *image = [UIImage imageNamed:@"XXXXX"];
    UIImage *highImage = [UIImage imageNamed:@"XXXXX"];
    int index = 0;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 5; j++) {
            
            double w = (Screen_Width-30)/5;
            double h = (216-30)/4;
            double x = 5 + j*(w+5);
            double y = 6 + i*(h+6);
      
            NSString *title = arrM[index];
            
            UIButton *numBtn = [KeyBoradTool setupBasicButtonsWithTitle:title image:image highImage:highImage];
            if (index == 4) {
                
                //给删除按钮一个事件处理方法
                [numBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            else{
                //添加一个事件处理方法
                [numBtn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            if (index < 18) {
                numBtn.frame = CGRectMake(x, y, w, h);
            }
            else{
                numBtn.frame = CGRectMake(x, y, 2*w+6, h);
            }
            //123  678  11 12 13  17 控制数字的背景颜色
            if (index == 1 || index == 2 || index == 3 || index == 6 || index == 7 || index == 8 || index == 11 || index == 12 || index == 13 || index == 17 ) {
                numBtn.backgroundColor = [UIColor whiteColor];
            }
            else{
                numBtn.backgroundColor = [UIColor lightGrayColor];
            }
            //设置点击时按钮背景图片
            [numBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
            [self addSubview:numBtn];
            index++;
            //没有第19个按钮，直接返回
            if (index == 19) {
                break;
            }
        }
    }
}

//点击数字，隐藏，ABC，清空，确定等按钮
- (void)numBtnClick:(UIButton *)numBtn {
    
    if ([self.delegate respondsToSelector:@selector(numberKeyboard:didClickButton:)]) {
        [self.delegate numberKeyboard:self didClickButton:numBtn];
    }
}

//点击删除按钮
- (void)deleteBtnClick:(UIButton *)deleteBtn {
    if ([self.delegate respondsToSelector:@selector(customKeyboardDidClickDeleteButton:)]) {
        [self.delegate customKeyboardDidClickDeleteButton:deleteBtn];
    }
}


@end
