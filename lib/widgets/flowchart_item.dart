import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/node_types.dart';
import '../constants/sizes.dart';

class FlowChartItemWidget extends StatefulWidget {
  final int nodeType;
  final String subtitle;
  final String description;
  final String entityTitle;
  final String? imgAddress;
  final Function(String)? onTap;
  final String uuid;
  final bool? isDropped;

  const FlowChartItemWidget(this.nodeType, this.subtitle, this.description, this.entityTitle, this.imgAddress, this.onTap, this.uuid, this.isDropped, {super.key});

  @override
  State<FlowChartItemWidget> createState() => _FlowChartItemWidgetState();
}

class _FlowChartItemWidgetState extends State<FlowChartItemWidget> {
  double widgetWidth=ChartItemSizes.widgetWidth;
  double widgetHeight=ChartItemSizes.widgetHeight;
  List<Color> flowChartColors=[];

  @override
  Widget build(BuildContext context) {
    if(widget.nodeType==NodeTypes.employee){
      flowChartColors=FlowChartColors.blue;
    } else if(widget.nodeType==NodeTypes.department){
      flowChartColors=FlowChartColors.green;
    } else if(widget.nodeType==NodeTypes.organization){
      flowChartColors=FlowChartColors.yellow;
    } else {//if(widget.nodeType==nodeTypes.Location){
      flowChartColors=FlowChartColors.pink;
    }
    return InkWell(
      onTap: widget.isDropped!=null?(){widget.onTap!(widget.uuid);}:null,
      child: Column(
        children: [
          Container(
            width: widgetWidth,
            height: widgetHeight,
            decoration: BoxDecoration(
              color: flowChartColors[2],
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: flowChartColors[1],width: 1)
            ),
            child: Column(
              children: [
                Container(
                  width: widgetWidth,
                  height: 40,
                  decoration: BoxDecoration(
                    color: flowChartColors[0],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0,top: 5.0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle
                          ),
                          child: widget.imgAddress!=null?Image.network(widget.imgAddress!,width: 20,height: 20,):const Icon(Icons.person,size: 20,color: Colors.grey,)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0,top: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                width: widgetWidth-40,
                                alignment: Alignment.centerRight,
                                child: Text(widget.entityTitle,overflow: TextOverflow.ellipsis, textDirection: TextDirection.rtl
                                  , style: const TextStyle(fontSize: 8,fontWeight: FontWeight.bold,),)
                            ),
                            Container(
                              width: widgetWidth-40,
                              alignment: Alignment.centerRight,
                              child: Text(widget.subtitle,overflow: TextOverflow.ellipsis,textDirection: TextDirection.rtl
                                , style: const TextStyle(fontSize: 7,color: Colors.grey),)
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: widgetWidth,
                  height: 15,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: flowChartColors[1],
                  ),
                  child: Text(widget.description, style: const TextStyle(fontSize: 7,color: Colors.white),),
                ),
                if(widget.isDropped!=null)
                  Icon(widget.isDropped!?Icons.keyboard_double_arrow_up:Icons.keyboard_double_arrow_down_rounded,color: Colors.white,size: 12,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}