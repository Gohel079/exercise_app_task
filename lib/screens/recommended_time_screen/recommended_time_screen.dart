import 'package:exercise_app/screens/custom_time_screen/custome_time_screen.dart';
import 'package:exercise_app/screens/recommended_time_screen/recommended_time_bloc.dart';
import 'package:exercise_app/screens/success_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';
import '../../constant/app_style.dart';
import '../../widget/button_view.dart';

class RecommendedTimeScreen extends StatefulWidget {
  const RecommendedTimeScreen({super.key});


  @override
  State<RecommendedTimeScreen> createState() => _RecommendedTimeScreenState();
}

class _RecommendedTimeScreenState extends State<RecommendedTimeScreen> {

  String shitDropDownValue = 'Morning';
  String thenAfterShitDropDownValue1 = 'Morning';
  String thenAfterShitDropDownValue2 = 'Morning';

  var shitList = [
    'Morning',
    'Noon',
    'Evening'
  ];

  var thenAfterShiftList1 = [
    'Morning',
    'Noon',
    'Evening'
  ];

  var thenAfterShiftList2 = [
    'Morning',
    'Noon',
    'Evening'
  ];


  BehaviorSubject<TimeOfDay>? first14Day;
  BehaviorSubject<TimeOfDay>? thenAfter1;
  BehaviorSubject<TimeOfDay>? thenAfter2;

  RecommendedTimeBloc bloc = RecommendedTimeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              const SizedBox(height: 20,),

              Text.rich(
                  TextSpan(
                      text: 'Hello ',
                      style: styleLarge1.copyWith(
                          color: secondaryColor, fontWeight: FontWeight.w700),
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Aden!',
                          style: styleLarge1.copyWith(
                              color: primaryColor, fontWeight: FontWeight.w700),
                        )
                      ]
                  )
              ),

              const SizedBox(height: 10,),

              Text(
                'Break the sedentary lifestyle and become active during your\nwork time.',
                style: styleSmall.copyWith(color:
                const Color(0xffA9A9A9), fontWeight: FontWeight.w400),),

              const SizedBox(height: 20,),

              Text('For the first 14 days',
                style: styleSmall2.copyWith(color: secondaryColor,
                    fontWeight: FontWeight.w600),),

              const SizedBox(height: 20,),


              selectTimeBoxFor14Days(),

              thenAfterPartView(),

              const SizedBox(height: 40,),

              submitButton()

              ,const SizedBox(height: 20,),

              Center(
                child: Text('OR',
                  textAlign: TextAlign.center,
                  style: styleSmall2.copyWith(color: secondaryColor,
                      fontWeight: FontWeight.w600),),
              ),

          const SizedBox(height: 10,),

              selectCustomeTimeContainer("Decide for yourself")

            ],),
        ),
      ),
    );
  }

  @override
  void initState() {
   first14Day = BehaviorSubject<TimeOfDay>.seeded(const TimeOfDay(hour: 08,minute: 00));
   thenAfter1 = BehaviorSubject<TimeOfDay>.seeded(const TimeOfDay(hour: 08,minute: 00));
   thenAfter2 = BehaviorSubject<TimeOfDay>.seeded(const TimeOfDay(hour: 08,minute: 00));
    super.initState();
  }


  Widget selectTimeBoxFor14Days() {
    return Container(decoration: BoxDecoration(color: boxColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: boxColor)), child:

    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [


          Text('In the',
            style: styleSmall2.copyWith(color: subTextColor,
                fontWeight: FontWeight.w500),),

          const SizedBox(width: 4,),

          shiftDropDownView(),

          const SizedBox(width: 5,),

          Text('at',
            style: styleSmall2.copyWith(color: subTextColor,
                fontWeight: FontWeight.w500),),

          const SizedBox(width: 5,),

          selectTimePickerForFirstDay()
        ],),
    ));
  }

  Widget shiftDropDownView() {
    return Container(
      decoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
          value: shitDropDownValue,
          isExpanded: false,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down_sharp,
            color: black,),
          items: shitList.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items,
                style: styleSmall2.copyWith(color: secondaryColor,
                    fontWeight: FontWeight.w500),),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              shitDropDownValue = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget selectTimePickerForFirstDay() {

    return InkWell(onTap: () async {

      TimeOfDay? time =await pickTime();
      if(time != null){
        first14Day?.add(time);
      }

    },
      child: Container(decoration: BoxDecoration(color: white,
          borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(children: [

              SvgPicture.asset(
                AppImages.icClock,
                color: primaryColor,
                height: 22,
              ),

              const SizedBox(width: 6,),

              Text('|',
                style: styleSmall2.copyWith(color: secondaryColor,
                    fontWeight: FontWeight.w700),),


              const SizedBox(width: 6,),
              StreamBuilder<TimeOfDay>(
                stream: first14Day?.stream,
                builder: (context, snapshot) {
                  return Text('${snapshot.data?.hour} : ${snapshot.data?.minute}',
                    style: styleSmall2.copyWith(color: secondaryColor,
                        fontWeight: FontWeight.w700),);
                }
              ),
            ],),
          )),
    );
  }


  Widget thenAfterPartView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        const SizedBox(height: 20,),

        Text('Then after',
          style: styleSmall2.copyWith(color: secondaryColor,
              fontWeight: FontWeight.w600),),

        const SizedBox(height: 20,),

        selectTimeBoxForThenAfter1(),

        SizedBox(height: 20,),

        selectTimeBoxForThenAfter2(),

      ],
    );
  }

  Widget selectTimeBoxForThenAfter1() {
    return InkWell(onTap: (){},
      child: Container(decoration: BoxDecoration(color: boxColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: boxColor)), child:

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [


            Text('In the',
              style: styleSmall2.copyWith(color: subTextColor,
                  fontWeight: FontWeight.w500),),

            const SizedBox(width: 4,),

            theAfterDropDownView1(),

            const SizedBox(width: 5,),

            Text('at',
              style: styleSmall2.copyWith(color: subTextColor,
                  fontWeight: FontWeight.w500),),

            const SizedBox(width: 5,),

            selectTimePickerThenAfter1()
          ],),
      )),
    );
  }

  Widget selectTimeBoxForThenAfter2() {
    return Container(decoration: BoxDecoration(color: boxColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: boxColor)), child:

    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [


          Text('In the',
            style: styleSmall2.copyWith(color: subTextColor,
                fontWeight: FontWeight.w500),),

          const SizedBox(width: 4,),

          theAfterDropDownView2(),

          const SizedBox(width: 5,),

          Text('at',
            style: styleSmall2.copyWith(color: subTextColor,
                fontWeight: FontWeight.w500),),

          const SizedBox(width: 5,),

          selectTimePickerThenAfter2()
        ],),
    ));
  }

  Widget theAfterDropDownView1() {
    return Container(
      decoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
          value: thenAfterShitDropDownValue1,
          isExpanded: false,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down_sharp,
            color: black,),
          items: thenAfterShiftList1.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items,
                style: styleSmall2.copyWith(color: secondaryColor,
                    fontWeight: FontWeight.w500),),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              thenAfterShitDropDownValue1 = newValue!;
            });
          },
        ),
      ),
    );
  }


  Widget theAfterDropDownView2() {
    return Container(
      decoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
          value: thenAfterShitDropDownValue2,
          isExpanded: false,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down_sharp,
            color: black,),
          items: thenAfterShiftList2.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items,
                style: styleSmall2.copyWith(color: secondaryColor,
                    fontWeight: FontWeight.w500),),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              thenAfterShitDropDownValue2 = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget selectTimePickerThenAfter1() {

    return InkWell(onTap: () async {

      TimeOfDay? time =await pickTime();
      if(time != null){
        thenAfter1?.add(time);
      }

    },
      child: Container(decoration: BoxDecoration(color: white,
          borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(children: [

              SvgPicture.asset(
                AppImages.icClock,
                color: primaryColor,
                height: 22,
              ),

              const SizedBox(width: 6,),

              Text('|',
                style: styleSmall2.copyWith(color: secondaryColor,
                    fontWeight: FontWeight.w700),),


              const SizedBox(width: 6,),
              StreamBuilder<TimeOfDay>(
                  stream: thenAfter1?.stream,
                  builder: (context, snapshot) {
                    return Text('${snapshot.data?.hour} : ${snapshot.data?.minute}',
                      style: styleSmall2.copyWith(color: secondaryColor,
                          fontWeight: FontWeight.w700),);
                  }
              ),
            ],),
          )),
    );
  }

  Widget selectTimePickerThenAfter2() {

    return InkWell(onTap: () async {

      TimeOfDay? time =await pickTime();
      if(time != null){
        thenAfter2?.add(time);
      }

    },
      child: Container(decoration: BoxDecoration(color: white,
          borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(children: [

              SvgPicture.asset(
                AppImages.icClock,
                color: primaryColor,
                height: 22,
              ),

              const SizedBox(width: 6,),

              Text('|',
                style: styleSmall2.copyWith(color: secondaryColor,
                    fontWeight: FontWeight.w700),),


              const SizedBox(width: 6,),
              StreamBuilder<TimeOfDay>(
                  stream: thenAfter2?.stream,
                  builder: (context, snapshot) {
                    return Text('${snapshot.data?.hour} : ${snapshot.data?.minute}',
                      style: styleSmall2.copyWith(color: secondaryColor,
                          fontWeight: FontWeight.w700),);
                  }
              ),
            ],),
          )),
    );
  }



  Widget submitButton() {
    return ButtonView("Continue", () {

      Map<String, dynamic> requestData = {
        "recommended": true,
        "before_break": ["${first14Day?.value.hour}:${first14Day?.value.minute}"],
        "after_break": ["${thenAfter1?.value.hour}:${thenAfter1?.value.minute}","${thenAfter2?.value.hour}:${thenAfter2?.value.minute}"],
        "days": 14,
        "breaks": []
      };

      print(requestData);
      bloc.recommendedApiCall(requestData, (response) {
        bool? status = response.success;


        if (status ?? false) {
          Navigator.push(context, CupertinoPageRoute(builder:
              (context) => const SuccessScreen()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text('${response.message}')));
        }
      },);
    });
  }


  Future<TimeOfDay?> pickTime() async {
    TimeOfDay? newTime = await showTimePicker(

      context: context,

      initialTime: TimeOfDay.now(),
      builder: (context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    return newTime;
  }

  Widget selectCustomeTimeContainer(String mainLabel) {
    return InkWell(onTap: (){
      Navigator.push(context, CupertinoPageRoute(builder: (context) => CustomTimeScreen(),));
    },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: const Color(0xffF6F6F6) ,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color:  const Color(0xffF6F6F6))),
        child: Column(children: [

          const SizedBox(height: 5,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: blueBtn(mainLabel),
          ),

          const SizedBox(height: 10,),

          Text('Here your can set your own daily active breaks\nprogram',
            textAlign: TextAlign.center,
            style: styleSmall1.copyWith(color:
            const Color(0xffA9A9A9),fontWeight: FontWeight.w400),),

          const SizedBox(height: 20,),
        ],),),
    );
  }

  Widget blueBtn(String label){
    return Container(width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
        color: const Color(0xff3B4860)),child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 7),
      child: Text(label, textAlign: TextAlign.center,style: styleSmall1.copyWith(color:Colors.white,fontWeight: FontWeight.w400),),
    ),);
  }

}

