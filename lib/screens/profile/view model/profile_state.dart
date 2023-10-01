part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ShowProfileSuccess extends ProfileState {}
class ShowProfileFailed extends ProfileState {}
class UpdateProfileSuccess extends ProfileState {}
class UpdateProfileFailed extends ProfileState {}
class GovernoratesGetSuccessfully extends ProfileState {}
class GovernoratesGetFailed extends ProfileState {}
class ChangeCitySuccessfully extends ProfileState {}