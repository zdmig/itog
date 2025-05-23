Процедура ЗаполнитьГрафик(ДатаНачала, ДатаОкончания, ВыходныеДни, График) Экспорт 
	
	Набор = РегистрыСведений.ГрафикиРаботы.СоздатьНаборЗаписей();
	Набор.Отбор.ГрафикРаботы.Установить(График);
	Набор.Прочитать();
	
	ЧислоСекундВСутках = 86400;
	
	Дат = ДатаНачала;
	Для к = 0 По Набор.Количество()-1 Цикл
		
		Запись = Набор[к];
		Если Запись.Дата < ДатаНачала Тогда
		    Продолжить;
		ИначеЕсли Запись.Дата =Дат Тогда
			Запись.ГрафикРаботы = График;
			
			Если Найти(ВыходныеДни, Строка(ДеньНедели(Дат))) Тогда
				Запись.ЗначениеЧасы = 0;
				Запись.ЗначениеДни = 0;
			Иначе	          
				Запись.ЗначениеЧасы = График.КоличествоЧасов;
				Запись.ЗначениеДни = 1;
			КонецЕсли;
			Дат = Дат + ЧислоСекундВСутках;
		Иначе
			Пока Дат < Мин(Запись.Дата, ДатаОкончания) Цикл
				НоваяЗапись = Набор.Добавить();
				НоваяЗапись.Дата = Дат;
				НоваяЗапись.ГрафикРаботы = График;
				
				Если Найти(ВыходныеДни, Строка(ДеньНедели(Дат))) Тогда
					НоваяЗапись.ЗначениеЧасы = 0;
					НоваяЗапись.ЗначениеДни = 0;
				Иначе	          
					НоваяЗапись.ЗначениеЧасы = График.КоличествоЧасов;
					НоваяЗапись.ЗначениеДни = 1;
				КонецЕсли; 
				Дат = Дат + ЧислоСекундВСутках;
			КонецЦикла; 
			Если Запись.Дата > ДатаОкончания Тогда
				Прервать;
			Иначе
				Запись.ГрафикРаботы = График;
				Если Найти(ВыходныеДни, Строка(ДеньНедели(Дат))) Тогда
					Запись.ЗначениеЧасы = 0;
					Запись.ЗначениеДни = 0;
				Иначе	          
					Запись.ЗначениеЧасы = График.КоличествоЧасов;
					Запись.ЗначениеДни = 1;      
				КонецЕсли;
			КонецЕсли;
			Дат = Дат + ЧислоСекундВСутках;
		КонецЕсли;
	КонецЦикла;
	Набор.Записать();
	
	Пока Дат <= ДатаОкончания Цикл
		Запись = Набор.Добавить();
		Запись.Дата = Дат; 
		Запись.ГрафикРаботы = График;
		
		Если Найти(ВыходныеДни, Строка(ДеньНедели(Дат))) Тогда
			Запись.ЗначениеЧасы = 0;
			Запись.ЗначениеДни = 0;
		Иначе	          
			Запись.ЗначениеЧасы = График.КоличествоЧасов;
			Запись.ЗначениеДни = 1;
		КонецЕсли;

		Дат = Дат + ЧислоСекундВСутках;
	КонецЦикла; 
	Набор.Записать();
КонецПроцедуры
