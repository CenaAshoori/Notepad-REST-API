class ApiResponse<T> {
  T data;
  bool error = false;
  String message;

  ApiResponse({this.data , this.error , this.message});
}