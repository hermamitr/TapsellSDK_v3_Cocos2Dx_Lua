<div dir="rtl">
 <h1>مستندات راه‌اندازی تبلیغات تپسل در Cocos2D-x</h1>
(نسخه اندروید: ۳.۰.۳۲)

پشتیبانی از اندروید ۲.۳ و بالاترکتابخانه تپسل از نسخه اندروید ۲.۳ و بالاتر پشتیبانی می‌کند و در نتیجه بر روی تقریبا تمامی دستگاه‌های فعال روی مارکت قابل اجرا است

نسخه نرم افزار Cocos2D-x و کتابخانه اندروید مورد نیاز جهت استفاده از SDK تپسل و تهیه خروجی اندروید در Cocos2D-x می‌بایست از build tools نسخه ۲۳ و بالاتر و همچنین نسخه ۳ و بالاتر Cocos2D-x استفاده کنید.

فهرست مطالب
<ul>
 	<li><a href="#android-init">راه اندازی پروژه Cocos2dx با زبان Lua (اندروید)</a></li>
 	<li><a href="#ios-init">راه اندازی پروژه Cocos2dx با زبان Lua پلتفرم iOS</a></li>
 	<li><a href="#rewarded">پیاده‌سازی تبلیغات ویدئویی (Interstitial/Rewarded Video) و بنری تمام صفحه (Interstitial Banner) در پروژه Cocos2dx زبان Lua</a></li>
 	<li><a href="#native-banner">پیاده‌سازی تبلیغات بنری هم‌نما (Native Banner) در پروژه Cocos2dx زبان Lua</a></li>
 	<li><a href="#native-video">پیاده‌سازی تبلیغات ویدیویی هم‌نما (Native Video) در پروژه Cocos2dx زبان Lua</a></li>
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

<div id="ios-init">
 <h2>راه اندازی پروژه Cocos2dx با زبان Lua پلتفرم iOS</h2>
 <h3><strong>گام ۱: تنظیمات پروژه Xcode</strong></h3>
قبل از هر کاری ابتدا پروژه iOS واقع در <span class="s1"><code>frameworks/runtime-src/proj.ios_mac</code> از محل پروژه خود را با xcode باز کرده و تنظیمات لینک زیر را در آن اعمال کنید : (دقت کنید که برای اضافه کردن فریمورک تپسل به پروژه Xcode باید Deployment Target بالاتر از iOS 8.0 باشد.)</span>
<p style="text-align: center;"><a href="https://answers.tapsell.ir?ht_kb=ios-sdk"><button>تنظیم پروژه Xcode</button></a></p>

<h3><strong>گام ۲: اضافه کردن کلاس TSTapsell به پروژه Xcode</strong></h3>
فایل های پلاگین تپسل  ( tapsell-cocos2dx-ios-lua ) را از لینک زیر دانلود کنید :
<p style="text-align: center;"><a href="https://storage.backtory.com/tapsell-server/sdk/tapsell-cocos2dx-ios-lua.zip"><button>پلاگین تپسل</button></a></p>
<p style="text-align: right;">فایل های TSTapsell.h و TSTapsell.mm را به پروژه ios در پوشه ios اضافه کنید. مانند تصویر زیر :</p>
<p style="text-align: right;"><img class="aligncenter wp-image-2377" src="https://answers.tapsell.ir/wp-content/uploads/2017/12/Screen-Shot-2017-12-20-at-4.41.20-PM.png" alt="" width="208" height="458" /></p>

<h3 id="گام-۶‌-اضافه-کردن-فایل-های-tapsell-lua-و-json-lua-به-پر">گام ۳:‌ اضافه کردن فایل های  Tapsell.lua و JSON.lua به پروژه cocos2dx</h3>
فایل های  Tapsell.lua و JSON.lua<strong> </strong>موجود در پلاگین تپسل را در فولدر src/app از پروژه کپی کنید.

&nbsp;
</div>

<div id="rewarded">
<h2>پیاده‌سازی تبلیغات ویدئویی (Interstitial/Rewarded Video) و بنری تمام صفحه (Interstitial Banner) در پروژه Cocos2dx زبان Lua</h2>
<h3>گام ۱ : راه اندازی پروژه Cocos2dx با زبان Lua</h3>
ابتدا به لینک زیر مراجعه کنید و پلاگین تپسل را به پروژه ی خود اضافه کنید :
<p style="text-align: center;"><a href="#android-init"><button>راه اندازی پروژه اندروید</button></a></p>
<p style="text-align: center;"><a href="#ios-init"><button>راه اندازی پروژه iOS</button></a></p>

<h3>گام ۲: دریافت کلید تپسل</h3>
وارد پنل مدیریت تپسل شده و با تعریف یک اپلیکیشن جدید با عنوان پکیج اپلیکیشن اندرویدی خود، یک کلید تپسل دریافت کنید.
<p style="text-align: center;"><a href="https://dashboard.tapsell.ir"><button>ورود به داشبورد تپسل</button></a></p>

<h3>گام ۳: شروع کار با SDK تپسل</h3>
در ابتدای کد خود این خط را اضافه کنید :‌
<pre style="color: #000000; background: #ffffff;" dir="ltr">local Tapsell <span style="color: #808030;">=</span> require<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">app.Tapsell</span><span style="color: #800000;">"</span><span style="color: #808030;">)</span>
</pre>
برای مقداردهی اولیه ، تابع زیر را با ورودی کلید اپ خود صدا بزنید.
<pre dir="ltr">Tapsell:initialize(<span style="color: #409b1c;">"Your tapsell appKey"</span>)</pre>
ورودی appKey کلید تپسلی است که در گام قبل از پنل تپسل دریافت کردید.
<h3>گام ۴: دریافت تبلیغ</h3>
نمایش یک تبلیغ ویدئویی در اپلیکیشن به دو صورت ممکن است صورت پذیرد. یک روش، نمایش تبلیغ بصورت stream می باشد. در این حالت، همزمان که کاربر درحال مشاهده بخشی از تبلیغ است، ادامه آن از اینترنت لود می گردد. ممکن است به دلیل کندی سرعت اینترنت، در این حالت کاربر با مکث های متعددی در هنگام دریافت و مشاهده تبلیغ مواجه شود. برای اینکه کاربر در هنگام نمایش تبلیغ منتظر نماند و تجربه کاربر در استفاده از اپلیکیشن بهبود یابد،روش دیگری نیز در SDK تپسل تعبیه شده است که در آن ابتدا فایل ویدئوی تبلیغاتی بطور کامل بارگذاری شده و سپس تبلیغ نمایش داده می شود.
همچنین در تپسل، تبلیغ می تواند در ناحیه‌های مختلفی از برنامه شما (مانند فروشگاه، انتهای هر مرحله، ابتدای مرحله جهت دریافت امتیاز دوبرابر، دریافت بنزین/لایف و ...) پخش شود. در تپسل به این ناحیه‌ها zone گفته می شود. ناحیه‌های هر اپلیکیشن در پنل تپسل تعریف می شوند.

با اجرای تابع زیر، می توانید یک درخواست تبلیغ به تپسل ارسال کرده و یک تبلیغ دریافت نمایید:
<pre dir="ltr">Tapsell:requestAd(zoneId, cached, onAdAvailable, 
    onNoAdAvailable, onError, onNoNetwork, onExpiring);
</pre>
هر درخواست شامل یک ورودی <code>zoneId</code> است که باید آن را از <a href="https://dashboard.tapsell.ir/">داشبورد تپسل</a> در صفحه اپلیکیشن خود دریافت کنید. دقت کنید که برای این پارامتر نباید از مقدار <code>null</code> استفاده کنید. ورودی <code>cached</code> یک متغیر <code>bool</code> (با مقدار True/False) می باشد که نشان می دهد که آیا تبلیغ باید ابتدا دانلود شده و سپس به کاربر نشان داده شود یا خیر.

تنها در ناحیه‌هایی که کاربر با احتمال زیادی پس از باز کردن اپلیکیشن تبلیغ آن را مشاهده می‌کند، از تبلیغ Cached استفاده کنید. جهت توضیحات بیشتر درباره روش انتخاب متد دریافت مناسب، <a href="https://answers.tapsell.ir/?ht_kb=cached-vs-streamed">اینجا</a> را مطالعه کنید.

نتیجه درخواست تبلیغ به تابع های callback ورودی بازگردانده می شود. یک نمونه پیاده سازی تابع های callback لازم در ادامه آمده است.

در onAdAvailable شناسه یک تبلیغ به شما برگردانده می شود که می بایست جهت نمایش تبلیغ آن را ذخیره نمایید. جهت توضیحات بیشتر به قطعه کد پیاده سازی اکشن که در ادامه آمده است توجه نمایید.
<pre style="color: #000000; background: #ffffff;" dir="ltr">Tapsell<span style="color: #800080;">:</span>requestAd<span style="color: #808030;">(</span>
                ZONE_ID<span style="color: #808030;">,</span>
                <span style="color: #0f4d75;">true</span><span style="color: #808030;">,</span>
                <span style="color: #800000; font-weight: bold;">function</span><span style="color: #808030;">(</span>adId<span style="color: #808030;">)</span>
                    print<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onAdAvailable</span><span style="color: #800000;">"</span><span style="color: #808030;">)</span>
                    AD_ID <span style="color: #808030;">=</span> adId
                end<span style="color: #808030;">,</span>
                <span style="color: #800000; font-weight: bold;">function</span><span style="color: #808030;">(</span>error<span style="color: #808030;">)</span>
                    printf<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onError %s</span><span style="color: #800000;">"</span><span style="color: #808030;">,</span> error<span style="color: #808030;">)</span>
                end<span style="color: #808030;">,</span>
                <span style="color: #800000; font-weight: bold;">function</span><span style="color: #808030;">(</span><span style="color: #808030;">)</span>
                    print<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onNoAdAvailable</span><span style="color: #800000;">"</span><span style="color: #808030;">)</span>
                end<span style="color: #808030;">,</span>
                <span style="color: #800000; font-weight: bold;">function</span><span style="color: #808030;">(</span><span style="color: #808030;">)</span>
                    print<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onNoNetwork</span><span style="color: #800000;">"</span><span style="color: #808030;">)</span>
                end<span style="color: #808030;">,</span>
                <span style="color: #800000; font-weight: bold;">function</span><span style="color: #808030;">(</span>adId<span style="color: #808030;">)</span>
                    print<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onExpiring</span><span style="color: #800000;">"</span><span style="color: #808030;">)</span>
                end
            <span style="color: #808030;">)</span>
</pre>
&nbsp;

توضیحات اکشن های مختلف و شرایط اجرا شدن آن ها در جدول ۱ آمده است.
<table style="text-align: center; border-collapse: collapse;" width="100%"><caption>جدول ۱ اکشن های دریافت نتیجه درخواست تبلیغ</caption>
<tbody>
<tr style="border-bottom: 1px solid #ddd;">
<th width="40%">تابع</th>
<th width="60%">توضیحات (زمان اجرا)</th>
</tr>
<tr style="background-color: #fefefe;">
<td dir="ltr" width="40%">onError(error : string)</td>
<td>هنگامی که هر نوع خطایی در پروسه‌ی دریافت تبلیغ بوجود بیاید</td>
</tr>
<tr style="background-color: #f2f2f2;">
<td dir="ltr" width="40%">onAdAvailable(adId : string)</td>
<td width="60%">زمانی که تبلیغ دریافت شده و آماده‌ی نمایش باشد.</td>
</tr>
<tr style="background-color: #fefefe;">
<td dir="ltr" width="40%">onNoAdAvailable()</td>
<td width="60%">در صورتی که تبلیغی برای نمایش وجود نداشته باشد.</td>
</tr>
<tr style="background-color: #f2f2f2;">
<td dir="ltr" width="40%">onNoNetwork()</td>
<td width="60%">زمانی که دسترسی به شبکه موجود نباشد.</td>
</tr>
<tr style="background-color: #fefefe;">
<td dir="ltr" width="40%">onExpiring(adId : string)</td>
<td width="60%">زمانی که تبلیغ منقضی شود. هر تبلیغ مدت زمان مشخصی معتبر است و در صورتی که تا قبل از آن نمایش داده نشود منقضی شده و دیگر قابل نمایش نخواهد بود.</td>
</tr>
</tbody>
</table>
<h3>گام ۵: نمایش تبلیغ</h3>
هر تبلیغ یک id از نوع string دارد. جهت نمایش تبلیغ، می‌توانید از دو تابع زیر استفاده نمایید (این تابع حداکثر یک بار برای هر تبلیغ قابل اجراست) :
<pre style="color: #000000; background: #ffffff;" dir="ltr">Tapsell<span style="color: #800080;">:</span>showAd<span style="color: #808030;">(</span>zoneId<span style="color: #808030;">,</span> adId<span style="color: #808030;">,</span> back_disabled<span style="color: #808030;">,</span> immersive_mode<span style="color: #808030;">,</span> rotation_mode<span style="color: #808030;">,</span> showExitDialog<span style="color: #808030;">)</span>
Tapsell<span style="color: #800080;">:</span>showAd<span style="color: #808030;">(</span>zoneId<span style="color: #808030;">,</span> adId<span style="color: #808030;">,</span> back_disabled<span style="color: #808030;">,</span> immersive_mode<span style="color: #808030;">,</span> rotation_mode<span style="color: #808030;">,</span> showExitDialog<span style="color: #808030;">,</span> onOpened<span style="color: #808030;">,</span> onClosed<span style="color: #808030;">)</span>
</pre>
دو ورودی onOpened و onClosed از جنس تابع هستند و این callback ها زمان اجرا و پایان نمایش تبلیغ صدا زده می شوند.
<table style="text-align: center; border-collapse: collapse;" width="100%" cellpadding="6"><caption>جدول ۲ فیلدهای adOptions</caption>
<tbody>
<tr style="border-bottom: 1px solid #ddd;">
<th width="40%">متغیر (نوع)</th>
<th width="60%">توضیحات</th>
</tr>
<tr style="background-color: #fefefe;">
<td dir="ltr" width="40%">back_disabled (Boolean)</td>
<td width="60%">
<div align="right">در هنگام پخش تبلیغ دکمه‌ی بازگشت گوشی فعال باشد یا خیر</div></td>
</tr>
<tr style="background-color: #f2f2f2;">
<td dir="ltr" width="40%">immersive_mode(Boolean)</td>
<td width="60%">
<div align="right">فعال‌سازی حالت Immersive در هنگام پخش تبلیغ (فقط در اندروید)</div></td>
</tr>
<tr style="background-color: #fefefe;">
<td dir="ltr" width="40%">rotation_mode (Number)</td>
<td width="60%">
<div align="right">تعیین وضعیت گوشی در هنگام پخش تبلیغ به یکی از سه حالت:</div>
<div align="left">ROTATION_LOCKED_PORTRAIT
ROTATION_LOCKED_LANDSCAPE
ROTATION_UNLOCKED
ROTATION_LOCKED_REVERSED_PORTRAIT
ROTATION_LOCKED_REVERSED_LANDSCAPE</div></td>
</tr>
<tr style="background-color: #f2f2f2;">
<td dir="ltr" width="40%">show_exit_dialog(Boolean)</td>
<td width="60%">
<div align="right">نمایش دیالوگ اخطار در هنگام بازگشت از تبلیغات جایزه‌دار</div></td>
</tr>
</tbody>
</table>
یک نمونه پیاده‌سازی درخواست تبلیغ در ادامه آمده است.
<pre style="color: #000000; background: #ffffff;" dir="ltr">Tapsell<span style="color: #800080;">:</span>showAd<span style="color: #808030;">(</span>
                ZONE_ID<span style="color: #808030;">,</span>
                AD_ID<span style="color: #808030;">,</span>
                <span style="color: #0f4d75;">false</span><span style="color: #808030;">,</span>
                <span style="color: #0f4d75;">false</span><span style="color: #808030;">,</span>
                Tapsell<span style="color: #808030;">.</span>ROTATION_UNLOCKED<span style="color: #808030;">,</span>
                <span style="color: #0f4d75;">true</span><span style="color: #808030;">,</span>
                <span style="color: #800000; font-weight: bold;">function</span><span style="color: #808030;">(</span><span style="color: #808030;">)</span>
                    print<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onOpened</span><span style="color: #800000;">"</span><span style="color: #808030;">)</span>
                end<span style="color: #808030;">,</span>
                <span style="color: #800000; font-weight: bold;">function</span><span style="color: #808030;">(</span><span style="color: #808030;">)</span>
                    print<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onClosed</span><span style="color: #800000;">"</span><span style="color: #808030;">)</span>
                end
            <span style="color: #808030;">)</span>
</pre>
&nbsp;
<h3>گام ۶: دریافت نتیجه نمایش تبلیغ</h3>
در صورتیکه در اپلیکیشن خود از تبلیغات جایزه‌دار استفاده می‌کنید، جهت دریافت نتیجه نمایش تبلیغ‌ها، باید یک اکشن مطابق زیر به SDK تپسل بدهید.
<pre style="color: #000000; background: #ffffff;" dir="ltr">Tapsell<span style="color: #800080;">:</span>setRewardListener<span style="color: #808030;">(</span>
        <span style="color: #800000; font-weight: bold;">function</span><span style="color: #808030;">(</span>zoneId<span style="color: #808030;">,</span> adId<span style="color: #808030;">,</span> completed<span style="color: #808030;">,</span> rewarded<span style="color: #808030;">)</span>
            printf<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">Reward %s %s</span><span style="color: #800000;">"</span><span style="color: #808030;">,</span> completed<span style="color: #808030;">,</span> rewarded<span style="color: #808030;">)</span>
        end
    <span style="color: #808030;">)</span>
</pre>
پس از نمایش تبلیغ، اکشن onAdShowFinished اجرا می‌شود و نتیجه نمایش تبلیغ بازگردانده می‌شود. درصورتیکه تبلیغ نمایش داده شده جایزه‌دار باشد، متغیر rewarded در این شی دارای مقدار true خواهد بود. همچنین درصورتیکه تبلیغ تا انتها دیده شود، متغیر completed در ای شین دارای مقدار true خواهد بود.  در صورتی که تبلیغ جایزه‌دار باشد و مشاهده ویدئو تا انتها انجام شده باشد، باید جایزه درون برنامه (سکه، اعتبار، بنزین یا ...) را به کاربر بدهید.
<h3>نمونه پیاده‌سازی</h3>
یک نمونه پیاده‌سازی SDK تپسل در Cocos2dx Lua در repository زیر آمده است.
<p style="text-align: center;"><a href="https://github.com/tapselladnet/TapsellSDK_v3_Cocos2Dx_Lua"><button>مشاهده پروژه نمونه</button></a></p>
لطفا نظرات خود درباره محتوای این فایل و مشکلاتی که در پیاده‌سازی SDK تپسل با آنها مواجه شدید را به ما اطلاع دهید.

&nbsp;

&nbsp;

&nbsp;
</div>

<div id="native-banner">
 <h2>پیاده‌سازی تبلیغات بنری هم‌نما (Native Banner) در پروژه Cocos2dx زبان Lua</h2>
<h3>گام ۱ : راه اندازی پروژه Cocos2dx با زبان Lua</h3>
ابتدا به لینک زیر مراجعه کنید و پلاگین تپسل را به پروژه ی خود اضافه کنید :
<p style="text-align: center;"><a href="#android-init"><button>راه اندازی پروژه اندروید</button></a></p>
<p style="text-align: center;"><a href="#ios-init"><button>راه اندازی پروژه iOS</button></a></p>

<h3>گام ۲: دریافت کلید تپسل</h3>
وارد پنل مدیریت تپسل شده و با تعریف یک اپلیکیشن جدید با عنوان پکیج اپلیکیشن اندرویدی خود، یک کلید تپسل دریافت کنید.
<p style="text-align: center;"><a href="https://dashboard.tapsell.ir"><button>ورود به داشبورد تپسل</button></a></p>

<h3>گام ۳: شروع کار با SDK تپسل</h3>
در ابتدای کد خود (در اسکوپی که می‌خواهید از تپسل استفاده کنید) این خط را اضافه کنید :‌
<pre dir="ltr">local Tapsell = require("app.Tapsell")
</pre>
برای مقداردهی اولیه ، تابع زیر را با ورودی کلید اپ خود صدا بزنید.
<pre dir="ltr">Tapsell:initialize(appKey)</pre>
ورودی appKey کلید تپسلی است که در گام قبل از پنل تپسل دریافت کردید.
<h3>گام ۴: دریافت تبلیغ</h3>
در تبلیغات هم‌نما، شما قادر هستید ویژگی‌های ظاهری هر یک از اجزای تبلیغ (اندازه، محل قرارگیری، رنگ فونت و…) را بصورتی که هماهنگ با محتوای اپلیکیشن شما باشد تعیین کنید.

برای این منظور، شما یک درخواست تبلیغ به SDK تپسل ارسال می کنید، محتوای یک تبلیغ هم‌نمای بنری را دریافت کنید و آن را به نحوه مورد نظر خود نمایش دهید.

جهت ارسال درخواست تبلیغ هم‌نما، از تابع زیر استفاده کنید.
<pre style="color: #000000; background: #ffffff;" dir="ltr"><span style="color: #e34adc;">Tapsell:</span>requestNativeBannerAd<span style="color: #808030;">(</span>
                zoneId <span style="color: #800080;">:</span> string<span style="color: #808030;">,</span>
                onAdAvailable <span style="color: #800080;">:</span> function<span style="color: #808030;">,</span>
                onError<span style="color: #800080;">:</span> function<span style="color: #808030;">,</span>
                onNoAdAvailable <span style="color: #800080;">:</span> function<span style="color: #808030;">,</span>
                onNoNetwork<span style="color: #800080;">:</span> function
            <span style="color: #808030;">)</span>
</pre>
ورودی zoneId، شناسه تبلیغ‌گاه از نوع بنری هم‌نما است که باید آن را از <a href="https://dashboard.tapsell.ir/">داشبورد تپسل</a> دریافت کنید.

نتیجه درخواست تبلیغ به تابع‌های ورودی بازگردانده می شود. یک نمونه پیاده سازی تابع‌های لازم در ادامه آمده است. تابع onAdAvailable یک Table به نام adProps به عنوان پارامتر دارد که داده های تبلیغ در آن در صورت وجود تبلیغ قرار می‌گیرد.
<pre style="color: #000000; background: #ffffff;" dir="ltr"><span style="color: #e34adc;">Tapsell:</span>requestNativeBannerAd<span style="color: #808030;">(</span>
                NATIVE_BANNER_ZONEID<span style="color: #808030;">,</span>
                function<span style="color: #808030;">(</span>adProps<span style="color: #808030;">)</span>
                    <span style="color: #603000;">printf</span><span style="color: #808030;">(</span>
                        <span style="color: #800000;">"</span><span style="color: #0000e6;">onAdAvailable title: </span><span style="color: #007997;">%s</span><span style="color: #0000e6;">, description: </span><span style="color: #007997;">%s</span><span style="color: #0000e6;">, icon_url: </span><span style="color: #007997;">%s</span><span style="color: #0000e6;">, call_to_action_text: </span><span style="color: #007997;">%s</span><span style="color: #0000e6;">, portrait_static_image_url: </span><span style="color: #007997;">%s</span><span style="color: #0000e6;">, landscape_static_image_url: </span><span style="color: #007997;">%s</span><span style="color: #800000;">"</span><span style="color: #808030;">,</span>
                        adProps<span style="color: #808030;">.</span>title<span style="color: #808030;">,</span>
                        adProps<span style="color: #808030;">.</span>description<span style="color: #808030;">,</span>
                        adProps<span style="color: #808030;">.</span>icon_url<span style="color: #808030;">,</span>
                        adProps<span style="color: #808030;">.</span>call_to_action_text<span style="color: #808030;">,</span>
                        adProps<span style="color: #808030;">.</span>portrait_static_image_url<span style="color: #808030;">,</span>
                        adProps<span style="color: #808030;">.</span>landscape_static_image_url
                    <span style="color: #808030;">)</span>
                end<span style="color: #808030;">,</span>
                function<span style="color: #808030;">(</span>error<span style="color: #808030;">)</span>
                    <span style="color: #603000;">printf</span><span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onError </span><span style="color: #007997;">%s</span><span style="color: #800000;">"</span><span style="color: #808030;">,</span> error<span style="color: #808030;">)</span>
                end<span style="color: #808030;">,</span>
                function<span style="color: #808030;">(</span><span style="color: #808030;">)</span>
                    print<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onNoAdAvailable</span><span style="color: #800000;">"</span><span style="color: #808030;">)</span>
                end<span style="color: #808030;">,</span>
                function<span style="color: #808030;">(</span><span style="color: #808030;">)</span>
                    print<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onNoNetwork</span><span style="color: #800000;">"</span><span style="color: #808030;">)</span>
                end
            <span style="color: #808030;">)</span>
</pre>
<h3 id="گام-۴-نمایش-تبلیغ">گام ۵: نمایش تبلیغ</h3>
برای نمایش تبلیغ، می‌بایست از داده های موجود در تابع onAdAvailable (همان adProps) استفاده کنید. توضیح این داده ها در جدول زیر آمده است :
<table width="100%"><caption>جدول ۱ داده های تابع onAdAvailable (همان adProps)</caption>
<tbody>
<tr>
<th width="40%">مشخصه</th>
<th width="60%">توضیحات</th>
</tr>
<tr>
<td width="40%">adProps.ad_id</td>
<td>شناسه تبلیغ</td>
</tr>
<tr>
<td width="40%">adProps.title</td>
<td>عنوان تبلیغ</td>
</tr>
<tr>
<td width="40%">adProps.description</td>
<td width="60%">توضیحات تبلیغ</td>
</tr>
<tr>
<td width="40%">adProps.call_to_action_text</td>
<td width="60%">متن دعوت کننده از کاربر به کلیک/نصب</td>
</tr>
<tr>
<td width="40%">adProps.portrait_static_image_url</td>
<td width="60%">لینک تصویر بنر تبلیغ (عمودی)</td>
</tr>
<tr>
<td width="40%">adProps.landscape_static_image_url</td>
<td width="60%">لینک تصویر بنر تبلیغ (افقی)</td>
</tr>
<tr>
<td width="40%">adProps.icon_url</td>
<td width="60%">لینک آیکون تبلیغ</td>
</tr>
</tbody>
</table>
دقت کنید که تبلیغ‌ها ممکن است هردو بنر عمودی و افقی را نداشته باشند.

در زمان نمایش تبلیغ، باید تابع <code>onNativeBannerAdShown</code> از <code>Tapsell</code> را فراخوانی کنید ؛ این تابع یک رشته به عنوان ورودی می‌گیرد که شناسه مربوط به تبلیغی است که نمایش داده شده است.
<pre dir="ltr">Tapsell:onNativeBannerAdShown(adId);</pre>
<h3 id="گام-۵-باز-کردن-تبلیغ">گام ۶: باز کردن تبلیغ</h3>
برای باز کردن تبلیغ، هنگامی که کاربر روی آن کلیک می‌کند، از تابع زیر استفاده کنید. این تابع یک رشته به عنوان ورودی می‌گیرد که شناسه تبلیغی است که روی آن کلیک شده است.
<pre dir="ltr">Tapsell:onNativeBannerAdClicked(adId);</pre>
<h3>نمونه پیاده‌سازی</h3>
یک نمونه پیاده‌سازی SDK تپسل در Cocos2dx Lua در repository زیر آمده است.
<p style="text-align: center;"><a href="https://github.com/tapselladnet/TapsellSDK_v3_Cocos2Dx_Lua"><button>مشاهده پروژه نمونه</button></a></p>

&nbsp;
</div>

<div id="native-video">
<h2>پیاده‌سازی تبلیغات ویدیویی هم‌نما (Native Video) در پروژه Cocos2dx زبان Lua</h2>
<h3>گام ۱ : راه اندازی پروژه Cocos2dx با زبان Lua</h3>
ابتدا به لینک زیر مراجعه کنید و پلاگین تپسل را به پروژه ی خود اضافه کنید :
<p style="text-align: center;"><a href="#android-init"><button>راه اندازی پروژه اندروید</button></a></p>
<p style="text-align: center;"><a href="#ios-init"><button>راه اندازی پروژه iOS</button></a></p>

<h3>گام ۲: دریافت کلید تپسل</h3>
وارد پنل مدیریت تپسل شده و با تعریف یک اپلیکیشن جدید با عنوان پکیج اپلیکیشن اندرویدی خود، یک کلید تپسل دریافت کنید.
<p style="text-align: center;"><a href="https://dashboard.tapsell.ir"><button>ورود به داشبورد تپسل</button></a></p>

<h3>گام ۳: شروع کار با SDK تپسل</h3>
در ابتدای کد خود (در اسکوپی که می‌خواهید از تپسل استفاده کنید) این خط را اضافه کنید :‌
<pre dir="ltr">local Tapsell = require("app.Tapsell")
</pre>
برای مقداردهی اولیه ، تابع زیر را با ورودی کلید اپ خود صدا بزنید.
<pre dir="ltr">Tapsell:initialize(appKey)</pre>
ورودی appKey کلید تپسلی است که در گام قبل از پنل تپسل دریافت کردید.
<h3>گام ۴: دریافت تبلیغ</h3>
در تبلیغات هم‌نما، شما قادر هستید ویژگی‌های ظاهری هر یک از اجزای تبلیغ (اندازه، محل قرارگیری، رنگ فونت و…) را بصورتی که هماهنگ با محتوای اپلیکیشن شما باشد تعیین کنید.

برای این منظور، شما یک درخواست تبلیغ به SDK تپسل ارسال می کنید، محتوای یک تبلیغ هم‌نمای ویدیویی را دریافت کنید و آن را به نحوه مورد نظر خود نمایش دهید.

جهت ارسال درخواست تبلیغ هم‌نما، از تابع زیر استفاده کنید.
<pre style="color: #000000; background: #ffffff;" dir="ltr"><span style="color: #e34adc;">Tapsell:</span>requestNativeVideoAd<span style="color: #808030;">(</span>
                zoneId <span style="color: #800080;">:</span> string<span style="color: #808030;">,</span>
                onAdAvailable <span style="color: #800080;">:</span> function<span style="color: #808030;">,</span>
                onError<span style="color: #800080;">:</span> function<span style="color: #808030;">,</span>
                onNoAdAvailable <span style="color: #800080;">:</span> function<span style="color: #808030;">,</span>
                onNoNetwork<span style="color: #800080;">:</span> function
            <span style="color: #808030;">)</span>
</pre>
ورودی zoneId، شناسه تبلیغ‌گاه از نوع ویدیویی هم‌نما است که باید آن را از <a href="https://dashboard.tapsell.ir/">داشبورد تپسل</a> دریافت کنید.

نتیجه درخواست تبلیغ به تابع‌های ورودی بازگردانده می شود. یک نمونه پیاده سازی تابع‌های لازم در ادامه آمده است. تابع onAdAvailable یک Table به نام adProps به عنوان پارامتر دارد که داده های تبلیغ در آن در صورت وجود تبلیغ قرار می‌گیرد.
<pre style="color: #000000; background: #ffffff;" dir="ltr"><span style="color: #e34adc;">Tapsell:</span>requestNativeBannerAd<span style="color: #808030;">(</span>
                NATIVE_BANNER_ZONEID<span style="color: #808030;">,</span>
                function<span style="color: #808030;">(</span>adProps<span style="color: #808030;">)</span>
                    <span style="color: #603000;">printf</span><span style="color: #808030;">(</span>
                        <span style="color: #800000;">"</span><span style="color: #0000e6;">onAdAvailable title: </span><span style="color: #007997;">%s</span><span style="color: #0000e6;">, description: </span><span style="color: #007997;">%s</span><span style="color: #0000e6;">, icon_url: </span><span style="color: #007997;">%s</span><span style="color: #0000e6;">, call_to_action_text: </span><span style="color: #007997;">%s</span><span style="color: #0000e6;">, video_url: </span><span style="color: #007997;">%s</span><span style="color: #800000;">"</span><span style="color: #808030;">,</span>
                        adProps<span style="color: #808030;">.</span>title<span style="color: #808030;">,</span>
                        adProps<span style="color: #808030;">.</span>description<span style="color: #808030;">,</span>
                        adProps<span style="color: #808030;">.</span>icon_url<span style="color: #808030;">,</span>
                        adProps<span style="color: #808030;">.</span>call_to_action_text<span style="color: #808030;">,</span>
                        adProps<span style="color: #808030;">.</span>video_url
                    <span style="color: #808030;">)</span>
                end<span style="color: #808030;">,</span>
                function<span style="color: #808030;">(</span>error<span style="color: #808030;">)</span>
                    <span style="color: #603000;">printf</span><span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onError </span><span style="color: #007997;">%s</span><span style="color: #800000;">"</span><span style="color: #808030;">,</span> error<span style="color: #808030;">)</span>
                end<span style="color: #808030;">,</span>
                function<span style="color: #808030;">(</span><span style="color: #808030;">)</span>
                    print<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onNoAdAvailable</span><span style="color: #800000;">"</span><span style="color: #808030;">)</span>
                end<span style="color: #808030;">,</span>
                function<span style="color: #808030;">(</span><span style="color: #808030;">)</span>
                    print<span style="color: #808030;">(</span><span style="color: #800000;">"</span><span style="color: #0000e6;">onNoNetwork</span><span style="color: #800000;">"</span><span style="color: #808030;">)</span>
                end
            <span style="color: #808030;">)</span>
</pre>
<h3 id="گام-۴-نمایش-تبلیغ">گام ۵: نمایش تبلیغ</h3>
برای نمایش تبلیغ، می‌بایست از داده های موجود در تابع onAdAvailable (همان adProps) استفاده کنید. توضیح این داده ها در جدول زیر آمده است :
<table width="100%"><caption>جدول ۱ داده های تابع onAdAvailable (همان adProps)</caption>
<tbody>
<tr>
<th width="40%">مشخصه</th>
<th width="60%">توضیحات</th>
</tr>
<tr>
<td width="40%">adProps.ad_id</td>
<td>شناسه تبلیغ</td>
</tr>
<tr>
<td width="40%">adProps.title</td>
<td>عنوان تبلیغ</td>
</tr>
<tr>
<td width="40%">adProps.description</td>
<td width="60%">توضیحات تبلیغ</td>
</tr>
<tr>
<td width="40%">adProps.call_to_action_text</td>
<td width="60%">متن دعوت کننده از کاربر به کلیک/نصب</td>
</tr>
<tr>
<td width="40%">adProps.video_url</td>
<td width="60%">لینک ویدیو تبلیغ</td>
</tr>
<tr>
<td width="40%">adProps.icon_url</td>
<td width="60%">لینک آیکون تبلیغ</td>
</tr>
</tbody>
</table>
زمانی که پخش ویدیو تمام شد، باید تابع <code>onNativeVideoAdShown</code> از <code>Tapsell</code> را فراخوانی کنید ؛ این تابع یک رشته به عنوان ورودی می‌گیرد که شناسه مربوط به تبلیغی است که نمایش داده شده است.
<pre dir="ltr">Tapsell:onNativeVideoAdShown(adId);</pre>
<h3 id="گام-۵-باز-کردن-تبلیغ">گام ۶: باز کردن تبلیغ</h3>
برای باز کردن تبلیغ، هنگامی که کاربر روی آن کلیک می‌کند، از تابع زیر استفاده کنید. این تابع یک رشته به عنوان ورودی می‌گیرد که شناسه تبلیغی است که روی آن کلیک شده است.
<pre dir="ltr">Tapsell:onNativeVideoAdClicked(adId);</pre>
<h3>نمونه پیاده‌سازی</h3>
یک نمونه پیاده‌سازی SDK تپسل در Cocos2dx Lua در repository زیر آمده است.
<p style="text-align: center;"><a href="https://github.com/hermamitr/TapsellSDK_v3_Cocos2Dx_Lua"><button>مشاهده پروژه نمونه</button></a></p>
لطفا نظرات خود درباره محتوای این فایل و مشکلاتی که در پیاده‌سازی SDK تپسل با آنها مواجه شدید را به ما اطلاع دهید.
</div>

</div>
