//
//  ViewController.m
//  ButtonDemo
//
//  Created by dpwong on 2017/12/18.
//  Copyright © 2017年 dpwong. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+DPTitlePostionType.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.btn1 setTitlePositionWithType:DPButtonTitlePostionTypeTop space:5];
    [self.btn2 setTitlePositionWithType:DPButtonTitlePostionTypeBottom space:5];
    [self.btn3 setTitlePositionWithType:DPButtonTitlePostionTypeLeft space:5];
    [self.btn4 setTitlePositionWithType:DPButtonTitlePostionTypeRight space:5];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn5 setTitlePositionWithType:DPButtonTitlePostionTypeBottom space:10];
    [btn5 setTitle:@"Custom" forState:UIControlStateNormal];
    [btn5 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn5.titleLabel.font = [UIFont systemFontOfSize:12];
    btn5.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:btn5];
    btn5.frame = CGRectMake(0, 0, 100, 100);
    btn5.center = self.view.center;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
