package org.cocos2dx.lua;
/* Created by ahmadrezasy on 10/11/17. */


import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;

import java.util.HashMap;

import ir.tapsell.sdk.TapsellCocos2D;
import ir.tapsell.sdk.TapsellCocos2DListener;
import ir.tapsell.sdk.TapsellCocos2DModule;
import ir.tapsell.sdk.gson.Gson;
import ir.tapsell.sdk.gson.GsonBuilder;
import ir.tapsell.sdk.nativeads.TapsellCocos2DNativeLuaListener;


public class Tapsell {

    private static final String TAG = "cocos2d-x";

    private static final String onAdAvailableCb = "onAdAvailable";
    private static final String onErrorCb = "onError";
    private static final String onNoAdAvailableCb = "onNoAdAvailable";
    private static final String onNoNetworkCb = "onNoNetwork";
    private static final String onExpiringCb = "onExpiring";
    private static final String onOpenedCb = "onOpened";
    private static final String onClosedCb = "onClosed";

    private static HashMap<String, HashMap<String, Integer>> callbacks;
    private static int onAdShowFinishedCb = 0;

    private static TapsellCocos2DModule tapsellCocos2DModule = null;
    private static Cocos2dxActivity app = null;
    private TapsellCocos2D tapsellCocos2D = null;

    public static void newInstance(Cocos2dxActivity app) {
        Tapsell.app = app;
        tapsellCocos2DModule = new TapsellCocos2DModule(app);
        Tapsell tapsell = new Tapsell();
        tapsell.initializeTapsell();
    }

    private void initializeTapsell() {
        callbacks = new HashMap<String, HashMap<String, Integer>>();
        callbacks.put(onAdAvailableCb, new HashMap<String, Integer>());
        callbacks.put(onErrorCb, new HashMap<String, Integer>());
        callbacks.put(onNoAdAvailableCb, new HashMap<String, Integer>());
        callbacks.put(onNoNetworkCb, new HashMap<String, Integer>());
        callbacks.put(onExpiringCb, new HashMap<String, Integer>());
        callbacks.put(onOpenedCb, new HashMap<String, Integer>());
        callbacks.put(onClosedCb, new HashMap<String, Integer>());

        tapsellCocos2D = TapsellCocos2D.newInstance(new TapsellCocos2DListener() {
            @Override
            public void onAdShowFinished(String zoneId, String adId, boolean completed, boolean rewarded) {
                Gson gson = new GsonBuilder().create();
                final String data = gson.toJson(new OnAdShowFinished(zoneId, adId, completed, rewarded));
                if (onAdShowFinishedCb != 0) {
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(onAdShowFinishedCb, data);
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(onAdShowFinishedCb);
                        }
                    });
                }
            }

            @Override
            public void onAdAvailable(String zoneId, String adId) {
                Gson gson = new GsonBuilder().create();
                final String data = gson.toJson(new OnAdAvailable(adId));
                if (callbacks.get(onAdAvailableCb).containsKey(zoneId)) {
                    final int callback = callbacks.get(onAdAvailableCb).get(zoneId);
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, data);
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                    callbacks.get(onAdAvailableCb).remove(zoneId);
                }
            }

            @Override
            public void onError(String zoneId, String error) {
                Gson gson = new GsonBuilder().create();
                final String data = gson.toJson(new OnError(error));
                if (callbacks.get(onErrorCb).containsKey(zoneId)) {
                    final int callback = callbacks.get(onErrorCb).get(zoneId);
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, data);
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                    callbacks.get(onErrorCb).remove(zoneId);
                }
            }

            @Override
            final public void onNoAdAvailable(String zoneId) {
                if (callbacks.get(onNoAdAvailableCb).containsKey(zoneId)) {
                    final int callback = callbacks.get(onNoAdAvailableCb).get(zoneId);
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, "");
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                    callbacks.get(onNoAdAvailableCb).remove(zoneId);
                }
            }

            @Override
            final public void onNoNetwork(String zoneId) {
                if (callbacks.get(onNoNetworkCb).containsKey(zoneId)) {
                    final int callback = callbacks.get(onNoNetworkCb).get(zoneId);
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, "");
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                    callbacks.get(onNoNetworkCb).remove(zoneId);
                }
            }

            @Override
            public void onExpiring(String zoneId, String adId) {
                Gson gson = new GsonBuilder().create();
                final String data = gson.toJson(new OnExpiring(adId));
                if (callbacks.get(onExpiringCb).containsKey(zoneId)) {
                    final int callback = callbacks.get(onExpiringCb).get(zoneId);
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, data);
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                    callbacks.get(onExpiringCb).remove(zoneId);
                }
            }

            @Override
            public void onOpened(String zoneId, String adId) {
                Gson gson = new GsonBuilder().create();
                final String data = gson.toJson(new OnOpened(adId));
                if (callbacks.get(onOpenedCb).containsKey(zoneId)) {
                    final int callback = callbacks.get(onOpenedCb).get(zoneId);
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, data);
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                    callbacks.get(onOpenedCb).remove(zoneId);
                }
            }

            @Override
            public void onClosed(String zoneId, String adId) {
                Gson gson = new GsonBuilder().create();
                final String data = gson.toJson(new OnClosed(adId));
                if (callbacks.get(onClosedCb).containsKey(zoneId)) {
                    final int callback = callbacks.get(onClosedCb).get(zoneId);
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, data);
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                    callbacks.get(onClosedCb).remove(zoneId);
                }
            }
        });
    }

    public static void initialize(String appKey) {
        tapsellCocos2DModule.initialize(appKey);
    }

    public static void showAd(String zoneId, String adId, boolean back_disabled, boolean immersive_mode, int rotation_mode,
                              boolean showExitDialog) {

        tapsellCocos2DModule.showAd(adId, back_disabled, immersive_mode, rotation_mode,
                showExitDialog);

    }

    public static void showAd(String zoneId, String adId, boolean back_disabled, boolean immersive_mode, int rotation_mode,
                              boolean showExitDialog, int onOpened, int onClosed) {
        callbacks.get(onOpenedCb).put(zoneId, onOpened);
        callbacks.get(onClosedCb).put(zoneId, onClosed);
        showAd(zoneId, adId, back_disabled, immersive_mode, rotation_mode, showExitDialog);
    }

    public static void requestAd(String zoneId, boolean isCached, int onAdAvailable, int onError,
                                 int onNoAdAvailable, int onNoNetwork, int onExpiring) {
        callbacks.get(onAdAvailableCb).put(zoneId, onAdAvailable);
        callbacks.get(onErrorCb).put(zoneId, onError);
        callbacks.get(onNoAdAvailableCb).put(zoneId, onNoAdAvailable);
        callbacks.get(onNoNetworkCb).put(zoneId, onNoNetwork);
        callbacks.get(onExpiringCb).put(zoneId, onExpiring);

        tapsellCocos2DModule.requestAd(zoneId, isCached);
    }

    public static void requestNativeBannerAd(final String zoneId, int onAdAvailable, int onError,
                                             int onNoAdAvailable, int onNoNetwork) {


        tapsellCocos2DModule.requestNativeBannerAd(zoneId, app, onAdAvailable, onError,
         onNoAdAvailable, onNoNetwork, new TapsellCocos2DNativeLuaListener() {
            @Override
            public void onBannerAdAvailable(final String nativeBannerAdProps, final int callback) {

                if (callback > 0) {
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, nativeBannerAdProps);
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                }
            }

            @Override
            public void onVideoAdAvailable(String nativeVideoAdProps, int callback) {}

            @Override
            public void onError(final String s, final int callback) {
                if (callback > 0) {
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, s);
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                }
            }

            @Override
            public void onNoAdAvailable(final int callback) {
                if (callback > 0) {
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, "");
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                }
            }

            @Override
            public void onNoNetwork(final int callback) {
                if (callback > 0) {
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, "");
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                }
            }
        });
    }

    public static void nativeBannerAdShown(String ad_id) {
        tapsellCocos2DModule.nativeBannerAdShown(ad_id, app);
    }

    public static void nativeBannerAdClicked(String ad_id) {
        tapsellCocos2DModule.nativeBannerAdClicked(ad_id, app);
    }

    public static void requestNativeVideoAd(final String zoneId, int onAdAvailable, int onError,
                                             int onNoAdAvailable, int onNoNetwork) {

        tapsellCocos2DModule.requestNativeVideoAd(zoneId, app, onAdAvailable, onError,
         onNoAdAvailable, onNoNetwork, new TapsellCocos2DNativeLuaListener() {
            @Override
            public void onVideoAdAvailable(final String nativeVideoAdProps, final int callback) {

                if (callback > 0) {
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, nativeVideoAdProps);
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                }
            }

            @Override
            public void onBannerAdAvailable(String nativeBannerAdProps, int callback) {}

            @Override
            public void onError(final String s, final int callback) {
                if (callback > 0) {
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, s);
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                }
            }

            @Override
            public void onNoAdAvailable(final int callback) {
                if (callback > 0) {
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, "");
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                }
            }

            @Override
            public void onNoNetwork(final int callback) {
                if (callback > 0) {
                    app.runOnGLThread(new Runnable() {
                        @Override
                        public void run() {
                            Cocos2dxLuaJavaBridge.callLuaFunctionWithString(callback, "");
                            Cocos2dxLuaJavaBridge.releaseLuaFunction(callback);
                        }
                    });
                }
            }
        });
    }

    public static void requestStandardBannerAd(String zoneId, int bannerType,
                                               int horizontalGravity, int verticalGravity) {
        tapsellCocos2DModule.requestBannerAd(app, zoneId, bannerType, horizontalGravity, verticalGravity);
    }

    public static void nativeVideoAdShown(String ad_id) {
        tapsellCocos2DModule.nativeVideoAdShown(ad_id, app);
    }

    public static void nativeVideoAdClicked(String ad_id) {
        tapsellCocos2DModule.nativeVideoAdClicked(ad_id, app);
    }

    public static void setRewardListener(int rewardListener) {
        onAdShowFinishedCb = rewardListener;
    }

    public static void setDebugMode(boolean debug) {
        tapsellCocos2DModule.setDebugMode(debug);
    }

    public static boolean isDebugMode() {
        return tapsellCocos2DModule.isDebugMode();
    }

    public static void setAppUserId(String appUserId) {
        tapsellCocos2DModule.setAppUserId(appUserId);
    }

    public static String getAppUserId() {
        return tapsellCocos2DModule.getAppUserId();
    }

    public static void setPermissionHandlerConfig(int permissionHandlerConfig) {
        tapsellCocos2DModule.setPermissionHandlerConfig(permissionHandlerConfig);
    }

    public static String getVersion() {
        return tapsellCocos2DModule.getVersion();
    }

    public static void setMaxAllowedBandwidthUsage(int maxBpsSpeed) {
        tapsellCocos2DModule.setMaxAllowedBandwidthUsage(maxBpsSpeed);
    }

    public static void setMaxAllowedBandwidthUsagePercentage(int maxPercentage) {
        tapsellCocos2DModule.setMaxAllowedBandwidthUsagePercentage(maxPercentage);
    }

    public static void clearBandwidthUsageConstrains() {
        tapsellCocos2DModule.clearBandwidthUsageConstrains();
    }

    private class OnAdShowFinished {
        String zoneId;
        String adId;
        boolean completed;
        boolean rewarded;

        public OnAdShowFinished(String zoneId, String adId, boolean completed, boolean rewarded) {
            this.zoneId = zoneId;
            this.adId = adId;
            this.completed = completed;
            this.rewarded = rewarded;
        }
    }

    private class OnAdAvailable {
        String adId;
        public OnAdAvailable(String adId) {
            this.adId = adId;
        }
    }
    private class OnError {
        String error;
        public OnError(String error) {
            this.error = error;
        }
    }
    private class OnExpiring {
        String adId;
        public OnExpiring(String adId) {
            this.adId = adId;
        }
    }
    private class OnOpened {
        String adId;
        public OnOpened(String adId) {
            this.adId = adId;
        }
    }
    private class OnClosed {
        String adId;
        public OnClosed(String adId) {
            this.adId = adId;
        }
    }


}