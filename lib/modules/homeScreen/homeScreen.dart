import 'package:agriculture/models/categoryModel/categoryModel.dart';
import 'package:agriculture/models/sliderModel/sliderModel.dart';
import 'package:agriculture/network/endpoints.dart';
import 'package:agriculture/shared/appCubit/app_cubit.dart';
import 'package:agriculture/shared/appCubit/app_states.dart';
import 'package:agriculture/shared/components/components.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

String name = '';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).sliderLength > 0,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                drawer: defaultDrawer(context),
                appBar: defaultAppBar(context, 'الصفحه الرئيسيه', true),
                body: Column(
                  children: [
                    buildSliderItem(
                        context,
                        140.0,
                        AppCubit.get(context).imgList,
                        AppCubit.get(context).slider),
                    SizedBox(
                      height: 50,
                      child: AppBar(
                        bottom: const TabBar(
                          indicatorColor: Colors.black,
                          tabs: [
                            Tab(
                              text: 'تصفح بالمنتجات',
                              // child: Text('data'),
                            ),
                            Tab(
                              text: 'تصفح بالمحاصيل',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // first tab bar view widget
                          Container(
                            color: Colors.grey[300],
                            child: GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              childAspectRatio: 1 / 1.0,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              // physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                AppCubit.get(context).productLength,
                                (index) => buildServiceItem(context,
                                    AppCubit.get(context).productData[index]),
                              ),
                            ),
                          ),

                          // second tab bar viiew widget
                          Container(
                            color: Colors.grey[300],
                            child: GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              childAspectRatio: 1 / 1.0,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                              // physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                AppCubit.get(context).cropsLength,
                                (index) => buildServiceItem(context,
                                    AppCubit.get(context).cropsData[index]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (AppCubit.get(context).sponsor?.data?.urlL !=
                                  '') {
                                _launchUrl(
                                    context,
                                    AppCubit.get(context).sponsor?.data?.urlL ??
                                        '');
                              }
                            },
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(imagesLink +
                                          (AppCubit.get(context)
                                                  .sponsor
                                                  ?.data
                                                  ?.img ??
                                              '')),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          buildSliderItem(
                              context,
                              100.0,
                              AppCubit.get(context).imgList2,
                              AppCubit.get(context).sliderAdv),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Widget buildSliderItem(context, height, List<Map> list, slider) => Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CarouselSlider(
        items: list
            .map(
              (e) => InkWell(
                onTap: () {
                  if (e['link'] != '') {
                    _launchUrl(context, e['link']);
                  }
                },
                child: Stack(
                  children: [
                    Image(
                      image: NetworkImage(e['image']),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    if (slider.runtimeType == SliderModel)
                      Positioned(
                        top: 100,
                        right: 40,
                        width: 300,
                        height: 140,
                        child: Text(
                          e['name'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      )
                  ],
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: height,
          initialPage: 0,
          viewportFraction: 1,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
          reverse: false,
        ),
      ),
    );

Widget buildServiceItem(context, product) => InkWell(
      onTap: () {
        _launchUrl(context, product!.linkUrl);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image(
                image: NetworkImage(imagesLink + (product?.img ?? '')),
                width: 200,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 200,
              height: 30,
              color: Colors.black.withOpacity(.7),
              child: Center(
                child: Text(
                  product?.name ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );

void _launchUrl(context, url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}
