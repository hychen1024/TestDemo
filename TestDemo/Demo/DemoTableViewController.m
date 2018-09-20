
//
//  DemoTableViewController.m
//  TestDemo
//
//  Created by huyuchen on 2018/9/11.
//  Copyright © 2018年 Hyc. All rights reserved.
//

#import "DemoTableViewController.h"
#import "GCDSemaphoreViewController.h"
#import "GCDBarrierViewController.h"
#import "iOSDeviceUniqueIdentifierViewController.h"

@interface DemoTableViewController ()
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleArray count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demo"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"demo"];
    }
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *classMethodString = [self.titleArray objectAtIndex:indexPath.row];
    SEL selector = NSSelectorFromString(classMethodString);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:selector withObject:nil];
#pragma clang diagnostic pop

}

- (void)GCD_Semaphore {
    [self pushViewControllerWithName:NSStringFromClass([GCDSemaphoreViewController class])];
}

- (void)GCD_Barrier {
    [self pushViewControllerWithName:NSStringFromClass([GCDBarrierViewController class])];
    
}

- (void)getUniqueIdentifierWithIdfvAndkeychain {
    [self pushViewControllerWithName:NSStringFromClass([iOSDeviceUniqueIdentifierViewController class])];
}

#pragma mark - getter
- (NSArray *)titleArray {
    return @[@"GCD_Semaphore",@"GCD_Barrier",@"getUniqueIdentifierWithIdfvAndkeychain"];
}

- (void)pushViewControllerWithName:(NSString *)vcName {
    Class vcClass = NSClassFromString(vcName);
    id vc = [vcClass new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
