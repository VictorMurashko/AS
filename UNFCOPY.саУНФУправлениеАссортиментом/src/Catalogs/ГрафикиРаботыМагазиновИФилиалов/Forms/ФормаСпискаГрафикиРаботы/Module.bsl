
&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда Возврат КонецЕсли;
	
	ТекущийСписок = ?(ОтборПоГрафику = "Сотрудники", СотрудникиПоГрафику, СущностиПоГрафику);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(ТекущийСписок, 
	"ГрафикРаботы",
	ТекущиеДанные.Ссылка,
	ВидСравненияКомпоновкиДанных.Равно);
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
	Список, "Недействителен", Ложь, , , Истина);
	
	Если Параметры.Свойство("Подсистема") Тогда
		ТипПодсистемы = Параметры.Подсистема;
		
		ЕстьВыводПоПодсистемам = Ложь;
		
		Если ПолучитьФункциональнуюОпцию("ИспользоватьПодсистемуЗарплата") Тогда
			Элементы.ОтборПографику.СписокВыбора.Добавить("Сотрудники", "Сотрудники");
			
			Если ТипПодсистемы = 2 Тогда
				
				Элементы.ОтборПографику.СписокВыбора.Добавить("Сотрудники", "Сотрудники");
				
				Элементы.СущностиПоГрафикуРесурсПредприятия.Заголовок = "Сотрудники по графику";
				Элементы.ОтборПографику.Видимость = Ложь;
				
				Элементы.СотрудникиПоГрафику.Видимость = Истина;
				Элементы.СущностиПоГрафику.Видимость = Ложь;
				
				ЭтаФорма.Заголовок = "Графики работы сотрудников";
				
				ОтборПоГрафику = "Сотрудники";
				
				ЕстьВыводПоПодсистемам = Истина;
				
			КонецЕсли;
		КонецЕсли;
		
		Если ТипПодсистемы = 1 Тогда
			
			ЭтаФорма.Заголовок = "Графики работы ресурсов";
			
			Если (ПолучитьФункциональнуюОпцию("ПланироватьЗагрузкуРесурсовПредприятияРаботы")
				или ПолучитьФункциональнуюОпцию("ПланироватьЗагрузкуРесурсовПредприятия") 
				или ПолучитьФункциональнуюОпцию("ПланироватьЗагрузкуРесурсовПредприятияЖурналЗаписи")) Тогда
				
				Элементы.ОтборПографику.СписокВыбора.Добавить("Ресурсы", "Ресурсы");
				
				Элементы.СущностиПоГрафикуРесурсПредприятия.Заголовок = "Ресурсы по графику";
				
				ЭтаФорма.Заголовок = "Графики работы ресурсов";
				
				ОтборПоГрафику = "Ресурсы";
				
				Элементы.СотрудникиПоГрафику.Видимость = Ложь;
				Элементы.СущностиПоГрафику.Видимость = Истина;
				
				ЕстьВыводПоПодсистемам = Истина;
				
			КонецЕсли;
			
		КонецЕсли;
		
		Если Не ЕстьВыводПоПодсистемам Тогда
			ТипПодсистемы = 0;
			Элементы.ГруппаСущностиПоГрафику.Видимость = Ложь;
			Элементы.ОтборПографику.Видимость = Ложь;
		КонецЕсли;
		
	Иначе
		ТипПодсистемы = 0;
		Элементы.ГруппаСущностиПоГрафику.Видимость = Ложь;
		Элементы.ОтборПографику.Видимость = Ложь;
	КонецЕсли;
	
	УстановитьУсловноеОформление();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()

		НовоеУсловноеОформление = УсловноеОформление.Элементы.Добавить();
		РаботаСФормой.ДобавитьЭлементОтбораКомпоновкиДанных(НовоеУсловноеОформление.Отбор, "Список.Недействителен", Истина, ВидСравненияКомпоновкиДанных.Равно);
		РаботаСФормой.ДобавитьОформляемыеПоля(НовоеУсловноеОформление, "Наименование");
		РаботаСФормой.ДобавитьЭлементУсловногоОформления(НовоеУсловноеОформление, "ЦветТекста", ЦветаСтиля.ЦветНедоступногоТекстаТабличнойЧасти);

КонецПроцедуры

&НаКлиенте
Процедура СущностиПоГрафикуВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ТекущиеДанные = Элементы.СущностиПоГрафику.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда Возврат КонецЕсли;
	
	Если ТипЗнч(ТекущиеДанные.РесурсПредприятия) = Тип("СправочникСсылка.КлючевыеРесурсы") Тогда
		ПараметрыФормы = Новый Структура("Ключ", ТекущиеДанные.РесурсПредприятия);
		ОткрытьФорму("Справочник.КлючевыеРесурсы.ФормаОбъекта",ПараметрыФормы);
	Иначе
		ПараметрыФормы = Новый Структура("Ключ", ТекущиеДанные.РесурсПредприятия);
		ОткрытьФорму("Справочник.Бригады.ФормаОбъекта",ПараметрыФормы);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиПоГрафикуВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	ТекущиеДанные = Элементы.СотрудникиПоГрафику.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда Возврат КонецЕсли;
	
	ПараметрыФормы = Новый Структура("Ключ", ТекущиеДанные.РесурсПредприятия);
	ОткрытьФорму("Справочник.Сотрудники.ФормаОбъекта",ПараметрыФормы);

КонецПроцедуры

&НаКлиенте
Процедура ОтборПографикуПриИзменении(Элемент)
	
	УстановитьОтборПоГрафику();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборПоГрафику()
	
	Если ОтборПоГрафику = "Сотрудники" Тогда
		
		Элементы.СотрудникиПоГрафику.Видимость = Истина;
		Элементы.СущностиПоГрафику.Видимость = Ложь;
		
		ЭтаФорма.Заголовок = "Графики работы сотрудников";
		
	ИначеЕсли ОтборПоГрафику = "Ресурсы" Тогда
		
		Элементы.СотрудникиПоГрафику.Видимость = Ложь;
		Элементы.СущностиПоГрафику.Видимость = Истина;
		
		ЭтаФорма.Заголовок = "Графики работы ресурсов";
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказыватьНедействительную(Команда)
	
	Элементы.СписокПоказыватьНедействительную.Пометка = Не Элементы.СписокПоказыватьНедействительную.Пометка;
	УстановитьОтборНедействительная(ЭтотОбъект)

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборНедействительная(Форма)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Форма.Список,
		"Недействителен",
		Ложь,
		,
		,
		Не Форма.Элементы.СписокПоказыватьНедействительную.Пометка);
	
КонецПроцедуры



