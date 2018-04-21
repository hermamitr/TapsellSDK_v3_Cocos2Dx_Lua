#import <Foundation/Foundation.h>
#import <TapsellSDKv3/TapsellSDKv3.h>
#include "cocos2d.h"
#include "cocos/scripting/lua-bindings/manual/CCLuaBridge.h"

@interface TSTapsell : NSObject
+(void)initialize:(NSDictionary *)appKey;
+(void)requestAd:(NSDictionary *)dict;
+(void)showAd:(NSDictionary *)dict;
+(void)requestNativeBannerAd:(NSDictionary *)dict;
+(void)onNativeBannerAdShown:(NSDictionary *)dict;
+(void)onNativeBannerAdClicked:(NSDictionary *)dict;
+(void)requestNativeVideoAd:(NSDictionary *)dict;
+(void)onNativeVideoAdShown:(NSDictionary *)dict;
+(void)onNativeVideoAdClicked:(NSDictionary *)dict;
+(void)requestStandardBannerAd:(NSDictionary *)dict;
+(void)setRewardListener:(NSDictionary *)dict;
+(void)setDebugMode:(NSDictionary *)dict;
+(void)isDebugMode:(NSDictionary *)dict;
+(void)setAppUserId:(NSDictionary *)dict;
+(void)getAppUserId:(NSDictionary *)dict;
+(void)getVersion:(NSDictionary *)dict;
@end
