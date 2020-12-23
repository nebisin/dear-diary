import 'package:firebase_admob/firebase_admob.dart';

class AdvertService {
  static final AdvertService _instance = AdvertService._internal();
  factory AdvertService() => _instance;
  MobileAdTargetingInfo _targetingInfo;
  final String _bannerAd = 'ca-app-pub-1639338975133942/6880648672';
  final String _interAd = 'ca-app-pub-1639338975133942/3236933043';

  AdvertService._internal() {
    _targetingInfo = MobileAdTargetingInfo();
  }

  showBanner() {
    BannerAd banner = BannerAd(
      adUnitId: _bannerAd,
      size: AdSize.smartBanner,
      targetingInfo: _targetingInfo,
    );

    banner
      ..load()
      ..show();

    banner.dispose();
  }

  showIntersitial() {
    InterstitialAd interstitialAd = InterstitialAd(
      adUnitId: _interAd,
      targetingInfo: _targetingInfo,
    );

    interstitialAd
      ..load()
      ..show();

    interstitialAd.dispose();
  }
}
