class SearchModel
{
  bool? status;
  SearchDataModel? searchDataModel;
  SearchModel.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    searchDataModel=SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel
{
  List<SearchData> searchList=[];
  SearchDataModel.fromJson(Map<String,dynamic> json)
  {
    json['data'].forEach((element)
    {
      searchList.add(SearchData.fromJson(element));
    });
  }

}

class SearchData
{
  int? favoriteId;
  SearchProducts? searchProducts;

  SearchData.fromJson(Map<String,dynamic>json)
  {
    favoriteId=json['id'];
    searchProducts=SearchProducts.fromJson(json['data']);
  }

}

class SearchProducts
{
  int? productId;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;

  SearchProducts.fromJson(Map<String,dynamic>json)
  {
    productId=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];


  }
}