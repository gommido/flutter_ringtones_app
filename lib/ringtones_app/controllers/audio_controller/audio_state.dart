part of 'audio_cubit.dart';

@immutable
abstract class AudioState {}

class AudioInitial extends AudioState {}

class SetCurrentTrackState extends AudioState {}
class SetAudioPathState extends AudioState {}
class StartPlayState extends AudioState {}
class PauseState extends AudioState {}
class StopState extends AudioState {}
class OnPlayListenerState extends AudioState {}
class OnPlayerStateStreamState extends AudioState {}

class DisposeAudioPlayerState extends AudioState {}

class AddToFavoritesState extends AudioState {}

class SetRingtoneSuccessState extends AudioState {}

class GetAudioDurationsLoadingState extends AudioState {}

class GetAudioDurationsSuccessState extends AudioState {}
