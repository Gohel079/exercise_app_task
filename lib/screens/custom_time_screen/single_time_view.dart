import 'dart:ffi';

import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:exercise_app/model/time_pick_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rxdart/rxdart.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';
import '../../constant/app_style.dart';

class SingleTimeView extends StatefulWidget {

  final Function(TimePickModel)? selectedTimeCallBack;
  final int? index;

  SingleTimeView({this.index,this.selectedTimeCallBack,super.key});

  @override
  State<SingleTimeView> createState() => _SingleTimeViewState();
}

class _SingleTimeViewState extends State<SingleTimeView> {

  String shitDropDownValue = 'Morning';

  var shiftList = [
    'Morning',
    'Noon',
    'Evening'
  ];
  TimePickModel? timePickModel = TimePickModel();
  BehaviorSubject<Time>? selectTime;

  @override
  Widget build(BuildContext context) {
    return selectCustomeBox();
  }

  Widget  selectCustomeBox(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(decoration: BoxDecoration(color: boxColor,
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
      )),
    );
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
              timePickModel?.shit = newValue!;
              shitDropDownValue = newValue!;
              print('ListItem ${timePickModel?.shit}');
              widget.selectedTimeCallBack?.call(timePickModel ?? TimePickModel());
            });
          },
        ),
      ),
    );
  }

  Widget selectTimePicker(){
    return  InkWell(onTap: ()  {
      setState(()  {

        /*Navigator.push(context, MaterialPageRoute(builder:
            (context) => timePicker((p0) => timePicker((p0) {
              hrs = p0.hour.toString();
              min = p0.minute.toString();
            },)) ));*/

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
          )
        );



        // showDayNightPickerWidget();

      });
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
              StreamBuilder(
                stream: selectTime?.stream,
                builder: (BuildContext context, AsyncSnapshot<Time> snapshot) {
                  return Text("${snapshot.data?.hour} : ${snapshot.data?.minute}",
                    style: styleSmall2.copyWith(color: secondaryColor,
                        fontWeight: FontWeight.w700),);
                },

              ),
            ],),
          )),
    );
  }

  void onTimeChanged(Time newTime) {
    setState(() {
      // widget.time.call(newTime);
      // defaultTime = newTime;
      selectTime?.add(newTime);
      timePickModel?.time = '${selectTime?.value.hour}:${selectTime?.value.minute}';
      widget.selectedTimeCallBack?.call(timePickModel ?? TimePickModel());
    });
  }


  @override
  void initState() {
  selectTime = BehaviorSubject<Time>.seeded(Time(hour: selectTime?.value.hour ?? 08, minute: selectTime?.value.minute ?? 00));
    super.initState();
  }

}



