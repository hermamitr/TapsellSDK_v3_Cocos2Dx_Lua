<div dir="rtl">
 <h1>مستندات راه‌اندازی تبلیغات تپسل در Cocos2D-x</h1>
(نسخه اندروید: ۳.۰.۳۲)

پشتیبانی از اندروید ۲.۳ و بالاترکتابخانه تپسل از نسخه اندروید ۲.۳ و بالاتر پشتیبانی می‌کند و در نتیجه بر روی تقریبا تمامی دستگاه‌های فعال روی مارکت قابل اجرا است

نسخه نرم افزار Cocos2D-x و کتابخانه اندروید مورد نیاز جهت استفاده از SDK تپسل و تهیه خروجی اندروید در Cocos2D-x می‌بایست از build tools نسخه ۲۳ و بالاتر و همچنین نسخه ۳ و بالاتر Cocos2D-x استفاده کنید.

فهرست مطالب
<ul>
 	<li><a href="#android-init">راه اندازی پروژه Cocos2dx با زبان Lua (اندروید)</a></li>
 	<li><a href="">راه اندازی پروژه Cocos2dx با زبان Lua پلتفرم iOS</a></li>
 	<li><a href="">پیاده‌سازی تبلیغات ویدئویی (Interstitial/Rewarded Video) و بنری تمام صفحه (Interstitial Banner) در پروژه Cocos2dx زبان Lua</a></li>
 	<li><a href="">پیاده‌سازی تبلیغات بنری هم‌نما (Native Banner) در پروژه Cocos2dx زبان Lua</a></li>
 	<li><a href="">پیاده‌سازی تبلیغات ویدیویی هم‌نما (Native Video) در پروژه Cocos2dx زبان Lua</a></li>
 	<li><a href="">پیاده‌سازی تبلیغات بنری استاندارد (Standard Banner) در پروژه Cocos2dx Lua</a></li>
</ul>

<div id="android-init">
<h1>راه اندازی پروژه Cocos2dx با زبان Lua (اندروید)</h1>
<h3>گام ۱: دریافت پلاگین تپسل برای Cocos2dx-Lua</h3>
ابتدا فایل پلاگین تپسل برای Cocos2dxLua را از آدرس زیر را دانلود کنید.
<p style="text-align: center;"><a href="https://storage.backtory.com/tapsell-server/sdk/tapsell-cocos2dx-android-lua.zip"><button>دانلود پلاگین</button></a></p>

<h3>گام ۲: اضافه کردن tapsell.jar به پروژه اندروید</h3>
فایل tapsell.jar موجود در پلاگین تپسل (دانلود شده از گام ۱) ، را در پوشه <code>frameworks/runtime-src/proj.android-studio/app/libs</code> از محل پروژه خود ، کپی کنید.
<h3>گام ۳: اضافه کردن فایل Tapsell.java به پروژه اندروید</h3>
فایل Tapsell.java موجود در پلاگین تپسل را در پوشه <code>frameworks/runtime-src/proj.android-studio/app/src/org/cocos2dx/lua</code> از محل پروژه خود ، کپی کنید.
<h3>گام ۴: اضافه کردن TapsellAdActivity به AndroidManifest.xml</h3>
فایل AndroidManifest.xml پروژه اندروید (واقع در پوشه <code>frameworks/runtime-src/proj.android-studio/app</code> از محل پروژه) را باز کرده و تکه کد زیر را درون تگ <code>&lt;application&gt;...&lt;/application&gt;</code> قرار دهید :
<pre style="color: #000000; background: #ffffff;" dir="ltr"><span style="color: #696969;">// AndroidManifest.xml</span>
<span style="color: #808030;">&lt;</span>activity
<span style="color: #e34adc;">    android:</span>name<span style="color: #808030;">=</span><span style="color: #800000;">"</span><span style="color: #0000e6;">ir.tapsell.sdk.TapsellAdActivity</span><span style="color: #800000;">"</span>
<span style="color: #e34adc;">    android:</span>label<span style="color: #808030;">=</span><span style="color: #800000;">"</span><span style="color: #0000e6;">TapsellAdActivity</span><span style="color: #800000;">"</span>
<span style="color: #e34adc;">    android:</span>configChanges<span style="color: #808030;">=</span><span style="color: #800000;">"</span><span style="color: #0000e6;">keyboard|keyboardHidden|orientation|screenSize</span><span style="color: #800000;">"</span>
<span style="color: #e34adc;">    android:</span>windowSoftInputMode<span style="color: #808030;">=</span><span style="color: #800000;">"</span><span style="color: #0000e6;">adjustPan</span><span style="color: #800000;">"</span><span style="color: #808030;">&gt;</span>
<span style="color: #808030;">&lt;</span><span style="color: #808030;">/</span>activity<span style="color: #808030;">&gt;</span>
</pre>
<h3>گام ۵: صدا زدن تابع newInstance در شروع برنامه اندروید</h3>
در Launcher Activity پروژه اندروید خود (پیشفرض cocos2dx فایل <code>frameworks/runtime-src/proj.android-studio/app/src/org/cocos2dx/lua/AppActivity.java</code> می باشد) ، در تابع onCreate یا onCreateView ، تابع Tapsell.newInstance را صدا بزنید :
<pre style="color: #000000; background: #ffffff;" dir="ltr"><span style="color: #696969;">// AppActivity.java</span>
<span style="color: #800000; font-weight: bold;">public</span> <span style="color: #800000; font-weight: bold;">class</span> AppActivity <span style="color: #800000; font-weight: bold;">extends</span> Cocos2dxActivity <span style="color: #800080;">{</span>
    <span style="color: #808030;">@</span>Override
    <span style="color: #800000; font-weight: bold;">protected</span> <span style="color: #bb7977;">void</span> onCreate<span style="color: #808030;">(</span>Bundle savedInstanceState<span style="color: #808030;">)</span> <span style="color: #800080;">{</span>
        <span style="color: #800000; font-weight: bold;">super</span><span style="color: #808030;">.</span>onCreate<span style="color: #808030;">(</span>savedInstanceState<span style="color: #808030;">)</span><span style="color: #800080;">;</span>
        Tapsell<span style="color: #808030;">.</span>newInstance<span style="color: #808030;">(</span><span style="color: #800000; font-weight: bold;">this</span><span style="color: #808030;">)</span><span style="color: #800080;">;</span>
    <span style="color: #800080;">}</span>
<span style="color: #800080;">}</span></pre>
<h3>گام ۶:‌ اضافه کردن فایل های  Tapsell.lua و JSON.lua به پروژه cocos2dx</h3>
فایل های  Tapsell.lua و JSON.lua<strong> </strong>موجود در پلاگین تپسل را در فولدر src/app از پروژه کپی کنید.

&nbsp;
</div>

</div>
