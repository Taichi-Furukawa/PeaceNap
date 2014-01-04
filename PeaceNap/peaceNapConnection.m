//
//  peaceNapConnection.m
//  PeaceNap
//
//  Created by furukawa on 2013/05/12.
//  Copyright (c) 2013年 古川 泰地. All rights reserved.
//

#import "peaceNapConnection.h"

@implementation peaceNapConnection
@synthesize deleagte,connect,request,error,responceData,responceString;

- (id)init
{
    self =  [super init];
    if(self) {
        connect=[[NSURLConnection alloc]init];
        request=[[NSMutableURLRequest alloc]init];
    }
    return self;
}

+ (id)instance
{
    static id _instance = nil;
    @synchronized(self) {
        if(!_instance) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

-(void)stillSleep:(NSArray*)friend_list{
    NSString *Str=[NSString stringWithFormat:@"action=still"];
    for (NSString *adst in friend_list) {
        NSString *addStr=[[NSString alloc]initWithFormat:@"&friends[]=%@",adst];
        Str=[Str stringByAppendingString:addStr];
    }
    NSLog(@"lasstr=%@",Str);
    
    NSMutableURLRequest *friendReq=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://peacenap.sp2lc.salesio-sp.ac.jp/main.php"]];
    
    
    NSHTTPCookie *aCookie = [self getpeacenapCookie];
    NSArray *cookies = [NSArray arrayWithObjects:aCookie, nil];
    NSDictionary *header = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    
    [friendReq setAllHTTPHeaderFields:header];
    friendReq.HTTPMethod=@"POST";
    friendReq.HTTPBody=[Str dataUsingEncoding:NSUTF8StringEncoding];
    NSURLConnection *friendconn=[[NSURLConnection alloc]initWithRequest:friendReq delegate:self];
    if (!friendconn) {
        NSLog(@"connection err");
        
    }

    
}

-(void)send_DeviceToken:(NSString*)devicetoken{
    NSLog(@"gettoken=%@",devicetoken);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableURLRequest *tokenReq=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://peacenap.sp2lc.salesio-sp.ac.jp/main.php"]];
    NSString *Str=[NSString stringWithFormat:@"action=send_token&dev_token=%@",devicetoken];
    NSHTTPCookie *aCookie = [self getpeacenapCookie];
    NSArray *cookies = [NSArray arrayWithObjects:aCookie, nil];
    NSDictionary *header = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    [tokenReq setAllHTTPHeaderFields:header];
    tokenReq.HTTPMethod=@"POST";
    tokenReq.HTTPBody=[Str dataUsingEncoding:NSUTF8StringEncoding];
    connect=[[NSURLConnection alloc]initWithRequest:tokenReq delegate:self];
}

-(void)accountLogin:(NSString*)user_name password:(NSString*)user_pass{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *loginStr=[NSString stringWithFormat:@"disposal=login&ID=%@&PASS=%@&",user_name,[user_pass MD5String]];
    NSURL *url=[NSURL URLWithString:@"http://peacenap.sp2lc.salesio-sp.ac.jp/login.php/"];
    request=[[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPShouldHandleCookies:YES];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(void)createAccount:(NSString*)user_name password:(NSString*)user_pass phoneNumber:(NSString*)user_phone{
    int idlength=[user_name length];
    int passlength=[user_pass length];
    int phonelength=[user_phone length];
    
    if ( 4 <= idlength && 8 <= passlength && 5<=phonelength) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSString *hashData=[[NSString alloc]init];
        hashData=[NSString stringWithFormat:@"disposal=create&ID=%@&PASS=%@&PHONE=%@",user_name,[user_pass MD5String],user_phone];
        NSURL *url=[NSURL URLWithString:@"http://peacenap.sp2lc.salesio-sp.ac.jp/login.php"];
        request=[[NSMutableURLRequest alloc]initWithURL:url];
        request.HTTPMethod=@"POST";
        request.HTTPBody=[hashData dataUsingEncoding:NSUTF8StringEncoding];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"error！"
                                  message:@"IDは４文字以上、PASSは８文字以上に設定して下さい" delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil
                                  ];
        [alertView show];
    }
}

-(void)getFriend:(NSString*)friend_name{
    request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://peacenap.sp2lc.salesio-sp.ac.jp/main.php"]];
    NSString *Str=[NSString stringWithFormat:@"action=getfriend&friend_ID=%@",friend_name];
    
    NSHTTPCookie *aCookie = [self getpeacenapCookie];
    NSArray *cookies = [NSArray arrayWithObjects:aCookie, nil];
    NSDictionary *header = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    
    [request setAllHTTPHeaderFields:header];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[Str dataUsingEncoding:NSUTF8StringEncoding];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (!connect) {
        NSLog(@"connection err");
    }
    
}

-(void)sessionCheck{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://peacenap.sp2lc.salesio-sp.ac.jp/main.php"]];
    NSHTTPCookie *aCookie = [self getpeacenapCookie];
    NSArray *cookies = [NSArray arrayWithObjects:aCookie, nil];
    NSDictionary *header = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    [request setAllHTTPHeaderFields:header];
    request.HTTPMethod=@"POST";
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(void)logOut{
    NSUserDefaults *user_def = [NSUserDefaults standardUserDefaults];
    [user_def setBool:NO forKey:@"LoginState"];
    
    request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://peacenap.sp2lc.salesio-sp.ac.jp/main.php"]];
    NSString *Str=[NSString stringWithFormat:@"action=logout"];
    NSHTTPCookie *aCookie = [self getpeacenapCookie];
    NSArray *cook = [NSArray arrayWithObjects:aCookie, nil];
    NSDictionary *header = [NSHTTPCookie requestHeaderFieldsWithCookies:cook];
    [request setAllHTTPHeaderFields:header];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[Str dataUsingEncoding:NSUTF8StringEncoding];
    connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (!connect) {
        NSLog(@"connection err");
    }
    
    //クッキー削除
    NSHTTPCookieStorage *aStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [aStorage cookies];
    
    //特定のドメイン(xxxx.ne.jp)のクッキーを全て削除
    for (NSHTTPCookie *aCookie in cookies) {
        NSDictionary *prop = [aCookie properties];
        NSString *cookieDomain = [prop objectForKey:NSHTTPCookieDomain];
        if (cookieDomain && [cookieDomain isEqualToString:@"peacenap.sp2lc.salesio-sp.ac.jp"]) {
            
            //無効なクッキーへ入れ替え。(deleteCookieのみだとキャッシュが残るため)
            //[prop setValue:@"" forKey:NSHTTPCookieValue];
            //追記：過去の時間を設定しクッキーを無効に
            [prop setValue:[NSDate dateWithTimeIntervalSinceNow:-3600]         forKey:NSHTTPCookieExpires];
            NSHTTPCookie *newCookie = [[NSHTTPCookie alloc] initWithProperties:prop];
            [aStorage deleteCookie:aCookie];
            [aStorage setCookie:newCookie];
        }
    }
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

-(void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)res{

    
}

-(void)connection:( NSURLConnection *) connection didReceiveData:( NSData *) resdata{
    responceString = [[NSString alloc] initWithData:resdata encoding:NSUTF8StringEncoding];
    NSLog(@"res=%@",responceString);
    
    if ([responceString isEqualToString:@"notlogin"]==YES) {
        NSUserDefaults *user_date=[[NSUserDefaults alloc]init];
        [self accountLogin:[user_date stringForKey:@"user_id"] password:[user_date stringForKey:@"user_pass"]];
    }
    [deleagte ReceiveData:responceString];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"サーバーと接続できません"message:@"接続を確立して下さい" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
    [alertView show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(NSHTTPCookie *)getpeacenapCookie{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        if ([cookie.domain isEqualToString: @"peacenap.sp2lc.salesio-sp.ac.jp" ]) {
            NSLog(@"getcookie:%@ %@,%@",cookie.name,cookie.domain,cookie.value);
            return cookie;
        }
    }
    return nil;
}

- (void)setCookie:(NSString *)value forKey:(NSString *)key domain:(NSString *)domain cookiePath:(NSString *)path expires:(NSString *)expires {
    //クッキーを作成
    NSDictionary *properties = [[NSMutableDictionary alloc] init];
    [properties setValue:[value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                  forKey:NSHTTPCookieValue];
    [properties setValue:key forKey:NSHTTPCookieName];
    [properties setValue:domain forKey:NSHTTPCookieDomain];
    [properties setValue:expires forKey:NSHTTPCookieExpires];
    [properties setValue:path forKey:NSHTTPCookiePath];
    NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
    
    //共通クッキーストレージを取得してセット
    NSHTTPCookieStorage *aStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [aStorage setCookie:cookie];
}


@end
