//
//  DetailsViewController.m
//  ToDoList2
//
//  Created by Engy on 7/17/2024.
#import "TodoViewController.h"
#import "TaskManager.h"
#import "DetailsViewController.h"

@interface TodoViewController () 
@property (weak, nonatomic) IBOutlet UISearchBar *uiSearch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<Task *> *userArray;

@end

@implementation TodoViewController
- (void)viewDidAppear:(BOOL)animated{
    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.userArray = [[[TaskManager sharedManager] tasks] mutableCopy]; // Fetch tasks from TaskManager

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"TaskManagerDidUpdate" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

- (IBAction)addBtnPressed:(id)sender {
    DetailsViewController *detailsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
//
//
//    //detailsVc.taskIndex = NSNotFound;
      [self.navigationController pushViewController:detailsVc animated:YES];

}

- (void)reloadData {
    self.userArray = [[[TaskManager sharedManager] tasks] mutableCopy]; // Reload tasks from TaskManager
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1" forIndexPath:indexPath];
    Task *task = self.userArray[indexPath.row];
    cell.textLabel.text = task.name; // Display task name (adjust as per your Task model)
    cell.imageView.image = [self imageForPriority:task.priority]; // Display image based on task priority
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailsViewController *detailsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    detailsVc.task = self.userArray[indexPath.row]; // Pass selected task to DetailsViewController
    detailsVc.taskIndex = indexPath.row; // Pass index of selected task
    [self.navigationController pushViewController:detailsVc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[TaskManager sharedManager] removeTaskAtIndex:indexPath.row]; // Remove task from TaskManager
        [self.userArray removeObjectAtIndex:indexPath.row]; // Remove task from userArray
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.userArray = [[[TaskManager sharedManager] tasks] mutableCopy]; // Reset to all tasks
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText]; // Adjust 'name' to match your Task model
        self.userArray = [[[[TaskManager sharedManager] tasks] filteredArrayUsingPredicate:predicate] mutableCopy]; // Filter tasks
    }
    [self.tableView reloadData]; // Reload table view with filtered tasks
}

#pragma mark - Helper Methods

- (UIImage *)imageForPriority:(Priority)priority {
    switch (priority) {
        case PriorityHigh:
            return [UIImage imageNamed:@"high_priority_image"];
        case PriorityMedium:
            return [UIImage imageNamed:@"medium_priority_image"];
        case PriorityLow:
            return [UIImage imageNamed:@"low_priority_image"];
        default:
            return nil;
    }
}

@end
