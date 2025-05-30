
&НаКлиенте
Процедура ТоварыНоменклатураПриИзменении(Элемент) 
	
	СтрокаТабличнойЧасти = Элементы.Товары.ТекущиеДанные;
	СтрокаТабличнойЧасти.ЦенаРеализации = ЦенаИзНоменклатурыНаСервере(СтрокаТабличнойЧасти.Номенклатура); 
	СтрокаТабличнойЧасти.Сумма = СтрокаТабличнойЧасти.Количество * СтрокаТабличнойЧасти.ЦенаРеализации; 
	
КонецПроцедуры   

&НаСервере
Функция ЦенаИзНоменклатурыНаСервере (Номенклатура)
	
	Возврат Номенклатура.ЦенаРеализации;
	
КонецФункции


&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент) 
	
	СтрокаТабличнойЧасти = Элементы.Товары.ТекущиеДанные; 
	СтрокаТабличнойЧасти.Сумма = СтрокаТабличнойЧасти.Количество * СтрокаТабличнойЧасти.ЦенаРеализации; 
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПоступленияПриИзменении(Элемент)
	
	СтрокаТабличнойЧасти = Элементы.Товары.ТекущиеДанные;           
	СтрокаТабличнойЧасти.Сумма = СтрокаТабличнойЧасти.Количество * СтрокаТабличнойЧасти.ЦенаРеализации; 

КонецПроцедуры 



&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
Если НЕ ЗначениеЗаполнено(Объект.Основание) Тогда

Элементы.Основание.Видимость = Ложь;	

КонецЕсли;

ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);

КонецПроцедуры



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


&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	ДатыЗапретаИзменения.ОбъектПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
КонецПроцедуры
   

