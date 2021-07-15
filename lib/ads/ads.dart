import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'YOUR_DEVICE_ID';
String androidAdAppId = FirebaseAdMob.testAppId;
String iosAdAppId = FirebaseAdMob.testAppId;
String androidBannerAdUnitId = BannerAd.testAdUnitId;
String iosBannerAdUnitId = BannerAd.testAdUnitId;
String androidInterstitialAdUnitId = InterstitialAd.testAdUnitId;
String iosInterstitialAdUnitId = InterstitialAd.testAdUnitId;

// class Ads {
//   MobileAdTargetingInfo targetingInfo() => MobileAdTargetingInfo(
//         contentUrl: 'https://flutter.io',
//         childDirected: false,
//         testDevices: testDevice != null
//             ? <String>[testDevice]
//             : null, // Android emulators are considered test devices
//   );

//   BannerAd myBanner() => BannerAd(
//         adUnitId: Platform.isIOS ? iosBannerAdUnitId : androidBannerAdUnitId,
//         size: AdSize.smartBanner,
//         targetingInfo: targetingInfo(),
//         listener: (MobileAdEvent event) {
//           print("BannerAd event is $event");
//         },
//   );

//   InterstitialAd myInterstitial() => InterstitialAd(
//         adUnitId: Platform.isAndroid
//             ? androidInterstitialAdUnitId
//             : iosInterstitialAdUnitId,
//         targetingInfo: targetingInfo(),
//         listener: (MobileAdEvent event) {
//           print("InterstitialAd event is $event");
//         },
//   );

//   void disable(ad) {
//     try {
//       ad?.dispose();
//     } catch (e) {
//       print("no ad found");
//     }
//   }
// }
