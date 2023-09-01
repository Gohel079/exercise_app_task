import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:exercise_app/screens/custom_time_screen/single_time_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';
import '../../constant/app_style.dart';
import '../../model/time_pick_model.dart';
import '../../widget/button_view.dart';
import '../success_screen.dart';
import 'custome_time_bloc.dart';

class CustomTimeScreen extends StatefulWidget {
  const CustomTimeScreen({super.key});

  @override
  State<CustomTimeScreen> createState() => _CustomTimeScreenState();
}

class _CustomTimeScreenState extends State<CustomTimeScreen> {

  String shitDropDownValue = 'Morning';

  var shiftList = [
    'Morning',
    'Noon',
    'Evening'
  ];

  List<SingleTimeView> dyamicList = [];

  List<TimePickModel>? timePickModelList = [];

  BehaviorSubject<Time>? selectTime;

  CustomTimeBloc bloc = CustomTimeBloc();

  @override
  void initState() {
    super.initState();
    selectTime = BehaviorSubject<Time>.seeded(Time(hour: selectTime?.value.hour ?? 08,
        minute: selectTime?.value.minute ?? 00));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                const SizedBox(height: 30,),

                Text.rich(
                    TextSpan(
                        text: 'Hello ',
                        style: styleLarge1.copyWith(color: secondaryColor,fontWeight: FontWeight.w700),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Aden!',
                            style: styleLarge1.copyWith(color: primaryColor,fontWeight: FontWeight.w700),
                          )
                        ]
                    )
                ),

                const SizedBox(height: 10,),

                Text('Break the sedentary lifestyle and become active during your\nwork time.',
                  style: styleSmall.copyWith(color:
                  const Color(0xffA9A9A9),fontWeight: FontWeight.w400),),

                const SizedBox(height: 20,),

                Text('Select what works for you the best!',
                  style: styleSmall2.copyWith(color: secondaryColor,
                      fontWeight: FontWeight.w600),),

                const SizedBox(height: 20,),


                selectCustomBox(),

                const SizedBox(height: 10,),

                dynamicList(),
                const SizedBox(height: 40,),

                addMoreBtn(),

                const SizedBox(height: 10,)
              ],),
            ),
          )


          ,submitButton()
      ],),
    ),);
  }

  Widget  selectCustomBox(){
    return Container(decoration: BoxDecoration(color: boxColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: boxColor)),child:

    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 12),
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

          selectTimePicker()
        ],),
    ));
  }

  Widget shiftDropDownView(){
    return Container(
      decoration: BoxDecoration(color: white,borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
          value: shitDropDownValue,
          isExpanded: false,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down_sharp,
            color: black,),
          items: shiftList.map((String items) {
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

  Widget selectTimePicker(){
    return  InkWell(onTap: (){

      Navigator.of(context).push(
        showPicker(
          key: UniqueKey(),
          context: context,
          value: selectTime?.value ?? Time(hour: selectTime?.value.hour ?? 7, minute: selectTime?.value.minute ??00),
          onChange: onTimeChanged,
          minuteInterval: TimePickerInterval.FIVE,
          onChangeDateTime: (DateTime dateTime) {
            // print(dateTime);
            debugPrint("[debug datetime]:  $dateTime");
          },
        ),
      );
    },
      child: Container(decoration: BoxDecoration(color: white,
          borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
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
              StreamBuilder<Time>(
                stream: selectTime?.stream,
                builder: (context, snapshot) {
                  return Text('${selectTime?.value.hour}:${selectTime?.value.minute}',
                    style: styleSmall2.copyWith(color: secondaryColor,
                        fontWeight: FontWeight.w700),);
                }
              ),
            ],),
          )),
    );
  }

  Widget addMoreBtn(){
    return InkWell(onTap: (){
      addItem();
    },
      child: Center(
        child: Container(width: 140,height: 45,decoration:
        BoxDecoration(color: primaryColor,
            borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text('+ Add More',
              style: styleSmall2.copyWith(color: white,
                  fontWeight: FontWeight.w600),),
          ),),
      ),
    );
  }

  Widget dynamicList(){
    return Column(children: [
     ListView.builder(
       physics: const NeverScrollableScrollPhysics(),
        itemCount: dyamicList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return  Dismissible(
            key: UniqueKey(),
            background: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.cancel_outlined,
                  color: primaryColor,size: 40,),
              ],
            ),
            onDismissed: (direction) {
              setState(() {
                dyamicList.removeAt(index);
              });
            },
            child: SingleTimeView(index :index,selectedTimeCallBack: (timePickModel) {
              print(timePickModel.time);
              print(timePickModel.shit);
              // timePickModelList?.add(timePickModel);
              print(index);
              timePickModelList?.add(timePickModel);
              print("Length : ${timePickModelList?.length}");

            }),
          );
     },)
    ],);
  }

  addItem(){
    dyamicList.add(SingleTimeView());
    setState(() {
    });
  }

  Widget submitButton() {
    return ButtonView("Continue", () {

      List<String>? temp = [];
      timePickModelList?.forEach((element) {
       temp.add(element.time.toString());
      });
    temp.map((e) => debugPrint('debug print time${e}'));
      Map<String, dynamic> requestData = {
        "recommended": true,
        "breaks": temp
      };



      bloc.customApi(requestData, (response) {
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
  void onTimeChanged(Time newTime) {
    setState(() {
      selectTime?.add(newTime);
    });
  }
}
