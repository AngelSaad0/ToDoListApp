//
//  TabBarController.m
//  ToDoList2
//
//  Created by Engy on 7/17/2567 BE.
//

#import "TabBarController.h"
#import "DetailsViewController.h"
#import "Static.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)addButtonPressed:(UIButton*)sender {
    DetailsViewController *detailsVc = [self.storyboard instantiateViewControllerWithIdentifier:DetailsVCSegue];
    [self.navigationController pushViewController:detailsVc animated:YES];
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
