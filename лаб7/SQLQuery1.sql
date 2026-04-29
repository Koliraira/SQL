/*
Лабораторная работа №5
«Создание таблиц с помощью языка SQL»
В отчёте должны быть операторы SQL для создания всех таблиц собственной базы данных.
Также в работе должны быть определены: одно значение поля по умолчанию, одно ограничение уникальности и одно проверочное ограничение. 
Значение поля по умолчанию, ограничение уникальности и проверочное ограничение на таблицы с данными по сотрудникам и должностям к рассмотрению не принимаются.
*/
ALTER TABLE Мероприятие 
  DROP CONSTRAINT FK_Мероприятие_Учитель, FK_Мероприятие_Класс
ALTER TABLE Оценка 
  DROP CONSTRAINT FK_Оценка_Урок, FK_Оценка_Ученик
ALTER TABLE Расписание 
  DROP CONSTRAINT FK_Расписание_Предмет, FK_Расписание_Учитель, FK_Расписание_Класс, FK_Расписание_Кабинет
ALTER TABLE Олимпиада 
  DROP CONSTRAINT FK_Олимпиада_Предмет, FK_Олимпиада_Ученик
ALTER TABLE Урок 
  DROP CONSTRAINT FK_Урок_Расписание
ALTER TABLE Ученик
  DROP CONSTRAINT FK_Ученик_Класс
GO

DROP TABLE Олимпиада
GO
DROP TABLE Оценка
GO
DROP TABLE Урок
GO
DROP TABLE Расписание
GO
DROP TABLE Мероприятие;
GO
DROP TABLE Предмет
GO
DROP TABLE Кабинет
GO
DROP TABLE Ученик 
GO
DROP TABLE Класс;
GO
DROP TABLE Учитель;
GO 

CREATE TABLE Учитель(
  Код INT IDENTITY PRIMARY KEY,
  ФИО VARCHAR(50) NOT NULL,
  Телефон VARCHAR(15) NOT NULL,
  ДатаРождения DATE NOT NULL
)
GO

CREATE TABLE Класс(
  Код INT IDENTITY PRIMARY KEY,
  Название VARCHAR(3) NOT NULL,
  Смена INT NOT NULL CHECK (Смена=1 OR Смена=2),
  ДатаПоступления DATE NOT NULL
)
GO

CREATE TABLE Мероприятие(
  Код INT IDENTITY PRIMARY KEY,
  КодУчителя INT NOT NULL,
  КодКласса INT NOT NULL,
  Дата DATE NOT NULL,
  Название VARCHAR(50) NOT NULL
)
GO

CREATE TABLE Кабинет(
  Код INT IDENTITY PRIMARY KEY,
  Номер VARCHAR(10) NOT NULL,
  UNIQUE (Номер),
  Вместимость INT
)
GO

CREATE TABLE Предмет(
  Код INT IDENTITY PRIMARY KEY,
  Название VARCHAR(50) NOT NULL
)
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

CREATE TABLE Расписание(
  Код INT IDENTITY PRIMARY KEY,
  КодПредмета INT NOT NULL,
  КодУчителя INT NOT NULL,
  КодКласса INT NOT NULL,
  КодКабинета INT NOT NULL,
  ДеньНедели VARCHAR(15) NOT NULL,
  НомерУрока INT NOT NULL
)
GO

CREATE TABLE Урок(
  Код INT IDENTITY PRIMARY KEY,
  КодРасписания INT NOT NULL,
  Дата DATE NOT NULL DEFAULT GETDATE()
)
GO

CREATE TABLE Оценка(
  Код INT IDENTITY PRIMARY KEY,
  КодУрока INT NOT NULL,
  КодУченика INT NOT NULL,
  Оценка INT 
)

/*
Лабораторная работа №7
«Определение связей между таблицами с помощью языка SQL»
В отчёте должны быть операторы SQL для определения всех связей между таблицами собственной базы данных (Alter Table + CONSTRAINT).
Также в Alter Table должны быть определены: 
одно ограничение уникальности и одно проверочное ограничение. 
Ограничение уникальности и проверочное ограничение на таблицы с данными по 
сотрудникам и должностям к рассмотрению не принимаются.
*/
ALTER TABLE Мероприятие 
  ADD CONSTRAINT FK_Мероприятие_Учитель FOREIGN KEY (КодУчителя) REFERENCES Учитель(Код),
      CONSTRAINT FK_Мероприятие_Класс FOREIGN KEY (КодКласса) REFERENCES Класс(Код)
GO

ALTER TABLE Оценка
  ADD CONSTRAINT FK_Оценка_Урок FOREIGN KEY (КодУрока) REFERENCES Урок(Код),
      CONSTRAINT FK_Оценка_Ученик FOREIGN KEY (КодУченика) REFERENCES Ученик(Код),
      CONSTRAINT CHK_Оценка_Оценка CHECK (Оценка>0)
GO

ALTER TABLE Предмет
  ADD CONSTRAINT UQ_Предмет_Название UNIQUE (Название)
GO

ALTER TABLE Расписание
  ADD CONSTRAINT FK_Расписание_Предмет FOREIGN KEY (КодПредмета) REFERENCES Предмет(Код),
      CONSTRAINT FK_Расписание_Учитель FOREIGN KEY (КодУчителя) REFERENCES Учитель(Код),
      CONSTRAINT FK_Расписание_Класс FOREIGN KEY (КодКласса) REFERENCES Класс(Код),
      CONSTRAINT FK_Расписание_Кабинет FOREIGN KEY (КодКабинета) REFERENCES Кабинет(Код)
GO

ALTER TABLE Олимпиада 
  ADD CONSTRAINT FK_Олимпиада_Предмет FOREIGN KEY (КодПредмета) REFERENCES Предмет(Код),
      CONSTRAINT FK_Олимпиада_Ученик FOREIGN KEY (КодУченика) REFERENCES Ученик(Код)
GO

ALTER TABLE Урок
  ADD CONSTRAINT FK_Урок_Расписание FOREIGN KEY (КодРасписания) REFERENCES Расписание(Код)
GO

ALTER TABLE Ученик
  ADD CONSTRAINT FK_Ученик_Класс FOREIGN KEY (КодКласс) REFERENCES Класс(Код)
