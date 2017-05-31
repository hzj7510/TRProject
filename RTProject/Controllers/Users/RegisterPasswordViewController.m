//
//  RegisterPasswordViewController.m
//  RTProject
//
//  Created by mac on 17/5/26.
//  Copyright © 2017年 x5. All rights reserved.
//

#import "RegisterPasswordViewController.h"
#import "RegisterPasswordView.h"

@interface RegisterPasswordViewController ()

@end

@implementation RegisterPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RegisterPasswordView *registerPwdView = [[RegisterPasswordView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:registerPwdView];
    [registerPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}


@end
