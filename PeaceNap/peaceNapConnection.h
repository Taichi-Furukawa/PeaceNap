//
//  peaceNapConnection.h
//  PeaceNap
//
//  Created by furukawa on 2013/05/12.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+MD5.h"

@class peaceNapConnection;

@protocol NapDelegate <NSObject>
@optional
//-(void)connection:( NSURLConnection *) connection didReceiveData:( NSData *) resdata;
-(void)ReceiveData:(NSString*)responce;
@end

@interface peaceNapConnection : NSData{
    id <NapDelegate> delegate;
}

+(id)instance;
-(void)send_DeviceToken:(NSString*)devicetoken;
-(void)accountLogin:(NSString*)user_name password:(NSString*)user_pass;
-(void)createAccount:(NSString*)user_name password:(NSString*)user_pass phoneNumber:(NSString*)user_phone;
-(void)sessionCheck;
-(void)logOut;
-(void)setCookie:(NSString *)value forKey:(NSString *)key domain:(NSString *)domain cookiePath:(NSString *)path expires:(NSString *)expires ;
-(void)getFriend:(NSString*)friend_name;
-(void)stillSleep:(NSArray*)friend_list;

@property(assign,nonatomic) id <NapDelegate> deleagte;
@property(retain,nonatomic)NSURLConnection *connect;
@property(retain,nonatomic)NSMutableURLRequest *request;
@property(retain,nonatomic)NSError *error;
@property(retain,nonatomic)NSData *responceData;
@property(retain,nonatomic)NSString *responceString;
@end
