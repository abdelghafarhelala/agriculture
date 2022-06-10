// ignore_for_file: avoid_print

import 'package:agriculture/models/userModel/userModel.dart';
import 'package:agriculture/modules/login/loginCubit/loginStates.dart';
import 'package:agriculture/network/endpoints.dart';
import 'package:agriculture/network/local/cache_Helper.dart';
import 'package:agriculture/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPass = true;
  IconData suffix = Icons.visibility_outlined;
  void changePasswordVisibility() {
    isPass = !isPass;
    isPass
        ? suffix = Icons.visibility_outlined
        : suffix = Icons.visibility_off_outlined;
    emit(LoginPasswordShown());
  }

  UserModel? loginModel;
  void userLogin(
      {required String phone, required String password, required var context}) {
    emit(LoginLoadingState());
    DioHelper.postDataWithoutToken(url: loginUrl, data: {
      'mobile': phone,
      'password': password,
      'onesignal_id': '1',
    }).then((value) {
      loginModel = UserModel.fromJson(value.data);
      CacheHelper.saveData(key: 'token', value: loginModel?.success?.token);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState());
    });
  }
}
