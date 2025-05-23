#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, НастройкиФормы) Экспорт

	 //ВариантыОтчетовПереопределяемый.ДобавитьКомандуСтруктураПодчиненности(КомандыОтчетов);

	 //ВариантыОтчетовПереопределяемый.ДобавитьКомандуДвиженияДокумента(КомандыОтчетов);

 КонецПроцедуры
 
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	//Документы.ПриходныйКассовыйОрдер.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	//Документы.ПоступлениеНаРасчетныйСчет.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
КонецПроцедуры 

 Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	 Если ПравоДоступа("Добавление", Метаданные.Документы.РасходныйКассовыйОрдер) Тогда
		 КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		 КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.РасходныйКассовыйОрдер.ПолноеИмя();
		 КомандаСоздатьНаОсновании.Представление = ОбщегоНазначения.ПредставлениеОбъекта(Метаданные.Документы.РасходныйКассовыйОрдер);
		 КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		 Возврат КомандаСоздатьНаОсновании;
	 КонецЕсли;
	 Возврат Неопределено;
 КонецФункции 
 
#КонецЕсли
Процедура ПечатьРасходногоКассовогоОрдера(ТабДок, Ссылка) Экспорт
	
	Макет = Документы.РасходныйКассовыйОрдер.ПолучитьМакет("ПФ_MXL_ПечатьРасходногоКассовогоОрдера");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	РасходныйКассовыйОрдер.Валюта,
	|	РасходныйКассовыйОрдер.Дата,
	|	РасходныйКассовыйОрдер.Номер,
	|	РасходныйКассовыйОрдер.Основание,
	|	РасходныйКассовыйОрдер.Поставщик,
	|	РасходныйКассовыйОрдер.СуммаДокумента
	|ИЗ
	|	Документ.РасходныйКассовыйОрдер КАК РасходныйКассовыйОрдер
	|ГДЕ
	|	РасходныйКассовыйОрдер.Ссылка В (&Ссылка)";
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
