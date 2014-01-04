//
//  NSString+MD5.m
//  PeaceNap
//
//  Created by furukawa on 2013/04/25.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

//  NSString+MD5.m

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h> // for CC_MD5

@implementation NSString (MD5)
- (NSString *) MD5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}
@end