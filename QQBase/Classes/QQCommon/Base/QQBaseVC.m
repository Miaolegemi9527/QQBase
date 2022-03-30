//
//  QQBaseVC.m
//  me
//
//  Created by 子不语 on 2021/12/8.
//  Copyright © 2021 gxrb. All rights reserved.
//

#import "QQBaseVC.h"

@interface QQBaseVC ()

@end

@implementation QQBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc {
    NSLog(@"zby %@ 页面销毁",[self class]);
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
