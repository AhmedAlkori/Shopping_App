import '../../../Models/Search/Search_class.dart';

abstract class SearchState{}

class SearchInit extends SearchState{}



class SearchLoadState extends SearchState{}
class SearchSuccessState extends SearchState
{
  final SearchModel searchModel;
  SearchSuccessState(this.searchModel);

}
class SearchErrorState extends SearchState{}

