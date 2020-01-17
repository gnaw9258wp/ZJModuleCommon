//
//  ZJBaseViewController.m
//  ZJModuleCommon
//
//  Created by wp on 2020/1/16.
//  Copyright © 2020 wp. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "UIViewController+BGNavigationViewController.h"
@interface ZJBaseViewController ()

@end

@implementation ZJBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:[self bg_prefresHiddenNavigationBar]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
