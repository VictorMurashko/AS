
&НаСервере
Процедура саУНФ_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
		// Элементы
		
		НовыйЭлемент = Элементы.Добавить("Водитель", Тип("ПолеФормы"), ЭтаФорма);
		НовыйЭлемент.ПутьКДанным                    =   "Объект.Водитель";
		НовыйЭлемент.Вид                            =   ВидПоляФормы.ПолеВвода;
		НовыйЭлемент.ТолькоПросмотр                 =   Ложь;
		НовыйЭлемент.Подсказка                      =   "Водитель по умолчанию";
		НовыйЭлемент.ОтображениеПодсказки           =   ОтображениеПодсказки.Кнопка;
		НовыйЭлемент.ПоложениеЗаголовка             =   ПоложениеЗаголовкаЭлементаФормы.Лево;
		
		НовыйЭлемент = Элементы.Добавить("id_Bitrix", Тип("ПолеФормы"), ЭтаФорма);
		НовыйЭлемент.ПутьКДанным                    =   "Объект.id_Bitrix";
		НовыйЭлемент.Вид                            =   ВидПоляФормы.ПолеВвода;
		НовыйЭлемент.ТолькоПросмотр                 =   Ложь;
		НовыйЭлемент.Подсказка                      =   "ID BITRIX 24";
		НовыйЭлемент.ОтображениеПодсказки           =   ОтображениеПодсказки.Кнопка;
		НовыйЭлемент.ПоложениеЗаголовка             =   ПоложениеЗаголовкаЭлементаФормы.Лево;
		
КонецПроцедуры
