

&НаКлиенте
Процедура ДопНачисленияВидНачисленияПриИзменении(Элемент)
	ТекДанные = Элементы.ДопНачисления.ТекущиеДанные;
	Если Строка(ТекДанные.ВидНачисления) = "Премия"  Тогда 
		ТекДанные.Процент = 1;
		ТекДанные.Размер = РассичатьПремиюНаСервере(ТекДанные.Сотрудник,Объект.Дата,ТекДанные.Процент); 
	КонецЕсли;
КонецПроцедуры


 
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);

КонецПроцедуры

&НаСервере
Функция РассичатьПремиюНаСервере(Сотрудник,Месяц,Процент)
	Возврат Документы.НачислениеЗарплаты.РассчитатьПремию(Сотрудник,ДобавитьМесяц(Месяц,-2),Процент); 
КонецФункции


// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если Объект.Дата <> Дата(1,1,1) И Объект.Месяц = 0 Тогда
		Объект.Месяц = Месяц(ДобавитьМесяц(Объект.Дата,-1));
	Иначе
		Объект.Месяц = Месяц(ДобавитьМесяц(ТекущаяДата(),-1));
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура МесяцПриИзменении(Элемент)
	Объект.Дата = ДобавитьМесяц(Объект.Дата,-Месяц(Объект.Дата)+Объект.Месяц+1);
КонецПроцедуры

&НаКлиенте
Процедура ДопНачисленияПроцентПриИзменении(Элемент) 
	ТекДанные = Элементы.ДопНачисления.ТекущиеДанные;
	Если Строка(ТекДанные.ВидНачисления) = "Премия"  Тогда
		ТекДанные.Размер = РассичатьПремиюНаСервере(ТекДанные.Сотрудник,Объект.Дата,ТекДанные.Процент);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура НачисленияВидНачисленияПриИзменении(Элемент)
	ТекДанные = Элементы.Начисления.ТекущиеДанные;
	Если Строка(ТекДанные.ВидНачисления) = "Оклад"  Тогда
		ТекДанные.ДатаНачала = НачалоМесяца(ДобавитьМесяц(Объект.Дата,-1));
		ТекДанные.ДатаОкончания = КонецМесяца(ДобавитьМесяц(Объект.Дата,-1))
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
КонецПроцедуры


