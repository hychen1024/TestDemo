//
//  NSSafeMutableArray.m
//  TestDemo
//
//  Created by huyuchen on 2018/9/13.
//  Copyright © 2018年 Hyc. All rights reserved.
//

#import "NSSafeMutableArray.h"

@interface NSSafeMutableArray ()
{
    CFMutableArrayRef _array;
}
@property (nonatomic, strong) dispatch_queue_t syncQueue;
@end

@implementation NSSafeMutableArray

/*
 下面方法必须重写
 - (void)addObject:(id)anObject;
 - (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
 - (void)removeLastObject;
 - (void)removeObjectAtIndex:(NSUInteger)index;
 - (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
 
 - (NSUInteger)count;
 - (id)objectAtIndex:(NSUInteger)index;
 */

- (id)init {
    return [self initWithCapacity:0];
}

- (id)initWithCapacity:(NSUInteger)numItems {
    self = [super init];
    if (self) {
        _array = CFArrayCreateMutable(kCFAllocatorDefault, numItems, &kCFTypeArrayCallBacks);
    }
    return self;
}

- (NSUInteger)count {
    __block NSUInteger result;
    dispatch_sync(self.syncQueue, ^{
        result = CFArrayGetCount(_array);
    });
    return result;
}

- (id)objectAtIndex:(NSUInteger)index {
    __block id result = nil;
    dispatch_sync(self.syncQueue, ^{
        NSUInteger count = CFArrayGetCount(_array);
        result = index < count ? CFArrayGetValueAtIndex(_array, index) : nil;
    });
    return result;
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    __block NSUInteger blockIndex = index;
    dispatch_barrier_async(self.syncQueue, ^{
        if (!anObject) {
            return;
        }
        
        NSUInteger count = CFArrayGetCount(_array);
        if (blockIndex > count) {
            blockIndex = count;
        }
        CFArrayInsertValueAtIndex(_array, anObject, blockIndex);
    });
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    dispatch_barrier_async(self.syncQueue, ^{
        NSUInteger count = CFArrayGetCount(_array);
        if (index < count) {
            CFArrayRemoveValueAtIndex(_array, index);
        }
    });
}

- (void)addObject:(id)anObject {
    dispatch_barrier_async(self.syncQueue, ^{
        if (!anObject) {
            return;
        }
        CFArrayAppendValue(_array, (__bridge const void *)(anObject));
    });
}

- (void)removeLastObject {
    dispatch_barrier_async(self.syncQueue, ^{
        NSUInteger count = CFArrayGetCount(_array);
        if (count > 0) {
            CFArrayRemoveValueAtIndex(_array, count-1);
        }
    });
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    dispatch_barrier_async(self.syncQueue, ^{
        if (!anObject) {
            return;
        }
        NSUInteger count = CFArrayGetCount(_array);
        if (index < count) {
            CFArraySetValueAtIndex(_array, index, (__bridge const void*)anObject);
        }
    });
}

- (void)removeAllObjects {
    dispatch_barrier_async(self.syncQueue, ^{
        CFArrayRemoveAllValues(_array);
    });
}

- (NSUInteger)indexOfObject:(id)anObject {
    if (!anObject) {
        return NSNotFound;
    }
    __block NSUInteger result;
    dispatch_sync(self.syncQueue, ^{
        NSUInteger count = CFArrayGetCount(_array);
        result = CFArrayGetFirstIndexOfValue(_array, CFRangeMake(0, count), (__bridge const void*)anObject);
    });
    return result;
}

- (void)removeObject:(id)anObject {
    dispatch_barrier_async(self.syncQueue, ^{
        NSUInteger index = [self indexOfObject:anObject];
        if (index != NSNotFound) {
            CFArrayRemoveValueAtIndex(_array, index);
        }
    });
}

- (dispatch_queue_t)syncQueue {
    static dispatch_queue_t queue = nil;
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("ArraySyncQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}
@end
