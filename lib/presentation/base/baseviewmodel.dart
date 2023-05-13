abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs{
  ///contains all shared functions and variables will be used through any view model
}

abstract class BaseViewModelInputs{
  void start();///start view model job

  void dispose();///called when viewModel dies
}

abstract class BaseViewModelOutputs{

}