//
//  CustomViewController.m
//  learn-YYModel
//
//  Created by oahgnehzoul on 2017/5/1.
//  Copyright © 2017年 oahgnehzoul. All rights reserved.
//

#import "CustomViewController.h"
#import "MLTagView.h"

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MLTagView *tagView = [[MLTagView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:tagView];
    tagView.margin = 0;
    tagView.itemBorderWidth = 0;
    tagView.itemCornerRadius = 0;
    tagView.itemTitleColor = [UIColor grayColor];
    tagView.itemTitlePadding = 0;
    NSArray *tags = @[@"中船科技、",@"中国重工、",@"中国船舶、",@"中船防务"];
    for (int i = 0 ; i < tags.count; i++) {
        [tagView addTag:[NSString stringWithFormat:@"%@",tags[i]]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
