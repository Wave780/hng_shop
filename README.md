
# SHOPPING APP

This is an assignment report for the HNG stage two task. I was tasked to develop a simple shopping app with a third-party API and packages with two menus: product and cart.

# Features

- List of Product(API)
- Add and remove products from the cart list.
- Navigate to the order successful screen from the cart screen.
- Packages used are; HTTP, Intl

# Screenshots
<b>Product Screen</b>
<img src = "Screenshot.png">
<b>Successful Order Screen</b>
<img src = "Screenshot_2.png">
<b>Empty Cart Screen</b>
<img src = "Screenshot_3.png">
<b>Cart Screen</b>
<img src = "Screenshot_4.png">
# The API Docs [Read] (https://docs.timbu.cloud/api/intro)

# The API [Link] (http://timbu.cloud/)
# Appetize Demo

- you can view the app on Appetize.io [Click here](https://appetize.io/app/vp6i7j6fanbtwpzovpehl2le4u?device=pixel7&osVersion=13.0&record=true) 

# Project Structure
lib/
|- core/
|   |- constants/
|   |   |- enum.dart
|- data/
|   |- model/
|   |   |- product_model.dart
|   |   |- profile.json
|   |- controllers/
|   |   |- base_controller.dart
|   |   |- dashboard_controller.dart
|   |   |- products_controller.dart
|   |   |- switch_controller.dart
|   |   |- theme_notifier.dart
|   |- services/
|   |   |- dio_mixin.dart
|   |   |- error_service.dart
|   |   |- product_services.dart
|- presentation/
|   |- screens/
|   |    |   |- home.dart
|   |    |   |- profile.dart
|   |- widgets/
|    |   |   |- home/
|    |   |   |   |- card_widget.dart
|    |   |   |   |- home_description.dart
|    |   |   |   |- home_image.dart
|    |   |   |- profile/
|    |   |   |   |- profile_stat.dart
|    |   |- my_fade_route.dart
|    |   |- shimmer.dart
|- utils/
|   |- locator.dart
|- home.dart
|- main.dart

