CREATE TABLE Diet
(
  Diet_id INT NOT NULL,
  Diet_name VARCHAR(30) NOT NULL,
  Diet_time_period VARCHAR(30) NOT NULL,
  Diet_description VARCHAR(500),
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
  group_name VARCHAR(50) NOT NULL,
  number_member INT NOT NULL,
  schedule VARCHAR(50) NOT NULL,
  Start_time FLOAT NOT NULL,
  end_time FLOAT NOT NULL,
  CONSTRAINT Group_PK PRIMARY KEY (group_id)
);

CREATE TABLE maintenances_name
(
  maintenances_name_id INT NOT NULL,
  maintenances_name VARCHAR(50) NOT NULL,
  CONSTRAINT maintenances_name_PK PRIMARY KEY (maintenances_name_id)
);

CREATE TABLE invoice_state
(
  invoice_state_id INT NOT NULL,
  invoice_state VARCHAR(50) NOT NULL,
  CONSTRAINT state_PK PRIMARY KEY (invoice_state_id)
);

CREATE TABLE invoice_type
(
  invoce_type_id INT NOT NULL,
  invoice_type VARCHAR(50) NOT NULL,
  CONSTRAINT type_PK PRIMARY KEY (invoce_type_id)
);

CREATE TABLE Progress_Level
(
  level_id INT NOT NULL,
  level_name VARCHAR(100) NOT NULL,
  CONSTRAINT Level_PK PRIMARY KEY (level_id)
);

CREATE TABLE packages
(
  package_id INT NOT NULL,
  package_name VARCHAR(30) NOT NULL,
  workout_number INT NOT NULL,
  gifts VARCHAR(100),
  Number_of_invitation INT,
  Diet_id INT NULL,
  Discound INT NOT NULL,
  CONSTRAINT Packages_PK PRIMARY KEY (package_id),
  CONSTRAINT FK_Diet_packages FOREIGN KEY(Diet_id)REFERENCES Diet(Diet_id)
);

CREATE TABLE users
(
  Register_id INT NOT NULL,
  Name VARCHAR(100) NOT NULL,
  User_ssn VARCHAR(50) NOT NULL,
  User_name VARCHAR(100),
  User_gender VARCHAR(30) NOT NULL,
  User_birthday DATE NOT NULL,
  Password VARCHAR(20),
  User_address VARCHAR(50) NOT NULL,
  User_Phone1 VARCHAR(20) NOT NULL,
  User_Phone2 VARCHAR(20),
  User_Code VARCHAR(50)NOT NULL,
  CONSTRAINT users_PK PRIMARY KEY (Register_id),
  CONSTRAINT ssn_UK UNIQUE (User_ssn)
);

CREATE TABLE Workouts
(
  workout_id INT NOT NULL,
  workouts_name VARCHAR(30) NOT NULL,
  workouts_price FLOAT NOT NULL,
  workouts_description VARCHAR(500),
  CONSTRAINT Workouts_PK PRIMARY KEY (workout_id)
);

CREATE TABLE exercieses
(
  exercieses_id INT NOT NULL,
  exercieses_name VARCHAR(50) NOT NULL,
  exercieses_time FLOAT,
  exercieses_counter INT,
  exercieses_video_link VARCHAR(100) NOT NULL,
  exercieses_describtion VARCHAR(500),
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
CREATE TABLE RoleST
(
  Role_id INT NOT NULL,
  Role_Name VARCHAR(20) NOT NULL,
  CONSTRAINT Role_PK PRIMARY KEY (Role_id)
);
CREATE TABLE staff
(
  Staff_id INT NOT NULL,
  Work_shift VARCHAR(20) NOT NULL,
  manage_id INT,
  Register_id INT NOT NULL,
  Role_id INT NOT NULL,
  CONSTRAINT staff_PK PRIMARY KEY (Staff_id),
  CONSTRAINT FK_user_staff FOREIGN KEY (Register_id) REFERENCES users(Register_id),
  CONSTRAINT FK_staff_staff FOREIGN KEY (manage_id) REFERENCES staff(Staff_id),
  CONSTRAINT FK_RoleST_staff FOREIGN KEY (Role_id) REFERENCES RoleST(Role_id)
);


CREATE TABLE staff_Salary
(
  Staff_id INT NOT NULL,
  staff_Salary FLOAT NOT NULL,
  Salary_Date DATE NOT NULL,
  CONSTRAINT StaffSalary_PK PRIMARY KEY (Staff_id,Salary_Date),
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
  package_id INT NULL,
  CONSTRAINT membership_PK PRIMARY KEY (Membership_id),
  CONSTRAINT FK_Members_membership FOREIGN KEY (Member_id) REFERENCES Members(Member_id),
  CONSTRAINT FK_packages_membership FOREIGN KEY (package_id) REFERENCES packages(package_id)
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
  equpment_name VARCHAR(50) NOT NULL,
  equipment_price FLOAT NOT NULL,
  equipment_amount INT NOT NULL,
  equipment_description VARCHAR(500),
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
  CONSTRAINT FK_equipment_mnt FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
  CONSTRAINT FK_MntName_mnt FOREIGN KEY (maintenances_name_id) REFERENCES maintenances_name(maintenances_name_id)
);

CREATE TABLE invoice
(
  invoice_id INT NOT NULL,
  invoice_name VARCHAR(50) NOT NULL,
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


CREATE TABLE Permission
(
  permission_id INT NOT NULL,
  permission_Name VARCHAR(50) NOT NULL,
  CONSTRAINT Permission_PK PRIMARY KEY (permission_id)
);

CREATE TABLE Staff_has_Permission
(
  permission_id INT NOT NULL,
  Staff_id INT NOT NULL,
  CONSTRAINT StaffhP_PK PRIMARY KEY (permission_id,Staff_id),
  CONSTRAINT FK_Permission_StaffhP FOREIGN KEY (Permission_id) REFERENCES Permission(Permission_id),
  CONSTRAINT FK_Staff_StaffhP FOREIGN KEY(Staff_id) REFERENCES Staff(Staff_id)
);
