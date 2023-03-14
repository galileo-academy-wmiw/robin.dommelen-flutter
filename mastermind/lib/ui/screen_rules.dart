import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../common/ui_controller.dart';
import 'ui_data.dart';
import 'ui_widgets.dart';

class ScreenRules extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Rules", style: TextStyle(fontSize: 32),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ut quam consequat, mollis metus vitae, aliquet tellus. Curabitur eu sapien pharetra purus sodales placerat. Proin metus sem, tincidunt et consequat sed, auctor quis leo. Morbi sollicitudin tempus enim at rutrum. Nulla eget odio nisi. Integer aliquam posuere dignissim. Donec id efficitur tellus. Duis bibendum id augue ut tempor. Nam eget rutrum nisi. Aliquam tempus dui sit amet scelerisque suscipit. Integer eget libero augue."),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(image: AssetImage("assets/img/rules_0.png"),)
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Maecenas quis lacus eu mi fringilla consequat sodales vel mi. Aenean id efficitur sem, eu mollis sem. Nunc ut consectetur nisi. Proin dictum mi vitae tellus condimentum vehicula. Nulla consequat facilisis ipsum, nec luctus justo. Aenean congue, purus in vehicula facilisis, ipsum dui tristique nisi, vitae dictum eros enim eget turpis. Vivamus pulvinar, dolor eget malesuada convallis, ex eros imperdiet nisl, sollicitudin iaculis enim mi sed justo. Fusce congue ante sed tortor consequat convallis sit amet sit amet neque. Suspendisse finibus nisl quis enim tincidunt sollicitudin. Nulla consectetur commodo molestie. Duis tempor blandit rutrum. Praesent vitae dui dui. Integer vulputate lectus lorem, at condimentum ante sagittis porttitor. Aenean blandit tempus accumsan."),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Proin varius non tellus vitae dapibus. Morbi nec odio et lectus tempus tristique. Quisque ac nibh leo. Sed imperdiet sollicitudin risus quis volutpat. Pellentesque laoreet condimentum finibus. Sed scelerisque sit amet velit sit amet interdum. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Donec vulputate, odio nec luctus dignissim, quam diam elementum orci, eu vestibulum justo magna vel metus. Duis lorem augue, semper vitae sagittis vitae, molestie at risus."),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(image: AssetImage("assets/img/rules_1.png"),)
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Praesent molestie ac metus vel ultrices. Nulla molestie est elit. Curabitur ultricies et leo vitae maximus. Donec faucibus enim vel urna consectetur, in consequat neque molestie. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris convallis metus ut fringilla dictum. Nulla condimentum lacinia urna eget tempor. Nam lacinia risus non laoreet commodo. Fusce eget imperdiet arcu. Mauris non placerat turpis. Duis fringilla ex sit amet feugiat vehicula. Donec faucibus lacus non hendrerit auctor. Sed finibus sed mi id finibus. Vivamus fringilla justo libero, at placerat nulla porta blandit."),
                  ),
                ],
              ),
            ],
          )
        ),
        Positioned(
            top: MediaQuery.of(context).size.height - 70,
            left: MediaQuery.of(context).size.width - 70,
            child: WidgetSquareButton(Icons.check, 60, () => {
              UiController.setScreenState(context, EnumUiState.homeScreen)
            })
        ),
      ],
    );
  }
}
