import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/feature/characters/data/models/character_model.dart';
import 'package:test_task/feature/characters/data/repository/character_repository_impl.dart';
import 'package:test_task/feature/characters/presentation/logic/bloc/characters_bloc.dart';
import 'package:test_task/internal/helpers/utils.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late TextEditingController _controller;
  late CharactersBloc bloc;
  late ScrollController scrollController;
  late ScrollController scrollControllerByName;
  bool isLoading = false;
  List<CharacterResult> characterResultList = [];
  List<CharacterResult> characterByNameResultList = [];

  int counter = 1;
  int totalCount = 0;
  int totalPage = 2;
  int counterByName = 1;
  int totalCountByName = 0;
  int totalPageByName = 2;
  late String name;

  @override
  void initState() {
    _controller = TextEditingController();
    bloc = CharactersBloc(CharacterRepositoryImpl());
    bloc.add(GetAllCharactersEvent(
      isFirstCall: true,
      page: counter,
    ));
    name = '';

    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    scrollControllerByName = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListenerByName);

    super.initState();
  }

  _scrollListener() {
    if (characterResultList.isNotEmpty) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (isLoading) {
          counter = counter + 1;

          bloc.add(GetAllCharactersEvent(
            isFirstCall: false,
            page: counter,
          ));
        }
      }
    }
  }

  _scrollListenerByName() {
    if (characterByNameResultList.isNotEmpty) {
      if (scrollControllerByName.offset >=
              scrollControllerByName.position.maxScrollExtent &&
          !scrollControllerByName.position.outOfRange) {
        if (isLoading) {
          counterByName = counterByName + 1;
          log(counterByName.toString());

          bloc.add(GetByNameEvent(
            isFirstCall: false,
            query: name,
            page: counterByName,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
      ),
      body: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                onSubmitted: (val) {
                  if (val.isNotEmpty) {
                    name = val;
                    bloc.add(GetByNameEvent(
                      isFirstCall: true,
                      query: val,
                      page: counterByName,
                    ));
                  } else {
                    bloc.add(GetAllCharactersEvent(
                      isFirstCall: true,
                      page: counter,
                    ));
                  }
                  setState(() {});
                },
              ),
              BlocConsumer<CharactersBloc, CharactersState>(
                bloc: bloc,
                listener: (context, state) {
                  log(state.toString());
                  if (state is CharactersLoadedState) {
                    totalPage = state.characterModel.info?.pages ?? 0;
                    totalCount = state.characterModel.info?.count ?? 0;

                    characterResultList
                        .addAll(state.characterModel.results ?? []);

                    if (counter < totalPage) {
                      isLoading = true;
                    } else if (counter >= totalPage) {
                      isLoading = false;
                    }
                  }

                  if (state is SearchByNameLoadedState) {
                    totalPageByName = state.characterModel.info?.pages ?? 0;
                    totalCountByName = state.characterModel.info?.count ?? 0;
                    characterByNameResultList
                        .addAll(state.characterModel.results ?? []);
                    log(totalPageByName.toString());

                    if (counterByName < totalPageByName) {
                      isLoading = true;
                    } else if (counterByName >= totalPageByName) {
                      isLoading = false;
                    }
                  }
                },
                builder: (context, state) {
                  if (state is SearchByNameLoadedState) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Всего: ${state.characterModel.info?.count}"),
                          SizedBox(height: 10.h),
                          Expanded(
                            child: ListView.separated(
                              controller: scrollControllerByName,
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10)
                                  .r,
                              itemCount: characterByNameResultList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    context.go(
                                      '/character_info',
                                      extra: {
                                        "characterResult":
                                            characterByNameResultList[index]
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 10)
                                        .r,
                                    width: 1.sw,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10).r,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5.r,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 53.r,
                                          width: 53.r,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30).r,
                                            child: Image.network(
                                              characterByNameResultList[index]
                                                      .image ??
                                                  '',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              characterByNameResultList[index]
                                                      .name ??
                                                  '',
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              statusConvert(
                                                  characterByNameResultList[
                                                              index]
                                                          .status ??
                                                      Status.UNKNOWN),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              genderConvert(
                                                  characterByNameResultList[
                                                              index]
                                                          .gender ??
                                                      Gender.UNKNOWN),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 20.h),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is CharactersLoadedState) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Всего: ${state.characterModel.info?.count}"),
                          SizedBox(height: 10.h),
                          Expanded(
                            child: ListView.separated(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10)
                                  .r,
                              itemCount: characterResultList.length ?? 0,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    context.go(
                                      '/character_info',
                                      extra: {
                                        "characterResult":
                                            characterResultList[index]
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 10)
                                        .r,
                                    width: 1.sw,
                                    height: 70.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10).r,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5.r,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 53.r,
                                          width: 53.r,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30).r,
                                            child: Image.network(
                                              characterResultList[index]
                                                      .image ??
                                                  '',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              characterResultList[index].name ??
                                                  '',
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              statusConvert(
                                                  characterResultList[index]
                                                          .status ??
                                                      Status.UNKNOWN),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              genderConvert(
                                                  characterResultList[index]
                                                          .gender ??
                                                      Gender.UNKNOWN),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 20.h),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
