#import "Task.h"
#import "Static.h"

@implementation Task

- (void)encodeWithCoder:(nonnull NSCoder *)encoder {
    [encoder encodeObject:_title forKey:title];
    [encoder encodeObject:_date forKey:date];
    [encoder encodeObject:_descriptionT forKey:descriptionT];
    [encoder encodeInt:_priority forKey:priority];
    [encoder encodeInt:_status forKey:status];
    [encoder encodeObject:_uuid forKey:uuidKey];
}


- (id)initWithCoder:(NSCoder *)decoder {
    if ((self = [super init])) {
        _title = [decoder decodeObjectOfClass:[NSString class] forKey:title];
        _date = [decoder decodeObjectOfClass:[NSDate class] forKey:date];
        _descriptionT = [decoder decodeObjectOfClass:[NSString class] forKey:descriptionT];
        _priority = [decoder decodeIntForKey:priority];
        _status = [decoder decodeIntForKey:status];
        _uuid = [decoder decodeObjectOfClass:[NSUUID class] forKey:uuidKey];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

+(void) saveDataWithKey: (NSString *)key withArray: (NSMutableArray *)data {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSError *error;
    NSDate *archiveData = [NSKeyedArchiver archivedDataWithRootObject:data requiringSecureCoding:YES error:&error];
        
    if (error) {
           NSLog(@"Error archiving data: %@", error.localizedDescription);
       } else {
           [defaults setObject:archiveData forKey:key];
           [defaults synchronize];
       }

}

+(NSArray<Task*> *) readDataWithKey: (NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSError *error;
    NSDate *savedData = [defaults objectForKey:key];
    
    if (!savedData) {
        NSLog(@"No data found for key: %@", key);
        return [NSArray<Task*> new];
    }

    NSSet *set = [NSSet setWithArray:@[
        [NSArray class],
        [Task class],
    ]];
    
    NSArray<Task*> *TaskArray = (NSArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:savedData error:&error];
    
    if (error) {
        NSLog(@"Error unarchiving data: %@", error.localizedDescription);
        return [NSArray<Task*> new];
    }

    return TaskArray;
}

+ (void)clearDataWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

+ (void)removeTaskAtIndex:(NSUInteger)index fromKey:(NSString *)key {
    NSMutableArray *TaskArray = [[NSMutableArray alloc] initWithArray:[Task readDataWithKey:key]];

    if (TaskArray && index < TaskArray.count) {
        [TaskArray removeObjectAtIndex:index];
        
        [Task saveDataWithKey: key withArray:TaskArray];
    }
}

+ (void)removeTaskByUUID:(NSUUID*)uuid fromKey:(NSString *)key {
    NSMutableArray<Task*> *TaskArray = [[NSMutableArray alloc] initWithArray:[Task readDataWithKey:key]];

    for (int i=0; i<TaskArray.count; i++) {
        if ([uuid isEqual:TaskArray[i].uuid]) {
            [TaskArray removeObjectAtIndex:i];
            
            [Task saveDataWithKey: key withArray:TaskArray];
            break;;
        }
    }
    
}

@end
