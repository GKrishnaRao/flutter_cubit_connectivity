import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';

import 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;


  InternetCubit() :  super(InternetState.Initial) {  // In cubit there is no events only state & functions
    connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        emit(InternetState.Gained); // emit directly without add
      }else{
        emit(InternetState.Lost);  // emit directly without add
      }
    });
  }

  @override
  Future<void> close(){
    connectivitySubscription?.cancel();
    return super.close();
  }// it will initilize the bloc like stateless widget we need to give initial state
}