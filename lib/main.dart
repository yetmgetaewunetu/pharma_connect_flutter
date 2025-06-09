import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pharma_connect_flutter/infrastructure/di/injection.dart';
import 'package:pharma_connect_flutter/application/blocs/auth/auth_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/admin/medicine/medicine_cubit.dart';
import 'package:pharma_connect_flutter/presentation/pages/auth/login_page.dart';
import 'package:pharma_connect_flutter/presentation/pages/auth/register_page.dart';
import 'package:pharma_connect_flutter/presentation/pages/home/home_page.dart';
import 'package:pharma_connect_flutter/presentation/pages/medicine/edit_medicine_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<MedicineCubit>()..fetchMedicines(),
        ),
      ],
      child: MaterialApp(
        title: 'Pharma Connect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
        home: const LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomePage(),
          '/medicine/edit': (context) => const EditMedicineScreen(),
        },
      ),
    );
  }
}
