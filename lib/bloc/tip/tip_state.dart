part of 'tip_bloc.dart';

abstract class TipState extends Equatable {
  const TipState();

  @override
  List<Object> get props => [];
}

final class TipInitial extends TipState {}

final class TipLoading extends TipState {}

final class TipFailed extends TipState {
  final String error;
  const TipFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

final class TipSuccess extends TipState {
  final List<TipModel> tips;
  const TipSuccess(
    this.tips,
  );
  @override
  List<Object> get props => [tips];
}
