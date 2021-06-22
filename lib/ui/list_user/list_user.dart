import 'package:belajar_bloc/bloc/get_user_bloc/get_user_bloc.dart';
import 'package:belajar_bloc/bloc/get_user_bloc/get_user_event.dart';
import 'package:belajar_bloc/bloc/get_user_bloc/get_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUserPage extends StatefulWidget {
  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  final ScrollController controller = ScrollController();
  GetUserBloc? bloc;
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
      bloc?.add(EventLoadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GetUserBloc(GetUserInitial()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("List User"),
        ),
        body: SingleChildScrollView(
          controller: controller,
          physics: BouncingScrollPhysics(),
          child: BlocBuilder<GetUserBloc, GetUserState>(
            builder: (BuildContext context, GetUserState state) {
              bloc = BlocProvider.of<GetUserBloc>(context);
              currentState = state;

              if (state is GetUserInitial) {
                bloc?.add(EventGetUser());
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
