part of 'data_plan_bloc.dart';

abstract class DataPlanState extends Equatable {
  const DataPlanState();

  @override
  List<Object> get props => [];
}

final class DataPlanInitial extends DataPlanState {}

final class DataPlanLoading extends DataPlanState {}

final class DataPlanFailed extends DataPlanState {
  final String error;

  const DataPlanFailed(this.error);

  @override
  List<Object> get props => [error];
}

final class DataPlanSuccess extends DataPlanState {}
