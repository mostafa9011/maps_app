import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'homeview_state.dart';

class HomeviewCubit extends Cubit<HomeviewState> {
  HomeviewCubit() : super(HomeviewInitial());
}
