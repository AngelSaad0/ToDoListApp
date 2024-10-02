//
//  TodoViewController.m
//  ToDoList2
//
//  Created by Engy on 7/17/2567 BE.

#import "TodoViewController.h"
#import "DetailsViewController.h"
#import "Task.h"
#import "Static.h"

@interface TodoViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *uiSearch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *myImg;
@property (nonatomic, strong) NSMutableArray<Task *> *allTasks;
@end

@implementation TodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}
-(void)updateUI{
    [self.tabBarController.navigationItem.rightBarButtonItems[0] setHidden:NO];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _uiSearch.delegate = self;
    [self.tableView reloadData];
    self.allTasks = [NSMutableArray arrayWithArray:[Task readDataWithKey:tasksKey]];
    [self.tabBarController.navigationItem setTitle:@"Todo List"];
}
-(void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.navigationItem.rightBarButtonItems[0] setHidden:NO];
    [self reloadData];
    [self.tabBarController.navigationItem setTitle:@"Todo List"];
}
- (IBAction)addBtnPressed:(id)sender {
    DetailsViewController *detailsVc = [self.storyboard instantiateViewControllerWithIdentifier:DetailsVCSegue];
    [self.navigationController pushViewController:detailsVc animated:YES];
}

- (void)reloadData {
    _allTasks = [NSMutableArray arrayWithArray:[Task readDataWithKey:tasksKey]];
    NSMutableArray *filteredTasks = [NSMutableArray new];
    for (int i=0; i<_allTasks.count; i++) {
        if (_allTasks[i].status == 0) {
            [filteredTasks addObject:_allTasks[i]];
        }
    }
    _allTasks = filteredTasks;
    
    [self.tableView reloadData];
   
    if (_allTasks.count == 0){
        [ self.tableView setHidden:YES];
        [ self.myImg setHidden:NO];
    }else{
        [ self.myImg setHidden:YES];
        [ self.tableView setHidden:NO];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell = [UITableViewCell new];
    Task *task = _allTasks[indexPath.row];
    cell.textLabel.text = task.title;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", task.priority]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailsViewController *detailsVc = [self.storyboard instantiateViewControllerWithIdentifier:DetailsVCSegue];
    detailsVc.task = _allTasks[indexPath.row];
    [self.navigationController pushViewController:detailsVc animated:YES];
 }

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [Task removeTaskByUUID:_allTasks[indexPath.row].uuid fromKey:tasksKey];
        [self reloadData];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.allTasks = [NSMutableArray arrayWithArray:[Task readDataWithKey:tasksKey]];
        [self reloadData];
    } else {
        self.allTasks = [NSMutableArray arrayWithArray:[Task readDataWithKey:tasksKey]];
        NSMutableArray<Task*> *newSearch = [NSMutableArray new];
        for (Task *task in _allTasks) {
            NSRange r = [task.title rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location != NSNotFound) {
                [newSearch addObject:task];
            }
        }
        _allTasks = newSearch;
        [_tableView reloadData];
    }
}

@end
