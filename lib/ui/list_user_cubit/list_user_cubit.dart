import 'package:belajar_bloc/bloc/get_user_cubit/get_user_state.dart';
import 'package:belajar_bloc/bloc/get_user_cubit/get_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUserCubit extends StatefulWidget {
  @override
  _ListUserCubitState createState() => _ListUserCubitState();
}

class _ListUserCubitState extends State<ListUserCubit> {
  final ScrollController controller = ScrollController();
  GetUserCubit? cubit;
  GetUserState? currentState;

  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent) {
        loadMore();
      }
    });
    super.initState();
  }

  void loadMore() {
    if (currentState is GetUserSuccess) {
      cubit?.getUserLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GetUserCubit(GetUserInitial()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("List User"),
        ),
        body: SingleChildScrollView(
          controller: controller,
          physics: BouncingScrollPhysics(),
          child: BlocBuilder<GetUserCubit, GetUserState>(
            builder: (BuildContext context, GetUserState state) {
              cubit = context.read<GetUserCubit>();
              currentState = state;

              if (state is GetUserInitial) {
                cubit?.getUser();
              } else if (state is GetUserLoading) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is GetUserNoData) {
                return Center(child: Text(state.message));
              } else if (state is GetUserError) {
                return Center(child: Text("Error"));
              } else if (state is GetUserSuccess) {
                return Column(
                  children: [
                    ListView.builder(
                      itemCount: state.users.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(state.users[index].name ?? "-"),
                          ),
                        );
                      },
                    ),
                    MaterialButton(
                      child: Text("Load more"),
                      onPressed: () {
                        loadMore();
                      },
                    ),
                  ],
                );
              } else if (state is GetUserLoadingLoadMore) {
                return Column(
                  children: [
                    ListView.builder(
                      itemCount: state.users.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(state.users[index].name ?? "-"),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
