import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meta/meta.dart';
import '../../core/constants/app_constants.dart';
part 'admob_ads_state.dart';

class AdmobAdsCubit extends Cubit<AdmobAdsState> {
  AdmobAdsCubit() : super(AdmobAdsInitial()){
    _isAdDismissed = false;
    _clicksNumber = 0;
  }
  InterstitialAd? _interstitialAd;
  InterstitialAd? get interstitialAd => _interstitialAd;

  late bool _isAdDismissed;
  bool get isAdDismissed => _isAdDismissed;

  /// Create Interstitial Ad
  bool? _isAdLoading;
  bool? get isAdLoading =>_isAdLoading;
  void createInterstitialAd() {
    _isAdLoading = true;
    _onAdDisposeDelay();
    InterstitialAd.load(
        adUnitId: AppConstants.interstitialId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  _isAdLoading = null;
                  _isAdDismissed = true;
                  emit(IsAdDismissedSuccessState());
                  ad.dispose();
                },
                onAdClicked: (ad) {
                  _isAdDismissed = true;
                  emit(IsAdDismissedSuccessState());
                });
            _interstitialAd = ad;
            showInterstitialAd();
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
          },
        )).then((value){
      emit(CreateInterstitialAdSuccessState());
    });
  }

  /// Show Interstitial Ad
  void showInterstitialAd() {
    emit(ShowInterstitialAdLoadingState());
    _isAdLoading = null;
    _interstitialAd?.show().then((value){
      emit(ShowInterstitialAdState());
    });
  }

  RewardedAd? _rewardedAd;
  RewardedAd? get rewardedAd => _rewardedAd;
  void createRewardedAd() {
    _isAdLoading = true;
    _onAdDisposeDelay();
    RewardedAd.load(
      adUnitId: AppConstants.rewardedAdId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {},
              onAdImpression: (ad) {},
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                _isAdDismissed = true;
                emit(IsAdDismissedSuccessState());
              },
              onAdClicked: (ad) {
                _isAdDismissed = true;
                emit(IsAdDismissedSuccessState());
              });

          _rewardedAd = ad;
          showRewardedAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
        },
      ),
    ).then((value){
      emit(CreateRewardedAdSuccessState());
    });
  }

  /// Show Rewarded Ad
  void showRewardedAd(){
    emit(ShowRewardedAdLoadingState());
    _isAdLoading = null;
    _rewardedAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      emit(ShowRewardedAdState());
    });
  }

  AppOpenAd? _appOpenAd;
  AppOpenAd? get appOpenAd => _appOpenAd;
  bool _isAdLoaded = false;

  void createAppOpenAd() {
    AppOpenAd.load(
      adUnitId: AppConstants.app_open,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _isAdLoaded = true;
          _showAppOpenAd();
        },
        onAdFailedToLoad: (error) {
        },
      ),
    );
  }

  void _showAppOpenAd() {
    if (_isAdLoaded && _appOpenAd != null) {
      _appOpenAd!.show();
      _appOpenAd = null;
    }
    emit(CreateAppOpenAdState());
  }

  late int _clicksNumber;
  int get clicksNumber => _clicksNumber;

  void increaseClicksNumber(){
    _clicksNumber = _clicksNumber + 1;
  }


  Future<void> _onAdDisposeDelay() async{
    emit(OnAdDisposeDelayLoadingState());
    await Future.delayed(const Duration(seconds: 15));
    emit(OnAdDisposeDelaySuccessState());
  }

  void disposeAd(){
    _interstitialAd?.dispose();
    _isAdLoading = null;
    emit(OnDisposeAdState());
  }

}
