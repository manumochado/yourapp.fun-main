
/*
 * Generated file. Do not edit.
 *
 * Locales: 2
 * Strings: 42 (21.0 per locale)
 *
 * Built on 2022-08-30 at 07:00 UTC
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.en;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale {
	en, // 'en' (base locale, fallback)
	es, // 'es'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn _t = _currLocale.translations;
_StringsEn get t => _t;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget.translations;
	}
}

class LocaleSettings {
	LocaleSettings._(); // no constructor

	/// Uses locale of the device, fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale useDeviceLocale() {
		final locale = AppLocaleUtils.findDeviceLocale();
		return setLocale(locale);
	}

	/// Sets locale
	/// Returns the locale which has been set.
	static AppLocale setLocale(AppLocale locale) {
		_currLocale = locale;
		_t = _currLocale.translations;

		// force rebuild if TranslationProvider is used
		_translationProviderKey.currentState?.setLocale(_currLocale);

		return _currLocale;
	}

	/// Sets locale using string tag (e.g. en_US, de-DE, fr)
	/// Fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale setLocaleRaw(String rawLocale) {
		final locale = AppLocaleUtils.parse(rawLocale);
		return setLocale(locale);
	}

	/// Gets current locale.
	static AppLocale get currentLocale {
		return _currLocale;
	}

	/// Gets base locale.
	static AppLocale get baseLocale {
		return _baseLocale;
	}

	/// Gets supported locales in string format.
	static List<String> get supportedLocalesRaw {
		return AppLocale.values
			.map((locale) => locale.languageTag)
			.toList();
	}

	/// Gets supported locales (as Locale objects) with base locale sorted first.
	static List<Locale> get supportedLocales {
		return AppLocale.values
			.map((locale) => locale.flutterLocale)
			.toList();
	}
}

/// Provides utility functions without any side effects.
class AppLocaleUtils {
	AppLocaleUtils._(); // no constructor

	/// Returns the locale of the device as the enum type.
	/// Fallbacks to base locale.
	static AppLocale findDeviceLocale() {
		final String? deviceLocale = WidgetsBinding.instance.window.locale.toLanguageTag();
		if (deviceLocale != null) {
			final typedLocale = _selectLocale(deviceLocale);
			if (typedLocale != null) {
				return typedLocale;
			}
		}
		return _baseLocale;
	}

	/// Returns the enum type of the raw locale.
	/// Fallbacks to base locale.
	static AppLocale parse(String rawLocale) {
		return _selectLocale(rawLocale) ?? _baseLocale;
	}
}

// context enums

// interfaces generated as mixins

// translation instances

late _StringsEn _translationsEn = _StringsEn.build();
late _StringsEs _translationsEs = _StringsEs.build();

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {

	/// Gets the translation instance managed by this library.
	/// [TranslationProvider] is using this instance.
	/// The plural resolvers are set via [LocaleSettings].
	_StringsEn get translations {
		switch (this) {
			case AppLocale.en: return _translationsEn;
			case AppLocale.es: return _translationsEs;
		}
	}

	/// Gets a new translation instance.
	/// [LocaleSettings] has no effect here.
	/// Suitable for dependency injection and unit tests.
	///
	/// Usage:
	/// final t = AppLocale.en.build(); // build
	/// String a = t.my.path; // access
	_StringsEn build() {
		switch (this) {
			case AppLocale.en: return _StringsEn.build();
			case AppLocale.es: return _StringsEs.build();
		}
	}

	String get languageTag {
		switch (this) {
			case AppLocale.en: return 'en';
			case AppLocale.es: return 'es';
		}
	}

	Locale get flutterLocale {
		switch (this) {
			case AppLocale.en: return const Locale.fromSubtags(languageCode: 'en');
			case AppLocale.es: return const Locale.fromSubtags(languageCode: 'es');
		}
	}
}

extension StringAppLocaleExtensions on String {
	AppLocale? toAppLocale() {
		switch (this) {
			case 'en': return AppLocale.en;
			case 'es': return AppLocale.es;
			default: return null;
		}
	}
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey = GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
	TranslationProvider({required this.child}) : super(key: _translationProviderKey);

	final Widget child;

	@override
	_TranslationProviderState createState() => _TranslationProviderState();

	static _InheritedLocaleData of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget;
	}
}

class _TranslationProviderState extends State<TranslationProvider> {
	AppLocale locale = _currLocale;

	void setLocale(AppLocale newLocale) {
		setState(() {
			locale = newLocale;
		});
	}

	@override
	Widget build(BuildContext context) {
		return _InheritedLocaleData(
			locale: locale,
			child: widget.child,
		);
	}
}

class _InheritedLocaleData extends InheritedWidget {
	final AppLocale locale;
	Locale get flutterLocale => locale.flutterLocale; // shortcut
	final _StringsEn translations; // store translations to avoid switch call

	_InheritedLocaleData({required this.locale, required Widget child})
		: translations = locale.translations, super(child: child);

	@override
	bool updateShouldNotify(_InheritedLocaleData oldWidget) {
		return oldWidget.locale != locale;
	}
}

// pluralization feature not used

// helpers

final _localeRegex = RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
	final match = _localeRegex.firstMatch(localeRaw);
	AppLocale? selected;
	if (match != null) {
		final language = match.group(1);
		final country = match.group(5);

		// match exactly
		selected = AppLocale.values
			.cast<AppLocale?>()
			.firstWhere((supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'), orElse: () => null);

		if (selected == null && language != null) {
			// match language
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.startsWith(language) == true, orElse: () => null);
		}

		if (selected == null && country != null) {
			// match country
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.contains(country) == true, orElse: () => null);
		}
	}
	return selected;
}

// translations

// Path: <root>
class _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build();

	/// Access flat map
	dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	String get imagePrivacity => 'assets/Ref1/Privacidad.png';
	String get imageOurApplications => 'assets/Ref1/+App.png';
	String get imagePlayCard => 'assets/Ref1/boton jugar2.png';
	String get titleSliderModalExternal => 'If you press the button to go to the app, it will take you to download the chosen APP to the';
	String get buttonSliderModalExternal => 'assets/Ref3/Pop Up Slider Boton.png';
	String get titlePLay => 'OLIVIA RODRIGUEZ';
	String get subtitlePLay => 'are you his #1 fan?';
	String get titleWallPaper => 'OLIVIA RODRIGUEZ';
	String get subTitleWallPaper => 'Unique Funds';
	String get imageWallPaper => 'assets/Ref1/Boton Wallpaper.png';
	String get titleMyApp => 'AN APP ABOUT YOU';
	String get subTitleMyApp => 'how much do you know';
	String get subTitle2MyApp => 'friends about you?';
	String get imageMyApp => 'assets/Ref1/Boton Quiero.png';
	String get titleRandom => 'PLAY WITH A';
	String get subTitleRandom => 'RANDOM ARTIST';
	String get imageRandom => 'assets/Ref1/Boton Artistas Aleatorio.png';
	String get ourAppsTitle => 'assets/Ref3/Todas Nuestras App.png';
	String get ourAppsSearchHint => 'Search artist...';
	String get titleEmpity => 'We do not have the artist you are looking for, you can check that it is well written, if it is well written you can send us the name so that we can make the app';
	String get ourAppsRecomendHint => 'Recommend artist...';
}

// Path: <root>
class _StringsEs implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEs.build();

	/// Access flat map
	@override dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	@override late final Map<String, dynamic> _flatMap = _buildFlatMap();

	@override late final _StringsEs _root = this; // ignore: unused_field

	// Translations
	@override String get imagePrivacity => 'assets/Ref1/Privacidad.png';
	@override String get imageOurApplications => 'assets/Ref1/+App.png';
	@override String get imagePlayCard => 'assets/Ref1/boton jugar2.png';
	@override String get titleSliderModalExternal => 'Si presionas el botón de ir a la app, te llevará a descargar la APP elegida a la';
	@override String get buttonSliderModalExternal => 'assets/Ref3/Pop Up Slider Boton.png';
	@override String get titlePLay => 'OLIVIA RODRIGUEZ';
	@override String get subtitlePLay => '¿eres su fan#1?';
	@override String get titleWallPaper => 'OLIVIA RODRIGUEZ';
	@override String get subTitleWallPaper => 'Fondos Únicos';
	@override String get imageWallPaper => 'assets/Ref1/Boton Wallpaper.png';
	@override String get titleMyApp => 'UNA APP SOBRE TÍ';
	@override String get subTitleMyApp => '¿Cuanto saben tus';
	@override String get subTitle2MyApp => 'amigos sobre ti?';
	@override String get imageMyApp => 'assets/Ref1/Boton Quiero.png';
	@override String get titleRandom => 'JUGAR CON UN';
	@override String get subTitleRandom => 'ARTISTA AL AZAR';
	@override String get imageRandom => 'assets/Ref1/Boton Artistas Aleatorio.png';
	@override String get ourAppsTitle => 'assets/Ref3/Todas Nuestras App.png';
	@override String get ourAppsSearchHint => 'Buscar artista...';
	@override String get titleEmpity => 'No tenemos el artista que buscas, puedes fijarte que este bien escrito, si esta bien escrito puedes enviarnos el nombre para que hagamos la app';
	@override String get ourAppsRecomendHint => 'Recomendar artista...';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'imagePrivacity': 'assets/Ref1/Privacidad.png',
			'imageOurApplications': 'assets/Ref1/+App.png',
			'imagePlayCard': 'assets/Ref1/boton jugar2.png',
			'titleSliderModalExternal': 'If you press the button to go to the app, it will take you to download the chosen APP to the',
			'buttonSliderModalExternal': 'assets/Ref3/Pop Up Slider Boton.png',
			'titlePLay': 'OLIVIA RODRIGUEZ',
			'subtitlePLay': 'are you his #1 fan?',
			'titleWallPaper': 'OLIVIA RODRIGUEZ',
			'subTitleWallPaper': 'Unique Funds',
			'imageWallPaper': 'assets/Ref1/Boton Wallpaper.png',
			'titleMyApp': 'AN APP ABOUT YOU',
			'subTitleMyApp': 'how much do you know',
			'subTitle2MyApp': 'friends about you?',
			'imageMyApp': 'assets/Ref1/Boton Quiero.png',
			'titleRandom': 'PLAY WITH A',
			'subTitleRandom': 'RANDOM ARTIST',
			'imageRandom': 'assets/Ref1/Boton Artistas Aleatorio.png',
			'ourAppsTitle': 'assets/Ref3/Todas Nuestras App.png',
			'ourAppsSearchHint': 'Search artist...',
			'titleEmpity': 'We do not have the artist you are looking for, you can check that it is well written, if it is well written you can send us the name so that we can make the app',
			'ourAppsRecomendHint': 'Recommend artist...',
		};
	}
}

extension on _StringsEs {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'imagePrivacity': 'assets/Ref1/Privacidad.png',
			'imageOurApplications': 'assets/Ref1/+App.png',
			'imagePlayCard': 'assets/Ref1/boton jugar2.png',
			'titleSliderModalExternal': 'Si presionas el botón de ir a la app, te llevará a descargar la APP elegida a la',
			'buttonSliderModalExternal': 'assets/Ref3/Pop Up Slider Boton.png',
			'titlePLay': 'OLIVIA RODRIGUEZ',
			'subtitlePLay': '¿eres su fan#1?',
			'titleWallPaper': 'OLIVIA RODRIGUEZ',
			'subTitleWallPaper': 'Fondos Únicos',
			'imageWallPaper': 'assets/Ref1/Boton Wallpaper.png',
			'titleMyApp': 'UNA APP SOBRE TÍ',
			'subTitleMyApp': '¿Cuanto saben tus',
			'subTitle2MyApp': 'amigos sobre ti?',
			'imageMyApp': 'assets/Ref1/Boton Quiero.png',
			'titleRandom': 'JUGAR CON UN',
			'subTitleRandom': 'ARTISTA AL AZAR',
			'imageRandom': 'assets/Ref1/Boton Artistas Aleatorio.png',
			'ourAppsTitle': 'assets/Ref3/Todas Nuestras App.png',
			'ourAppsSearchHint': 'Buscar artista...',
			'titleEmpity': 'No tenemos el artista que buscas, puedes fijarte que este bien escrito, si esta bien escrito puedes enviarnos el nombre para que hagamos la app',
			'ourAppsRecomendHint': 'Recomendar artista...',
		};
	}
}
