//
//  DoneViewController.m
//  ToDoList2
//
//  Created by Engy on 7/17/2567 BE.
//

#import "DoneViewController.h"
#import "Task.h"
#import "Static.h"
#import "DetailsViewController.h"

@interface DoneViewController ()
@property BOOL isFiltered;
@property (weak, nonatomic) IBOutlet UIImageView *myImg;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<Task *> *allTasks;
@property (nonatomic, strong) NSMutableArray<Task *> *lowTasks;
@property (nonatomic, strong) NSMutableArray<Task *> *medTasks;
@property (nonatomic, strong) NSMutableArray<Task *> *highTasks;
@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _isFiltered = NO;
    _lowTasks = [NSMutableArray new];
    _medTasks = [NSMutableArray new];
    _highTasks = [NSMutableArray new];
    [self.tableView reloadData];
    self.allTasks = [NSMutableArray arrayWithArray:[Task readDataWithKey:tasksKey]];
    [self.tabBarController.navigationItem setTitle:@"Done List"];

}

-(void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.navigationItem.rightBarButtonItems[0] setHidden:YES];
    [self reloadData];
    [self.tabBarController.navigationItem setTitle:@"Done List"];
}


- (void)reloadData {
    self.allTasks = [NSMutableArray arrayWithArray:[Task readDataWithKey:tasksKey]];
    
    NSMutableArray *filteredTasks = [NSMutableArray new];
    for (int i=0; i<_allTasks.count; i++) {
        if (_allTasks[i].status == 2) {
            [filteredTasks addObject:_allTasks[i]];
        }
    }
    _allTasks = filteredTasks;
    
    if (_isFiltered) {
        
        for (Task *task in _allTasks) {
            if (task.priority == 0) {
                [_lowTasks addObject:task];
            } else if (task.priority == 1) {
                [_medTasks addObject:task];
            } else if (task.priority == 2) {
                [_highTasks addObject:task];
            }
        }
        if (_lowTasks.count == 0 && _medTasks.count == 0 && _highTasks.count == 0){
            [_tableView setHidden:YES];
            [ _myImg setHidden:NO];
        }else{
            [ _myImg setHidden:YES];
            [ _tableView setHidden:NO];
        }
    } else {
        if (_allTasks.count == 0){
            [_tableView setHidden:YES];
            [ _myImg setHidden:NO];
        }else{
            [ _myImg setHidden:YES];
            [ _tableView setHidden:NO];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _isFiltered ? 3 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isFiltered) {
        switch (section) {
            case 0:
                return _lowTasks.count;
                break;
            case 1:
                return _medTasks.count;
                break;
            case 2:
                return _highTasks.count;
                break;
            default:
                break;
        }
    } else {
        return _allTasks.count;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_isFiltered) {
        switch(section) {
            case 0:
                return @"Low Priority";
            case 1:
                return @"Medium Priority";
            case 2:
                return @"High Priority";
        }
        return @"";
    } else {
        return @"All Tasks";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
    Task *task;
    if (cell == nil) {
        cell = [UITableViewCell new];
    }
    
    if (_isFiltered) {
        switch (indexPath.section) {
            case 0:
                task = _lowTasks[indexPath.row];
                break;
            case 1:
                task = _medTasks[indexPath.row];
                break;
            case 2:
                task = _highTasks[indexPath.row];
                break;
            default:
                break;
        }
        cell.textLabel.text = task.title;
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", task.priority]];
    } else {
        task = self.allTasks[indexPath.row];
        cell.textLabel.text = task.title;
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", task.priority]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailsViewController *detailsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    detailsVc.task = _allTasks[indexPath.row];
    [self.navigationController pushViewController:detailsVc animated:YES];
 }

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [Task1 removeTaskAtIndex:indexPath.row fromKey:tasksKey];
        [Task removeTaskByUUID:_allTasks[indexPath.row].uuid fromKey:tasksKey];
        [self reloadData];
    }
}

- (IBAction)filterSwitch:(UISwitch *)sender {
    if([sender isOn]) {
        _isFiltered = YES;
        [_lowTasks removeAllObjects];
        [_medTasks removeAllObjects];
        [_highTasks removeAllObjects];
    } else {
        _isFiltered = NO;
    }
    [self reloadData];
}

@end
