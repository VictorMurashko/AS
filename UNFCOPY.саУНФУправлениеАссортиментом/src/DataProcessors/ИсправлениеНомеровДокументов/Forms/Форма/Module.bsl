&НаСервереБезКонтекста
Процедура КомандаИсправитьНаСервере(Док)
	УстановитьПривилегированныйРежим(Истина);
	
	//Имя=Док.Метаданные().Имя;  
	лкМассив = Новый Массив;
	
	//ТипДокумента - ваш тип, например: РеализацияТоваровУслуг 
	//можно несколько документов добавить, а в цикле так и вообще все.
	Для каждого Мета Из Метаданные["Документы"] Цикл
		лкМассив.Добавить(Мета);
	КонецЦикла; 
	//лкМассив.Добавить(Метаданные.Документы[Имя]);
	
	ОбновитьНумерациюОбъектов(лкМассив);
	
	Для каждого Мета Из Метаданные["Справочники"] Цикл
		лкМассив.Добавить(Мета);
	КонецЦикла; 
	ОбновитьНумерациюОбъектов(лкМассив);
	
	УстановитьПривилегированныйРежим(Ложь);

КонецПроцедуры



&НаКлиенте
Процедура ЗаписатьДок(Команда)
	КомандаИсправитьНаСервере(Докумень);
КонецПроцедуры
