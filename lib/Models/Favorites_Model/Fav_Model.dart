class FavoritesModel
{
  bool? status;
  FavoritesDataModel? favoritesDataModel;
  FavoritesModel.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    favoritesDataModel=FavoritesDataModel.fromJson(json['data']);
  }
}

class FavoritesDataModel
{
   List<FavoritesData> favoriteList=[];
    FavoritesDataModel.fromJson(Map<String,dynamic> json)
    {
      json['data'].forEach((element)
      {
        favoriteList.add(FavoritesData.fromJson(element));
      });
    }

}

class FavoritesData
{
  int? favoriteId;
  FavoriteProducts? favoriteProducts;

  FavoritesData.fromJson(Map<String,dynamic>json)
  {
     favoriteId=json['id'];
     favoriteProducts=FavoriteProducts.fromJson(json['product']);
  }

}

class FavoriteProducts
{
 int? productId;
 dynamic price;
 dynamic old_price;
 dynamic discount;
 String? image;
 String? name;

 FavoriteProducts.fromJson(Map<String,dynamic>json)
 {
   productId=json['id'];
   price=json['price'];
   old_price=json['old_price'];
   discount=json['discount'];
   image=json['image'];
   name=json['name'];


 }
}