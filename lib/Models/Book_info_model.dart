class Book_info_model{
  String _author;
  bool _availability;
  String _bookname;
  String _Condition;
  String _Dislikes;
  String _Likes;
  String _Homepagecat;
  String _Imageurl;
  String _Longdescription;
  String _MRP;
  double _quotedDeposit;

  String get author => _author;

  set author(String value) {
    _author = value;
  }

  Book_info_model(
      this._author,
      this._availability,
      this._bookname,
      this._Condition,
      this._Dislikes,
      this._Likes,
      this._Homepagecat,
      this._Imageurl,
      this._Longdescription,
      this._MRP,
      this._quotedDeposit,
      this._OwnerRatings,
      this._OwnerUId,
      this._Quantity,
      this._Category,
      this._Conditiondescription,
      this._ISBN);

  String _OwnerRatings;
  String _OwnerUId;
  String _Quantity;
  String _Category;
  String _Conditiondescription;
  String _ISBN;

  bool get availability => _availability;

  String get ISBN => _ISBN;

  set ISBN(String value) {
    _ISBN = value;
  }

  String get Conditiondescription => _Conditiondescription;

  set Conditiondescription(String value) {
    _Conditiondescription = value;
  }

  String get Category => _Category;

  set Category(String value) {
    _Category = value;
  }

  String get Quantity => _Quantity;

  set Quantity(String value) {
    _Quantity = value;
  }

  String get OwnerUId => _OwnerUId;

  set OwnerUId(String value) {
    _OwnerUId = value;
  }

  String get OwnerRatings => _OwnerRatings;

  set OwnerRatings(String value) {
    _OwnerRatings = value;
  }

  double get quotedDeposit => _quotedDeposit;

  set quotedDeposit(double value) {
    _quotedDeposit = value;
  }

  String get MRP => _MRP;

  set MRP(String value) {
    _MRP = value;
  }

  String get Longdescription => _Longdescription;

  set Longdescription(String value) {
    _Longdescription = value;
  }

  String get Imageurl => _Imageurl;

  set Imageurl(String value) {
    _Imageurl = value;
  }

  String get Homepagecat => _Homepagecat;

  set Homepagecat(String value) {
    _Homepagecat = value;
  }

  String get Likes => _Likes;

  set Likes(String value) {
    _Likes = value;
  }

  String get Dislikes => _Dislikes;

  set Dislikes(String value) {
    _Dislikes = value;
  }

  String get Condition => _Condition;

  set Condition(String value) {
    _Condition = value;
  }

  String get bookname => _bookname;

  set bookname(String value) {
    _bookname = value;
  }

  set availability(bool value) {
    _availability = value;
  }
}