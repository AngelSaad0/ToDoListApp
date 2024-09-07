//
//  TaskManager.h
//  ToDoList2
//
//  Created by Engy on 7/17/2024.
//
// TaskManager.h


#import <Foundation/Foundation.h>
#import "Task.h"
@interface TaskManager : NSObject

@property (nonatomic, strong, readonly) NSArray<Task *> *tasks; // Use NSArray for external access

+ (instancetype)sharedManager;
- (void)addTask:(Task *)task;
- (void)removeTaskAtIndex:(NSUInteger)index;
- (void)updateTaskAtIndex:(NSUInteger)index withTask:(Task *)task;

@end


