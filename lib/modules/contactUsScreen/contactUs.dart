import 'package:agriculture/shared/appCubit/app_cubit.dart';
import 'package:agriculture/shared/appCubit/app_states.dart';
import 'package:agriculture/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppPostContactSuccessState) {
          showToast(text: state.model.errorMessage, state: ToastStates.success);
        }
        elseif(AppPostContactErrorState) {
          showToast(
              text: 'لم يتم ارسال البيانات برجاء المحاوله مره اخري',
              state: ToastStates.error);
        }
      },
      builder: (context, state) {
        var emailController = TextEditingController();
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        var detailsController = TextEditingController();

        var formKey = GlobalKey<FormState>();
        return Scaffold(
          appBar: defaultAppBar(context, 'تواصل معنا', false),
          body: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'كيف يمكننا ان نساعدك',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                            lable: 'الاسم',
                            controller: nameController,
                            prefix: Icons.person,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'يجب ان تدخل الاسم';
                              }
                            },
                            context: context,
                            type: TextInputType.text),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextField(
                            lable: 'الهاتف',
                            controller: phoneController,
                            prefix: Icons.person,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'يجب ان تدخل رقم الهاتف';
                              }
                            },
                            context: context,
                            type: TextInputType.phone),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextField(
                            lable: 'البريد الالكتروني',
                            controller: emailController,
                            prefix: Icons.email_outlined,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'يجب ان تدخل البريد الالكتروني';
                              }
                            },
                            context: context,
                            type: TextInputType.emailAddress),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: detailsController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            hintText: 'رسالتك',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! AppPostContactLoadingState,
                          fallback: (context) =>
                              const Center(child: LinearProgressIndicator()),
                          builder: (context) => defaultButton(
                              onPress: () {
                                if (formKey.currentState!.validate()) {
                                  if (EmailValidator.validate(
                                      emailController.text)) {
                                    AppCubit.get(context).contactUsData(
                                      message: detailsController.text,
                                      email: emailController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                  } else {
                                    showToast(
                                        text: 'البريد الالكتروني غير صحيح',
                                        state: ToastStates.error);
                                  }
                                } else {}
                              },
                              text: 'ارسال'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                            ),
                            Text(
                              ' حسابات التواصل الاجتماعي الخاصه بنا ',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FlutterSocialButton(
                                mini: true,
                                onTap: () {
                                  // _launchUrl(
                                  //     context,
                                  //     AppCubit.get(context)
                                  //         .social
                                  //         ?.socialMedia?[0]
                                  //         .urlLink);
                                },
                                buttonType: ButtonType.facebook),
                            FlutterSocialButton(
                                mini: true,
                                onTap: () {
                                  // _launchUrl(
                                  //     context,
                                  //     AppCubit.get(context)
                                  //         .social
                                  //         ?.socialMedia?[1]
                                  //         .urlLink);
                                },
                                buttonType: ButtonType.twitter),
                            FlutterSocialButton(
                                mini: true,
                                onTap: () {
                                  _launchUrl(
                                      context, 'https://mail.google.com/');
                                },
                                buttonType: ButtonType.google),
                            FlutterSocialButton(
                                mini: true,
                                onTap: () {
                                  _launchUrl(
                                      context, 'https://www.linkedin.com/');
                                },
                                buttonType: ButtonType.linkedin),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void _launchUrl(context, url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}
