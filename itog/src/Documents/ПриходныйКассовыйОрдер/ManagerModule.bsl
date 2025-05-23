#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, НастройкиФормы) Экспорт

	 //ВариантыОтчетовПереопределяемый.ДобавитьКомандуСтруктураПодчиненности(КомандыОтчетов);

	 //ВариантыОтчетовПереопределяемый.ДобавитьКомандуДвиженияДокумента(КомандыОтчетов);

 КонецПроцедуры

 
 
 Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	 Если ПравоДоступа("Добавление", Метаданные.Документы.ПриходныйКассовыйОрдер) Тогда
		 КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		 КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.ПриходныйКассовыйОрдер.ПолноеИмя();
		 КомандаСоздатьНаОсновании.Представление = ОбщегоНазначения.ПредставлениеОбъекта(Метаданные.Документы.ПриходныйКассовыйОрдер);
		 КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		 Возврат КомандаСоздатьНаОсновании;
	 КонецЕсли;
	 Возврат Неопределено;
 КонецФункции
 
 Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	//Документы.ПриходныйКассовыйОрдер.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	//Документы.ПоступлениеНаРасчетныйСчет.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
КонецПроцедуры


Процедура ПечатьПриходногоКассовогоОрдера(ТабДок, Ссылка) Экспорт
	
	Макет = Документы.ПриходныйКассовыйОрдер.ПолучитьМакет("ПФ_MXL_ПриходныйКассовыйОрдер");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПриходныйКассовыйОрдер.Валюта,
	|	ПриходныйКассовыйОрдер.Дата,
	|	ПриходныйКассовыйОрдер.Контрагент,
	|	ПриходныйКассовыйОрдер.Номер,
	|	ПриходныйКассовыйОрдер.Основание,
	|	ПриходныйКассовыйОрдер.СуммаДокумента
	|ИЗ
	|	Документ.ПриходныйКассовыйОрдер КАК ПриходныйКассовыйОрдер
	|ГДЕ
	|	ПриходныйКассовыйОрдер.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ТабДок.Очистить();

	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

		ТабДок.Вывести(ОбластьЗаголовок);

		Шапка.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Шапка, Выборка.Уровень());

		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	
КонецПроцедуры

#КонецЕсли
