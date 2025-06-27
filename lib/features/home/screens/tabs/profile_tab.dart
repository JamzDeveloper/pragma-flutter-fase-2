import 'package:fake_store/core/theme/colors.dart';
import 'package:fake_store/features/auth/state/auth_bloc.dart';
import 'package:fake_store/features/auth/state/auth_state.dart';
import 'package:fake_store/features/home/state/user_bloc.dart';
import 'package:fake_store/features/home/state/user_event.dart';
import 'package:fake_store/features/home/state/user_state.dart';
import 'package:fake_store/features/home/widgets/profile_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    if (authState is AuthSuccess) {
      final userId = authState.userId;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<UserBloc>().add(FetchUser(userId));
      });
    }

    return _ProfileContent();
  }
}

class _ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // UI con BlocBuilder<UserBloc, UserState> para mostrar nombre/email
          Column(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoaded) {
                    final user = state.user;

                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,

                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Text(
                              '${user.name.firstname.substring(0, 1).toUpperCase() + user.name.lastname.substring(0, 1).toUpperCase()}',
                              style: TextStyle(fontSize: 40),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          '${state.user.name.firstname} ${state.user.name.lastname}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(state.user.email),
                      ],
                    );
                  } else if (state is UserLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return const Text("👤 Usuario no disponible");
                  }
                },
              ),
            ],
          ),

          Column(
            children: [
              ProfileOptionTile(
                icon: Icons.person,
                label: 'Información de cuenta',
                onTap: () {},
              ),
              SizedBox(height: 15),
              ProfileOptionTile(
                icon: Icons.location_on,
                label: 'Dirección de entrega',
                onTap: () {},
              ),
              SizedBox(height: 15),
              ProfileOptionTile(
                icon: Icons.payment,
                label: 'Método de pago',
                onTap: () {},
              ),
              SizedBox(height: 15),
              ProfileOptionTile(
                icon: Icons.lock,
                label: 'Contraseña',
                onTap: () {},
              ),
              SizedBox(height: 15),
              ProfileOptionTile(
                icon: Icons.people,
                label: 'Referidos',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child:  Text(
                "Cerrar sesión",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
