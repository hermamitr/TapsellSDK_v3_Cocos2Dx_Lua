#import "TSTapsell.h"


NSMutableDictionary * tapsellAds;

@implementation TSTapsell

+(NSString*) createJSON:(NSArray*)keys withValues:(NSArray*)values {
    NSString* result = @"{";
    for(int i = 0; i < [keys count]; i++) {
        result = [result stringByAppendingString:@"\""];
        result = [result stringByAppendingString:keys[i]];
        result = [result stringByAppendingString:@"\""];
        result = [result stringByAppendingString:@":"];
        result = [result stringByAppendingString:@"\""];
        result = [result stringByAppendingString:values[i]];
        result = [result stringByAppendingString:@"\""];
        result = [result stringByAppendingString:@","];
    }
    result = [result substringToIndex:[result length]-1];
    result = [result stringByAppendingString:@"}"];
    return result;
}

+(void)initialize:(NSDictionary *)dict {
    NSString* appKey = [dict objectForKey:@"appKey"];
    if(!appKey) {
        NSLog(@"No appkey passed for Tapsell:initialize");
        return;
    }
    [Tapsell initializeWithAppKey:appKey];
    tapsellAds = [[NSMutableDictionary alloc] init];
}

+(void)requestAd:(NSDictionary *)dict {
    TSAdRequestOptions* requestOptions = [[TSAdRequestOptions alloc] init];
    NSNumber* cacheType = [dict objectForKey:@"cacheType"];
    if(!cacheType) {
        NSLog(@"No cacheType passed for Tapsell:requestAd");
        return;
    }
    [requestOptions setCacheType:(CacheType)[cacheType integerValue]];
    
    NSString* zoneId = [dict objectForKey:@"zoneId"];
    if(!zoneId) {
        NSLog(@"No zoneid passed for Tapsell:requestAd");
        return;
    }
    [Tapsell requestAdForZone:zoneId
                   andOptions:requestOptions
                onAdAvailable:^(TapsellAd *ad){
                    [tapsellAds setObject:ad forKey:ad.getId];
                    NSNumber* onAdAvailable = [dict objectForKey:@"onAdAvailable"];
                    if(!onAdAvailable) {
                        NSLog(@"No onAdAvailable passed for Tapsell:requestAd");
                        return;
                    }
                    cocos2d::LuaBridge::pushLuaFunctionById([onAdAvailable intValue]);
                    cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
                    std::string adIdC = std::string([[ad getId] UTF8String]);
                    stack->pushString(adIdC.c_str());
                    stack->executeFunction(1);
                }
              onNoAdAvailable:^{
                  NSNumber* onNoAdAvailable = [dict objectForKey:@"onNoAdAvailable"];
                  if(!onNoAdAvailable) {
                      NSLog(@"No onNoAdAvailable passed for Tapsell:requestAd");
                      return;
                  }
                  cocos2d::LuaBridge::pushLuaFunctionById([onNoAdAvailable intValue]);
                  cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
                  stack->executeFunction(0);
              }
                      onError:^(NSString* error){
                          NSNumber* onError = [dict objectForKey:@"onError"];
                          if(!onError) {
                              NSLog(@"No onError passed for Tapsell:requestAd");
                              return;
                          }
                          cocos2d::LuaBridge::pushLuaFunctionById([onError intValue]);
                          cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
                          std::string errorC = std::string([error UTF8String]);
                          stack->pushString(errorC.c_str());
                          stack->executeFunction(1);
                      }
                   onExpiring:^(TapsellAd* ad){
                       NSNumber* onExpiring = [dict objectForKey:@"onExpiring"];
                       if(!onExpiring) {
                           NSLog(@"No onExpiring passed for Tapsell:requestAd");
                           return;
                       }
                       cocos2d::LuaBridge::pushLuaFunctionById([onExpiring intValue]);
                       cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
                       std::string adIdC = std::string([[ad getId] UTF8String]);
                       stack->pushString(adIdC.c_str());
                       stack->executeFunction(1);
                   }];
}

+(void)showAd:(NSDictionary *)dict {
    TSAdShowOptions* showOptions = [[TSAdShowOptions alloc] init];
    NSNumber* rotationMode = [dict objectForKey:@"rotationMode"];
    if(!rotationMode) {
        NSLog(@"No rotationMode passed for Tapsell:showAd");
        return;
    }
    [showOptions setOrientation:(Orientation)[rotationMode integerValue]];
    NSNumber* backDisabled = [dict objectForKey:@"backDisabled"];
    if(!backDisabled) {
        NSLog(@"No backDisabled passed for Tapsell:showAd");
        return;
    }
    [showOptions setBackDisabled:backDisabled];
    NSNumber* showExitDialog = [dict objectForKey:@"showExitDialog"];
    if(!showExitDialog) {
        NSLog(@"No showExitDialog passed for Tapsell:showAd");
        return;
    }
    [showOptions setShowDialoge:showExitDialog];
    
    
    NSString* adId = [dict objectForKey:@"adId"];
    if(!adId) {
        NSLog(@"No adId passed for Tapsell:showAd");
        return;
    }
    TapsellAd* ad = tapsellAds[adId];
    [ad showWithOptions:showOptions
      andOpenedCallback:^(TapsellAd * _Nullable ad){
          NSNumber* onOpened = [dict objectForKey:@"onOpened"];
          if(!onOpened) {
              NSLog(@"No onOpened passed for Tapsell:showAd");
              return;
          }
          cocos2d::LuaBridge::pushLuaFunctionById([onOpened intValue]);
          cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
          std::string adIdC = std::string([[ad getId] UTF8String]);
          stack->pushString(adIdC.c_str());
          stack->executeFunction(1);
      }
      andClosedCallback:^(TapsellAd * _Nullable ad){
          NSNumber* onClosed = [dict objectForKey:@"onClosed"];
          if(!onClosed) {
              NSLog(@"No onClosed passed for Tapsell:showAd");
              return;
          }
          cocos2d::LuaBridge::pushLuaFunctionById([onClosed intValue]);
          cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
          std::string adIdC = std::string([[ad getId] UTF8String]);
          stack->pushString(adIdC.c_str());
          stack->executeFunction(1);
      }];
}

+(void)requestNativeBannerAd:(NSDictionary *)dict {
    NSString* zoneId = [dict objectForKey:@"zoneId"];
    [Tapsell requestNativeBannerAdForZone:zoneId
                            onAdAvailable:^(TSNativeBannerAdWrapper* ad) {
                                if(ad != nil) {
                                    NSNumber* onAdAvailable = [dict objectForKey:@"onAdAvailable"];
                                    if(!onAdAvailable) {
                                        NSLog(@"No onAdAvailable passed for Tapsell:requestNativeBannerAd");
                                        return;
                                    }
                                    NSString* adProps = [self createJSON:@[@"ad_id",@"title",@"description",@"call_to_action_text",@"icon_url",@"portrait_static_image_url",@"landscape_static_image_url"] withValues:@[ad.adId, ad.title, ad.htmlDescription, ad.callToActionText, ad.logoUrl, ad.portriatImageUrl, ad.landscapeImageUrl]];
                                    cocos2d::LuaBridge::pushLuaFunctionById([onAdAvailable intValue]);
                                    cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
                                    std::string adPropsC = std::string([adProps UTF8String]);
                                    stack->pushString(adPropsC.c_str());
                                    stack->executeFunction(1);
                                }
                            }
                          onNoAdAvailable:^(void) {
                              NSNumber* onNoAdAvailable = [dict objectForKey:@"onNoAdAvailable"];
                              if(!onNoAdAvailable) {
                                  NSLog(@"No onNoAdAvailable passed for Tapsell:requestNativeBannerAd");
                                  return;
                              }
                              cocos2d::LuaBridge::pushLuaFunctionById([onNoAdAvailable intValue]);
                              cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
                              stack->executeFunction(0);
                          }
                                  onError:^(NSString* error) {
                                      NSNumber* onError = [dict objectForKey:@"onError"];
                                      if(!onError) {
                                          NSLog(@"No onError passed for Tapsell:requestAd");
                                          return;
                                      }
                                      cocos2d::LuaBridge::pushLuaFunctionById([onError intValue]);
                                      cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
                                      std::string errorC = std::string([error UTF8String]);
                                      stack->pushString(errorC.c_str());
                                      stack->executeFunction(1);
                                  }];
}

+(void)onNativeBannerAdShown:(NSDictionary *)dict {
    NSString* adId = [dict objectForKey:@"adId"];
    [Tapsell nativeBannerAdShowWithAdId:adId];
}
+(void)onNativeBannerAdClicked:(NSDictionary *)dict {
    NSString* adId = [dict objectForKey:@"adId"];
    [Tapsell nativeBannerAdClickedWithAdId:adId];
}

+(void)requestNativeVideoAd:(NSDictionary *)dict {
    NSString* zoneId = [dict objectForKey:@"zoneId"];
    [Tapsell requestNativeVideoAdForZone:zoneId
                           onAdAvailable:^(TSNativeVideoAdWrapper* ad) {
                               if(ad != nil) {
                                   NSNumber* onAdAvailable = [dict objectForKey:@"onAdAvailable"];
                                   if(!onAdAvailable) {
                                       NSLog(@"No onAdAvailable passed for Tapsell:requestNativeBannerAd");
                                       return;
                                   }
                                   NSString* adProps = [self createJSON:@[@"ad_id",@"title",@"description",@"call_to_action_text",@"icon_url",@"video_url"] withValues:@[ad.adId, ad.title, ad.htmlDescription, ad.callToActionText, ad.logoUrl, ad.videoUrl]];
                                   cocos2d::LuaBridge::pushLuaFunctionById([onAdAvailable intValue]);
                                   cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
                                   std::string adPropsC = std::string([adProps UTF8String]);
                                   stack->pushString(adPropsC.c_str());
                                   stack->executeFunction(1);
                               }
                           }
                         onNoAdAvailable:^(void) {
                             NSNumber* onNoAdAvailable = [dict objectForKey:@"onNoAdAvailable"];
                             if(!onNoAdAvailable) {
                                 NSLog(@"No onNoAdAvailable passed for Tapsell:requestNativeBannerAd");
                                 return;
                             }
                             cocos2d::LuaBridge::pushLuaFunctionById([onNoAdAvailable intValue]);
                             cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
                             stack->executeFunction(0);
                         }
                                 onError:^(NSString* error) {
                                     NSNumber* onError = [dict objectForKey:@"onError"];
                                     if(!onError) {
                                         NSLog(@"No onError passed for Tapsell:requestAd");
                                         return;
                                     }
                                     cocos2d::LuaBridge::pushLuaFunctionById([onError intValue]);
                                     cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
                                     std::string errorC = std::string([error UTF8String]);
                                     stack->pushString(errorC.c_str());
                                     stack->executeFunction(1);
                                 }];
}

+(void)onNativeVideoAdShown:(NSDictionary *)dict {
    NSString* adId = [dict objectForKey:@"adId"];
    [Tapsell nativeVideoAdShowWithAdId:adId];
}
+(void)onNativeVideoAdClicked:(NSDictionary *)dict {
    NSString* adId = [dict objectForKey:@"adId"];
    [Tapsell nativeVideoAdClickedWithAdId:adId];
}

+(void)requestStandardBannerAd:(NSDictionary *)dict {
    NSString* zoneId = [dict objectForKey:@"zoneId"];
    NSNumber* bannerType = [dict objectForKey:@"bannerType"];
    NSNumber* horizontalGravity = [dict objectForKey:@"horizontalGravity"];
    NSNumber* verticalGravity = [dict objectForKey:@"verticalGravity"];
    [TSBannerAdView loadAdWithZoneId:zoneId
                       andBannerType:bannerType
                     andHorizGravity:horizontalGravity
                      andVertGravity:verticalGravity];
}

+(void)setRewardListener:(NSDictionary *)dict {
    [Tapsell setAdShowFinishedCallback:^(TapsellAd *ad, BOOL completed) {
        NSNumber* onAdShowFinished = [dict objectForKey:@"onAdShowFinished"];
        if(!onAdShowFinished) {
            NSLog(@"No onOpened passed for Tapsell:setRewardListener");
            return;
        }
        cocos2d::LuaBridge::pushLuaFunctionById([onAdShowFinished intValue]);
        cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
        std::string adIdC = std::string([[ad getId] UTF8String]);
        std::string zoneIdC = std::string([[ad getZoneId] UTF8String]);
        stack->pushString(zoneIdC.c_str());
        stack->pushString(adIdC.c_str());
        stack->pushBoolean(completed);
        stack->executeFunction(3);
    }];
}

+(void)setDebugMode:(NSDictionary *)dict {
    NSNumber* mode = [dict objectForKey:@"mode"];
    [Tapsell setDebugMode:mode];
}
+(void)isDebugMode:(NSDictionary *)dict {
    BOOL mode = [Tapsell isDebugMode];
    NSNumber* isDebugMode = [dict objectForKey:@"isDebugMode"];
    if(!isDebugMode) {
        NSLog(@"No isDebugMode passed for Tapsell:isDebugMode");
        return;
    }
    cocos2d::LuaBridge::pushLuaFunctionById([isDebugMode intValue]);
    cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
    stack->pushBoolean(mode);
    stack->executeFunction(1);
}
+(void)setAppUserId:(NSDictionary *)dict {
    NSString* appUserId = [dict objectForKey:@"appUserId"];
    [Tapsell setAppUserId:appUserId];
}
+(void)getAppUserId:(NSDictionary *)dict {
    NSString* appUserId = [Tapsell getAppUserId];
    NSNumber* getAppUserId = [dict objectForKey:@"getAppUserId"];
    if(!getAppUserId) {
        NSLog(@"No getAppUserId passed for Tapsell:getAppUserId");
        return;
    }
    cocos2d::LuaBridge::pushLuaFunctionById([getAppUserId intValue]);
    cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
    std::string appUserIdC = [appUserId UTF8String];
    stack->pushString(appUserIdC.c_str());
    stack->executeFunction(1);
}
+(void)getVersion:(NSDictionary *)dict {
    NSString* version = [Tapsell getAppUserId];
    NSNumber* getVersion = [dict objectForKey:@"getVersion"];
    if(!getVersion) {
        NSLog(@"No getVersion passed for Tapsell:getVersion");
        return;
    }
    cocos2d::LuaBridge::pushLuaFunctionById([getVersion intValue]);
    cocos2d::LuaStack *stack = cocos2d::LuaBridge::getStack();
    std::string versionC = [version UTF8String];
    stack->pushString(versionC.c_str());
    stack->executeFunction(1);
}
@end
