//
//  AddTaskProtocol.h
//  ToDoList2
//
//  Created by Engy on 7/17/2567 BE.
//

#import <Foundation/Foundation.h>


@protocol AddTaskProtocol <NSObject>
-(void) receiveTask:(NSDictionary *) newTask;
-(void) recieveUpdateTask:(NSDictionary *) updatedTask withID:(NSInteger)Id andSection:(NSInteger)section;
@end


