
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если НЕ ЗначениеЗаполнено(Объект.Дата) Тогда
		Объект.Дата = ТекущаяДатаСеанса();
	КонецЕсли;
	
	Если Объект.Ссылка.Пустая() Тогда
		
		ТекущийПользователь = Пользователи.ТекущийПользователь();
		Объект.Автор = ТекущийПользователь;
		Объект.Организация = УправлениеНебольшойФирмойПовтИсп.ПолучитьЗначениеПоУмолчаниюПользователя(
		ТекущийПользователь,
		"ОсновнаяОрганизация");
		
	КонецЕсли;	
	
КонецПроцедуры