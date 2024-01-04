abstract class WriteDateCubitStates {}

class WriteDateCubitIntialState extends WriteDateCubitStates {}

class WriteDateCubitLoadingState extends WriteDateCubitStates {}

class WriteDateCubitSuccessState extends WriteDateCubitStates {}

class WriteDateCubitFailedState extends WriteDateCubitStates {
  final String message;

  WriteDateCubitFailedState({required this.message});
}
