//
//  DetailsViewController.h
//  ToDoList2
//
//  Created by Engy on 7/17/2024.
//

#import <UIKit/UIKit.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (nonatomic, strong) Task *task; 
@property (nonatomic) NSUInteger taskIndex;

@end

NS_ASSUME_NONNULL_END
