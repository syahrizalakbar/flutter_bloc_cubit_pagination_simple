

import 'package:belajar_bloc/bloc/get_user_bloc/get_user_event.dart';
import 'package:belajar_bloc/bloc/get_user_bloc/get_user_state.dart';
import 'package:belajar_bloc/model/res/res_list_user.dart';
import 'package:belajar_bloc/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  GetUserBloc(GetUserState initialState) : super(initialState);

  UserRepository userRepo = UserRepository();
  List<ResListUser> list = [];

  @override
  Stream<GetUserState> mapEventToState(GetUserEvent event) async* {
    if (event is EventGetUser) {
      yield* getUser();
    } else if (event is EventLoadMore) {
      yield GetUserLoadingLoadMore(list);

      List<ResListUser> listNew = await userRepo.getUsers();
      list.addAll(listNew);

      if (list.isNotEmpty) {
        yield GetUserSuccess(list);
      } else {
        yield GetUserNoData("Data tidak ada");
      }
    }
  }

  Stream<GetUserState> getUser() async* {
    yield GetUserLoading();

    list = await userRepo.getUsers();

    if (list.isNotEmpty) {
      yield GetUserSuccess(list);
    } else {
      yield GetUserNoData("Data tidak ada");
    }
  }

}