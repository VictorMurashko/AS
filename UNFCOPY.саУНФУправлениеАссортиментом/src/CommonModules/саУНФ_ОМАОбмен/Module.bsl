Функция ПолучитьJSON()    Экспорт
Массив = Новый Массив;
	
		Структура = Новый Структура("barcode, cod, name, articul","2345678",5,"Что то",Истина);
		Массив.Добавить(Структура);

	
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();
	ЗаписатьJSON(ЗаписьJSON, Массив);
	
	СтрокаJSON = ЗаписьJSON.Закрыть();
	Возврат СтрокаJSON;
	
	

КонецФункции // ()
 

