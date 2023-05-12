// import 'package:chatapp_firebase/pages/welcome/controller.dart';
import 'package:chatapp_firebase/pages/welcome/index.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Here we GetView to access controller and its properties

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SizedBox(
          // SizedBox using because using Stack
          width: 360.w,
          height: 720.w,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                scrollDirection: Axis.horizontal,
                reverse: false,
                pageSnapping: true, // small slide leads to next page
                physics: const ClampingScrollPhysics(),

                // controller
                controller: PageController(
                  initialPage: 0,
                  keepPage:
                      false, // If this property is set to false, the current [page] is never saved and [initialPage] is always used to initialize the scroll offset
                  viewportFraction: 1,
                ),

                // onPageChanged function
                onPageChanged: (index) {
                  // controller.state.index.value = index; // it is right one , but change the value using controller
                  controller.changeIndexValue(index);
                },

                // children
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/banner1.png')),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/banner2.png')),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/banner3.png')),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          // bottom:90,
                          bottom: 30.w,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              side: MaterialStateProperty.all(
                                const BorderSide(color: Colors.white),
                              ),
                            ),
                            child: const Text('Login'),
                            onPressed: () {
                              // controller.handleSignIn();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              // Stacked above of PageView
              Positioned(
                // bottom:70,
                bottom: 10.w,
                child: DotsIndicator(
                  position: controller.state.index.value.toInt(),
                  dotsCount: 3,
                  reversed: false,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  decorator: DotsDecorator(
                    size: const Size.square(11),  
                    activeSize: const Size(18, 9),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
