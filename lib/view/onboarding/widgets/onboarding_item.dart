import 'package:flutter/material.dart';
import 'package:puzzle/model_view/data_provider.dart';

Container onboardingItem(
    BuildContext context, DataProvider value, int currentPage) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.7,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          value.data.intro![currentPage].icon.toString()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
