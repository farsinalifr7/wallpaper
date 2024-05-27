import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walpaper/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: SizedBox(
    //   height: MediaQuery.of(context).size.height,
    //   width: MediaQuery.of(context).size.width,
    //   child: Image.asset(
    //     "asset/images/wallpaper.jpg",
    //     fit: BoxFit.cover,
    //   ),
    // ));

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "asset/images/wallpaper.jpg",
                    ))),
            child: Container(
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Fresh looks daily. Dress up your phone in style",
                        style: GoogleFonts.lora(
                          textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                    Text(
                      "Make it easy to user to access the latest and most important news quickly in single platform",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[500]),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey),
                              color: Colors.grey[200],
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.pink[200],
                              size: 24,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
