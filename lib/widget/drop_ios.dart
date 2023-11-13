import 'package:bin_trade/bloc/home/home_bloc.dart';
import 'package:bin_trade/setting/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Flutter code sample for [CupertinoPicker].

const double _kItemExtent = 32.0;

class CupertinoPickerExample extends StatefulWidget {
  final Color color;
  final Color textColor;
  final double size;
  final Map<String, String> values;
  const CupertinoPickerExample(
      {super.key,
      required this.color,
      required this.size,
      required this.values,
      required this.textColor});

  @override
  State<CupertinoPickerExample> createState() => _CupertinoPickerExampleState();
}

class _CupertinoPickerExampleState extends State<CupertinoPickerExample> {
  int _selectedFruit = 0;

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showDialog(
          CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: _kItemExtent,
            scrollController: FixedExtentScrollController(
              initialItem: _selectedFruit,
            ),
            onSelectedItemChanged: (int selectedItem) {
              // при выборе инструмента
              widget.values['EUR/USD'] != null
                  ? context.read<HomeBloc>().add(GetCurrentChartsEvent(
                      value: widget.values.values.toList()[selectedItem]))
                  : null;
              widget.values['dollar'] != null
                  ? context.read<HomeBloc>().add(SetOrderPointEvent(
                      value: widget.values.values.toList()[selectedItem]))
                  : null;
              widget.values['one'] != null
                  ? context.read<HomeBloc>().add(SetOrderTimeEvent(
                      value: widget.values.values.toList()[selectedItem]))
                  : null;
              setState(() {
                _selectedFruit = selectedItem;
              });
            },
            children: List<Widget>.generate(
              widget.values.length,
              (int index) {
                return Center(
                    child: Text(widget.values.values.toList()[index]));
              },
            ),
          ),
        ),
        child: SizedBox(
          height: 48,
          width: widget.size,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: widget.color),
            child: Row(
              children: [
                widget.values['one'] != null
                    ? const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.timer,
                          color: containerColor,
                        ),
                      )
                    : const SizedBox.shrink(),
                widget.values['dollar'] != null
                    ? const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Icon(
                          Icons.monetization_on,
                          color: containerColor,
                        ),
                      )
                    : const SizedBox.shrink(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: BlocBuilder<HomeBloc, HomeState>(
                      buildWhen: (previous, current) => previous.order.time != current.order.time || previous.order.price != current.order.price || previous.currentValute != current.currentValute,
                      builder: (context, state) {
                        String x = '';
                        switch (widget.values.keys.first) {
                          case 'dollar' : x = '${state.order.price}';
                          break;
                          case 'EUR/USD' : x = state.currentValute;
                          break;
                          case 'one' : x = state.order.time;
                        }
                        return Text(
                          x,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: widget.textColor),
                        );
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: menuIconsColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

