//
//  ViewController.m
//  TableViewBeginEndUpdates
//
//  Created by 王庆学 on 2017/11/12.
//  Copyright © 2017年 王庆学. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.arrayData = [NSMutableArray arrayWithArray:@[@"第一行",@"第二行",@"第三行",@"第四行",@"第五行",@"第六行",@"第七行"]];
}

- (IBAction)addCell:(id)sender {
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            NSLog(@"插入cell完成");
        }];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
        [self.arrayData insertObject:@"新添加的行" atIndex:0];
        [self.tableView endUpdates];
        [CATransaction commit];
    } completion:^(BOOL finished) {
        NSLog(@"动画执行完毕");
    }];
}

- (IBAction)deleteCell:(id)sender {
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            
        }];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self.arrayData removeObjectAtIndex:0];
        [self.tableView endUpdates];
        [CATransaction commit];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (IBAction)changeCellText:(id)sender {
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            
        }];
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
        [self.arrayData replaceObjectAtIndex:0 withObject:@"修正后的cell"];
        [self.tableView endUpdates];
        [CATransaction commit];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (IBAction)moveCell:(id)sender {
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionAutoreverse animations:^{
    } completion:^(BOOL finished) {
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            
        }];
        [self.tableView beginUpdates];
        [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        NSString *str = self.arrayData[0];
        [self.arrayData removeObjectAtIndex:0];
        [self.arrayData insertObject:str atIndex:2];
        [self.tableView endUpdates];
        [CATransaction commit];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * stringCellIdentifier = @"baseTableViewCellIdentifier";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:stringCellIdentifier];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:stringCellIdentifier];
    cell.textLabel.text = self.arrayData[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
