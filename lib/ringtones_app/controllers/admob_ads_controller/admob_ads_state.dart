part of 'admob_ads_cubit.dart';

@immutable
abstract class AdmobAdsState {}

class AdmobAdsInitial extends AdmobAdsState {}

class ShowInterstitialAdLoadingState extends AdmobAdsState {}
class ShowInterstitialAdState extends AdmobAdsState {}
class CreateInterstitialAdSuccessState extends AdmobAdsState {}

class ShowRewardedAdLoadingState extends AdmobAdsState {}
class CreateRewardedAdSuccessState extends AdmobAdsState {}
class ShowRewardedAdState extends AdmobAdsState {}

class IsAdDismissedSuccessState extends AdmobAdsState {}

class CreateAppOpenAdState extends AdmobAdsState {}

class OnAdDisposeDelayLoadingState extends AdmobAdsState {}
class OnAdDisposeDelaySuccessState extends AdmobAdsState {}

class OnDisposeAdState extends AdmobAdsState {}
