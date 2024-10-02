//
//  TaskManager.m
//  ToDoList2
//
//  Created by Engy on 7/17/2567 BE.
//

#import "TaskManager.h"
#import "Static.h"

@interface TaskManager ()

@property (nonatomic, strong) NSMutableArray<Task *> *mutableTasks; // Use NSMutableArray internally

@end

@implementation TaskManager

+ (instancetype)sharedManager {
    static TaskManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadTasks];
    }
    return self;
}

- (NSArray<Task *> *)tasks {
    return [self.mutableTasks copy]; // Return immutable copy to ensure external immutability
}

- (void)loadTasks {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:tasksKey];
    if (data) {
        NSArray *savedTasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        self.mutableTasks = [NSMutableArray arrayWithArray:savedTasks];
    } else {
        self.mutableTasks = [NSMutableArray array];
    }
}

- (void)saveTasks {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.mutableTasks];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:tasksKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)addTask:(Task *)task {
    [self.mutableTasks addObject:task];
    [self saveTasks];
}

- (void)removeTaskAtIndex:(NSUInteger)index {
    [self.mutableTasks removeObjectAtIndex:index];
    [self saveTasks];
}

- (void)updateTaskAtIndex:(NSUInteger)index withTask:(Task *)task {
    if (index < self.mutableTasks.count) {
        self.mutableTasks[index] = task;
        [self saveTasks];
    }
}

@end
