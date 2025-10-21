import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myflow_mini_companion_app/domain/models/user/user.dart';
import 'package:myflow_mini_companion_app/data/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(const UserInitial());

  Future<void> loadUser() async {
    try {
      emit(const UserLoading());
      final user = _userRepository.getUser();
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void clearUser() {
    emit(const UserInitial());
  }
}
