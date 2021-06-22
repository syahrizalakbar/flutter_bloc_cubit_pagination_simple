import 'package:belajar_bloc/model/res/res_list_user.dart';

abstract class GetUserState {}

class GetUserInitial extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserLoadingLoadMore extends GetUserState {
  final List<ResListUser> users;

  GetUserLoadingLoadMore(this.users);
}

class GetUserSuccess extends GetUserState {
  final List<ResListUser> users;

  GetUserSuccess(this.users);
}

class GetUserError extends GetUserState {}

class GetUserNoData extends GetUserState {
  final String message;

  GetUserNoData(this.message);
}
