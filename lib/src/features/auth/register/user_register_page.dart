import 'package:dw_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/features/auth/register/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterVM = ref.watch(userRegisterVmProvider.notifier);

    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
          break;
        case UserRegisterStateStatus.success:
          Navigator.of(context).pushNamed('/auth/register/barbershop');
        case UserRegisterStateStatus.error:
          Messages.showError('Erro ao registar usuario administrador', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                controller: nameEC,
                validator: Validatorless.required('Nome obrigatorio'),
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                controller: emailEC,
                validator: Validatorless.multiple([
                  Validatorless.required('Email obrigatorio'),
                  Validatorless.email('Email não é valido'),
                ]),
                decoration: const InputDecoration(label: Text('E-mail')),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                controller: passwordEC,
                validator: Validatorless.multiple([
                  Validatorless.required('Senha é obrigatória'),
                  Validatorless.min(6, 'Senha deve ter no minimo 6 caracateres')
                ]),
                obscureText: true,
                decoration: const InputDecoration(label: Text('Senha')),
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                onTapOutside: (_) => context.unfocus(),
                validator: Validatorless.multiple([
                  Validatorless.required('Confirma senha é obrigatória'),
                  Validatorless.compare(
                      passwordEC, 'Senha diferente de confirma senha')
                ]),
                obscureText: true,
                decoration:
                    const InputDecoration(label: Text('Confirmar Senha')),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56)),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        Messages.showError('Formulario invalido', context);
                      case true:
                        userRegisterVM.register(
                            name: nameEC.text,
                            email: emailEC.text,
                            password: passwordEC.text);
                    }
                  },
                  child: const Text('CRIAR CONTA'))
            ],
          ),
        )),
      ),
    );
  }
}
