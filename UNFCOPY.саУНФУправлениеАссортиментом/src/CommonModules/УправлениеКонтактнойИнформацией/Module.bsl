

&Вместо("ЗаписатьКонтактнуюИнформацию")
Процедура саУНФ_ЗаписатьКонтактнуюИнформацию(Объект, Знач Значение, ВидИнформации, ТипИнформации, ИдентификаторСтроки, Дата)
	 Если ПустаяСтрока(Значение) Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(Объект)=Тип("СправочникОбъект.Контрагенты") Тогда
		
		Если УправлениеКонтактнойИнформациейКлиентСервер.ЭтоКонтактнаяИнформацияВXML(Значение) Тогда
			ОбъектКИ = УправлениеКонтактнойИнформациейСлужебный.КонтактнаяИнформацияВСтруктуруJSON(Значение, ТипИнформации);
		Иначе
			ОбъектКИ = УправлениеКонтактнойИнформациейСлужебный.JSONВКонтактнуюИнформациюПоПолям(Значение, ТипИнформации);
		КонецЕсли;
		
		Если Не УправлениеКонтактнойИнформациейСлужебный.КонтактнаяИнформацияЗаполнена(ОбъектКИ) Тогда
			Возврат;
		КонецЕсли;
		
		НоваяСтрока = Объект.КонтактнаяИнформация.Добавить();
		НоваяСтрока.Представление = ОбъектКИ.Value;
		НоваяСтрока.Значение      = УправлениеКонтактнойИнформациейСлужебный.СтруктураВСтрокуJSON(ОбъектКИ);
		НоваяСтрока.ЗначенияПолей = УправлениеКонтактнойИнформациейСлужебный.КонтактнаяИнформацияИзJSONВXML(ОбъектКИ, ТипИнформации);
		НоваяСтрока.Вид           = ВидИнформации;
		НоваяСтрока.Тип           = ТипИнформации;
		НоваяСтрока.id_adress   = ИдентификаторСтроки;
		Если ЗначениеЗаполнено(Дата) 
			И УправлениеКонтактнойИнформациейСлужебныйПовтИсп.КонтактнаяИнформацияОбъектаСодержитКолонкуДействуетС(Объект.Ссылка) Тогда
			НоваяСтрока.ДействуетС  = Дата;
		КонецЕсли;
		
		//Если ЗначениеЗаполнено(ИдентификаторСтроки) Тогда
		//	НоваяСтрока.ИдентификаторСтрокиТабличнойЧасти = ИдентификаторСтроки;
		//КонецЕсли;
		
		// Заполнение дополнительных реквизитов ТЧ.
		УправлениеКонтактнойИнформациейСлужебный.ЗаполнитьТехническиеПоляКонтактнойИнформации(НоваяСтрока, ОбъектКИ, ТипИнформации);
		
	Иначе
		
		ПродолжитьВызов(Объект, Значение, ВидИнформации, ТипИнформации, ИдентификаторСтроки, Дата);
	КонецЕсли;

КонецПроцедуры

