import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/auth/auth_bloc.dart';
import 'package:pharma_connect_flutter/presentation/widgets/loading_indicator.dart';
import 'package:pharma_connect_flutter/presentation/widgets/error_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pharma_connect_flutter/presentation/pages/admin/admin_home_page.dart';
import 'package:pharma_connect_flutter/application/blocs/admin/pharmacy/pharmacy_cubit.dart';
import 'package:pharma_connect_flutter/infrastructure/repositories/pharmacy_repository.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/pharmacy_api.dart';
import 'package:pharma_connect_flutter/infrastructure/datasources/api_client.dart';
import 'package:pharma_connect_flutter/presentation/pages/user/user_home_page.dart';
import 'package:pharma_connect_flutter/presentation/pages/owner/owner_home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  Future<void> _handleAuth(BuildContext context, user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', user.id);
    await prefs.setString('role', user.role);
    if (user.role.toLowerCase() == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => PharmacyCubit(
              PharmacyRepository(
                PharmacyApi(ApiClient()),
              ),
            ),
            child: const AdminHomePage(),
          ),
        ),
      );
    } else if (user.role.toLowerCase() == 'owner') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OwnerHomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UserHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (user) => _handleAuth(context, user),
            error: (message) => showDialog(
              context: context,
              builder: (context) => ErrorDialog(message: message),
            ),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: LoadingIndicator()),
            orElse: () => const LoginForm(),
          );
        },
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            AuthEvent.login(
              _emailController.text,
              _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  if (!value!.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your password';
                  }
                  if (value!.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _onSubmit,
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
