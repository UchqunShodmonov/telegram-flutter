cd ../app/
echo 'generate for app'
flutter packages pub run build_runner build
cd ../feature/feature_chats_list_impl/
echo 'generate for feature_chats_list_impl'
flutter packages pub run build_runner build
cd ../feature_global_search_impl/
echo 'generate for feature_global_search_impl'
flutter packages pub run build_runner build
cd ../feature_main_screen_impl/
echo 'generate for feature_main_screen_impl'
flutter packages pub run build_runner build