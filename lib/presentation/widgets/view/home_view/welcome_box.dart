import 'package:fast_order/config/index.dart';
import 'package:fast_order/presentation/bloc/index.dart';
import 'package:fast_order/presentation/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomBox extends StatelessWidget {
  const WelcomBox({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AvailableDishesBloc, AvailableDishesState, int?>(
      selector: (state) {
        if (state.isFetching) return null;
        if (state.availableDishes == null || state.availableDishes!.isEmpty) return 0;
        return state.availableDishes!.length;
      },
      builder: (context, dishesAvailable) {
        return Container(
          width: width,
          height: height,
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Título Guisos del día
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Flexible(
                      flex: 2,
                      child: ResponsiveText(
                        text: 'Guisos',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          height: 0.95,
                          letterSpacing: 1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        maxFontSize: 32,
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: ResponsiveText(
                        text: 'del día',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                          letterSpacing: 1,
                        ),
                        maxFontSize: 28,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),

              //* Fecha
              Expanded(
                flex: 2,
                child: CustomDate(width: width),
              ),

              //* Num. Raciones disponibles + Platillos disponibles
              dishesAvailable == null
                  ? ShimmerDishesAvailableText(height: height, width: width)
                  : Expanded(
                      flex: 4,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ResponsiveText(
                              text: '$dishesAvailable',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: colorList[0],
                                height: 0.8,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              minFontSize: 18,
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: ResponsiveText(
                              text: dishesAvailable == 1
                                  ? 'Platillo\ndisponible'
                                  : 'Platillos\ndisponibles',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                                height: 0.95,
                              ),
                              maxFontSize: 18,
                              minFontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}