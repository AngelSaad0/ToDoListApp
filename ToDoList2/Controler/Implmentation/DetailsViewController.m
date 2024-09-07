//
//  DetailsViewController.m
//  ToDoList2
//
//  Created by Engy on 7/17/2024.
#import "DetailsViewController.h"
#import "TaskManager.h"

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
    if (self.task) {
        self.titleLabel.text = self.task.name;
        self.descriptionLabel.text = self.task.taskDescription;
        self.prioritySegmentedControl.selectedSegmentIndex = self.task.priority;
        self.statusSegmentedControl.selectedSegmentIndex = self.task.status;
        self.reminderDatePicker.date = self.task.reminder ? self.task.reminder : [NSDate date];
    }
}

- (IBAction)saveButtonPressed:(id)sender {
    if (!self.task) {
        self.task = [[Task alloc] initWithName:@"" description:@"" priority:PriorityLow];
    }
    self.task.name = self.titleLabel.text;
    self.task.taskDescription = self.descriptionLabel.text;
    self.task.priority = self.prioritySegmentedControl.selectedSegmentIndex;
    self.task.status = self.statusSegmentedControl.selectedSegmentIndex;
    self.task.reminder = self.reminderDatePicker.date;

    TaskManager *taskManager = [TaskManager sharedManager];
    if (self.taskIndex != NSNotFound) {
        [taskManager updateTaskAtIndex:self.taskIndex withTask:self.task];
    } else {
        [taskManager addTask:self.task];
    }

    [self.navigationController popViewControllerAnimated:YES];
}

@end
