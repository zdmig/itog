Функция РасчетСебестоимостиТовара(Номенклатура) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТоварыНаСкладахОстатки.КоличествоОстаток КАК КоличествоОстаток,
		|	ЕстьNULL(ЦеныНоменклатурыСрезПоследних.Цена,0) КАК Цена
		|ИЗ
		|	РегистрНакопления.ТоварыНаСкладах.Остатки(, Номенклатура = &Номенклатура) КАК ТоварыНаСкладахОстатки
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЦеныНоменклатуры.СрезПоследних(
		|				,
		|				Номенклатура = &Номенклатура
		|					И ВидЦены = &ВидЦены) КАК ЦеныНоменклатурыСрезПоследних
		|		ПО ТоварыНаСкладахОстатки.Номенклатура = ЦеныНоменклатурыСрезПоследних.Номенклатура
		|			И ТоварыНаСкладахОстатки.Характеристика = ЦеныНоменклатурыСрезПоследних.Характеристика";
	
	Запрос.УстановитьПараметр("Номенклатура",Номенклатура);
	Запрос.УстановитьПараметр("ВидЦены", Справочники.ВидыЦен.Закупочная);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Сумма = 0;
	Количество = 0;
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Сумма = ВыборкаДетальныеЗаписи.КоличествоОстаток * ВыборкаДетальныеЗаписи.Цена + Сумма;
		Количество = ВыборкаДетальныеЗаписи.КоличествоОстаток + Количество; 
	КонецЦикла;
	
    Возврат Сумма/Количество;
	

КонецФункции // РасчетСебестоимостиТовара()


Функция ПолучитьКурс(Валюта, ДатаКурса) Экспорт 
			
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЕСТЬNULL(КурсыВалютСрезПоследних.Курс / КурсыВалютСрезПоследних.Кратность, НЕОПРЕДЕЛЕНО) КАК Результат
		|ИЗ
		|	РегистрСведений.КурсыВалют.СрезПоследних(&ДатаКурса, Валюта = &Валюта) КАК КурсыВалютСрезПоследних";
		
		Запрос.УстановитьПараметр("Валюта", Валюта);
		Запрос.УстановитьПараметр("ДатаКурса", ДатаКурса);
		
		
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
			Результат = ВыборкаДетальныеЗаписи.Результат; 
		КонецЦикла; 
		
		Если Результат = Неопределено Тогда
			Возврат 0;
		Иначе
			Возврат Результат;
		КонецЕсли;
		
	
КонецФункции



