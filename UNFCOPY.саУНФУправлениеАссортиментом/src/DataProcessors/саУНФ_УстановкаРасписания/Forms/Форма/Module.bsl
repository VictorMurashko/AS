
&НаСервере
Процедура ЗаполнитьРТТНаСервере()
	МВТ = НОВЫЙ МенеджерВременныхТаблиц;
	Организация	=	УправлениеНебольшойФирмойПовтИсп.ОрганизацияПоУмолчанию();

	 саУНФ_АтозаказВызовСервера.ДействующиеМагазины(МВТ,Организация);
	 
	 Запрос = Новый Запрос;
	 Запрос.МенеджерВременныхТаблиц = МВТ;
	 Запрос.Текст=
	 "ВЫБРАТЬ
	 |	ВТ_РТТ.Магазин КАК РТТ,
	 |	ВТ_РТТ.ЛетнееРасписание КАК ЛетнееРасписание,
	 |	ВТ_РТТ.ЗимнееРасписание КАК ЗимнееРасписание
	 |ИЗ
	 |	ВТ_РТТ КАК ВТ_РТТ
	 |
	 |УПОРЯДОЧИТЬ ПО
	 |	РТТ
	 |АВТОУПОРЯДОЧИВАНИЕ";
	 
	 
	 Объект.ТабличнаяЧастьРасписание.Очистить();
	 Результат = Запрос.Выполнить();
	 Выборка = Результат.Выбрать();
	 Пока Выборка.Следующий() Цикл
	 	         НоваяСтрока = Объект.ТабличнаяЧастьРасписание.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока,Выборка);
	 КонецЦикла; 
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьРТТ(Команда)
	ЗаполнитьРТТНаСервере();
КонецПроцедуры

&НаСервере
Процедура ЗаписатьРасписаниеНаСервере()
	
	Для каждого СтрР Из Объект.ТабличнаяЧастьРасписание Цикл
		
		Если  НЕ ЗначениеЗаполнено(СтрР.РТТ) Тогда
			Продолжить;
		КонецЕсли;
		Если ЗначениеЗаполнено(СтрР.ЛетнееРасписание) ИЛИ ЗначениеЗаполнено(СтрР.ЗимнееРасписание) Тогда
			УстановитьПривилегированныйРежим(Истина);
			ФлагЗаписывать = Ложь;
			РТТ = СтрР.РТТ.ПолучитьОбъект();
			Если ЗначениеЗаполнено(СтрР.ЛетнееРасписание) И  РТТ.саУНФ_ЛетнееРасписание  <> СтрР.ЛетнееРасписание Тогда
				   РТТ.саУНФ_ЛетнееРасписание  = СтрР.ЛетнееРасписание;
				   ФлагЗаписывать = Истина;
			КонецЕсли;
			Если ЗначениеЗаполнено(СтрР.ЗимнееРасписание) И  РТТ.саУНФ_ЗимнееРасписание  <> СтрР.ЗимнееРасписание Тогда
				   РТТ.саУНФ_ЗимнееРасписание  = СтрР.ЗимнееРасписание;
				   ФлагЗаписывать = Истина;
			КонецЕсли;
             Если ФлагЗаписывать Тогда
			           РТТ.Записать();
			 КонецЕсли; 
			 			 
			 УстановитьПривилегированныйРежим(Ложь);

		КонецЕсли; 
	КонецЦикла;
	      
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьРасписание(Команда)
	ЗаписатьРасписаниеНаСервере();
КонецПроцедуры
