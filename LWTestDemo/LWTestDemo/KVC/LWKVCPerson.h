//
//  LWKVCPerson.h
//  LWTestDemo
//
//  Created by linwei on 2021/3/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWKVCPerson : NSObject{
@public NSString *_key;
@public NSString *key;
@public NSString *_isKey;
@public NSString *isKey;

}
@property(nonatomic,copy)NSString *isKey;
//@property(nonatomic,copy)NSString *key;

@end

NS_ASSUME_NONNULL_END
