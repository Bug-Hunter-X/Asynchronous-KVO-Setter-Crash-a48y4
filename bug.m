In Objective-C, a subtle bug can occur when using KVO (Key-Value Observing) with custom setter methods that perform asynchronous operations.  If the asynchronous operation completes after the observer has already been removed, a crash can result. This is because the observer's dealloc method might have already been called, leading to attempts to access deallocated memory.  Example:

```objectivec
@interface MyClass : NSObject
@property (nonatomic, strong) NSString *myString;
@end

@implementation MyClass
- (void)setMyString:(NSString *)newString {
    _myString = newString;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
        // Simulate an asynchronous operation
        [NSThread sleepForTimeInterval:1];
        NSLog(@