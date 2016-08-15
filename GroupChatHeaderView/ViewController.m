//
//  ViewController.m
//  GroupChatHeaderView
//
//  Created by liang wang on 16/8/15.
//  Copyright © 2016年 liang wang. All rights reserved.
//

#import "ViewController.h"
#import "GroupChatHeaderView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 2; i++) {
        [tempArray addObject:@""];
    }
    GroupChatHeaderView *headerView = [[GroupChatHeaderView alloc] init];
    headerView.frame = CGRectMake(0, 0, 80, 80);
    [headerView initViewWithFrame:headerView.frame members:tempArray];
    headerView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0);
    headerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:headerView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
