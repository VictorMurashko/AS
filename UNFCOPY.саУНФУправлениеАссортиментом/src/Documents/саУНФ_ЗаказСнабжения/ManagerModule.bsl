// Формирует таблицу значений, содержащую данные для проведения по регистру.
//
Функция са_УНФ_СформироватьТаблицаЗапасы(ДокументСсылкаПеремещениеЗапасов, СтруктураДополнительныеСвойства,ТаблицаВыгрузкиЗапасов)
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = СтруктураДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	Запрос.Текст = 
	" ВЫБРАТЬ *
	| ПОМЕСТИТЬ ВрТаблицаВыгрузкиЗапасов
	| ИЗ &ТаблицаВыгрузкиЗапасов КАК ТаблицаВыгрузкиЗапасов
	|";
	
	Запрос.УстановитьПараметр("ТаблицаВыгрузкиЗапасов",ТаблицаВыгрузкиЗапасов);
	РезультатЗапроса = Запрос.Выполнить();
	
	// Установка исключительной блокировки контролируемых остатков запасов.
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ТаблицаЗапасы.Организация КАК Организация,
	|	ТаблицаЗапасы.СтруктурнаяЕдиница КАК СтруктурнаяЕдиница,
	|	ТаблицаЗапасы.СчетУчета КАК СчетУчета,
	|	ТаблицаЗапасы.Номенклатура КАК Номенклатура,
	|	ТаблицаЗапасы.Характеристика КАК Характеристика,
	|	ТаблицаЗапасы.Партия КАК Партия,
	|	ТаблицаЗапасы.ЗаказПокупателя КАК ЗаказПокупателя
	|ИЗ
	|	(ВЫБРАТЬ
	|		ТаблицаЗапасы.Организация КАК Организация,
	|		ТаблицаЗапасы.СтруктурнаяЕдиница КАК СтруктурнаяЕдиница,
	|		ТаблицаЗапасы.СчетУчета КАК СчетУчета,
	|		ТаблицаЗапасы.Номенклатура КАК Номенклатура,
	|		ТаблицаЗапасы.Характеристика КАК Характеристика,
	|		ТаблицаЗапасы.Партия КАК Партия,
	|		ТаблицаЗапасы.ЗаказПокупателя КАК ЗаказПокупателя
	|	ИЗ
	|		ВрТаблицаВыгрузкиЗапасов КАК ТаблицаЗапасы
	|	ГДЕ
	|		ТаблицаЗапасы.ЗаказПокупателя <> ЗНАЧЕНИЕ(Документ.ЗаказПокупателя.ПустаяСсылка)
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ТаблицаЗапасы.Организация,
	|		ТаблицаЗапасы.СтруктурнаяЕдиница,
	|		ТаблицаЗапасы.СчетУчета,
	|		ТаблицаЗапасы.Номенклатура,
	|		ТаблицаЗапасы.Характеристика,
	|		ТаблицаЗапасы.Партия,
	|		ЗНАЧЕНИЕ(Документ.ЗаказПокупателя.ПустаяСсылка)
	|	ИЗ
	|		ВрТаблицаВыгрузкиЗапасов КАК ТаблицаЗапасы) КАК ТаблицаЗапасы
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаЗапасы.Организация,
	|	ТаблицаЗапасы.СтруктурнаяЕдиница,
	|	ТаблицаЗапасы.СчетУчета,
	|	ТаблицаЗапасы.Номенклатура,
	|	ТаблицаЗапасы.Характеристика,
	|	ТаблицаЗапасы.Партия,
	|	ТаблицаЗапасы.ЗаказПокупателя";
	
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Блокировка = Новый БлокировкаДанных;
	ЭлементБлокировки = Блокировка.Добавить("РегистрНакопления.Запасы");
	ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
	ЭлементБлокировки.ИсточникДанных = РезультатЗапроса;

	Для каждого КолонкаРезультатЗапроса из РезультатЗапроса.Колонки Цикл
		ЭлементБлокировки.ИспользоватьИзИсточникаДанных(КолонкаРезультатЗапроса.Имя, КолонкаРезультатЗапроса.Имя);
	КонецЦикла;
	Блокировка.Заблокировать();
	
	// Получение остатков запасов по стоимости.
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ЗапасыОстатки.Организация КАК Организация,
	|	ЗапасыОстатки.СтруктурнаяЕдиница КАК СтруктурнаяЕдиница,
	|	ЗапасыОстатки.СчетУчета КАК СчетУчета,
	|	ЗапасыОстатки.Номенклатура КАК Номенклатура,
	|	ЗапасыОстатки.Характеристика КАК Характеристика,
	|	ЗапасыОстатки.Партия КАК Партия,
	|	ЗапасыОстатки.ЗаказПокупателя КАК ЗаказПокупателя,
	|	СУММА(ЗапасыОстатки.КоличествоОстаток) КАК КоличествоОстаток,
	|	СУММА(ЗапасыОстатки.СуммаОстаток) КАК СуммаОстаток
	|ИЗ
	|	(ВЫБРАТЬ
	|		ЗапасыОстатки.Организация КАК Организация,
	|		ЗапасыОстатки.СтруктурнаяЕдиница КАК СтруктурнаяЕдиница,
	|		ЗапасыОстатки.СчетУчета КАК СчетУчета,
	|		ЗапасыОстатки.Номенклатура КАК Номенклатура,
	|		ЗапасыОстатки.Характеристика КАК Характеристика,
	|		ЗапасыОстатки.Партия КАК Партия,
	|		ЗапасыОстатки.ЗаказПокупателя КАК ЗаказПокупателя,
	|		СУММА(ЗапасыОстатки.КоличествоОстаток) КАК КоличествоОстаток,
	|		СУММА(ЗапасыОстатки.СуммаОстаток) КАК СуммаОстаток
	|	ИЗ
	|		РегистрНакопления.Запасы.Остатки(
	|				&МоментКонтроля,
	|				(Организация, СтруктурнаяЕдиница, СчетУчета, Номенклатура, Характеристика, Партия, ЗаказПокупателя) В
	|					(ВЫБРАТЬ
	|						ТаблицаЗапасы.Организация,
	|						ТаблицаЗапасы.СтруктурнаяЕдиница,
	|						ТаблицаЗапасы.СчетУчета,
	|						ТаблицаЗапасы.Номенклатура,
	|						ТаблицаЗапасы.Характеристика,
	|						ТаблицаЗапасы.Партия,
	|						ТаблицаЗапасы.ЗаказПокупателя
	|					ИЗ
	|						ВрТаблицаВыгрузкиЗапасов КАК ТаблицаЗапасы
	|					ГДЕ
	|						ТаблицаЗапасы.ЗаказПокупателя <> ЗНАЧЕНИЕ(Документ.ЗаказПокупателя.ПустаяСсылка))) КАК ЗапасыОстатки
	|	
	|	СГРУППИРОВАТЬ ПО
	|		ЗапасыОстатки.Организация,
	|		ЗапасыОстатки.СтруктурнаяЕдиница,
	|		ЗапасыОстатки.СчетУчета,
	|		ЗапасыОстатки.Номенклатура,
	|		ЗапасыОстатки.Характеристика,
	|		ЗапасыОстатки.Партия,
	|		ЗапасыОстатки.ЗаказПокупателя
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ЗапасыОстатки.Организация,
	|		ЗапасыОстатки.СтруктурнаяЕдиница,
	|		ЗапасыОстатки.СчетУчета,
	|		ЗапасыОстатки.Номенклатура,
	|		ЗапасыОстатки.Характеристика,
	|		ЗапасыОстатки.Партия,
	|		ЗапасыОстатки.ЗаказПокупателя,
	|		СУММА(ЗапасыОстатки.КоличествоОстаток),
	|		СУММА(ЗапасыОстатки.СуммаОстаток)
	|	ИЗ
	|		РегистрНакопления.Запасы.Остатки(
	|				&МоментКонтроля,
	|				(Организация, СтруктурнаяЕдиница, СчетУчета, Номенклатура, Характеристика, Партия, ЗаказПокупателя) В
	|					(ВЫБРАТЬ
	|						ТаблицаЗапасы.Организация,
	|						ТаблицаЗапасы.СтруктурнаяЕдиница,
	|						ТаблицаЗапасы.СчетУчета,
	|						ТаблицаЗапасы.Номенклатура,
	|						ТаблицаЗапасы.Характеристика,
	|						ТаблицаЗапасы.Партия,
	|						ЗНАЧЕНИЕ(Документ.ЗаказПокупателя.ПустаяСсылка)
	|					ИЗ
	|						ВрТаблицаВыгрузкиЗапасов КАК ТаблицаЗапасы)) КАК ЗапасыОстатки
	|	
	|	СГРУППИРОВАТЬ ПО
	|		ЗапасыОстатки.Организация,
	|		ЗапасыОстатки.СтруктурнаяЕдиница,
	|		ЗапасыОстатки.СчетУчета,
	|		ЗапасыОстатки.Номенклатура,
	|		ЗапасыОстатки.Характеристика,
	|		ЗапасыОстатки.Партия,
	|		ЗапасыОстатки.ЗаказПокупателя
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ДвиженияДокументаЗапасы.Организация,
	|		ДвиженияДокументаЗапасы.СтруктурнаяЕдиница,
	|		ДвиженияДокументаЗапасы.СчетУчета,
	|		ДвиженияДокументаЗапасы.Номенклатура,
	|		ДвиженияДокументаЗапасы.Характеристика,
	|		ДвиженияДокументаЗапасы.Партия,
	|		ДвиженияДокументаЗапасы.ЗаказПокупателя,
	|		ВЫБОР
	|			КОГДА ДвиженияДокументаЗапасы.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|				ТОГДА ЕСТЬNULL(ДвиженияДокументаЗапасы.Количество, 0)
	|			ИНАЧЕ -ЕСТЬNULL(ДвиженияДокументаЗапасы.Количество, 0)
	|		КОНЕЦ,
	|		ВЫБОР
	|			КОГДА ДвиженияДокументаЗапасы.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|				ТОГДА ЕСТЬNULL(ДвиженияДокументаЗапасы.Сумма, 0)
	|			ИНАЧЕ -ЕСТЬNULL(ДвиженияДокументаЗапасы.Сумма, 0)
	|		КОНЕЦ
	|	ИЗ
	|		РегистрНакопления.Запасы КАК ДвиженияДокументаЗапасы
	|	ГДЕ
	|		ДвиженияДокументаЗапасы.Регистратор = &Ссылка
	|		И ДвиженияДокументаЗапасы.Период <= &ПериодКонтроля) КАК ЗапасыОстатки
	|
	|СГРУППИРОВАТЬ ПО
	|	ЗапасыОстатки.Организация,
	|	ЗапасыОстатки.СтруктурнаяЕдиница,
	|	ЗапасыОстатки.СчетУчета,
	|	ЗапасыОстатки.Номенклатура,
	|	ЗапасыОстатки.Характеристика,
	|	ЗапасыОстатки.Партия,
	|	ЗапасыОстатки.ЗаказПокупателя";	
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылкаПеремещениеЗапасов);
	Запрос.УстановитьПараметр("МоментКонтроля", Новый Граница(СтруктураДополнительныеСвойства.ДляПроведения.МоментВремени, ВидГраницы.Включая));
	Запрос.УстановитьПараметр("ПериодКонтроля", СтруктураДополнительныеСвойства.ДляПроведения.МоментВремени.Дата);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ТаблицаЗапасыОстатки = РезультатЗапроса.Выгрузить();
	ТаблицаЗапасыОстатки.Индексы.Добавить("Организация,СтруктурнаяЕдиница,СчетУчета,Номенклатура,Характеристика,Партия,ЗаказПокупателя");
	
	ВременнаяТаблицаЗапасы = ТаблицаВыгрузкиЗапасов.СкопироватьКолонки();
	
	ПустаяСтруктурнаяЕдиница = Справочники.СтруктурныеЕдиницы.ПустаяСсылка();
	ПустойСчетУчета = ПланыСчетов.Управленческий.ПустаяСсылка();
	ПустаяНоменклатура = Справочники.Номенклатура.ПустаяСсылка();
	ПустаяХарактеристика = Справочники.ХарактеристикиНоменклатуры.ПустаяСсылка();
	ПустаяПартия = Справочники.ПартииНоменклатуры.ПустаяСсылка();
    ПустойЗаказПокупателя = Документы.ЗаказПокупателя.ПустаяСсылка();

	ПеремещениеВРозницуСуммовойУчет = Ложь;
	ВозвратИзРозницыСуммовойУчет = Ложь;	
	
	Для н = 0 По ТаблицаВыгрузкиЗапасов.Количество() - 1 Цикл
		
		СтрокаТаблицаЗапасы = ТаблицаВыгрузкиЗапасов[н];
		
		СтруктураДляПоиска = Новый Структура;
		СтруктураДляПоиска.Вставить("Организация", СтрокаТаблицаЗапасы.Организация);
		СтруктураДляПоиска.Вставить("СтруктурнаяЕдиница", СтрокаТаблицаЗапасы.СтруктурнаяЕдиница);
		СтруктураДляПоиска.Вставить("СчетУчета", СтрокаТаблицаЗапасы.СчетУчета);
		СтруктураДляПоиска.Вставить("Номенклатура", СтрокаТаблицаЗапасы.Номенклатура);
		СтруктураДляПоиска.Вставить("Характеристика", СтрокаТаблицаЗапасы.Характеристика);
		СтруктураДляПоиска.Вставить("Партия", СтрокаТаблицаЗапасы.Партия);
		
		КоличествоТребуетсяСвободныйОстаток = СтрокаТаблицаЗапасы.Количество;
		
			
		Если КоличествоТребуетсяСвободныйОстаток > 0 Тогда
			
			СтруктураДляПоиска.Вставить("ЗаказПокупателя", ПустойЗаказПокупателя);
			
			МассивСтрокОстатков = ТаблицаЗапасыОстатки.НайтиСтроки(СтруктураДляПоиска);
			
			КоличествоОстаток = 0;
			СуммаОстаток = 0;
			
			Если МассивСтрокОстатков.Количество() > 0 Тогда
				КоличествоОстаток = МассивСтрокОстатков[0].КоличествоОстаток;
				СуммаОстаток = МассивСтрокОстатков[0].СуммаОстаток;
			КонецЕсли;
			
			Если КоличествоОстаток > 0 И КоличествоОстаток > КоличествоТребуетсяСвободныйОстаток Тогда

				СуммаКСписанию = Окр(СуммаОстаток * КоличествоТребуетсяСвободныйОстаток / КоличествоОстаток , 2, 1);

				МассивСтрокОстатков[0].КоличествоОстаток = МассивСтрокОстатков[0].КоличествоОстаток - КоличествоТребуетсяСвободныйОстаток;
				МассивСтрокОстатков[0].СуммаОстаток = МассивСтрокОстатков[0].СуммаОстаток - СуммаКСписанию;

			ИначеЕсли КоличествоОстаток = КоличествоТребуетсяСвободныйОстаток Тогда

				СуммаКСписанию = СуммаОстаток;

				МассивСтрокОстатков[0].КоличествоОстаток = 0;
				МассивСтрокОстатков[0].СуммаОстаток = 0;

			Иначе
				СуммаКСписанию = 0;	
			КонецЕсли;
	
			// Расход.
			СтрокаТаблицыРасход = ВременнаяТаблицаЗапасы.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТаблицыРасход, СтрокаТаблицаЗапасы);
			
			СтрокаТаблицыРасход.Сумма = СуммаКСписанию;
			СтрокаТаблицыРасход.Количество = КоличествоТребуетсяСвободныйОстаток;
			СтрокаТаблицыРасход.ЗаказПокупателя = ПустойЗаказПокупателя;
			СтрокаТаблицыРасход.КоррЗаказПокупателя = ПустойЗаказПокупателя;
	КонецЕсли;
			
	КонецЦикла;
	Возврат ВременнаяТаблицаЗапасы;

		
	
КонецФункции // СформироватьТаблицаЗапасов()


&Вместо("ИнициализироватьДанныеДокументаЗаказПокупателя")
Процедура саУНФ_ИнициализироватьДанныеДокументаЗаказПокупателя(ДокументСсылкаЗаказПокупателя, СтруктураДополнительныеСвойства, ДокументОбъектЗаказПокупателя)
	 Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = СтруктураДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы.МенеджерВременныхТаблиц;
	Запрос.Текст = ПолучитьТекстЗапросаИнициализироватьДанныеДокументаЗаказПокупателя();
	
	ДобавитьТаблицуЗапасыВМенеджерВременныхТаблиц(ДокументСсылкаЗаказПокупателя, Запрос.МенеджерВременныхТаблиц, Истина);
	
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылкаЗаказПокупателя);
	Запрос.УстановитьПараметр("МоментВремени", Новый Граница(СтруктураДополнительныеСвойства.ДляПроведения.МоментВремени, ВидГраницы.Включая));
	Запрос.УстановитьПараметр("Организация", СтруктураДополнительныеСвойства.ДляПроведения.Организация);
	Запрос.УстановитьПараметр("ИспользоватьХарактеристики", СтруктураДополнительныеСвойства.УчетнаяПолитика.ИспользоватьХарактеристики);
	Запрос.УстановитьПараметр("ИспользоватьПартии",  СтруктураДополнительныеСвойства.УчетнаяПолитика.ИспользоватьПартии);
	Запрос.УстановитьПараметр("РезервированиеЗапасов", НСтр("ru = 'Резервирование запасов'"));
	Запрос.УстановитьПараметр("ИспользоватьЭтапыПроизводства",  СтруктураДополнительныеСвойства.УчетнаяПолитика.ИспользоватьЭтапыПроизводства);
	
	Запрос.УстановитьПараметр("ВалютаУчета", СтруктураДополнительныеСвойства.ВалютаУчета);
	Запрос.УстановитьПараметр("ВалютаНациональная", СтруктураДополнительныеСвойства.НациональнаяВалюта);
	Запрос.УстановитьПараметр("ВалютаРасчетов", ДокументСсылкаЗаказПокупателя.ВалютаДокумента);
	Запрос.УстановитьПараметр("ВалютаДокумента", ДокументСсылкаЗаказПокупателя.ВалютаДокумента);
	
	МассивРезультатов = Запрос.ВыполнитьПакетСПромежуточнымиДанными();
	
	ТаблицаВыгрузкиЗапасов =  МассивРезультатов[5].Выгрузить();
	Если ДокументСсылкаЗаказПокупателя.ВариантЗавершения = Перечисления.ВариантыЗавершенияЗаказа.Успешно Тогда
	        ТаблицаВыгрузкиЗапасов.Очистить();
	Иначе
			ТаблицаВыгрузкиЗапасов=са_УНФ_СформироватьТаблицаЗапасы(ДокументСсылкаЗаказПокупателя, СтруктураДополнительныеСвойства,ТаблицаВыгрузкиЗапасов);
	КонецЕсли; 
	СтруктураДополнительныеСвойства.ТаблицыДляДвижений.Вставить("ТаблицаЗапасы", ТаблицаВыгрузкиЗапасов);
    СформироватьТаблицаСуммыДокументовРегламентированныйУчет(ДокументСсылкаЗаказПокупателя, СтруктураДополнительныеСвойства);

КонецПроцедуры

