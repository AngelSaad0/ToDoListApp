//
//  DetailsViewController.m
//  ToDoList2
//
//  Created by Engy on 7/17/2567 BE.
#import "DetailsViewController.h"
#import "Task.h"
#import "Static.h"

@interface DetailsViewController ()
@property (strong, nonatomic) IBOutlet UITextField *titleLabel;
@property (strong, nonatomic) IBOutlet UITextField *descriptionLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *prioritySegmentedControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *statusSegmentedControl;
@property (strong, nonatomic) IBOutlet UIDatePicker *reminderDatePicker;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation DetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
   }


- (void)setupUI {
    if (_task){
        _titleLabel.text =_task.title;
        _descriptionLabel.text = _task.descriptionT;
        [_prioritySegmentedControl setSelectedSegmentIndex:_task.priority];
        [_statusSegmentedControl setSelectedSegmentIndex:_task.status];
        [_reminderDatePicker setDate: _task.date];

        [_saveButton setTitle:Edit forState:UIControlStateNormal];

        if (_task.status == 1) {
            [_statusSegmentedControl setEnabled:NO forSegmentAtIndex:0];
        } else if (_task.status == 2) {
            [_statusSegmentedControl setEnabled:NO];
            [_descriptionLabel setEnabled:NO];
            [_titleLabel setEnabled:NO];
            [_reminderDatePicker setEnabled:NO];
            [_prioritySegmentedControl setEnabled:NO];
            [_saveButton setHidden:YES];
        }
    } else {
        [_statusSegmentedControl setEnabled:NO forSegmentAtIndex:1];
        [_statusSegmentedControl setEnabled:NO forSegmentAtIndex:2];
        [_saveButton setTitle:Add forState:UIControlStateNormal];
    }
}

- (IBAction)saveButtonPressed:(id)sender {
    if (_task) {
        [self editBtnPressed];
    } else {
        [self addBtnPressed];
    }
}
-(void)editBtnPressed{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:Edit message:sureMassage preferredStyle:UIAlertControllerStyleActionSheet];

        UIAlertAction *action0 = [UIAlertAction actionWithTitle:Edit style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            Task *editedTask = [Task new];
            editedTask.title = self.titleLabel.text;
            editedTask.descriptionT = self.descriptionLabel.text;
            editedTask.priority = (int)self.prioritySegmentedControl.selectedSegmentIndex;
            editedTask.status = (int)self.statusSegmentedControl.selectedSegmentIndex;
            editedTask.date = self.reminderDatePicker.date;
            editedTask.uuid = [NSUUID UUID];
            [Task removeTaskByUUID:self.task.uuid fromKey:tasksKey];
            NSMutableArray<Task*> *tasks = [NSMutableArray arrayWithArray:[Task readDataWithKey:tasksKey]];
            [tasks addObject:editedTask];
            [Task saveDataWithKey:tasksKey withArray:tasks];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action0];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:NULL];
}
-(void)addBtnPressed{
    Task *newTask = [Task new];
    newTask.title = self.titleLabel.text;
    newTask.descriptionT = self.descriptionLabel.text;
    newTask.priority = (int)self.prioritySegmentedControl.selectedSegmentIndex;
    newTask.status = (int)self.statusSegmentedControl.selectedSegmentIndex;
    newTask.date = self.reminderDatePicker.date;
    newTask.uuid = [NSUUID UUID];


    NSMutableArray<Task*> *tasks = [NSMutableArray arrayWithArray:[Task readDataWithKey:tasksKey]];
    [tasks addObject:newTask];
    [Task saveDataWithKey:tasksKey withArray:tasks];


    [self.navigationController popViewControllerAnimated:YES];
}

@end
