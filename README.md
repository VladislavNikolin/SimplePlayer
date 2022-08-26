Simple Player
===

Приложение реализуещее плеер для камер с их настройкой на протоколе ONVIF.

Введение
---

На данный момент приложение позволяет настроить некоторые характеристики изображения: яркость, насыщенность, контрастность, резкость.
Также приложение позволяет настроить ip адрес камеры и маску сети в ручном и автоматическом режимах.

Клонирование
---
Чтобы склонировать проект, введите команду:

```bash
git clone --recursive https://github.com/VladislavNikolin/SimplePlayer.git
```

Сборка 
---

Для сборки проекта необходимо установить следующие пакеты (для Ubuntu 22.04):
```bash
sudo apt install build-essentials cmake
sudo apt install qt6-declarative-dev qml6-module-qtquick qml6-module-qtquick-controls qml6-module-qtquick-dialogs qml6-module-qtquick-layouts qml6-module-qtmultimedia libgl1-mesa-dev 
sudo apt install libxml2-dev
```

После того, как вы установили необходимые пакеты, введите следующие команды для сборки проекта

```bash
mkdir build
cd build
cmake ..
cmake --build .
```

Тестирование
---

Чтобы запустить приложение, введите следующую команду:

```bash
./src/SimplePlayer/splayer
```

