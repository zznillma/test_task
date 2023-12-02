import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/feature/episodes/data/models/episodes_model.dart';
import 'package:test_task/feature/episodes/data/repository/episodes_repository_impl.dart';
import 'package:test_task/feature/episodes/presentation/logic/bloc/episodes_bloc.dart';
import 'package:test_task/internal/helpers/utils.dart';

class EpisodeScreen extends StatefulWidget {
  const EpisodeScreen({super.key});

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  late EpisodesBloc bloc;
  int counter = 1;
  int totalCount = 0;
  int totalPage = 2;
  bool isLoading = false;
  List<EpisodeResult> episodeResultList = [];
  late ScrollController scrollController;

  @override
  void initState() {
    bloc = EpisodesBloc(EpisodesRepositoryImpl());
    bloc.add(GetAllEpisodesEvent(
      isFirstCall: true,
      pages: counter,
    ));

    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (episodeResultList.isNotEmpty) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (isLoading) {
          counter = counter + 1;

          bloc.add(GetAllEpisodesEvent(
            isFirstCall: false,
            pages: counter,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Episodes'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        bloc.add(GetAllEpisodesEvent(
                          pages: counter,
                          isFirstCall: true,
                        ));
                      } else {
                        bloc.add(GetSeasonEvent(season: 'S0$index'));
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: index == 0 ? Text('Все') : Text('сезон $index'),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 10),
              ),
            ),
            BlocConsumer<EpisodesBloc, EpisodesState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is EpisodesLoadedState) {
                  totalPage = state.episodeModel.info?.pages ?? 0;
                  totalCount = state.episodeModel.info?.count ?? 0;

                  episodeResultList.addAll(state.episodeModel.results ?? []);

                  if (counter < totalPage) {
                    isLoading = true;
                  } else if (counter >= totalPage) {
                    isLoading = false;
                  }
                }
              },
              builder: (context, state) {
                log(state.toString());
                if (state is SeasonLoadedState) {
                  return Expanded(
                    child: Column(
                      children: [
                        Text('Всего: ${state.episodeModel.info!.count}'),
                        Expanded(
                          child: ListView.separated(
                            controller: scrollController,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            itemCount: state.episodeModel.results?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    const BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 53,
                                      width: 53,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          'https://i.ebayimg.com/images/g/iSwAAOSwXIpjJi76/s-l1200.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.episodeModel.results?[index]
                                                  .name ??
                                              '',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          episodeConvert(state
                                                      .episodeModel
                                                      .results?[index]
                                                      .episode ??
                                                  '') ??
                                              '',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                          ),
                        )
                      ],
                    ),
                  );
                }

                if (state is EpisodesLoadedState) {
                  return Expanded(
                    child: Column(
                      children: [
                        Text('Всего: ${state.episodeModel.info!.count}'),
                        Expanded(
                          child: ListView.separated(
                            controller: scrollController,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            itemCount: episodeResultList.length ?? 0,
                            itemBuilder: (context, index) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    const BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 53,
                                      width: 53,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          'https://i.ebayimg.com/images/g/iSwAAOSwXIpjJi76/s-l1200.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          episodeResultList[index].name ?? '',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          episodeConvert(
                                                  episodeResultList[index]
                                                          .episode ??
                                                      '') ??
                                              '',
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                          ),
                        )
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
    );
  }
}
