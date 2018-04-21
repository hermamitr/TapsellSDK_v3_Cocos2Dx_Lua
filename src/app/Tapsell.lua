local Tapsell = {}
Tapsell["ROTATION_LOCKED_PORTRAIT"] = 1
Tapsell["ROTATION_LOCKED_LANDSCAPE"] = 2
Tapsell["ROTATION_UNLOCKED"] = 3
Tapsell["ROTATION_LOCKED_REVERSED_LANDSCAPE"] = 4
Tapsell["ROTATION_LOCKED_REVERSED_PORTRAIT"] = 5

Tapsell["BANNER_320x50"] = 1
Tapsell["BANNER_320x100"] = 2
Tapsell["BANNER_250x250"] = 3
Tapsell["BANNER_300x250"] = 4

Tapsell["TOP"] = 1
Tapsell["BOTTOM"] = 2
Tapsell["LEFT"] = 3
Tapsell["RIGHT"] = 4
Tapsell["CENTER"] = 5

local javaClassName = "org/cocos2dx/lua/Tapsell"
local ocClassName = "TSTapsell"

function Tapsell:initialize(appKey)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("initialize: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "initialize"
        local javaMethodSig = "(Ljava/lang/String;)V"
        local javaParams = {appKey}
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end
    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "initialize"
        local params = {appKey = appKey}
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:requestAd(zoneId, isCached, onAdAvailable, onError, onNoAdAvailable, onNoNetwork, onExpiring)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("requestAd: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local JSON = require("app.JSON")
        local javaMethodName = "requestAd"
        local javaMethodSig = "(Ljava/lang/String;ZIIIII)V"
        local javaParams = {
            zoneId,
            isCached,
            function(data)
                data = JSON:decode(data)
                onAdAvailable(data.adId)
            end,
            function(data)
                data = JSON:decode(data)
                onError(data.error)
            end,
            function(data)
                onNoAdAvailable()
            end,
            function(data)
                onNoNetwork()
            end,
            function(data)
                data = JSON:decode(data)
                onExpiring(data.adId)
            end
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end

    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "requestAd"
        local params = {
            zoneId = zoneId,
            cacheType = isCached,
            onAdAvailable = function(adId)
                onAdAvailable(adId)
            end,
            onError = function(error)
                onError(error)
            end,
            onNoAdAvailable = function(data)
                onNoAdAvailable()
            end,
            onExpiring = function(adId)
                onExpiring(adId)
            end
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:setRewardListener(rewardListener)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("setRewardListener: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local JSON = require("app.JSON")
        local javaMethodName = "setRewardListener"
        local javaMethodSig = "(I)V"
        local javaParams = {
            function(data)
                data = JSON:decode(data)
                rewardListener(data.zoneId, data.adId, data.completed, data.rewarded)
            end
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end

    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "setRewardListener"
        local params = {
            onAdShowFinished = function(zoneId, adId, completed)
                rewardListener(zoneId, adId, completed)
            end
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:showAd(zoneId, adId, back_disabled, immersive_mode, rotation_mode, showExitDialog)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("showAd: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "showAd"
        local javaMethodSig = "(Ljava/lang/String;Ljava/lang/String;ZZIZ)V"
        local javaParams = {
            adId,
            back_disabled,
            immersive_mode,
            rotation_mode,
            showExitDialog
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end

    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "showAd"
        local params = {
            adId = adId,
            backDisabled = back_disabled,
            showExitDialog = showExitDialog,
            rotationMode = rotation_mode
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:showAd(zoneId, adId, back_disabled, immersive_mode, rotation_mode, showExitDialog, onOpened, onClosed)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("showAd: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local JSON = require("app.JSON")
        local javaMethodName = "showAd"
        local javaMethodSig = "(Ljava/lang/String;Ljava/lang/String;ZZIZII)V"
        local javaParams = {
            zoneId,
            adId,
            back_disabled,
            immersive_mode,
            rotation_mode,
            showExitDialog,
            function(data)
                data = JSON:decode(data)
                onOpened(data.adId)
            end,
            function(data)
                data = JSON:decode(data)
                onClosed(data.adId)
            end
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end

    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "showAd"
        local params = {
            adId = adId,
            backDisabled = back_disabled,
            showExitDialog = showExitDialog,
            rotationMode = rotation_mode,
            onOpened = function(adId)
                onOpened(adId)
            end,
            onClosed = function(adId)
                onClosed(adId)
            end
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:requestNativeBannerAd(zoneId, onAdAvailable, onError, onNoAdAvailable, onNoNetwork)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("showAd: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local JSON = require("app.JSON")
        local javaMethodName = "requestNativeBannerAd"
        local javaMethodSig = "(Ljava/lang/String;IIII)V"
        local javaParams = {
            zoneId,
            function(data)
                data = JSON:decode(data)
                onAdAvailable(data)
            end,
            function(data)
                data = JSON:decode(data)
                onError(data.error)
            end,
            function(data)
                onNoAdAvailable()
            end,
            function(data)
                onNoNetwork()
            end
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end
    if device.platform == "ios" then
        local JSON = require("app.JSON")
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "requestNativeBannerAd"
        local params = {
            zoneId = zoneId,
            onAdAvailable = function(data)
                data = JSON:decode(data)
                onAdAvailable(data)
            end,
            onError = function(error)
                onError(error)
            end,
            onNoAdAvailable = function(data)
                onNoAdAvailable()
            end
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:onNativeBannerAdShown(adId)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("showAd: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "nativeBannerAdShown"
        local javaMethodSig = "(Ljava/lang/String;)V"
        local javaParams = {
            adId
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end
    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "onNativeBannerAdShown"
        local params = {
            adId = adId
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:onNativeBannerAdClicked(adId)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("showAd: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "nativeBannerAdClicked"
        local javaMethodSig = "(Ljava/lang/String;)V"
        local javaParams = {
            adId = adId
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end
    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "onNativeBannerAdClicked"
        local params = {
            adId = adId
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:requestNativeVideoAd(zoneId, onAdAvailable, onError, onNoAdAvailable, onNoNetwork)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("showAd: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local JSON = require("app.JSON")
        local javaMethodName = "requestNativeVideoAd"
        local javaMethodSig = "(Ljava/lang/String;IIII)V"
        local javaParams = {
            zoneId,
            function(data)
                data = JSON:decode(data)
                onAdAvailable(data)
            end,
            function(data)
                data = JSON:decode(data)
                onError(data.error)
            end,
            function(data)
                onNoAdAvailable()
            end,
            function(data)
                onNoNetwork()
            end
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end
    if device.platform == "ios" then
        local JSON = require("app.JSON")
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "requestNativeVideoAd"
        local params = {
            zoneId = zoneId,
            onAdAvailable = function(data)
                data = JSON:decode(data)
                onAdAvailable(data)
            end,
            onError = function(error)
                onError(error)
            end,
            onNoAdAvailable = function(data)
                onNoAdAvailable()
            end
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:onNativeVideoAdShown(adId)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("showAd: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "nativeVideoAdShown"
        local javaMethodSig = "(Ljava/lang/String;)V"
        local javaParams = {
            adId
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end
    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "onNativeVideoAdShown"
        local params = {
            adId = adId
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:onNativeVideoAdClicked(adId)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("showAd: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "nativeVideoAdClicked"
        local javaMethodSig = "(Ljava/lang/String;)V"
        local javaParams = {
            adId
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end
    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "onNativeVideoAdClicked"
        local params = {
            adId = adId
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:requestStandardBannerAd(zoneId, bannerType, horizontalGravity, verticalGravity)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("showAd: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "requestStandardBannerAd"
        local javaMethodSig = "(Ljava/lang/String;III)V"
        local javaParams = {
            zoneId,
            bannerType,
            horizontalGravity,
            verticalGravity
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end
    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "requestStandardBannerAd"
        local params = {
            zoneId = zoneId,
            bannerType = bannerType,
            horizontalGravity = horizontalGravity,
            verticalGravity = verticalGravity
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:setDebugMode(mode)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("setDebugMode: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "setDebugMode"
        local javaMethodSig = "(Z)V"
        local javaParams = {
            mode
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end

    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "setDebugMode"
        local params = {
            mode = mode
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:isDebugMode()
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("isDebugMode: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "isDebugMode"
        local javaMethodSig = "()Z"
        local javaParams = {}
        return LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end

    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "isDebugMode"
        local debugMode = false
        local params = {
            isDebugMode = function(mode)
                debugMode = mode
            end
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
        return debugMode
    end
end

function Tapsell:setAppUserId(appUserId)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("setAppUserId: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "setAppUserId"
        local javaMethodSig = "(Ljava/lang/String;)V"
        local javaParams = {
            appUserId
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end

    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "setAppUserId"
        local params = {
            appUserId = appUserId
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:getAppUserId()
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("getAppUserId: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "getAppUserId"
        local javaMethodSig = "()Ljava/lang/String;"
        local javaParams = {}
        return LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end

    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "getAppUserId"
        local appUserId = ""
        local params = {
            getAppUserId = function(userId)
                appUserId = userId
            end
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
        return appUserId
    end
end

function Tapsell:setPermissionHandlerConfig(permissionHandlerConfig)
    if device.platform ~= "android" then
        printf("setPermissionHandlerConfig: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "setPermissionHandlerConfig"
        local javaMethodSig = "(I)V"
        local javaParams = {
            permissionHandlerConfig
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end
end

function Tapsell:getVersion()
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("getVersion: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "getVersion"
        local javaMethodSig = "()Ljava/lang/String;"
        local javaParams = {}
        return LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end

    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "getVersion"
        local version = ""
        local params = {
            getVersion = function(sdkVersion)
                version = sdkVersion
            end
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
        return version
    end
end

function Tapsell:setMaxAllowedBandwidthUsage(maxBpsSpeed)
    if device.platform ~= "android" and device.platform ~= "ios" then
        printf("setMaxAllowedBandwidthUsage: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "setMaxAllowedBandwidthUsage"
        local javaMethodSig = "(I)V"
        local javaParams = {
            maxBpsSpeed
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end

    if device.platform == "ios" then
        local luaoc = require("cocos.cocos2d.luaoc")
        local ocMethodName = "setMaxAllowedBandwidthUsagePercentage"
        local params = {
            maxPercentage = maxPercentage
        }
        luaoc.callStaticMethod(ocClassName, ocMethodName, params)
    end
end

function Tapsell:setMaxAllowedBandwidthUsagePercentage(maxPercentage)
    if device.platform ~= "android" then
        printf("setMaxAllowedBandwidthUsagePercentage: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "setMaxAllowedBandwidthUsagePercentage"
        local javaMethodSig = "(I)V"
        local javaParams = {
            maxPercentage
        }
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end
end

function Tapsell:clearBandwidthUsageConstrains()
    if device.platform ~= "android" then
        printf("clearBandwidthUsageConstrains: Platform %s is not supported by tapsell sdk!", device.platform)
        return
    end
    if device.platform == "android" then
        local javaMethodName = "clearBandwidthUsageConstrains"
        local javaMethodSig = "()V"
        local javaParams = {}
        LuaJavaBridge.callStaticMethod(javaClassName, javaMethodName, javaParams, javaMethodSig)
    end
end

Tapsell.__index = Tapsell
function Tapsell:new()
    return setmetatable({}, Tapsell)
end

return Tapsell:new()
