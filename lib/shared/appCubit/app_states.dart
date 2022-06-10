import 'package:agriculture/models/ContactUsModel/contactUsModel.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeLanguageState extends AppStates {}

class ChangeNavButtomNavState extends AppStates {}

class AppChangeThemState extends AppStates {}

//logout
class AppLogoutSuccessState extends AppStates {}

//about
class AppGetAboutUsDataSuccessState extends AppStates {}

class AppGetAboutUsDataErrorState extends AppStates {}

class AppGetAboutUsDataLoadingState extends AppStates {}

//contact us
class AppPostContactErrorState extends AppStates {}

class AppPostContactLoadingState extends AppStates {}

class AppPostContactSuccessState extends AppStates {
  final contactUsModel model;

  AppPostContactSuccessState(this.model);
}

//get product
class AppGetProductLoadingState extends AppStates {}

class AppGetProductSuccessState extends AppStates {}

class AppGetProductErrorState extends AppStates {}

//get Crops
class AppGetCropsLoadingState extends AppStates {}

class AppGetCropsSuccessState extends AppStates {}

class AppGetCropsErrorState extends AppStates {}

//get slider one
class AppGetSliderDataLoadingState extends AppStates {}

class AppGetSliderDataSuccessState extends AppStates {}

class AppGetSliderDataErrorState extends AppStates {}

//get slider two
class AppGetSliderAdvDataLoadingState extends AppStates {}

class AppGetSliderAdvDataSuccessState extends AppStates {}

class AppGetSliderAdvDataErrorState extends AppStates {}

//get Sponsor
class AppGetSponsorDataLoadingState extends AppStates {}

class AppGetSponsorDataSuccessState extends AppStates {}

class AppGetSponsorDataErrorState extends AppStates {}

//get user data states
class AppGetUserDataSuccessState extends AppStates {}

class AppGetUserDataErrorState extends AppStates {}

class AppGetUserDataLoadingState extends AppStates {}
