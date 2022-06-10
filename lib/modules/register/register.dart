import 'package:agriculture/modules/homeScreen/homeScreen.dart';
import 'package:agriculture/modules/login/login.dart';
import 'package:agriculture/modules/register/registerCubit/registerCubit.dart';
import 'package:agriculture/network/local/cache_Helper.dart';
import 'package:agriculture/shared/appCubit/app_cubit.dart';
import 'package:agriculture/shared/components/components.dart';
import 'package:agriculture/shared/const.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'registerCubit/registerStates.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.model?.result == true) {
              CacheHelper.saveData(
                      key: "token", value: state.model?.success!.token)
                  .then((value) {
                token = state.model?.success?.token;
                AppCubit.get(context).getUserData();
                showToast(
                    text: 'تم تسجيل الدخول بنجاح', state: ToastStates.success);
                // navigateAndFinish(context, LayoutScreen());
                print(state.model?.data!.name);
              });
            } else {
              showToast(
                  text: state.model?.error_message, state: ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/image.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: [
                          Positioned(
                            // top: 50,
                            left: 30,
                            width: 80,
                            height: 180,
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light.png'))),
                            ),
                          ),
                          Positioned(
                            left: 140,
                            width: 80,
                            height: 130,
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            ),
                          ),
                          Positioned(
                            right: 40,
                            top: 40,
                            width: 80,
                            height: 150,
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            ),
                          ),
                          Positioned(
                            child: Center(
                              child: Text(
                                'حساب جديد',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.white, fontSize: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          defaultTextField(
                              lable: 'الاسم',
                              controller: nameController,
                              prefix: Icons.person,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return ' يجب ان تدخل الاسم}';
                                }
                              },
                              context: context,
                              type: TextInputType.text),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextField(
                              lable: 'البريد اللالكتروني',
                              controller: emailController,
                              prefix: Icons.person,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'يجب ان تدخل البريد اللالكتروني';
                                }
                              },
                              context: context,
                              type: TextInputType.emailAddress),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextField(
                              controller: passwordController,
                              lable: 'كلمة السر',
                              prefix: Icons.lock,
                              suffix: RegisterCubit.get(context).suffix,
                              suffixPressed: () {
                                RegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              isSecure: RegisterCubit.get(context).isPass,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'يجب ان تدخل كلمة السر';
                                }
                              },
                              context: context,
                              type: TextInputType.visiblePassword),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextField(
                              controller: confirmPasswordController,
                              lable: 'تأكيد كلمة السر  ',
                              prefix: Icons.lock,
                              suffix: RegisterCubit.get(context).suffix,
                              suffixPressed: () {
                                RegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              isSecure: RegisterCubit.get(context).isPass,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'يجب ان تدخل تأكيد كلمة السر';
                                }
                              },
                              context: context,
                              type: TextInputType.visiblePassword),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextField(
                              lable: 'الهاتف',
                              controller: phoneController,
                              prefix: Icons.phone,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'يجب ان تدخل رقم الهاتف';
                                }
                              },
                              context: context,
                              type: TextInputType.phone),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => defaultButton(
                                onPress: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        name: nameController.text,
                                        password: passwordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text);
                                  } else {}
                                },
                                text: 'حساب جديد'),
                            fallback: (context) =>
                                const CircularProgressIndicator(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('لديك حساب بالفعل'),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, const LoginScreen());
                                  },
                                  child: const Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // color: Colors.blue,
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' انتقل الي الصفحه الرئيسية مباشرة',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              TextButton(
                                  onPressed: () {
                                    // AppCubit.get(context).currentIndex = 0;
                                    navigateTo(context, HomeScreen());
                                  },
                                  child: const Text(
                                    'الصفحه الرئيسية ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // color: Colors.blue,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
