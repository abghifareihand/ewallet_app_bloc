import 'package:carousel_slider/carousel_slider.dart';
import 'package:ewallet_app/common/theme.dart';
import 'package:ewallet_app/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;
  CarouselController carouselController = CarouselController();

  List<String> titles = [
    "Grow Your\nFinancial Today",
    "Build From\nZero to Freedom",
    "Start Together",
  ];

  List<String> subTitles = [
    "Our system is helping you to\nachieve a better goal",
    "We provide tips for you so that\nyou can adapt easier",
    "We will guide you to where\nyou wanted it too",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                CarouselSlider(
                  items: [
                    Image.asset(
                      'assets/img_onboarding_1.png',
                      height: 331,
                    ),
                    Image.asset(
                      'assets/img_onboarding_2.png',
                      height: 331,
                    ),
                    Image.asset(
                      'assets/img_onboarding_3.png',
                      height: 331,
                    ),
                  ],
                  options: CarouselOptions(
                    height: 331,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  carouselController: carouselController,
                ),
                const SizedBox(height: 80),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 22,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        titles[currentIndex],
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 26),
                      Text(
                        subTitles[currentIndex],
                        style: greyTextStyle.copyWith(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: currentIndex == 2 ? 38 : 50),
                      currentIndex == 2
                          ? Column(
                              children: [
                                CustomFilledButton(
                                  title: 'Get Started',
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                ),
                                const SizedBox(height: 20),
                                CustomTextbutton(
                                  title: 'Login',
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: currentIndex == 0
                                        ? blueColor
                                        : lightBackgroundColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  width: 12,
                                  height: 12,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: currentIndex == 1
                                        ? blueColor
                                        : lightBackgroundColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  width: 12,
                                  height: 12,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: currentIndex == 2
                                        ? blueColor
                                        : lightBackgroundColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const Spacer(),
                                CustomFilledButton(
                                  width: 150,
                                  title: 'Continue',
                                  onPressed: () {
                                    carouselController.nextPage();
                                  },
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
