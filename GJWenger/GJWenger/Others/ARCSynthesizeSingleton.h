
/*!
 @header ARCSynthesizeSingleton.h
 @abstract ARC下 单例宏
 */

#ifndef ARC_SYNTHESIZE_SINGLETON_FOR_CLASS

#pragma mark -
#pragma mark Singleton

/*!
   MyClass.h:
   ========================================
  	#import "ARCSynthesizeSingleton.h"
 
 	@interface MyClass: SomeSuperclass
 	{
 		...
 	}
 	ARC_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(MyClass);
 
 	@end
   ========================================
 
 
 	MyClass.m:
   ========================================
 	#import "MyClass.h"
 
 	@implementation MyClass
 
 	ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(MyClass);
 
 	...
 
 	@end
   ========================================
 */


#define ARC_SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(className) \
\
+ (className *)shared##className;


#define ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#endif