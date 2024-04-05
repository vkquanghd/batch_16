import 'package:batch_16/signup/bloc/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:batch_16/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<SignUpCubit>(
        create: (context) => SignUpCubit(),
        child: _HomeContent(),
      ),
    );
  }
}

// ignore: must_be_immutable
class _HomeContent extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                'Create Account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Assets.felmale.image(width: 89, height: 88),
              ),
              Text('Create Account With',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocListener<SignUpCubit, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Can\'t login with github')));
                      }
                    },
                    child: AccountHolder(
                      image:
                          Assets.icons8Github1201.image(width: 43, height: 43),
                      onTap: () {
                        context.read<SignUpCubit>().signUpWithGithub();
                      },
                    ),
                  ),
                  AccountHolder(
                    image: Assets.icons8Google481.image(width: 43, height: 43),
                    onTap: () {
                      context.read<SignUpCubit>().signUpWithGoogle();
                    },
                  ),
                  AccountHolder(
                    image: Assets.linkedin1.image(width: 43, height: 43),
                    onTap: () {},
                  ),
                ],
              ),
              Text('or'),
              BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) {
                  if (state is GoogleSignUpNotSupported) {
                    return const Text('Google sign up not supported');
                  }
                  return const SizedBox.shrink();
                },
              ),
              Container(
                width: 350,
                height: 199,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      // Thêm khoảng cách dọc
                      child: IconTextFileRow(
                        hint: 'Name',
                        image: Assets.icons8User641.path,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      // Thêm khoảng cách dọc
                      child: IconTextFileRow(
                        hint: 'Email',
                        image: Assets.email1.path,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      // Thêm khoảng cách dọc
                      child: IconPasswordFileRow(
                        image2: Assets.icons8ShowPassword321.path,
                        hint: 'Password',
                        image: Assets.icons8Password1001.path,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: () {
                    print('Button pressed!');
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 15, // Độ nâng của nút

                    backgroundColor: Color(0xFF27014A), // Màu nền của nút
                  ),
                  child: Text('Signup', style: TextStyle(color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('or'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Thực hiện hành động khi văn bản được nhấn
                  },
                  child: Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    // Thực hiện hành động khi văn bản được nhấn
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Color(0xFF023768),
                        fontWeight: FontWeight.w700,
                        fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      )));
}

class AccountHolder extends StatelessWidget {
  final VoidCallback? onTap;
  final Image image;

  const AccountHolder({
    required this.image,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell // là nhấn vào õng nó in đậm
        (
      onTap: onTap, // Gọi hàm callback khi người dùng nhấn vào
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 40,
              blurStyle: BlurStyle.outer,
              color: Colors.black.withOpacity(0.3),
              offset: Offset(2, 3),
            )
          ],
        ),
        child: image,
      ),
    );
  }
}

class IconTextFileRow extends StatelessWidget {
  const IconTextFileRow({required this.hint, required this.image, super.key});

  final String image;
  final String hint;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Image.asset(image, width: 43, height: 43),
          Expanded(
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(2, 2),
                    blurRadius: 40)
              ], color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: hint),
              ),
            ),
          )
        ],
      );
}

class IconPasswordFileRow extends StatelessWidget {
  const IconPasswordFileRow(
      {required this.image2,
      required this.hint,
      required this.image,
      super.key});

  final String image;
  final String hint;
  final String image2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, width: 43, height: 43),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 8.0),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(2, 2),
                  blurRadius: 40)
            ], color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(8.0),
                hintText: hint,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(image2, width: 24, height: 24),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
