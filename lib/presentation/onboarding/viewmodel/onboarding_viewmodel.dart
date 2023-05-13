import 'dart:async';

import 'package:flutter_advanced/domain/model/models.dart';
import 'package:flutter_advanced/presentation/base/baseviewmodel.dart';
import 'package:flutter_advanced/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  ///stream controllers outputs
  final StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  ///onboarding view model inputs
  @override
  void start() {
    _list=_getSliderData();
    _postDataToView();
  }
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  int goNext() {
    int nextIndex= ++_currentIndex ;
    if(nextIndex==_list.length) {
      nextIndex=0 ;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex= --_currentIndex;
    if(previousIndex==-1) {
      previousIndex=_list.length -1 ;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  ///onboarding view model outputs
  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  ///onboarding private functions
  List<SliderObject> _getSliderData() {
    return [
      SliderObject(AppStrings.onBoardingTitle1, AppStrings.onBoardingSubTitle1,
          ImageAssets.onBoardingLogo1),
      SliderObject(AppStrings.onBoardingTitle2, AppStrings.onBoardingSubTitle2,
          ImageAssets.onBoardingLogo2),
      SliderObject(AppStrings.onBoardingTitle3, AppStrings.onBoardingSubTitle3,
          ImageAssets.onBoardingLogo3),
      SliderObject(AppStrings.onBoardingTitle4, AppStrings.onBoardingSubTitle4,
          ImageAssets.onBoardingLogo4),
    ];
  }

  void _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

///inputs means orders that view model will receive from view
abstract class OnBoardingViewModelInputs {
  int goNext();

  ///when user click on right arrow
  int goPrevious();

  ///when user click on left arrow
  void onPageChanged(int index);

  ///stream controller inputs
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  ///stream controller outputs
  Stream<SliderViewObject> get outputSliderViewObject;
}
