// ignore_for_file: avoid_print

import 'package:agriculture/models/ContactUsModel/contactUsModel.dart';
import 'package:agriculture/models/aboutUsModel/aboutUsModel.dart';
import 'package:agriculture/models/categoryModel/categoryModel.dart';
import 'package:agriculture/models/cropsModel/cropsModel.dart';
import 'package:agriculture/models/profileModel/profileModel.dart';
import 'package:agriculture/models/sliderAdvModel/sliderAdvModel.dart';
import 'package:agriculture/models/sliderModel/sliderModel.dart';
import 'package:agriculture/models/sponserModel/sponserModel.dart';
import 'package:agriculture/modules/homeScreen/homeScreen.dart';
import 'package:agriculture/modules/login/login.dart';
import 'package:agriculture/network/endpoints.dart';
import 'package:agriculture/network/local/cache_Helper.dart';
import 'package:agriculture/network/remote/dio_helper.dart';
import 'package:agriculture/shared/components/components.dart';
import 'package:agriculture/shared/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  bool isFirst = true;
  List<BottomNavigationBarItem> buttomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسيه'),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'الخدمات'),
    const BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'اتصل بنا'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.post_add_outlined), label: 'الحجز'),
  ];
  // List<String> titles = [
  //   'الرئيسيه',
  //   'الخدمات',
  //   'اتصل بنا',
  //   'الحجز',
  // ];
  // List<Widget> appScreens = [
  //   const HomeScreen(),
  //   // const MainServicesScreen(),
  //   // const ContactUsScreen(),
  //   // BookingScreen(),
  // ];

  int currentIndex = 0;

  void changeAppNav(index) {
    currentIndex = index;
    emit(ChangeNavButtomNavState());
  }

  var isDark = true;
  void changeAppTheme({bool? fromCache}) {
    if (fromCache != null) {
      isDark = fromCache;
      emit(AppChangeThemState());
    } else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeThemState());
      });
    }
  }

  void logOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        // profile = null;
        navigateAndFinish(context, const LoginScreen());
        emit(AppLogoutSuccessState());
      }
    });
  }

  AboutUsModel? about;

  void getAboutData() {
    emit(AppGetAboutUsDataLoadingState());
    DioHelper.getDataWithoutToken(url: aboutUsUrl).then((value) {
      print(value.data);
      about = AboutUsModel.fromJson(value.data);
      // print(category?.data?[0].name);
      emit(AppGetAboutUsDataSuccessState());
    }).catchError((error) {
      emit(AppGetAboutUsDataErrorState());
      print(error.toString());
    });
  }

  contactUsModel? contact;
  void contactUsData({
    required String name,
    required String phone,
    required String email,
    required String message,
  }) {
    emit(AppPostContactLoadingState());
    DioHelper.postDataWithoutToken(url: contactUsUrl, data: {
      'name': name,
      'phone': phone,
      'email': email,
      'subject': message,
      'message': 'a'
    }).then((value) {
      print(value.data);
      contact = contactUsModel.fromJson(value.data);
      print(contact?.errorMessage);
      emit(AppPostContactSuccessState(contact!));
    }).catchError((error) {
      emit(AppPostContactErrorState());
      print(error.toString());
    });
  }

  ProfileModel? profile;
  void getUserData() {
    emit(AppGetUserDataLoadingState());
    DioHelper.getData(url: profileUrl, token: token).then((value) {
      profile = ProfileModel.fromJson(value.data);
      print(profile!.data!.name);
      emit(AppGetUserDataSuccessState());
    }).catchError((error) {
      emit(AppGetUserDataErrorState());
      print(error.toString());
    });
  }

//get all product
  int productLength = 0;
  List<ProductData> productData = [];
  ProductModel? product;
  void getProductData() {
    emit(AppGetProductLoadingState());
    DioHelper.getDataWithoutToken(url: productUrl).then((value) {
      product = ProductModel.fromJson(value.data);
      productLength = product!.data!.length;
      product?.data?.forEach((element) {
        productData.add(element);
      });
      emit(AppGetProductSuccessState());
    }).catchError((error) {
      emit(AppGetProductErrorState());
      print(error.toString());
    });
  }

  //get all product
  int cropsLength = 0;
  List<CropsData> cropsData = [];
  CropsModel? crops;
  void getCropsData() {
    emit(AppGetCropsLoadingState());
    DioHelper.getDataWithoutToken(url: cropsUrl).then((value) {
      crops = CropsModel.fromJson(value.data);
      cropsLength = crops!.data!.length;
      crops?.data?.forEach((element) {
        cropsData.add(element);
      });
      emit(AppGetCropsSuccessState());
    }).catchError((error) {
      emit(AppGetCropsErrorState());
      print(error.toString());
    });
  }

  //get slider data
  SliderModel? slider;
  int sliderLength = 0;
  final List<Map<String, dynamic>> imgList = [];
  void getSliderData() {
    emit(AppGetSliderDataLoadingState());
    DioHelper.getDataWithoutToken(url: sliderOneUrl).then((value) {
      print(value.data);
      slider = SliderModel.fromJson(value.data);
      // print(category?.data?[0].name);
      sliderLength = slider!.data!.length;

      imgList.clear();
      slider?.data?.forEach((element) {
        imgList.add({
          'image': imagesLink + element.img!,
          'link': element.urlL!,
          'name': element.name
        });
      });

      emit(AppGetSliderDataSuccessState());
    }).catchError((error) {
      emit(AppGetSliderDataErrorState());
      print(error.toString());
    });
  }

  //get slider adv data
  SliderAdvModel? sliderAdv;
  int sliderAdvLength = 0;
  final List<Map<String, dynamic>> imgList2 = [];

  void getSliderAdvData() {
    emit(AppGetSliderAdvDataLoadingState());
    DioHelper.getDataWithoutToken(url: sliderTwoUrl).then((value) {
      print(value.data);
      sliderAdv = SliderAdvModel.fromJson(value.data);
      // print(category?.data?[0].name);
      sliderAdvLength = sliderAdv!.data!.length;

      imgList2.clear();
      sliderAdv?.data?.forEach((element) {
        imgList2.add({
          'image': imagesLink + element.img!,
          'link': element.urlL!,
          'name': element.name
        });
      });
      emit(AppGetSliderAdvDataSuccessState());
    }).catchError((error) {
      emit(AppGetSliderAdvDataErrorState());
      print(error.toString());
    });
  }

  // get sponsor data
  SponserModel? sponsor;
  void getSponsorData() {
    emit(AppGetSponsorDataLoadingState());
    DioHelper.getDataWithoutToken(url: sponsorUrl).then((value) {
      print(value.data);
      sponsor = SponserModel.fromJson(value.data);
      // print(category?.data?[0].name);
      emit(AppGetSponsorDataSuccessState());
    }).catchError((error) {
      emit(AppGetSponsorDataErrorState());
      print(error.toString());
    });
  }
}
