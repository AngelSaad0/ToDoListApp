#import <Foundation/Foundation.h>


@interface Task : NSObject <NSCoding, NSSecureCoding>

@property int priority;
@property int status;
@property NSString *descriptionT;
@property NSString *title;
@property NSDate *date;
@property NSUUID *uuid;


-(void) encodeWithCoder: (NSCoder *)encoder;


+(void) saveDataWithKey: (NSString *)key withArray: (NSArray *)data;

+(NSArray<Task*> *) readDataWithKey: (NSString *)key;

+(void) clearDataWithKey:(NSString *)key;
+(void) removeTaskAtIndex:(NSUInteger)index fromKey:(NSString *)key;
+ (void)removeTaskByUUID:(NSUUID*)uuid fromKey:(NSString *)key;
@end

