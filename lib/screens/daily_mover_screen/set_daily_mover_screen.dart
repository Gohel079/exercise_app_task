import 'package:exercise_app/constant/app_colors.dart';
import 'package:exercise_app/constant/app_images.dart';
import 'package:exercise_app/constant/app_style.dart';
import 'package:exercise_app/screens/custom_time_screen/custome_time_screen.dart';
import 'package:exercise_app/screens/recommended_time_screen/recommended_time_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../widget/button_view.dart';

class SetDailyMoverScreen extends StatefulWidget {
  const SetDailyMoverScreen({super.key});

  @override
  State<SetDailyMoverScreen> createState() => _SetDailyMoverScreenState();
}

class _SetDailyMoverScreenState extends State<SetDailyMoverScreen> {



  BehaviorSubject<bool>? recoomeded;
  BehaviorSubject<bool>? custome;


  @override
  void initState() {
    recoomeded = BehaviorSubject<bool>.seeded(true);
     custome = BehaviorSubject<bool>.seeded(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                    const SizedBox(height: 20,),

                    Text.rich(
                        TextSpan(
                            text: 'Set your ',
                            style: styleLarge1.copyWith(color: secondaryColor,fontWeight: FontWeight.w700),
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Active Breaks',
                                style: styleLarge1.copyWith(color: primaryColor,fontWeight: FontWeight.w700),
                              )
                            ]
                        )
                    ),

                    const SizedBox(height: 20,),

                    Text('Break the sedentary lifestyle and become active during your\nwork time.',
                      style: styleSmall.copyWith(color:
                      const Color(0xffA9A9A9),fontWeight: FontWeight.w400),),

                    const SizedBox(height: 20,),

                    bannerImage(),

                    const SizedBox(height: 20,),

                    Text('Active breaks are the time you want to break\nthe sedentary behaviour with small exercises\n'
                        'of maximum 5 min.',
                      textAlign: TextAlign.center,
                      style: styleSmall2.copyWith(color:
                      const Color(0xffA9A9A9),fontWeight: FontWeight.w400),),


                    const SizedBox(height: 20,),

                    Row(
                      children: [
                        Expanded(flex: 1,child:
                        StreamBuilder(
                            stream: recoomeded?.stream,
                            builder: (context, snapshot) {
                              return selectTimeContainer("Recommendation",snapshot.data);
                            },
                          )),
                        const SizedBox(width: 15,),
                        Expanded(flex:1,child: StreamBuilder<bool>(
                          stream: custome?.stream,
                          builder: (context, snapshot) {
                            return selectCustomeTimeContainer("Decide for yourself",snapshot.data);
                          }
                        )),
                      ],
                    )

                    ,const SizedBox(height: 40,),
                  ],),
                ),
              ),

              submitButton()
            ],
          ),),
      ),
    );
  }


  Widget selectTimeContainer(String mainLabel, bool? data) {
    return InkWell(onTap: (){

      recoomeded?.add(true);
      custome?.add(false);
      print("Recommend $recoomeded");
    },
      child: Container(decoration: BoxDecoration(color: const Color(0xffF6F6F6) ,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: data ?? false ? const Color(0xffED7844) : const Color(0xffF6F6F6))),
        child: Column(children: [

          const SizedBox(height: 5,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 7),
            child: blueBtn(mainLabel),
          ),

          const SizedBox(height: 20,),

          Text.rich(textAlign : TextAlign.center,
              TextSpan(
                  text: '1 ',
                  style: styleSmall1.copyWith(color: const Color(0xffED7844),fontWeight: FontWeight.w500),
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'per day for the first ',
                      style: styleSmall1.copyWith(color:  data ?? false ?  Colors.black : Color(0xffA9A9A9),fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: '14\n',
                      style: styleSmall1.copyWith(color: Color(0xffED7844),fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: 'days then ',
                      style: styleSmall1.copyWith(color:  data ?? false ?  Colors.black : Color(0xffA9A9A9),fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: '2 ',
                      style: styleSmall1.copyWith(color: Color(0xffED7844),fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: 'per day ',
                      style: styleSmall1.copyWith(color:  data ?? false ?  Colors.black : Color(0xffA9A9A9),fontWeight: FontWeight.w500),
                    ),
                  ]
              )
          ),

          const SizedBox(height: 30,),
        ],),),
    );
  }

  Widget selectCustomeTimeContainer(String mainLabel, bool? data) {
    return InkWell(onTap: (){
      custome?.add(true);
      recoomeded?.add(false);
    },
      child: Container(decoration: BoxDecoration(color: const Color(0xffF6F6F6) ,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: data ?? false  ? const Color(0xffED7844) : const Color(0xffF6F6F6))),
        child: Column(children: [

          const SizedBox(height: 5,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 5),
            child: blueBtn(mainLabel),
          ),

          const SizedBox(height: 10,),

          Text('Here your can set your\nown daily active breaks\nprogram',
            textAlign: TextAlign.center,
            style: styleSmall1.copyWith(color:
            data ?? false ?  Colors.black : Color(0xffA9A9A9),fontWeight: FontWeight.w400),),

          const SizedBox(height: 20,),
        ],),),
    );
  }

  Widget blueBtn(String label){
    return Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
        color: const Color(0xff3B4860)),child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
          child: Text(label, style: styleSmall1.copyWith(color:Colors.white,fontWeight: FontWeight.w400),),
        ),);
  }


  Widget bannerImage(){
    return Container(width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Image.asset(AppImages.bannerImage,fit: BoxFit.fill,));
  }

  Widget submitButton() {
    return ButtonView("Continue", () {

      if(recoomeded?.value ?? false){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => RecommendedTimeScreen()));
      }
      else if(custome?.value ?? false){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => CustomeTimeScreen()));
      }

    });
  }


  @override
  void dispose() {
   recoomeded?.close();
   custome?.close();
    super.dispose();
  }
}
