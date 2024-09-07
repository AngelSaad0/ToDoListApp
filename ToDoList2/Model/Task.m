//
//  Task.m
//  ToDoList2
//
//  Created by Engy on 7/17/2024.
//
#import "Task.h"

@implementation Task

- (instancetype)initWithName:(NSString *)name description:(NSString *)description priority:(Priority)priority {
    self = [super init];
    if (self) {
        _taskID = [NSUUID UUID];
        _name = name;
        _taskDescription = description;
        _priority = priority;
        _dateCreated = [NSDate date];
        _status = TaskStatusTodo; // Default status
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.taskID forKey:@"taskID"];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.taskDescription forKey:@"taskDescription"];
    [coder encodeInteger:self.priority forKey:@"priority"];
    [coder encodeObject:self.dateCreated forKey:@"dateCreated"];
    [coder encodeInteger:self.status forKey:@"status"];
    [coder encodeObject:self.reminder forKey:@"reminder"];
    [coder encodeObject:self.attachedFile forKey:@"attachedFile"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _taskID = [coder decodeObjectForKey:@"taskID"];
        _name = [coder decodeObjectForKey:@"name"];
        _taskDescription = [coder decodeObjectForKey:@"taskDescription"];
        _priority = [coder decodeIntegerForKey:@"priority"];
        _dateCreated = [coder decodeObjectForKey:@"dateCreated"];
        _status = [coder decodeIntegerForKey:@"status"];
        _reminder = [coder decodeObjectForKey:@"reminder"];
        _attachedFile = [coder decodeObjectForKey:@"attachedFile"];
    }
    return self;
}

@end
