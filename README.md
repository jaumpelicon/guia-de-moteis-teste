# Guia de Motel - Teste Técnico

Este projeto **`guia_de_motel_teste`** foi desenvolvido como parte de um teste técnico para demonstrar habilidades em Flutter, boas práticas de arquitetura e testes automatizados. O objetivo da aplicação é fornecer um guia de motéis, listando informações relevantes e permitindo a filtragem de opções disponíveis.

---

## 🖼️ **Demonstração**

<div display="flex">
<img src="/assets/documentation_images/app_screen.png"  height=400/>
<img src="/assets/documentation_images/app_screen_2.png"  height=400/>
<img src="/assets/documentation_images/app_screen_2.png"  height=400/>
</div>

---

## 🚀 **Tecnologias Utilizadas**

### **🔹 Principais Tecnologias**

- **Flutter** (SDK para desenvolvimento cross-platform)
- **Dart** (Linguagem de programação)
- **Flutter BLoC** (Gerenciamento de estado)
- **Equatable** (Comparação eficiente de estados)
- **Dartz** (Programação funcional e uso de Either para erros)

### **🛠️ Utilitários e Ferramentas**

- **Get It** (Injeção de dependência)
- **GoRouter** (Gerenciamento de rotas)
- **Intl** (Internacionalização)
- **Url Launcher** (Abertura de URLs externas)
- **Package Info Plus** (Informações do app e versão)
- **Flutter Localizations** (Suporte a múltiplos idiomas)
- **Flutter SVG** (Renderização de SVGs)
- **Cached Network Image** (Carregamento e cache de imagens remotas)

### **🧪 Testes e Mocking**

- **Mockito** e **Mocktail** (Mocking para testes unitários)
- **Bloc Test** (Testes de BLoC)
- **Build Runner** (Geração de código para mocks e injeção de dependência)
- **Network Image Mock** (Mocking de imagens para testes)
- **Flutter Test** (Testes de unidade e integração)

### **🎨 Estilos e Assets**

- **LabradorA** (Fonte utilizada no projeto)
- **Assets de ícones e imagens** organizados em `assets/icons/` e `assets/images/`

---

## 📐 **Arquitetura do Projeto**

Este projeto segue a **arquitetura recomendada pelo Flutter** em seu [caso de estudo](https://docs.flutter.dev/app-architecture/case-study), organizando as camadas de forma modular e escalável. A estrutura está dividida em:

```
lib
|____ui
| |____core
| | |____ui
| | | |____<shared widgets>
| | |____themes
| |____<FEATURE NAME>
| | |____view_model
| | | |_____<view_model class>.dart
| | |____widgets
| | | |____<feature name>_screen.dart
| | | |____<other widgets>
|____domain
| |____models
| | |____<model name>.dart
|____data
| |____repositories
| | |____<repository class>.dart
| |____services
| | |____<service class>.dart
| |____model
| | |____<api model class>.dart
|____config
|____utils
|____routing
|____main_staging.dart
|____main_development.dart
|____main.dart

// The test folder contains unit and widget tests
test
|____data
|____domain
|____ui
|____utils
```

A separação em **Camada de Dados (`data`), Domínio (`domain`) e Apresentação (`ui`)** permite maior flexibilidade, testabilidade e escalabilidade do projeto.

---

## 🏗️ **Gerenciamento de Estado com BLoC**

O projeto utiliza **Flutter BLoC** como padrão para controle de estado, garantindo um fluxo de dados previsível e bem estruturado.

### **📌 Exemplo de BLoC para Motéis**

#### **Estados do HomeBloc:**

```dart
sealed class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<MotelEntity> motels;
  HomeSuccess({required this.motels});

  @override
  List<Object?> get props => [motels];
}

final class HomeError extends HomeState {
  final FailureError error;
  HomeError({required this.error});

  @override
  List<Object?> get props => [error];
}
```

#### **Eventos e Requisição de Dados**

```dart
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final repository = ServiceLocator.get<MotelsRepositoryProtocol>();

  HomeBloc() : super(HomeInitial()) {
    on<GetHomeMotelsEvent>(_getHomeMotels);
  }

  Future<void> _getHomeMotels(GetHomeMotelsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final response = await repository.getMotels();
    response.fold(
      (error) => emit(HomeError(error: error)),
      (success) => emit(HomeSuccess(motels: success)),
    );
  }
}
```

---

## 🧪 **Cobertura de Testes**

O projeto conta com testes unitários e de widgets utilizando **`flutter_test`**, **`bloc_test`** e **`mockito`**.

### 📊 **Gerando Coverage dos Testes**

Para verificar a cobertura dos testes, utilize:

```sh
flutter test --coverage
```

Para gerar um relatório legível em HTML:

```sh
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html  # Para visualizar no navegador
```

Se preferir verificar diretamente no Visual Studio Code baixe as extensões:

- coverage gutters;
- flutter coverage;
  Após rodar o comando :

```sh
flutter test --coverage
```

Aparecerá assim na aba de testes:
<img src="/assets/documentation_images/coverage.png" />

---

## 📌 **Conclusão**

O projeto **`guia_de_motel_teste`** segue as melhores práticas recomendadas pelo Flutter:

- **Arquitetura modularizada** baseada em camadas (`data`, `domain`, `ui`)
- **Gerenciamento de estado com BLoC** para previsibilidade
- **Cobertura de testes com bloc_test e mockito**

Isso garante **escalabilidade, facilidade de manutenção e testabilidade**.

🚀 **Agora é só testar e expandir a aplicação!**
