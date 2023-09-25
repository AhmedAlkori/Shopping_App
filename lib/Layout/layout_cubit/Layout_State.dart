
abstract class LayoutState {}
class LayoutInitState extends LayoutState{}

class LayoutChangeNavState extends LayoutState{}


class LayoutLoadBannersState extends LayoutState{}
class LayoutSuccessBannerState extends LayoutState{}
class LayoutErrorBannerState extends LayoutState{}

class LayoutLoadCategoriesState extends LayoutState{}
class LayoutSuccessCategoriesState extends LayoutState{}
class LayoutErrorCategoriesState extends LayoutState{}

class LayoutChangeFavIconState extends LayoutState{}
class LayoutLoadChangeFavIconState extends LayoutState{}

class LayoutLoadFavState extends LayoutState{}
class LayoutSuccessFavoritesState extends LayoutState{}
class LayoutErrorFavoritesState extends LayoutState{}


class SettingsLoadDataState extends LayoutState {}
class SettingsGetDataSuccessState extends LayoutState {}
class SettingsGetDataErrorState extends LayoutState {}

class SettingsUpdateProfieSuccessState extends LayoutState
{
  final String message;
  SettingsUpdateProfieSuccessState(this.message);
}
class SettingsUpdateProfieWarningState extends LayoutState
{
  final String message;
  SettingsUpdateProfieWarningState(this.message);
}
class SettingsUpdateProfieLoadState extends LayoutState{}
class SettingsUpdateProfieErrorState extends LayoutState{}
