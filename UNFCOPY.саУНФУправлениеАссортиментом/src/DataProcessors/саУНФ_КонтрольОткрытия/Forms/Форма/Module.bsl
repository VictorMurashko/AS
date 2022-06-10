
&НаСервереБезКонтекста
Процедура КонтрольНаСервере(Дата)
	Если Метаданные.Обработки.Найти("саУНФ_КонтрольОткрытия") <> Неопределено Тогда
		Обработки["саУНФ_КонтрольОткрытия"].Контроль(Дата);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Контроль(Команда)
	КонтрольНаСервере(Дата);
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Дата = ТекущаяДата();
КонецПроцедуры
