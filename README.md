# lecle_social_share

A Flutter project support share file to social media (Facebook, Instagram, etc.). If you only want to share files on certain platforms, 
this plugin is made for you.

Current supported platform:

* ***Facebook***
* ***Instagram***
* ***Messenger***
* ***Telegram***
* ***WhatsApp***
* ***Twitter***
* ***TikTok***

There are static instances in LecleSocialShare class represent for:
* F: Facebook
* I: Instagram
* M: Messenger
* T: Telegram
* W: WhatsApp
* TW: Twitter
* TI: TikTok

**Simply use LecleSocialShare class and call the instance of which platform you want to share 
then call the corresponding method from the instance**

## Android

Paste the following attribute in the manifest tag in the AndroidManifest.xml

```xml

xmlns:tools="http://schemas.android.com/tools"
```

For example:

```xml

<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          xmlns:tools="http://schemas.android.com/tools"
          package="your package...">
```

Add these permissions and queries to your AndroidManifest.xml

```xml

<queries>
    <!-- Explicit apps you know in advance about: -->
    <package android:name="com.instagram.android" />
    <package android:name="com.facebook.katana" />
    <package android:name="com.facebook.orca" />
    <package android:name="org.telegram.messenger" />
    <package android:name="com.whatsapp" />
    <package android:name="com.twitter.android" />
    <package android:name="com.zhiliaoapp.musically" />
    <package android:name="com.ss.android.ugc.trill" />
</queries>

<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />  
```

Create xml folder and add a provider path file to it (for example: provider_paths_app.xml) in android/app/src/main/res and 
add the lines below to the created xml file

```xml
<?xml version="1.0" encoding="utf-8"?>
<paths>
    <external-path
        name="external_files"
        path="." />
</paths>
```

After created your own file provider and define your own path paste them into this and add to your AndroidManifest.xml

```xml

<provider android:name="androidx.core.content.FileProvider" 
        android:authorities="${applicationId}.[your_custom_fileProvider_path]"
    android:exported="false" android:grantUriPermissions="true">
    <meta-data android:name="android.support.FILE_PROVIDER_PATHS" android:resource="@xml/[your_custom_fileProvider_file_name]" />
</provider>
```

### Facebook app register

+ In /android/app/src/main/values folder create a strings.xml file and add your facebook app id and facebook client token.
+ To get the facebook client token: Open your app on Meta for developer ([link](https://developers.facebook.com)) > Settings > Advanced > Security >
  Application code
+ To get the facebook app id follow the Meta link above and go to your app Settings > Basic information > App ID

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="facebook_app_id">[facebook_app_id]</string>
    <string name="facebook_client_token">[facebook_client_token]</string>
</resources>
```

+ After complete the step above add these xml tags to your AndroidManifest.xml
+ To create the custom facebook theme: In android/app/src/main/res/values define your custom theme and 
add to the [your_custom_theme] in the activity below
+ Custom theme example:

```xml

<style name="com_facebook_activity_theme" parent="@style/Theme.AppCompat.NoActionBar">
  <item name="android:windowIsTranslucent">true</item>
  <item name="android:windowBackground">@android:color/transparent</item>
  <item name="android:windowNoTitle">true</item>
</style>

```

```xml

<provider android:name="com.facebook.FacebookContentProvider" android:authorities="com.facebook.app.FacebookContentProvider[your_facebook_app_id]"
    android:exported="true" />

<meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id" />
<meta-data android:name="com.facebook.sdk.ClientToken" android:value="@string/facebook_client_token" />

<activity android:name="com.facebook.FacebookActivity" 
android:configChanges="keyboard|keyboardHidden|screenLayout|screenSize|orientation"
android:theme="@style/[your_custom_theme]" />

<activity android:name="com.facebook.CustomTabMainActivity" />
<activity android:name="com.facebook.CustomTabActivity" android:exported="true" tools:node="merge">
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="fbconnect" android:host="cct.${applicationId}" />
</intent-filter>
</activity>
```

## iOS

***Open Xcode and change your deployment target to iOS 11***

Add these lines to your Info.plist file

```xml

<key>CFBundleURLTypes</key>
<array>
<dict>
    <key>CFBundleURLSchemes</key>
    <array>
        <string>fb[your_facebook_app_id]</string>
        <string>[your_tiktok_app_id]</string>
    </array>
</dict>
</array>

<key>LSApplicationQueriesSchemes</key>
<array>
  <string>instagram</string>
  <string>fb</string>
  <string>fbauth2</string>
  <string>fbshareextension</string>
  <string>fbapi</string>
  <string>facebook-reels</string>
  <string>facebook-stories</string>
  <string>fb-messenger-share-api</string>
  <string>fb-messenger</string>
  <string>tg</string>
  <string>whatsapp</string>
  <string>twitter</string>
  
  <string>tiktokopensdk</string>
  <string>tiktoksharesdk</string>
  <string>snssdk1180</string>
  <string>snssdk1233</string>
</array>

<key>NSPhotoLibraryUsageDescription</key>
<string>$(PRODUCT_NAME) needs permission to access photos and videos on your device</string>
<key>NSMicrophoneUsageDescription</key>
<string>$(PRODUCT_NAME) does not require access to the microphone.</string>
<key>NSCameraUsageDescription</key>
<string>$(PRODUCT_NAME) requires access to the camera.</string>
<key>NSAppleMusicUsageDescription</key>
<string>$(PRODUCT_NAME) requires access to play music</string>

<key>FacebookAppID</key>
<string>[your_facebook_app_id]</string>
<key>FacebookClientToken</key>
<string>[your_facebook_client_token]</string>
<key>FacebookDisplayName</key>
<string>[your_facebook_app_display_name]</string>

<key>NSBonjourServices</key>
<array>
<string>_dartobservatory._tcp</string>
</array>

<key>TikTokAppID</key>
<string>[your_tiktok_app_id]</string>
```

***The facebook app id and facebook client token you can get by complete the steps mentioned on Android config***

Update your AppDelegate.swift the same as the below example

```
import UIKit
import Flutter

// Add these lines
import FBSDKCoreKit
import TikTokOpenSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // Add these lines
        FBSDKCoreKit.ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        TikTokOpenSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // Add this method
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
              let annotation = options[UIApplication.OpenURLOptionsKey.annotation] else {
            return false
        }
        
        if TikTokOpenSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: sourceApplication, annotation: annotation) {
            return true
        }
        return false
    }
    
    // Add this method
    override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if TikTokOpenSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) {
            return true
        }
        return false
    }
    
    // Add this method
    override func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        if TikTokOpenSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: nil, annotation: "") {
            return true
        }
        return false
    }
}

```

Update your AppDelegate.swift file to register TikTok from the instruction of step 4 in TikTok's document 
[here](https://developers.tiktok.com/doc/getting-started-ios-quickstart-swift/).

### Twitter app register

+ To get the Twitter app consumer key and secret key you can follow the instruction in this 
[Stackoverflow link](https://stackoverflow.com/questions/1808855/getting-new-twitter-api-consumer-and-secret-keys)

### TikTok app register

+ To register a TikTok app for development, you can go to [TikTok for developers page](https://developers.tiktok.com) and create one. 
After create an app on `TikTok for developers page` you can get the client key and the client secret of the app to 
register and use the TikTok share features of the plugin.
+ For the project config you can follow the step 3 and step 4 in 
[this TikTok's document](https://developers.tiktok.com/doc/getting-started-ios-quickstart-swift/). However, we have integrated 
the step 3 and step 4 in the AppDelegate.swift file and the Info.plist file above, 
if you need to find some more information you can check them again in this document.

## Facebook features

### Working on both platform

```dart

Future<dynamic> shareFileToFacebook();
Future<dynamic> shareFeedContentToFacebook();
Future<dynamic> shareLinkContentToFacebook();
Future<dynamic> shareMediaContentFileToFacebook();
Future<dynamic> shareBackgroundAssetFileToFacebookStory();
Future<dynamic> shareStickerAssetToFacebookStory();
Future<dynamic> shareVideoToFacebookReels();
Future<dynamic> shareCameraEffectToFacebook();

```

### Features for Android platform

```dart

Future<dynamic> shareBitmapImageBackgroundAssetToFacebookStory();
Future<dynamic> shareImageBackgroundAssetContentToFacebookStory();
Future<dynamic> shareVideoBackgroundAssetContentToFacebookStory();

```

### Features for iOS platform

```dart

Future<dynamic> shareBackgroundImageAndStickerToFacebookStoryiOS();

```

## Instagram features

### Working on both platform

```dart

Future<dynamic> shareFileToInstagram();
Future<dynamic> sendMessageToInstagram();

```

## Messsenger features

### Working on both platform

```dart

Future<dynamic> shareFileToMessenger();
Future<dynamic> sendMessageToMessenger();
Future<dynamic> shareLinkContentToMessenger();

```

## Telegram features

### Working on both platform

```dart

Future<dynamic> sendMessageToTelegram();
Future<dynamic> openTelegramDirectMessage();
Future<dynamic> openTelegramChannelViaShareLink();
Future<dynamic> shareFileToTelegram();

```

## WhatsApp features

### Working on both platform

```dart

Future<dynamic> shareFileToWhatsApp();
Future<dynamic> sendMessageToWhatsApp();

```

## Twitter features

### Working on both platform

```dart

Future<dynamic> createTwitterTweet();
Future<dynamic> shareFileToTwitter();

```

## TikTok features

### Working on both platform

```dart

Future<dynamic> shareFilesToTikTok();
Future<dynamic> openTikTokUserPage();
```

## Example

### Facebook

- `Future<dynamic> shareFileToFacebook()`

```dart

ElevatedButton(
  onPressed: () async {
    var video =
            await _picker.pickImage(source: ImageSource.gallery);
    
    if (video != null) {
      LecleSocialShare.F.shareFileToFacebook(
        filePath: video.path,
        dstPath: 'your_custom_save_folder',
        fileProviderPath: 'your_custom_fileProvider_path',
        fileType: AssetType.image,
      );
    }
  },
  child: const Text('Share file to facebook'),
),

```

- `Future<dynamic> shareFeedContentToFacebook()`

```dart

ElevatedButton(
  onPressed: () {
    LecleSocialShare.F.shareFeedContentToFacebook(
      link: "https://pub.dev",
      linkName: "pub",
      hashtag: "flutter_pub",
    );
  },
  child: const Text('Share feed content to facebook'),
),

```

- `Future<dynamic> shareLinkContentToFacebook()`

```dart

ElevatedButton(
  onPressed: () {
    LecleSocialShare.F.shareLinkContentToFacebook(
      contentUrl: "https://pub.dev",
    );
  },
  child: const Text('Share link content to facebook'),
),

```

- `Future<dynamic> shareMediaContentFileToFacebook()`

```dart

ElevatedButton(
  onPressed: () async {
  imageUrls = (await _picker.pickMultiImage())?.map((image) => image.path).toList();
  videoUrls = (await _pickFile(FileType.video, allowMultiple: true))?.paths;
  
    LecleSocialShare.F.shareMediaContentFileToFacebook(
      imageUrls: imageUrls,
      videoUrls: videoUrls,
      fileProviderPath: 'your_custom_fileProvider_path',
    );
  },
  child: const Text('Share media content file to facebook'),
),

```

- `Future<dynamic> shareCameraEffectToFacebook()`

```dart

ElevatedButton(
  onPressed: () async {
    var texture =
        await _picker.pickImage(source: ImageSource.gallery);

    if (texture != null) {
      LecleSocialShare.F.shareCameraEffectToFacebook(
        cameraEffectTextures: CameraEffectTextures(
          textureKey: 'texture_key',
          textureUrl: texture.path,
        ),
        cameraEffectArguments: const CameraEffectArguments(
          argumentKey: 'argument_key',
          argumentValue: 'argument_value',
          argumentList: ['argument_value'],
        ),
        hashtag: '#helloworld',
        contentUrl: 'https://pub.dev',
      );
    }
  },
  child: const Text('Share camera effect to facebook'),
)
```

- `Future<dynamic> shareBackgroundAssetFileToFacebookStory()`

```dart

ElevatedButton(
  onPressed: () async {
    var image = await _picker.pickVideo(source: ImageSource.gallery);
    
    LecleSocialShare.F.shareBackgroundAssetFileToFacebookStory(
      appId: 'your_facebook_app_id',
      filePath: image?.path,
      fileProviderPath: 'your_custom_fileProvider_path',
      fileType: AssetType.video,
    );
  },
  child: const Text(
    'Share background asset file to facebook story',
  ),
),

```

- `Future<dynamic> shareStickerAssetToFacebookStory()`

```dart

ElevatedButton(
  onPressed: () async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    LecleSocialShare.F.shareStickerAssetToFacebookStory(
      appId: 'your_facebook_app_id',
      stickerPath: image?.path,
      fileProviderPath: 'your_custom_fileProvider_path',
    );
  },
  child: const Text('Share sticker background asset to facebook story'),
),

```

- `Future<dynamic> shareBitmapImageBackgroundAssetToFacebookStory()`

```dart

// ShareStoryContent class in Facebook SDK is not working for now, you can use 
// Future<dynamic> shareImageBackgroundAssetToFacebookStory() or Future<dynamic> shareStickerAssetToFacebookStory()
// methods instead.
Visibility(
  visible: Platform.isAndroid,
  child: ElevatedButton(
    onPressed: () async {
      var image = await _picker.pickImage(source: ImageSource.gallery);
      LecleSocialShare.F.shareBitmapImageBackgroundAssetToFacebookStory(
        imagePath: image?.path,
        fileProviderPath: 'your_custom_fileProvider_path',
      );
    },
    child: const Text('Share bitmap image background asset to facebook story'),
  ),
),

```

- `Future<dynamic> shareImageBackgroundAssetContentToFacebookStory()`

```dart

// ShareStoryContent class in Facebook SDK is not working for now, you can use 
// Future<dynamic> shareImageBackgroundAssetToFacebookStory() or Future<dynamic> shareStickerAssetToFacebookStory()
// methods instead.
Visibility(
  visible: Platform.isAndroid,
  child: ElevatedButton(
    onPressed: () async {
      var image = await _picker.pickImage(source: ImageSource.gallery);
      LecleSocialShare.F.shareImageBackgroundAssetContentToFacebookStory(
        photoBackgroundAssetPath: image?.path,
        fileProviderPath: 'your_custom_fileProvider_path',
      );
    },
    child: const Text('Share photo background asset to facebook story'),
  ),
),

```

- `Future<dynamic> shareVideoBackgroundAssetContentToFacebookStory()`

```dart

// ShareStoryContent class in Facebook SDK is not working for now, you can use 
// Future<dynamic> shareVideoBackgroundAssetToFacebookStory() method instead.
Visibility(
  visible: Platform.isAndroid,
  child: ElevatedButton(
    onPressed: () async {
      var video = await _picker.pickVideo(source: ImageSource.gallery);
      LecleSocialShare.F.shareVideoBackgroundAssetContentToFacebookStory(
        videoBackgroundAssetPath: video?.path,
        fileProviderPath: 'your_custom_fileProvider_path',
      );
    },
    child: const Text('Share video background asset to facebook story'),
  ),
),

```

- `Future<dynamic> shareVideoToFacebookReels()`

```dart

ElevatedButton(
  onPressed: () async {
    var sticker = await _picker.pickImage(source: ImageSource.gallery);
    var video = await _pickFile(FileType.video);
    
    LecleSocialShare.F.shareVideoToFacebookReels(
      filePath: video?.paths[0],
      fileProviderPath: 'your_custom_fileProvider_path',
      appId: 'your_facebook_app_id',
      stickerPath: sticker?.path,
    );
  },
  child: const Text('Share video asset (and sticker on Android) to facebook reels'),
),

```

- `Future<dynamic> shareBackgroundImageAndStickerToFacebookStoryiOS()`

```dart

Visibility(
  visible: Platform.isIOS,
  child: ElevatedButton(
    onPressed: () async {
      var images = await _picker.pickMultiImage();
      var stickers = await _picker.pickMultiImage();

      LecleSocialShare.F.shareBackgroundImageAndStickerToFacebookStoryiOS(
        photoBackgroundAssetPaths: images?.map((image) => image.path).toList(),
        stickerAssetPaths: stickers?.map((image) => image.path).toList(),
        appId: 'your_facebook_app_id',
      );
    },
    child: const Text('Share background image and sticker asset to facebook story iOS'),
  ),
),

```

### Instagram

- `Future<dynamic> shareFileToInstagram()`

```dart

ElevatedButton(
  onPressed: () async {
    var video = await _picker.pickImage(source: ImageSource.gallery);
  
    if (video != null) {
      LecleSocialShare.I.shareFileToInstagram(
        filePath: video.path,
        fileProviderPath: 'your_custom_fileProvider_path',
        fileType: AssetType.image,
      );
    }
  },
  child: const Text('Share file to instagram'),
),

```

- `Future<dynamic> sendMessageToInstagram()`

```dart

ElevatedButton(
  onPressed: () async {
    LecleSocialShare.I.sendMessageToInstagram(
      message: 'Hello world',
    );
  },
  child: const Text('Send message to instagram'),
),
```

### Messenger

- `Future<dynamic> shareFileToMessenger()`

```dart

ElevatedButton(
  onPressed: () async {
    var video = await _picker.pickVideo(source: ImageSource.gallery);
    
    LecleSocialShare.M.shareFileToMessenger(
      filePath: video?.path,
      fileProviderPath: 'your_custom_fileProvider_path',
      fileType: AssetType.video,
      hashtag: '#helloworld',
      contentUrl: 'https://pub.dev',
    );
  },
  child: const Text('Share file to messenger'),
),
```

- `Future<dynamic> sendMessageToMessenger()`

```dart

ElevatedButton(
  onPressed: () async {
    LecleSocialShare.M.sendMessageToMessenger(
      message: 'https://pub.dev',
      quote: 'Hello world',
      hashtag: '#hello',
    );
  },
  child: const Text('Send message to messenger'),
),
```

- `Future<dynamic> shareLinkContentToMessenger()`

```dart

ElevatedButton(
  onPressed: () async {
    LecleSocialShare.M.shareLinkContentToMessenger(
      contentUrl: 'https://pub.dev',
      quote: 'Hello world',
      hashtag: '#hello',
    );
  },
  child: const Text('Share link content to messenger'),
),
```

### Telegram

- `Future<dynamic> sendMessageToTelegram()`

```dart

ElevatedButton(
  onPressed: () async {
    LecleSocialShare.T.sendMessageToTelegram(
      message: 'Hello world',
    );
  },
  child: const Text('Send message to Telegram'),
),
```

- `Future<dynamic> openTelegramDirectMessage()`

```dart

ElevatedButton(
  onPressed: () async {
    LecleSocialShare.T.openTelegramDirectMessage(
      username: 'user_name',
    );
  },
  child: const Text('Open Telegram direct message'),
),
```

- `Future<dynamic> openTelegramChannelViaShareLink()`

```dart

ElevatedButton(
  onPressed: () async {
    LecleSocialShare.T.openTelegramChannelViaShareLink(
      inviteLink: 'your_invite_link',
    );
  },
  child: const Text('Open Telegram group via invite link'),
),
```

- `Future<dynamic> shareFileToTelegram()`

```dart

ElevatedButton(
  onPressed: () async {
    var video = await _picker.pickVideo(source: ImageSource.gallery);
  
    LecleSocialShare.T.shareFileToTelegram(
      filePath: video?.path,
      fileProviderPath: 'your_custom_fileProvider_path',
      fileType: AssetType.any,
      message: 'Hello world',
    );
  },
  child: const Text('Share file to Telegram'),
),

ElevatedButton(
  onPressed: () async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    LecleSocialShare.T.shareFileToTelegram(
      filePath: image?.path,
      fileProviderPath: 'your_custom_fileProvider_path',
      fileType: AssetType.any,
      message: 'Hello world',
    );
  },
  child: const Text('Share file to Telegram'),
),
```

### WhatsApp

- `Future<dynamic> shareFileToWhatsApp()`

```dart

ElevatedButton(
onPressed: () async {
    var file = await _pickFile(FileType.any);
  
    LecleSocialShare.W.shareFileToWhatsApp(
      filePath: file?.paths[0],
      fileType: AssetType.pdf,
      fileProviderPath: 'your_custom_fileProvider_path',
      message: 'Hello world',
    );
  },
  child: const Text('Share file to WhatsApp'),
),

```

- `Future<dynamic> sendMessageToWhatsApp()`

```dart

ElevatedButton(
  onPressed: () async {
    LecleSocialShare.W.sendMessageToWhatsApp(
      message: 'https://pub.dev',
      phoneNumber: "receiver_phone_number",
    );
  },
  child: const Text('Send message to WhatsApp'),
),

```

### Twitter

- `Future<dynamic> createTwitterTweet()`

```dart

ElevatedButton(
  onPressed: () async {
    LecleSocialShare.TW.createTwitterTweet(
      title: 'Hello world',
      attachedUrl: "https://pub.dev",
      hashtags: [
        'hello',
        'world',
      ],
      via: 'abc',
      related: ['twitter', 'twitterapi'],
    );
  },
  child: const Text('Create Twitter tweet'),
),

```

- `Future<dynamic> shareFileToTwitter()`

```dart

ElevatedButton(
  onPressed: () async {
    var file = await _picker.pickImage(source: ImageSource.gallery);
  
    LecleSocialShare.TW.shareFileToTwitter(
      filePath: file?.path,
      fileProviderPath: 'your_custom_fileProvider_path',
      fileType: AssetType.image,
      iOSConsumerKey: 'abc',
      iOSSecretKey: 'xyz',
      title: "Hello world",
    );
  },
  child: const Text('Share file to Twitter'),
),

```

### TikTok

- `Future<dynamic> shareFilesToTikTok()`

```dart

ElevatedButton(
  onPressed: () async {
    var res = await _picker.pickMultiImage();
    
    LecleSocialShare.TI.shareFilesToTikTok(
      fileUrls: res?.map((e) => e.path).toList(),
      fileType: AssetType.image,
      fileProviderPath: 'your_custom_fileProvider_path',
    );
  },
  child: const Text('Share files to TikTok'),
),
```

- `Future<dynamic> openTikTokUserPage()`

```dart

ElevatedButton(
  onPressed: () async {
    LecleSocialShare.TI.openTikTokUserPage(
      username: 'username',
    );
  },
  child: const Text('Open TikTok user page'),
),
```

