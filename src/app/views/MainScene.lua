local MainScene = class("MainScene", cc.load("mvc").ViewBase)
function MainScene:onCreate()
    local Tapsell = require("app.Tapsell")
    Tapsell:setDebugMode(true)
    local APP_KEY = "qjmospqbfarbhodregqecbbnfhcjllkflpbpsmdrtpqkapdeptftldfiapfgbamkhalbij"
    local ZONE_ID = "59b4d07d468465281b792cb7"
    local NATIVE_BANNER_ZONEID = "59c8a9334684656c504f0e19"
    local NATIVE_VIDEO_ZONEID = "59c8ae514684656c504fce40"
    local STANDARD_BANNER_ZONEID = "5a44aa6565a77100013d5fb3"
    local AD_ID = ""
    local NATIVE_BANNER_AD_ID = ""
    local NATIVE_VIDEO_AD_ID = ""
    local nativeMode = "banner"
    Tapsell:initialize(APP_KEY)
    Tapsell:setRewardListener(
        function(zoneId, adId, completed, rewarded)
            printf("Reward %s %s", completed, rewarded)
        end
    )

    local item1 = cc.MenuItemFont:create("RequestAd")
    item1:setPosition(display.width / 2, display.height / 7 * 6)
    item1:registerScriptTapHandler(
        function()
            print("RequestAd Clicked")
            Tapsell:requestAd(
                ZONE_ID,
                true,
                function(adId)
                    print("onAdAvailable")
                    AD_ID = adId
                end,
                function(error)
                    printf("onError %s", error)
                end,
                function()
                    print("onNoAdAvailable")
                end,
                function()
                    print("onNoNetwork")
                end,
                function(adId)
                    print("onExpiring")
                end
            )
        end
    )
    local item2 = cc.MenuItemFont:create("ShowAd")
    item2:setPosition(display.width / 2, display.height / 7 * 5)
    item2:registerScriptTapHandler(
        function()
            print("ShowAd Clicked")
            Tapsell:showAd(
                ZONE_ID,
                AD_ID,
                false,
                false,
                Tapsell.ROTATION_UNLOCKED,
                true,
                function()
                    print("onOpened")
                end,
                function()
                    print("onClosed")
                end
            )
        end
    )

    local nativeLabel = cc.Label:createWithSystemFont("Native Ad Title", "Arial", 24)
    nativeLabel:setPosition(display.width / 2, display.height / 7 * 2)
    self:addChild(nativeLabel)
    local function onTouchBegan(touch, event)
        local target = event:getCurrentTarget()
        local locationInNode = target:convertToNodeSpace(touch:getLocation())
        local s = target:getContentSize()
        local rect = cc.rect(0, 0, s.width, s.height)
        
        if cc.rectContainsPoint(rect, locationInNode) then
            target:setOpacity(180)
            return true
        end
        return false 
    end
    local function onTouchMoved(touch, event)
    end
    local function onTouchEnded(touch, event)
        print("Call To Action Clicked")
        event:getCurrentTarget():setOpacity(255);
        if(nativeMode == "banner") then
            Tapsell:onNativeBannerAdClicked(NATIVE_BANNER_AD_ID)
        end
        if(nativeMode == "video") then
            Tapsell:onNativeVideoAdClicked(NATIVE_VIDEO_AD_ID)
        end
    end
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher = nativeLabel:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, nativeLabel)

    local item3 = cc.MenuItemFont:create("RequestNativeBannerAd")
    item3:setPosition(display.width / 2, display.height / 7 * 4)
    item3:registerScriptTapHandler(
        function()
            print("RequestNativeBannerAd Clicked")
            nativeMode = "banner"
            Tapsell:requestNativeBannerAd(
                NATIVE_BANNER_ZONEID,
                function(adProps)
                    printf(
                        "onAdAvailable title: %s, description: %s, icon_url: %s, call_to_action_text: %s, portrait_static_image_url: %s, landscape_static_image_url: %s",
                        adProps.title,
                        adProps.description,
                        adProps.icon_url,
                        adProps.call_to_action_text,
                        adProps.portrait_static_image_url,
                        adProps.landscape_static_image_url
                    )
                    NATIVE_BANNER_AD_ID = adProps.ad_id
                    nativeLabel:setString(adProps.title)
                    Tapsell:onNativeBannerAdShown(NATIVE_BANNER_AD_ID)
                end,
                function(error)
                    printf("onError %s", error)
                end,
                function()
                    print("onNoAdAvailable")
                end,
                function()
                    print("onNoNetwork")
                end
            )
        end
    )

    local item4 = cc.MenuItemFont:create("RequestNativeVideoAd")
    item4:setPosition(display.width / 2, display.height / 7 * 3)
    item4:registerScriptTapHandler(
        function()
            print("RequestNativeVideoAd Clicked")
            nativeMode = "video"
            Tapsell:requestNativeVideoAd(
                NATIVE_VIDEO_ZONEID,
                function(adProps)
                    printf(
                        "onAdAvailable title: %s, description: %s, icon_url: %s, call_to_action_text: %s, video_url: %s",
                        adProps.title,
                        adProps.description,
                        adProps.icon_url,
                        adProps.call_to_action_text,
                        adProps.video_url
                    )
                    NATIVE_VIDEO_AD_ID = adProps.ad_id
                    nativeLabel:setString(adProps.title)
                    Tapsell:onNativeVideoAdShown(NATIVE_VIDEO_AD_ID)
                end,
                function(error)
                    printf("onError %s", error)
                end,
                function()
                    print("onNoAdAvailable")
                end,
                function()
                    print("onNoNetwork")
                end
            )
        end
    )
    cc.Menu:create(item1, item2, item3, item4):move(0, 0):addTo(self)

    Tapsell:requestStandardBannerAd(STANDARD_BANNER_ZONEID, Tapsell.BANNER_320x50, Tapsell.BOTTOM, Tapsell.CENTER)
end

return MainScene
