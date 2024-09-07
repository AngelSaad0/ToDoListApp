//
//  TaskManager.h
//  ToDoList2
//
//  Created by Engy on 7/17/2567 BE.
//
// TaskManager.h
#import <Foundation/Foundation.h>
#import "Task.h"

@interface TaskManager : NSObject

+ (instancetype)sharedManager;

- (NSArray<Task *> *)loadTasks;
- (void)saveTasks;
- (void)addTask:(Task *)task;
- (void)removeTaskAtIndex:(NSUInteger)index;
- (void)updateTask:(Task *)task atIndex:(NSUInteger)index;

@end
