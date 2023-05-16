import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lecle_social_share/lecle_social_share.dart';
import 'package:lecle_social_share/models/models.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String?>? videoUrls = [];
  List<String?>? imageUrls = [];
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media share plugin example'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text(
                  'Basic share',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var video =
                      await _picker.pickVideo(source: ImageSource.gallery);

                  if (video != null) {
                    LecleSocialShare.F.shareFileToFacebook(
                      filePath: video.path,
                      dstPath: '/LecleSocialShareExample/Facebook/',
                      fileProviderPath: '.social.share.fileprovider',
                      fileType: AssetType.video,
                    );
                  }
                },
                child: const Text('Share file to facebook'),
              ),
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
              ElevatedButton(
                onPressed: () {
                  LecleSocialShare.F.shareLinkContentToFacebook(
                    contentUrl: "https://pub.dev",
                  );
                },
                child: const Text('Share link content to facebook'),
              ),
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
                        argumentList: [],
                      ),
                      hashtag: '#helloworld',
                      contentUrl: 'https://pub.dev',
                    );
                  }
                },
                child: const Text('Share camera effect to facebook'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text(
                  'Media content share',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  imageUrls = (await _picker.pickMultiImage())
                      ?.map((image) => image.path)
                      .toList();
                  videoUrls =
                      (await _pickFile(FileType.video, allowMultiple: true))
                          ?.paths;

                  LecleSocialShare.F.shareMediaContentFileToFacebook(
                    imageUrls: imageUrls,
                    videoUrls: videoUrls,
                    fileProviderPath: '.social.share.fileprovider',
                  );
                },
                child: const Text('Share media content file to facebook'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text(
                  'Facebook story share',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var image =
                      await _picker.pickImage(source: ImageSource.gallery);

                  LecleSocialShare.F.shareBackgroundAssetFileToFacebookStory(
                    appId: '3258588111079263',
                    filePath: image?.path,
                    fileProviderPath: '.social.share.fileprovider',
                    fileType: AssetType.image,
                  );
                },
                child: const Text(
                  'Share background asset file to facebook story',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var image =
                      await _picker.pickImage(source: ImageSource.gallery);

                  LecleSocialShare.F.shareStickerAssetToFacebookStory(
                    appId: '3258588111079263',
                    stickerPath: image?.path,
                    fileProviderPath: '.social.share.fileprovider',
                  );
                },
                child: const Text(
                    'Share sticker background asset to facebook story'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text(
                  'Facebook story share ${Platform.isAndroid ? 'using ShareStoryContent' : ''}',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
              Visibility(
                visible: Platform.isAndroid,
                child: ElevatedButton(
                  onPressed: () async {
                    var image =
                        await _picker.pickImage(source: ImageSource.gallery);

                    LecleSocialShare.F
                        .shareBitmapImageBackgroundAssetToFacebookStory(
                      imagePath: image?.path,
                      fileProviderPath: '.social.share.fileprovider',
                    );
                  },
                  child: const Text(
                      'Share bitmap image background asset to facebook story'),
                ),
              ),
              Visibility(
                visible: Platform.isAndroid,
                child: ElevatedButton(
                  onPressed: () async {
                    var image =
                        await _picker.pickImage(source: ImageSource.gallery);

                    LecleSocialShare.F
                        .shareImageBackgroundAssetContentToFacebookStory(
                      photoBackgroundAssetPath: image?.path,
                      fileProviderPath: '.social.share.fileprovider',
                    );
                  },
                  child: const Text(
                      'Share photo background asset content to facebook story'),
                ),
              ),
              Visibility(
                visible: Platform.isAndroid,
                child: ElevatedButton(
                  onPressed: () async {
                    var video =
                        await _picker.pickVideo(source: ImageSource.gallery);

                    LecleSocialShare.F
                        .shareVideoBackgroundAssetContentToFacebookStory(
                      videoBackgroundAssetPath: video?.path,
                      fileProviderPath: '.social.share.fileprovider',
                    );
                  },
                  child: const Text(
                      'Share video background asset to facebook story'),
                ),
              ),
              Visibility(
                visible: Platform.isIOS,
                child: ElevatedButton(
                  onPressed: () async {
                    var images = await _picker.pickMultiImage();
                    var stickers = await _picker.pickMultiImage();

                    LecleSocialShare.F
                        .shareBackgroundImageAndStickerToFacebookStoryiOS(
                      photoBackgroundAssetPaths:
                          images?.map((image) => image.path).toList(),
                      stickerAssetPaths:
                          stickers?.map((image) => image.path).toList(),
                      appId: '3258588111079263',
                    );
                  },
                  child: const Text(
                      'Share background image and sticker asset to facebook story iOS'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text(
                  'Facebook reels share',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  XFile? sticker;
                  if (Platform.isAndroid) {
                    sticker =
                        await _picker.pickImage(source: ImageSource.gallery);
                  }
                  var video = await _pickFile(FileType.video);

                  LecleSocialShare.F.shareVideoToFacebookReels(
                    filePath: video?.paths[0],
                    fileProviderPath: '.social.share.fileprovider',
                    appId: '3258588111079263',
                    stickerPath: sticker?.path,
                  );
                },
                child: const Text(
                    'Share video asset (and sticker on Android) to facebook reels'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text(
                  'Instagram share',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var video =
                      await _picker.pickImage(source: ImageSource.gallery);

                  if (video != null) {
                    LecleSocialShare.I.shareFileToInstagram(
                      filePath: video.path,
                      fileProviderPath: '.social.share.fileprovider',
                      fileType: AssetType.image,
                    );
                  }
                },
                child: const Text('Share file to instagram'),
              ),
              ElevatedButton(
                onPressed: () async {
                  LecleSocialShare.I.sendMessageToInstagram(
                    message: 'Hello world',
                  );
                },
                child: const Text('Send message to instagram'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text(
                  'Messenger share',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var video =
                      await _picker.pickVideo(source: ImageSource.gallery);

                  LecleSocialShare.M
                      .shareFileToMessenger(
                    filePath: video?.path,
                    fileProviderPath: '.social.share.fileprovider',
                    fileType: AssetType.video,
                    hashtag: '#helloworld',
                    contentUrl: 'https://pub.dev',
                  )
                      .catchError((err) {
                    print('Share file to messenger error $err');
                  });
                },
                child: const Text('Share file to messenger'),
              ),
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
              const Padding(
                padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text(
                  'Telegram share',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  LecleSocialShare.T.sendMessageToTelegram(
                    message: 'Hello world',
                  );
                },
                child: const Text('Send message to Telegram'),
              ),
              ElevatedButton(
                onPressed: () async {
                  LecleSocialShare.T.openTelegramDirectMessage(
                    username: 'user_name',
                  );
                },
                child: const Text('Open Telegram direct message'),
              ),
              ElevatedButton(
                onPressed: () async {
                  LecleSocialShare.T.openTelegramChannelViaShareLink(
                    inviteLink: 'your_invite_link',
                  );
                },
                child: const Text('Open Telegram group via invite link'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var file = await _pickFile(FileType.any);

                  LecleSocialShare.T.shareFileToTelegram(
                    filePath: file?.paths[0],
                    fileProviderPath: '.social.share.fileprovider',
                    fileType: AssetType.any,
                    message: 'Hello friend',
                  );
                },
                child: const Text('Share file to Telegram'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text(
                  'WhatsApp share',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var file = await _pickFile(FileType.any);

                  LecleSocialShare.W.shareFileToWhatsApp(
                    filePath: file?.paths[0],
                    fileType: AssetType.pdf,
                    fileProviderPath: '.social.share.fileprovider',
                    message: 'Hello friend',
                  );
                },
                child: const Text('Share file to WhatsApp'),
              ),
              ElevatedButton(
                onPressed: () async {
                  LecleSocialShare.W.sendMessageToWhatsApp(
                    message: 'https://pub.dev',
                    phoneNumber: "receiver_phone_number",
                  );
                },
                child: const Text('Send message to WhatsApp'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text(
                  'Twitter share',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
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
              ElevatedButton(
                onPressed: () async {
                  var file =
                      await _picker.pickImage(source: ImageSource.gallery);

                  LecleSocialShare.TW.shareFileToTwitter(
                    filePath: file?.path,
                    fileProviderPath: '.social.share.fileprovider',
                    fileType: AssetType.image,
                    iOSConsumerKey: 'abc',
                    iOSSecretKey: 'xyz',
                    title: "Hello world",
                  );
                },
                child: const Text('Share file to Twitter'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24.0, bottom: 8.0),
                child: Text(
                  'TikTok share',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var res = await _picker.pickMultiImage();

                  LecleSocialShare.TI.shareFilesToTikTok(
                    fileUrls: res?.map((e) => e.path).toList(),
                    fileType: AssetType.image,
                    fileProviderPath: '.social.share.fileprovider',
                  );
                },
                child: const Text('Share files to TikTok'),
              ),
              ElevatedButton(
                onPressed: () async {
                  LecleSocialShare.TI.openTikTokUserPage(
                    username: 'username',
                  );
                },
                child: const Text('Open TikTok user page'),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }

  Future<FilePickerResult?> _pickFile(FileType type,
      {bool allowMultiple = false}) async {
    return await FilePicker.platform
        .pickFiles(allowMultiple: allowMultiple, type: type);
  }
}
