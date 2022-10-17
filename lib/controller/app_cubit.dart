import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gr_code_generator/controller/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  String? qrCodeText;

  generateQrCode(String qrCodeMessage) {
    qrCodeText = qrCodeMessage;
    emit(GenerateQrCodeSuccessState());
  }
}
