// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:agriculture/modules/login/login.dart';
import 'package:agriculture/network/local/cache_Helper.dart';
import 'package:agriculture/shared/theme/colors.dart';
import 'package:agriculture/shared/components/components.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //const OnBoardingScreen({Key? key}) : super(key: key);
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/ag9.jpg',
        title: ' المبيدات الزراعية  ',
        body:
            'مجموعة كاملة من اقوي المبيدات الزراعية ومبيدات الصحة العامة المسجلة رسميا ذات الجوده والكفاءة العالية'),

    // BoardingModel(
    //     image:
    //       'https://media.istockphoto.com/vectors/auction-online-vector-concept-for-web-banner-website-page-vector-id1194209555?k=20&m=1194209555&s=612x612&w=0&h=9wfcdXTGfa1e65S0s1hGDl0e03Z_stxJxwtTulhpniw=',
    //     title: ' On Board 2 title',
    //     body: 'On Board 2 body '),
    BoardingModel(
        image: 'assets/images/ag8.jpg',
        title: 'الأسمدة والمخصبات ',
        body:
            'أفضل مجموعة من الأسمدة والمخصبات الكيماوية والحيوية والعضوية المسجلة والموثوقة محليا وعالميا'),
    BoardingModel(
        image: 'assets/images/ag10.jpg',
        title: ' التقاوي والشتلات ',
        body:
            'أشتري أجود اصناف التقاوي لمحاصيل الخضر والمحاصيل الحقلية وكمان الاعلاف من كبري الشركات المصرية والعالمية'),
  ];

  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: primaryColor,
                  ),
                ),
                onPressed: () {
                  submit();
                }),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(children: [
            Expanded(
              child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    spacing: 5.0,
                    expansionFactor: 4,
                    activeDotColor: primaryColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: primaryColor,
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 740,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Center(
                child: Image(
          image: AssetImage('${model.image}'),
          fit: BoxFit.cover,
        ))),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Text(
            '${model.title}',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          '${model.body}',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
