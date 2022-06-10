// import 'package:agriculture/shared/appCubit/app_cubit.dart';
// import 'package:agriculture/shared/appCubit/app_states.dart';
// import 'package:agriculture/shared/components/components.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_switch/flutter_switch.dart';

// class LayoutScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var cubit = AppCubit.get(context);

//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           drawer: defaultDrawer(context),
//           appBar:
//               defaultAppBar(context, cubit.titles[cubit.currentIndex], true),
//           body: ConditionalBuilder(
//               condition: true,
//               // state is! AppGetMainServicesLoadingState &&
//               //     state is! AppGetMainServicesLoadingState,
//               fallback: (context) =>
//                   const Center(child: CircularProgressIndicator()),
//               builder: (context) => cubit.appScreens[cubit.currentIndex]),
//           bottomNavigationBar: BottomNavigationBar(
//             items: cubit.buttomItems,
//             onTap: (index) {
//               cubit.changeAppNav(index);
//             },
//             currentIndex: cubit.currentIndex,
//           ),
//         );
//       },
//     );
//   }
// }
