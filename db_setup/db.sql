/*
  Syntax Notes:
  • single quotes \' are strings
  • double quotes \" are column identifiers (reference column names)
*/

DROP TABLE IF EXISTS casemanager;

CREATE TABLE casemanager (
  id integer PRIMARY KEY,
  username varchar(45) NOT NULL,
  password varchar(45) NOT NULL,
  first_name varchar(45) NOT NULL,
  last_name varchar(45) NOT NULL,
  position varchar(45) NOT NULL
);

INSERT INTO casemanager VALUES (1, 'jew@spfy.org','tables','Jeanine','Espejo-Watkins','Case Manager');
INSERT INTO casemanager VALUES (2, 'bp@spfy.org','tables','Ben','Perkins','Case Manager');
INSERT INTO casemanager VALUES (3, 'rh@spfy.org','tables','Rob','Hanna','Case Manager');



DROP TABLE IF EXISTS status;

CREATE TABLE status (
  id SERIAL PRIMARY KEY,
  name varchar(45) DEFAULT NULL
);

INSERT INTO status (name) VALUES ('okay');
INSERT INTO status (name) VALUES ('missing');
INSERT INTO status (name) VALUES ('sick');
INSERT INTO status (name) VALUES ('vulnerable');
INSERT INTO status (name) VALUES ('dangerous');


DROP TABLE IF EXISTS client;

-- Where are the rest of the intake fields for a client profile?
-- They are broken up into subsequent tables that follow this one
-- (this structure is still being decided upon)


-- for dates, postgres documentation recommends using ISO 8601 format: '2016-01-08'
-- which postgres will accept in any mode (some formats are rejected in certain postgres date/time modes)

CREATE TABLE client (
  id SERIAL PRIMARY KEY,
  first_name varchar(45) DEFAULT NULL,
  last_name varchar(45) DEFAULT NULL,
  nickname varchar(45) DEFAULT NULL,
  person_completing_intake varchar(65) DEFAULT NULL,
  intake_date date DEFAULT NULL,
  hmis_consent boolean DEFAULT NULL,
  first_time boolean DEFAULT NULL,
  case_manager varchar(65) DEFAULT NULL,
  case_manager_id integer DEFAULT NULL,
  phone_number varchar(45) DEFAULT NULL,
  email varchar(65) DEFAULT NULL,
  date_of_birth date DEFAULT NULL,
  intake_age integer DEFAULT NULL,
  provided_id boolean DEFAULT NULL,
  id_state varchar(45) DEFAULT NULL,
  reference varchar(45) DEFAULT NULL,
  services varchar(45) DEFAULT NULL,
  status integer REFERENCES status (id)
);

INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('John','Doe', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 1);
INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Steven', 'Brown', '2010-03-15T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 3);
INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Carlie','Smith', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 4);
INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Carlie','Johnson', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 1);
INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Jeremiah','Haelstrom', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 2);
INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Erick','Wilson', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 1);
INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Tommie', 'Franklin', '2010-03-15T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 3);
INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Tricia','Goodman', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 4);
INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Mona','Adkins', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 1);
INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Brooke','Burke', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 3);
-- INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Ed','Salazar', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 3);
-- INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Gerard', 'Powers', '2010-03-15T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 2);
-- INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Courtney','Lawrence', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 4);
-- INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Alfredo','Hodges', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 1);
-- INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Lynne','Simmons', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 1);
-- INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Sonya','Powell', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 1);
-- INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Ann', 'Moss', '2010-03-15T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 3);
-- INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Rickey','Jacobs', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 4);
-- INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Colin','Turner', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 1);
-- INSERT INTO client (first_name, last_name, intake_date, phone_number, email, date_of_birth, status) VALUES ('Tara','Evans', '2016-10-20T07:00:00.000Z', '123-456-7890', 'email@email.com', '01/01/2222', 1);




DROP TABLE IF EXISTS prescreen;

CREATE TABLE prescreen (
  id integer PRIMARY KEY,
  client_id integer REFERENCES client (id)
);

DROP TABLE IF EXISTS background;

CREATE TABLE background (
  id integer PRIMARY KEY,
  client_id integer REFERENCES client (id)
  -- Disability varchar(45) DEFAULT NULL,
  -- LastGradeCompleted varchar(45) DEFAULT NULL,
  -- SomeCompleted varchar(45) DEFAULT NULL,
  -- CurrentlyAttending varchar(45) DEFAULT NULL,
  -- Graduated varchar(45) DEFAULT NULL,
  -- FirstLanguage varchar(45) DEFAULT NULL,
  -- PreferredLanguage varchar(45) DEFAULT NULL,
  -- MaritalStatus varchar(45) DEFAULT NULL,
  -- MilitaryService varchar(45) DEFAULT NULL,
  -- HealthInsurance varchar(45) DEFAULT NULL,
  -- Gender varchar(45) DEFAULT NULL,
  -- GenderIdentification varchar(45) DEFAULT NULL,
  -- PreferredPronoun varchar(45) DEFAULT NULL,
  -- Ethnicity varchar(45) DEFAULT NULL,
  -- Race varchar(45) DEFAULT NULL
);

DROP TABLE IF EXISTS housing_history;

CREATE TABLE housing_history (
  id integer PRIMARY KEY,
  client_id integer REFERENCES client (id),
  last_sleeping_location varchar(45) DEFAULT NULL,
  last_sleeping_duration varchar(45) DEFAULT NULL,
  first_day_first_time_homeless date DEFAULT NULL,
  current_homeless_start_date date DEFAULT NULL,
  current_homeless_length varchar(45) DEFAULT NULL,
  homeless_episode_count varchar(45) DEFAULT NULL,
  location_before_west_la varchar(45) DEFAULT NULL,
  duration_in_west_la varchar(45) DEFAULT NULL,
  housing_instability_cause varchar(45) DEFAULT NULL,
  stable_housing_obstacle varchar(45) DEFAULT NULL,
  housing_interest boolean DEFAULT NULL
);

DROP TABLE IF EXISTS natural_connection;

CREATE TABLE natural_connection (
  id integer PRIMARY KEY,
  client_id integer REFERENCES client (id),
  natural_connection boolean DEFAULT NULL,
  contact_name varchar(45) DEFAULT NULL,
  contact_phone_number varchar(45) DEFAULT NULL,
  contact_relationship varchar(45) DEFAULT NULL
);

DROP TABLE IF EXISTS pregnant_and_parenting;

CREATE TABLE pregnant_and_parenting (
  id integer PRIMARY KEY,
  client_id integer REFERENCES client (id),
  currently_pregnant boolean DEFAULT NULL,
  first_pregnancy boolean DEFAULT NULL,
  pre_natal_carereceived boolean DEFAULT NULL,
  pre_natal_carelocation varchar(45) DEFAULT NULL,
  pre_natal_caredesired boolean DEFAULT NULL,
  trimester varchar(45) DEFAULT NULL,
  baby_due_date date DEFAULT NULL,
  has_other_children boolean DEFAULT NULL,
  dcfs_open_case boolean DEFAULT NULL,
  children_with_family_or_friends varchar(45) DEFAULT NULL
);

DROP TABLE IF EXISTS substance_abuse;

CREATE TABLE substance_abuse (
  id integer PRIMARY KEY,
  client_id integer REFERENCES client (id),
  substance_abuse boolean DEFAULT NULL,
  choice_substance varchar(45) DEFAULT NULL,
  injected_drugs boolean DEFAULT NULL,
  treatment_interest boolean DEFAULT NULL
);

DROP TABLE IF EXISTS mental_health;

CREATE TABLE mental_health (
  id integer PRIMARY KEY,
  client_id integer REFERENCES client (id)
  -- MentalServicesReceived boolean DEFAULT NULL,
  -- MentalServicesLocation varchar(45) DEFAULT NULL,
  -- MentalMedication boolean DEFAULT NULL,
  -- HelpAcquiringMedicine boolean DEFAULT NULL
);

DROP TABLE IF EXISTS referrals;

CREATE TABLE referral (
  id integer PRIMARY KEY,
  client_id integer REFERENCES client (id),
  internal_referral varchar(45) DEFAULT NULL,
  external_referral varchar(45) DEFAULT NULL
);

DROP TABLE IF EXISTS additional_info;

CREATE TABLE additional_info (
  id integer PRIMARY KEY,
  client_id integer REFERENCES client (id),
  income varchar(45) DEFAULT NULL,
  birth_city varchar(45) DEFAULT NULL,
  birth_state varchar(45) DEFAULT NULL,
  birth_country varchar(45) DEFAULT NULL,
  employed varchar(45) DEFAULT NULL,
  looking_for_employment boolean DEFAULT NULL,
  foster_care boolean DEFAULT NULL,
  social_security_number varchar(45) DEFAULT NULL,
  caring_for_animals boolean DEFAULT NULL,
  chronically_homeless boolean DEFAULT NULL
);

DROP TABLE IF EXISTS forms;

CREATE TABLE forms (
  id integer PRIMARY KEY,
  client_id integer  REFERENCES client (id),
  good_neighbor_contract varchar(45) DEFAULT NULL,
  story_photo_video_audio_form boolean DEFAULT NULL,
  information_release_authrorized boolean DEFAULT NULL,
  services_consent boolean DEFAULT NULL,
  shower_instructions boolean DEFAULT NULL,
  shower_guidelines boolean DEFAULT NULL,
  drop_in_guidelines boolean DEFAULT NULL,
  intake_confirmation boolean DEFAULT NULL,
  immediate_needs_transportation boolean DEFAULT NULL,
  documents_signed boolean DEFAULT NULL,
  sleeping_bag boolean DEFAULT NULL,
  backpack boolean DEFAULT NULL
);

DROP TABLE IF EXISTS match;

-- matching case managers with their clients

CREATE TABLE match (
  id integer PRIMARY KEY,
  casemanager_id integer REFERENCES casemanager (id),
  client_id integer REFERENCES client (id)
);

/* INSERT INTO match VALUES (1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 1, 4); */


/* should we use inheritance here?
Programs definitely "contain" subprograms,
but is a subprogram also a program?
Is an activity a subprogram?
*/

DROP TABLE IF EXISTS program;

CREATE TABLE program (
  id SERIAL PRIMARY KEY,
  program_name varchar(45) DEFAULT NULL
);

INSERT INTO program (program_name) VALUES ('Education & Employment');

DROP TABLE IF EXISTS subprogram;

CREATE TABLE subprogram (
  id SERIAL PRIMARY KEY,
  subprogram_name varchar(45) DEFAULT NULL,
  program_id integer REFERENCES program (id)
);

INSERT INTO subprogram (subprogram_name, program_id) VALUES ('Digital Arts Lab', 1);


DROP TABLE IF EXISTS activity;

CREATE TABLE activity (
  id SERIAL PRIMARY KEY,
  activity_name varchar(45) DEFAULT NULL,
  ongoing boolean DEFAULT NULL,
  start_date date DEFAULT NULL,
  end_date date DEFAULT NULL
);

INSERT INTO activity (activity_name) VALUES ('Medical Care');
INSERT INTO activity (activity_name) VALUES ('Medi-Cal Registration');
INSERT INTO activity (activity_name) VALUES ('HIV Testing');
INSERT INTO activity (activity_name) VALUES ('Dental Care');

DROP TABLE IF EXISTS drop_in;

CREATE TABLE drop_in (
  id SERIAL PRIMARY KEY,
  date date DEFAULT CURRENT_DATE
);

INSERT INTO drop_in (date) VALUES ('2016-10-16');
INSERT INTO drop_in (date) VALUES ('2016-10-17');

DROP TABLE IF EXISTS match_drop_in_activity;

CREATE TABLE match_drop_in_activity (
  id SERIAL PRIMARY KEY,
  drop_in_id integer REFERENCES drop_in (id),
  activity_id integer REFERENCES activity (id),
  room varchar(30) DEFAULT NULL,
  comments varchar(128) DEFAULT NULL,
  start_time time DEFAULT '00:00:00',
  end_time time DEFAULT '23:59:59'
);

INSERT INTO match_drop_in_activity (drop_in_id, activity_id, room, start_time, end_time) VALUES (2, 3, 'Clinic', '13:30:00', '15:30:00');
INSERT INTO match_drop_in_activity (drop_in_id, activity_id, room, start_time, end_time) VALUES (2, 4, 'Clinic', '12:30:00', '13:30:00');
INSERT INTO match_drop_in_activity (drop_in_id, activity_id, room, start_time, end_time) VALUES (2, 1, 'Clinic', '12:30:00', '13:30:00');


DROP TABLE IF EXISTS enrollment;

CREATE TABLE enrollment (
  id SERIAL PRIMARY KEY,
  drop_in_id integer REFERENCES drop_in (id),
  client_id integer REFERENCES client (id),
  activity_id integer REFERENCES activity (id)
);

INSERT INTO enrollment (drop_in_id, client_id, activity_id) VALUES (2, 2, 4);
INSERT INTO enrollment (drop_in_id, client_id, activity_id) VALUES (2, 3, 4);
INSERT INTO enrollment (drop_in_id, client_id, activity_id) VALUES (2, 4, 4);

INSERT INTO enrollment (drop_in_id, client_id, activity_id) VALUES (2, 2, 3);
INSERT INTO enrollment (drop_in_id, client_id, activity_id) VALUES (2, 4, 3);
INSERT INTO enrollment (drop_in_id, client_id, activity_id) VALUES (2, 1, 3);

INSERT INTO enrollment (drop_in_id, client_id, activity_id) VALUES (2, 4, 1);
INSERT INTO enrollment (drop_in_id, client_id, activity_id) VALUES (2, 5, 1);
INSERT INTO enrollment (drop_in_id, client_id, activity_id) VALUES (2, 7, 1);

DROP TABLE IF EXISTS check_in;

CREATE TABLE check_in (
  id SERIAL PRIMARY KEY,
  drop_in_id integer REFERENCES drop_in (id),
  client_id integer REFERENCES client (id),
  date date DEFAULT NULL
);

INSERT INTO check_in (drop_in_id, client_id, date) VALUES (2, 4, '2016-10-20T07:00:00.000Z');
INSERT INTO check_in (drop_in_id, client_id, date) VALUES (2, 3, '2016-10-20T07:00:00.000Z');
INSERT INTO check_in (drop_in_id, client_id, date) VALUES (2, 5, '2016-10-20T07:00:00.000Z');
INSERT INTO check_in (drop_in_id, client_id, date) VALUES (2, 7, '2016-10-20T07:00:00.000Z');
INSERT INTO check_in (drop_in_id, client_id, date) VALUES (2, 1, '2016-10-20T07:00:00.000Z');
INSERT INTO check_in (drop_in_id, client_id, date) VALUES (2, 10, '2016-10-20T07:00:00.000Z');

DROP TABLE IF EXISTS case_note;

CREATE TABLE case_note (
  id SERIAL PRIMARY KEY,
  client_id integer REFERENCES client (id),
  case_manager_id integer REFERENCES casemanager (id),
  date date DEFAULT CURRENT_DATE,
  category VARCHAR (5) DEFAULT NULL,
  note VARCHAR(200) DEFAULT NULL,
  follow_up_needed boolean DEFAULT NULL,
  due_date date DEFAULT NULL,
  reminder_date date DEFAULT NULL
);

INSERT INTO case_note (client_id, case_manager_id, date, category, note, follow_up_needed, due_date, reminder_date) VALUES (1, 1, '2016-10-31', 'CM', 'This is an initial note', false, null, null);
INSERT INTO case_note (client_id, case_manager_id, date, category, note, follow_up_needed, due_date, reminder_date) VALUES (1, 1, '2016-11-15', 'CM', 'This is another initial note', false, null, null);
INSERT INTO case_note (client_id, case_manager_id, date, category, note, follow_up_needed, due_date, reminder_date) VALUES (2, 3, '2016-10-31', 'CM', 'This is an initial note', false, null, null);
INSERT INTO case_note (client_id, case_manager_id, date, category, note, follow_up_needed, due_date, reminder_date) VALUES (2, 2, '2016-10-31', 'CM', 'This is another initial note', false, null, null);
INSERT INTO case_note (client_id, case_manager_id, date, category, note, follow_up_needed, due_date, reminder_date) VALUES (3, 1, '2016-10-31', 'CM', 'This is an initial note', false, null, null);

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username varchar(45) NOT NULL,
  hashed_password varchar(70) NOT NULL
);

-- inserting user 'test' to login with password 'passwordisnone'
INSERT INTO users (username, hashed_password) VALUES ('test', '$2a$10$DAInVRGKZJ4pmb64YDJxXe2zgt4N3/FbxHkhC23yv8Dwv0uHeov6u');

DROP TABLE IF EXISTS notifications;

CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  user_id integer REFERENCES users (id),
  type varchar(45) NOT NULL DEFAULT 'general',
  comment varchar(128) DEFAULT NULL,
  link varchar(128) DEFAULT NULL,
  checked boolean DEFAULT NULL
);

INSERT INTO notifications (user_id, comment, link, checked) VALUES (1, 'Test notification for test', '/frontdesk', 'FALSE');
INSERT INTO notifications (user_id, comment, link, checked) VALUES (1, 'Another notification', '/frontdesk', 'FALSE');
INSERT INTO notifications (user_id, comment, link, checked) VALUES (1, 'Another notification1', '/frontdesk', 'TRUE');
INSERT INTO notifications (user_id, comment, link, checked) VALUES (1, 'Another notification2', '/frontdesk', 'FALSE');