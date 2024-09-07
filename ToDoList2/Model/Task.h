//
//  Task.m
//  ToDoList2
//
//  Created by Engy on 7/17/2024.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Priority) {
    PriorityHigh,
    PriorityMedium,
    PriorityLow
};

typedef NS_ENUM(NSInteger, TaskStatus) {
    TaskStatusTodo,
    TaskStatusInProgress,
    TaskStatusDone
};

@interface Task : NSObject <NSCoding>

@property  NSUUID *taskID;
@property NSString *name;
@property NSString *taskDescription;
@property  Priority priority;
@property  NSDate *dateCreated;
@property  TaskStatus status;
@property  NSDate *reminder;
@property  NSURL *attachedFile;

- (instancetype)initWithName:(NSString *)name
                description:(NSString *)description
                   priority:(Priority)priority;

@end
