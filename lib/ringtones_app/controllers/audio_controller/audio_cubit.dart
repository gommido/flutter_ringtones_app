import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';
import 'package:set_ringtone/set_ringtone.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/ringtones.dart';
import '../../models/track_model.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(AudioInitial()){
    _player = AudioPlayer();
    _isPlaying = false;
    processingState = ProcessingState.idle;
    _isSuccess = false;
    position = Duration.zero;
    _durations =  List<Duration>.filled(tracks.length, Duration.zero);
  }


  late TrackModel _currentTrack;
  TrackModel get currentTrack => _currentTrack;
  void setCurrentTrack(TrackModel track){
    _currentTrack = track;
    emit(SetCurrentTrackState());
  }

  late Duration _currentTrackDuration;
  Duration get currentTrackDuration => _currentTrackDuration;
  void setCurrentTrackDuration(int currentTrackIndex){
    _currentTrackDuration = durations[currentTrackIndex];
    emit(SetCurrentTrackState());
  }

  late AudioPlayer _player;
  AudioPlayer get player => _player;

  late bool _isPlaying;
  bool get isPlaying => _isPlaying;

  Future<void> setTrackPath() async{
    await _player.setAsset(_currentTrack.sound);
    await play();
    emit(SetAudioPathState());
  }

  Future<void> play() async{
    _isPlaying = true;
    await _player.play();
    onPlayListener();
    emit(StartPlayState());
  }

  Future<void> pause() async{
    _isPlaying = false;
    await _player.pause();
    emit(PauseState());
  }

  Future<void> seek(Duration position) async{
    await _player.seek(position);
    emit(PauseState());
  }

  void disposeAudioPlayer(){
    _player.dispose();
    emit(DisposeAudioPlayerState());
  }

  late Duration position;

  void onPlayListener() async{
    _player.positionStream.listen((event){
      position = event;
      emit(OnPlayListenerState());
    });
  }

  late ProcessingState processingState;
  void onPlayerStateStream() async{
    _player.playerStateStream.listen((playerState) {
      processingState = playerState.processingState;
      emit(OnPlayerStateStreamState());
    });
  }


  bool? _isSuccess;
  bool? get isSuccess => _isSuccess;

  void setIsSuccessData(){
    _isSuccess = null;
  }

  Future<bool> setRingtone({required String type})async {
    _isSuccess = false;
    if(type == AppStrings.ringtone){
      _isSuccess =  await Ringtone.setRingtone(_currentTrack.sound);
    }else if(type == AppStrings.notification){
      _isSuccess =  await Ringtone.setNotification(_currentTrack.sound);
    }else{
      _isSuccess =  await Ringtone.setAlarm(_currentTrack.sound);
    }
    emit(SetRingtoneSuccessState());
    return _isSuccess!;
  }


  late List<Duration> _durations;
  List<Duration> get durations => _durations;
  Future<List<Duration?>> getAudioDurations() async {
    emit(GetAudioDurationsLoadingState());
    final assetPaths = tracks.map((track)=> track.sound).toList();
    for(int i = 0; i < assetPaths.length; i++){
      try {
        await _player.setAsset(assetPaths[i]);
        if(_player.duration != null) _durations[i] = _player.duration!;
      } catch (e) {
        _durations[i] = Duration.zero;
      }
      emit(GetAudioDurationsSuccessState());
    }
    return _durations;
  }
}
