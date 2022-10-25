/* видалення таблиць з каскадним видаленням 
можливих описів цілісності */
drop table Users CASCADE CONSTRAINTS;
drop table Students CASCADE CONSTRAINTS;
drop table Lectors CASCADE CONSTRAINTS;
drop table Data CASCADE CONSTRAINTS;
drop table Orders CASCADE CONSTRAINTS;
drop table Recommendations CASCADE CONSTRAINTS;

CREATE TABLE Users ( -- опис співробітників
	user_id NUMBER(10), -- N співробітника
	surname VARCHAR(20), -- прізвище співробітника
	name VARCHAR(20), -- ім'я співробітника
	email_address NUMBER(4), -- N email адреси співробітника
);

-- обмеження первинного ключа
ALTER TABLE Users ADD CONSTRAINT us_pk
	PRIMARY KEY (user_id);
	
ALTER TABLE Users ADD CONSTRAINT us_email_address
    CHECK ( regexp_like(email_address, 
	           '^([a-z0-9][a-z0-9._-]*@[a-z][a-z0-9._-]*\.[a-z]{2,4})$'));
			   
CREATE TABLE Students( -- опис користувача
	student_id NUMBER(10), -- N користувача
	age DATE, -- дата народження
	desire NUMBER(2), -- побажання користувача
	user_id NUMBER(10), -- N користувача
);

-- обмеження первинного ключа
ALTER TABLE Students ADD CONSTRAINT st_pk
	PRIMARY KEY (student_id);
	
-- обмеження зовнішніх ключів
ALTER TABLE Students ADD CONSTRAINT student_id_fk
	FOREIGN KEY (user_id )
	REFERENCES Users(user_id );
	
CREATE TABLE Data( -- опис даних 
	data_id NUMBER(10), -- N користувача
	type_of_architecture_course VARCHAR(20), -- тип курсу з літератури
	student_id NUMBER(10), -- N користувача
);

-- обмеження первинного ключа
ALTER TABLE Data ADD CONSTRAINT data_pk
	PRIMARY KEY (data_id);
	
-- обмеження зовнішніх ключів
ALTER TABLE Data ADD CONSTRAINT сours_data_id_fk
	FOREIGN KEY (student_id)
	REFERENCES Students (student_id );
	
CREATE TABLE Recommendations( -- закази
	recommendation_id NUMBER(10), -- N заказа
	recommendation VARCHAR(20), -- рекомендація
	data_id NUMBER(10), -- N даних
);

-- обмеження первинного ключа
ALTER TABLE Recommendations ADD CONSTRAINT rec_pk
	PRIMARY KEY (recommendation_id);
	
-- обмеження зовнішніх ключів
ALTER TABLE Recommendations ADD CONSTRAINT rec_order_id_fk
	FOREIGN KEY (data_id)
	REFERENCES Data (data_id);
	
CREATE TABLE Lectors( -- опис користувача
	lector_id NUMBER(10), -- N користувача
	education VARCHAR(20), -- ступінь освіти
	work_experience NUMBER(2), -- досвід (у роках) користувача
	user_id NUMBER(10), -- N користувача
    recommendation_id VARCHAR(40), -- рекомендації користувача
    data_id VARCHAR(40), -- дані користувача
);

-- обмеження первинного ключа
ALTER TABLE Lectors ADD CONSTRAINT lec_pk
	PRIMARY KEY (lector_id);
	
-- обмеження зовнішніх ключів
ALTER TABLE Lectors ADD CONSTRAINT lec_lector_id_fk
	FOREIGN KEY (recommendation_id)
	REFERENCES Recommendations (recommendation_id);

ALTER TABLE Lectors ADD CONSTRAINT lec_lector_id_fk
	FOREIGN KEY (data_id)
	REFERENCES Data (data_id);
	
ALTER TABLE Lectors ADD CONSTRAINT lec_lector_id_fk
	FOREIGN KEY (user_id )
	REFERENCES Users(user_id );

CREATE TABLE Orders( -- закази
	order_id NUMBER(10), -- N заказа
	wishes VARCHAR(20), -- коментарії танцев
	student_id NUMBER(10), -- N користувача
);

-- обмеження первинного ключа
ALTER TABLE Orders ADD CONSTRAINT ord_pk
	PRIMARY KEY (order_id);
	
-- обмеження зовнішніх ключів
ALTER TABLE Orders ADD CONSTRAINT ord_order_id_fk
	FOREIGN KEY (lector_id)
	REFERENCES Lectors (lector_id);
	
ALTER TABLE Orders ADD CONSTRAINT ord_order_id_fk
	FOREIGN KEY (student_id)
	REFERENCES Students(student_id);
