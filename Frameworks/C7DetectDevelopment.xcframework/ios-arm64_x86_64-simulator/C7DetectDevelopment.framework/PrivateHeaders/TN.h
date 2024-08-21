#import <Foundation/Foundation.h>

#ifndef C7D_TN_h
#define C7D_TN_h

#ifndef CHECK_AND_CRASH_CLASS_METHOD_SWIZZLING
#define CHECK_AND_CRASH_CLASS_METHOD_SWIZZLING(className, methodSelector) \
    do { \
        Method currentMethod = class_getClassMethod([className class], methodSelector); \
        IMP currentIMP = method_getImplementation(currentMethod); \
        if ([className vector] != currentIMP) { \
            @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                           reason:[SH d:OFUSCATED_C7DETECTMANAGER_RUNTIME_INTEGRITY] \
                                         userInfo:nil]; \
        } \
    } while (0)
#endif

#ifndef CHECK_AND_CRASH_INSTANCE_METHOD_SWIZZLING
#define CHECK_AND_CRASH_INSTANCE_METHOD_SWIZZLING(className, methodSelector) \
    do { \
        Method currentMethod = class_getInstanceMethod([className class], methodSelector); \
        IMP currentIMP = method_getImplementation(currentMethod); \
        if ([className vector] != currentIMP) { \
            @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                           reason:[SH d:OFUSCATED_C7DETECTMANAGER_RUNTIME_INTEGRITY] \
                                         userInfo:nil]; \
        } \
    } while (0)
#endif

/*
 @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                reason:[SH d:OFUSCATED_C7DETECTMANAGER_RUNTIME_INTEGRITY] \
                             userInfo:nil]; \
 */

@interface TN : NSObject

+ (void)on:(NSString *)threatName with:(NSDictionary *)userInfo;
+ (IMP)vector;

@end

#endif
