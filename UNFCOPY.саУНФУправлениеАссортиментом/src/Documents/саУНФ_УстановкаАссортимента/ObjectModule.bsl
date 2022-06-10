
Процедура ОбработкаПроведения(Отказ, Режим)

	Движения.саУНФ_НормыАссортимента.Записывать = Истина;
	
	Для Каждого ТекСтрокаНоменклатура Из Номенклатура Цикл
			
		Движение 									= Движения.саУНФ_НормыАссортимента.Добавить();
		Движение.Период							= Дата;
		Движение.Организация 				= Организация;
		Движение.ФорматМагазина 			= ФорматМагазина;
		Движение.Номенклатура 				= ТекСтрокаНоменклатура.Номенклатура;
		Движение.Количество 					= ТекСтрокаНоменклатура.Количество;
		Движение.КоличествоНаПаллете	= ТекСтрокаНоменклатура.КоличествоНаПаллете;
		Движение.МинимальныйЗапас		= ТекСтрокаНоменклатура.МинимальныйЗапас;


	КонецЦикла;
		
КонецПроцедуры

Процедура ПриУстановкеНовогоНомера(СтандартнаяОбработка, Префикс)
	
	ПрефиксацияОбъектовСобытия.УстановитьПрефиксИнформационнойБазыИОрганизации(ЭтотОбъект, Истина, Префикс);
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Автор = Пользователи.ТекущийПользователь();

КонецПроцедуры
