/*
Лабораторная работа №5
«Создание таблиц с помощью языка SQL»
В отчёте должны быть операторы SQL для создания всех таблиц собственной базы данных.
Также в работе должны быть определены: одно значение поля по умолчанию, одно ограничение уникальности и одно проверочное ограничение. 
Значение поля по умолчанию, ограничение уникальности и проверочное ограничение на таблицы с данными по сотрудникам и должностям к рассмотрению не принимаются.
*/

DROP TABLE Учитель;
GO 
CREATE TABLE Учитель(
  Код INT IDENTITY PRIMARY KEY,
  ФИО VARCHAR(50) NOT NULL,
  Телефон VARCHAR(15) NOT NULL,
  ДатаРождения DATE NOT NULL
)
GO

DROP TABLE Класс;
GO
CREATE TABLE Класс(
  Код INT IDENTITY PRIMARY KEY,
  Название VARCHAR(3) NOT NULL,
  Смена INT NOT NULL CHECK (Смена=1 OR Смена=2),
  ДатаПоступления DATE NOT NULL
)
GO

DROP TABLE Мероприятие;
GO
CREATE TABLE Мероприятие(
  Код INT IDENTITY PRIMARY KEY,
  КодУчителя INT NOT NULL,
  КодКласса INT NOT NULL,
  Дата DATE NOT NULL,
  Название VARCHAR(50) NOT NULL
)
GO

DROP TABLE Кабинет
GO
CREATE TABLE Кабинет(
  Код INT IDENTITY PRIMARY KEY,
  Номер VARCHAR(10) NOT NULL,
  UNIQUE (Номер),
  Вместимость INT
)
GO

DROP TABLE Предмет
GO
CREATE TABLE Предмет(
  Код INT IDENTITY PRIMARY KEY,
  Название VARCHAR(50) NOT NULL
)
GO

DROP TABLE Ученик 
GO
CREATE TABLE Ученик(
  Код INT IDENTITY PRIMARY KEY,
  КодКласс INT NOT NULL,
  ФИО VARCHAR(50) NOT NULL,
  ДатаРождения DATE NOT NULL,
  Увлечение VARCHAR(50),
  Пол VARCHAR(1) NOT NULL,
  Адрес VARCHAR(50) NOT NULL
)
GO

DROP TABLE Олимпиада
GO
CREATE TABLE Олимпиада(
  Код INT IDENTITY PRIMARY KEY,
  КодПредмета INT NOT NULL,
  КодУченика INT NOT NULL,
  Название VARCHAR(50) NOT NULL,
  Результат VARCHAR(50) NOT NULL,
  Дата DATE NOT NULL,
  КодУчителя INT NOT NULL,
  Место INT NOT NULL
)
GO

DROP TABLE Расписание
GO
CREATE TABLE Расписание(
  Код INT IDENTITY PRIMARY KEY,
  КодПредмета INT NOT NULL,
  КодУчителя INT NOT NULL,
  КодКласс INT NOT NULL,
  КодКабинета INT NOT NULL,
  ДеньНедели VARCHAR(15) NOT NULL,
  НомерУрока INT NOT NULL
)
GO

DROP TABLE Урок
GO
CREATE TABLE Урок(
  Код INT IDENTITY PRIMARY KEY,
  КодРасписания INT NOT NULL,
  Дата DATE NOT NULL DEFAULT GETDATE()
)
GO

DROP TABLE Оценка
GO
CREATE TABLE Оценка(
  Код INT IDENTITY PRIMARY KEY,
  КодУрока INT NOT NULL,
  КодУченика INT NOT NULL,
  Оценка INT 
)