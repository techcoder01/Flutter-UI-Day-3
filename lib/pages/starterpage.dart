import 'package:day3/Animation/fade_animation.dart';
import 'package:day3/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  bool textVisible = true;
  
  @override
  void initState() {
    animationController = AnimationController(vsync: this , duration: Duration(milliseconds: 100));
    animation = Tween<double>(begin: 1.0, end: 25.0).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void onTap(){
    setState(() {
      textVisible = false;
    });

    animationController.forward().then((f) => Navigator.push(context, PageTransition(child: const HomePage(), type: PageTransitionType.fade)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/starter-image.jpg'),fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.2),
              ]
              ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FadeAnimation(
                  .5, const Text('Taking Order For Faster Delivery', style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                const SizedBox(height: 20,),
                FadeAnimation(
                  1, const Text('See restaurants nearby \nyour location', style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    height: 1.4,
                  ),),
                ),
                const SizedBox(height: 100,),
                  FadeAnimation(
                    1.2, ScaleTransition(
                      scale: animation,
                      child: Container(
                        decoration:  BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(colors: [Colors.yellow, Colors.orange]),
                        ),
                        child: AnimatedOpacity(
                          opacity: textVisible ? 1: 0,
                          duration: Duration(milliseconds: 50),
                          child: MaterialButton(onPressed: (){
                            onTap();
                          },minWidth: double.infinity, child: const Text('Start', style: TextStyle(color: Colors.white),),),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 30,),
                FadeAnimation(
                  1.4 , AnimatedOpacity(
                          opacity: textVisible ? 1: 0,
                          duration: Duration(milliseconds: 50),                    
                    child: const Align(
                      child: Text('Now Deliver To Your Door 24/7' , style: TextStyle(color: Colors.white70, fontSize: 15),),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
              ],
            ),
          ), 
        ),
      ),
    );
  }
}