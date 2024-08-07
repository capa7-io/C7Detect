#import <Foundation/Foundation.h>

#ifndef C7D_TN_h
#define C7D_TN_h

#ifndef CHECK_AND_REVERT_METHOD_SWIZZLING
#define CHECK_AND_REVERT_METHOD_SWIZZLING(className, methodSelector) \
    do { \
        Method currentMethod = class_getClassMethod([className class], methodSelector); \
        IMP currentIMP = method_getImplementation(currentMethod); \
        if ([className vector] != currentIMP) { \
            method_setImplementation(currentMethod, [className vector]); \
            [TN on:[SH d:OFUSCATED_C7DETECTMANAGER_RUNTIME_INTEGRITY] with:@{ @"c": [[className class] description] }]; \
        } \
    } while (0)
#endif

@interface TN : NSObject

+ (void)on:(NSString *)threatName with:(NSDictionary *)userInfo;
+ (IMP)vector;

@end

#endif
