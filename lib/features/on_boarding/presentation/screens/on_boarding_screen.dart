import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/features/auth/presentation/screens/introduction_screen.dart';
import 'package:tennis_app/features/on_boarding/presentation/controllers/on_boarding_bloc/on_boarding_event.dart';
import 'package:tennis_app/features/on_boarding/presentation/widgets/dots_indicator_widgets.dart';

import '../controllers/on_boarding_bloc/on_boarding_bloc.dart';
import '../controllers/on_boarding_bloc/on_boarding_state.dart';
import '../widgets/on_boarding_page.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingBloc()..add(FetchOnBoardingData()),
      child: Scaffold(
        body: BlocBuilder<OnBoardingBloc, OnBoardingState>(
          builder: (context, state) {
            if (state is OnBoardingDataLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: state.data.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return OnBoardingPage(
                          title: state.data[index].title,
                          description: state.data[index].description,
                          image: state.data[index].image,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 150),
                        DotsIndicator(
                          currentIndex: _currentIndex,
                          itemCount: state.data.length,
                        ),
                        const Spacer(),
                        if (_currentIndex == state.data.length - 1)
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const IntroductionScreen();
                                    },
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Color.fromARGB(200, 0, 87, 166),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            } else if (state is OnBoardingDataError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
