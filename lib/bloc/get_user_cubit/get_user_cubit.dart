
import 'package:belajar_bloc/bloc/get_user_cubit/get_user_state.dart';
import 'package:belajar_bloc/model/res/res_list_user.dart';
import 'package:belajar_bloc/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit(GetUserState initialState) : super(initialState);

  UserRepository userRepo = UserRepository();
  List<ResListUser> list = [];

  Future<void> getUser() async {
    emit(GetUserLoading());

    list = await userRepo.getUsers();

    if (list.isNotEmpty) {
      emit(GetUserSuccess(list));
    } else {
      emit(GetUserNoData("Data tidak ada"));
    }
  }

  Future<void> getUserLoadMore() async {
    emit(GetUserLoadingLoadMore(list));

    List<ResListUser> listNew = await userRepo.getUsers();
    list.addAll(listNew);

    if (list.isNotEmpty) {
      emit(GetUserSuccess(list));
    } else {
      emit(GetUserNoData("Data tidak ada"));
    }
  }

}