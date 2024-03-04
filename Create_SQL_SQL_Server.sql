create database gym;
use gym
CREATE TABLE Diet
(
  Diet_id INT NOT NULL,
  Diet_name VARCHAR(30) NOT NULL,
  Diet_time_period nvarchar(50) NOT NULL,
  Diet_description VARCHAR(MAX),
  CONSTRAINT Diet_PK PRIMARY KEY (Diet_id)
);

CREATE TABLE exercise_location
(
  location_id INT NOT NULL,
  exercise_location VARCHAR(10) NOT NULL,
  CONSTRAINT Location_PK PRIMARY KEY (location_id)
);

CREATE TABLE group_time
(
  group_id INT NOT NULL,
  group_name VARCHAR(MAX) NOT NULL,
  number_member INT NOT NULL,
  schedule VARCHAR(50) NOT NULL,
  Start_time time(2) NOT NULL,
  end_time time(2) NOT NULL,
  CONSTRAINT Group_PK PRIMARY KEY (group_id)
);

CREATE TABLE maintenances_name
(
  maintenances_name_id INT NOT NULL,
  maintenances_name VARCHAR(MAX) NOT NULL,
  CONSTRAINT maintenances_name_PK PRIMARY KEY (maintenances_name_id)
);

CREATE TABLE invoice_state
(
  invoice_state_id INT NOT NULL,
  invoice_state VARCHAR(MAX) NOT NULL,
  CONSTRAINT state_PK PRIMARY KEY (invoice_state_id)
);

CREATE TABLE invoice_type
(
  invoce_type_id INT NOT NULL,
  invoice_type VARCHAR(MAX) NOT NULL,
  CONSTRAINT type_PK PRIMARY KEY (invoce_type_id)
);

CREATE TABLE Progress_Level
(
  level_id INT NOT NULL,
  level_name VARCHAR(MAX) NOT NULL,
  CONSTRAINT Level_PK PRIMARY KEY (level_id)
);

CREATE TABLE packages
(
  package_id INT NOT NULL,
  package_name VARCHAR(30) NOT NULL,
  workout_number INT NOT NULL,
  gifts VARCHAR(MAX),
  Number_of_invitation INT,
  CONSTRAINT Packages_PK PRIMARY KEY (package_id)
);

CREATE TABLE users
(
  Register_id INT NOT NULL,
  User_ssn VARCHAR(MAX) NOT NULL,
  User_name VARCHAR(MAX) NOT NULL,
  User_gender VARCHAR(MAX) NOT NULL,
  User_birthday DATE NOT NULL,
  Password VARCHAR(MAX),
  User_address VARCHAR(MAX) NOT NULL,
  User_Phone1 VARCHAR(MAX) NOT NULL,
  User_Phone2 VARCHAR(MAX),
  User_Code VARCHAR(MAX) NOT NULL,
  CONSTRAINT users_PK PRIMARY KEY (Register_id)
);

CREATE TABLE Workouts
(
  workout_id INT NOT NULL,
  workouts_name nvarchar(50) NOT NULL,
  workouts_price real NOT NULL,
  workouts_description nvarchar(MAX),
  CONSTRAINT Workouts_PK PRIMARY KEY (workout_id)
);

CREATE TABLE exercieses
(
  exercieses_id INT NOT NULL,
  exercieses_name VARCHAR(MAX) NOT NULL,
  exercieses_time FLOAT,
  exercieses_counter INT,
  exercieses_video_link VARCHAR(MAX) NOT NULL,
  exercieses_describtion VARCHAR(MAX),
  location_id INT NOT NULL,
  CONSTRAINT exercieses_PK PRIMARY KEY (exercieses_id),
  CONSTRAINT FK_Location_Excercieses FOREIGN KEY(location_id)REFERENCES exercise_location(location_id)
);

CREATE TABLE exercieses_has_level
(
  exercieses_id INT NOT NULL,
  level_id INT NOT NULL,
  CONSTRAINT exercieses_has_level_PK PRIMARY KEY (exercieses_id,level_id),
  CONSTRAINT FK_exercieses_EXLEVEL FOREIGN KEY (exercieses_id) REFERENCES exercieses(exercieses_id),
  CONSTRAINT FK_LEVEL_EXlevel FOREIGN KEY(level_id) REFERENCES Progress_Level(level_id)
);

CREATE TABLE Time_OF_Workouts
(
  workout_id INT NOT NULL,
  group_id INT NOT NULL,
  CONSTRAINT GroupTimeDOW_PK PRIMARY KEY (workout_id,group_id),
  CONSTRAINT FK_workouts_GroupTimeDOW FOREIGN KEY (workout_id) REFERENCES Workouts(workout_id),
  CONSTRAINT FK_GroupTime_GroupTimeDOW FOREIGN KEY (group_id) REFERENCES group_time(group_id)
);

CREATE TABLE staff
(
  Staff_id INT NOT NULL,
  Work_shift VARCHAR(MAX) NOT NULL,
  manage_id INT,
  Register_id INT NOT NULL,
  CONSTRAINT staff_PK PRIMARY KEY (Staff_id),
  CONSTRAINT FK_user_staff FOREIGN KEY (Register_id) REFERENCES users(Register_id),
  CONSTRAINT FK_staff_staff FOREIGN KEY (manage_id) REFERENCES staff(Staff_id)
);

CREATE TABLE staff_Salary
(
  Staff_id INT NOT NULL,
  staff_Salary FLOAT NOT NULL,
  Salary_Date Date NOT NULL,
  CONSTRAINT StaffSalary_PK PRIMARY KEY (Salary_Date,Staff_id),
  CONSTRAINT FK_staff_StaffSalary FOREIGN KEY (Staff_id) REFERENCES staff(Staff_id)
);

CREATE TABLE workouts_contain_exercises
(
  workout_id INT NOT NULL,
  exercieses_id INT NOT NULL,
  CONSTRAINT WorkInEX_PK PRIMARY KEY (workout_id,exercieses_id),
  CONSTRAINT FK_workouts_WorkInEX FOREIGN KEY (workout_id) REFERENCES Workouts(workout_id),
  CONSTRAINT FK_exercieses_WorkInEX FOREIGN KEY (exercieses_id) REFERENCES exercieses(exercieses_id)
);

CREATE TABLE Members
(
  Member_id INT NOT NULL,
  Member_height FLOAT NOT NULL,
  Member_Weight FLOAT NOT NULL,
  Register_id INT NOT NULL,
  Staff_id INT NOT NULL,
  CONSTRAINT Members_PK PRIMARY KEY (Member_id),
  CONSTRAINT FK_users_Members FOREIGN KEY (Register_id) REFERENCES users(Register_id),
  CONSTRAINT FK_staff_Members FOREIGN KEY (Staff_id) REFERENCES staff(Staff_id)
);

CREATE TABLE inbody
(
  Member_id INT NOT NULL,
  water_percentage FLOAT,
  heart_rate FLOAT,
  pressure FLOAT,
  muscles FLOAT,
  bones FLOAT,
  fats FLOAT,
  date_of_measure DATE NOT NULL,
  Diet_id INT NOT NULL,
  CONSTRAINT Inbody_PK PRIMARY KEY (Member_id,date_of_measure),
  CONSTRAINT FK_Diet_inbody FOREIGN KEY (Diet_id) REFERENCES Diet(Diet_id),
  CONSTRAINT FK_Members_inbody FOREIGN KEY (Member_id) REFERENCES Members(Member_id)
  
);

CREATE TABLE membership
(
  Membership_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  Membership_period FLOAT NOT NULL,
  Membership_price FLOAT NOT NULL,
  total_price FLOAT NOT NULL,
  Member_id INT NOT NULL,
  CONSTRAINT membership_PK PRIMARY KEY (Membership_id),
  CONSTRAINT FK_Members_membership FOREIGN KEY (Member_id) REFERENCES Members(Member_id)
);

CREATE TABLE membership_work_staff
(
  Membership_id INT NOT NULL,
  Staff_id INT NOT NULL,
  CONSTRAINT membershipWS_PK PRIMARY KEY (Staff_id,Membership_id),
  CONSTRAINT FK_membership_membershipWS FOREIGN KEY (Membership_id) REFERENCES membership(Membership_id),
  CONSTRAINT FK_staff_membershipWS FOREIGN KEY (Staff_id) REFERENCES staff(Staff_id)
);

CREATE TABLE WorkoutsInMs
(
  Membership_id INT NOT NULL,
  workout_id INT NOT NULL,
  CONSTRAINT workoutInMembership_PK PRIMARY KEY (Membership_id,workout_id),
  CONSTRAINT FK_membership_WorkoutsInMs FOREIGN KEY (Membership_id) REFERENCES membership(Membership_id),
  CONSTRAINT FK_workouts_WorkoutsInMs FOREIGN KEY (workout_id) REFERENCES Workouts(workout_id)
);

CREATE TABLE Membership_Package
(
  period INT NOT NULL,
  Membership_id INT NOT NULL,
  package_id INT NOT NULL,
  Diet_id INT NULL,
  CONSTRAINT MembershipPAC_PK PRIMARY KEY (period,Membership_id,package_id),
  CONSTRAINT FK_membership_MembershipPAC FOREIGN KEY (Membership_id) REFERENCES membership(Membership_id),
  CONSTRAINT FK_package_MembershipPAC FOREIGN KEY (package_id) REFERENCES packages(package_id),
  CONSTRAINT FK_Diet_MembershipPAC FOREIGN KEY (Diet_id) REFERENCES Diet(Diet_id)
);

CREATE TABLE Time_Of_Membership
(
  group_id INT NOT NULL,
  Membership_id INT NOT NULL,
  CONSTRAINT GTmembership_PK PRIMARY KEY (group_id,Membership_id),
  CONSTRAINT FK_groupTime_GTmembership FOREIGN KEY (group_id) REFERENCES group_time(group_id),
  CONSTRAINT FK_membership_GTmembership FOREIGN KEY (Membership_id) REFERENCES membership(Membership_id)
);

CREATE TABLE equipment
(
  equipment_id INT NOT NULL,
  equpment_name VARCHAR(MAX) NOT NULL,
  equipment_price FLOAT NOT NULL,
  equipment_amount INT NOT NULL,
  equipment_description VARCHAR(MAX),
  equipment_total_price FLOAT NOT NULL,
  CONSTRAINT equipment_PK PRIMARY KEY (equipment_id)
);

CREATE TABLE maintenances
(
  maintenances_id INT NOT NULL,
  maintenances_name_id INT NOT NULL,
  maintenances_price FLOAT NOT NULL,
  maintenances_date DATE NOT NULL,
  equipment_id INT NOT NULL,
  amount INT NOT NULL,
  CONSTRAINT maintenances_PK PRIMARY KEY (maintenances_id),
  CONSTRAINT FK_equipment_maintenances FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
  CONSTRAINT FK_MaintenancesName_maintenances FOREIGN KEY (maintenances_name_id) REFERENCES maintenances_name(maintenances_name_id)
);

CREATE TABLE invoice
(
  invoice_id INT NOT NULL,
  invoice_name VARCHAR(MAX) NOT NULL,
  invoice_date DATE NOT NULL,
  invoice_total_price FLOAT NOT NULL,
  reference_invoice_id INT,
  invoice_state_id INT NOT NULL,
  invoce_type_id INT NOT NULL,
  Membership_id INT NULL,
  Staff_id INT NOT NULL,
  maintenances_id INT NULL,
  CONSTRAINT invoice_PK PRIMARY KEY (invoice_id),
  CONSTRAINT FK_state_invoice FOREIGN KEY (invoice_state_id) REFERENCES invoice_state(invoice_state_id),
  CONSTRAINT FK_type_invoice FOREIGN KEY (invoce_type_id) REFERENCES invoice_type(invoce_type_id),
  CONSTRAINT FK_staff_invoice FOREIGN KEY (Staff_id) REFERENCES staff(Staff_id),
  CONSTRAINT FK_Membership_invoice FOREIGN KEY (Membership_id) REFERENCES membership(Membership_id),
  CONSTRAINT FK_maintenances_invoice FOREIGN KEY (maintenances_id) REFERENCES maintenances(maintenances_id),
  CONSTRAINT FK_invoice_invoice FOREIGN KEY (reference_invoice_id) REFERENCES invoice(invoice_id)
);

CREATE TABLE exercises_use_equipment
(
  exercieses_id INT NOT NULL,
  equipment_id INT NOT NULL,
  CONSTRAINT EXEuseEQUI_PK PRIMARY KEY (equipment_id,exercieses_id),
  CONSTRAINT FK_exercises_EXEuseEQUI FOREIGN KEY (exercieses_id) REFERENCES exercieses(exercieses_id),
  CONSTRAINT FK_equipment_EXEuseEQUI FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);
