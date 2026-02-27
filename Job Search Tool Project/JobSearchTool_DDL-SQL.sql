DROP TABLE IF EXISTS Job_listing;
create table Job_listing(
JobID varchar(40) NOT NULL PRIMARY KEY,
Company_Name varchar(60) NOT NULL,
Job_Title varchar(40),
Location varchar(60),
Salary Integer);

DROP TABLE IF EXISTS Website;
create table Website(
WebsiteID varchar(40) NOT NULL PRIMARY KEY,
JobID varchar(40) NOT NULL, 
Foreign Key (JobID) References Job_listing(JobID),
WebsiteName Varchar(40));

DROP TABLE IF EXISTS applicants;
create table Applicants(
JobID varchar(40) NOT NULL, 
Foreign Key (JobID) References Job_listing(JobID),
NumberOfApplicants Integer);

DROP TABLE IF EXISTS employer;
create table Employer(
EmployerID varchar(40) not null Primary key,
EmployerName varchar(40),
EmployerLocation varchar(40));

DROP TABLE IF EXISTS JobPosts;
create table JobPosts(
JobID varchar(40) NOT NULL, 
Foreign Key (JobID) References Job_listing(JobID),
EmployerID varchar(40) NOT NULL,
foreign key (EmployerID) References Employer(EmployerID));

DROP TABLE IF EXISTS User;
create table User(
UserID varchar(40) NOT NULL Primary key,
UserName varchar(40) NOT NULL,
UserLocation varchar(40),
UserExperiance Varchar(40));

DROP TABLE IF EXISTS appliesforjob;
create table AppliesForJob(
primary key (JobID, UserID),
JobID varchar(40) NOT NULL, 
Foreign Key (JobID) References Job_listing(JobID),
UserID varchar(40) NOT NULL,
foreign key (UserID) References User(UserID));

DROP TABLE IF EXISTS Role;
create table Role(
RoleID varchar(40) NOT NULL PRIMARY KEY,
UserID varchar(40) NOT NULL, 
Foreign Key (UserID) References User(UserID),
RoleName varchar(40) NOT NULL);

DROP TABLE IF EXISTS Account;
create table Account(
AccountID varchar(60) NOT NULL PRIMARY KEY);

DROP TABLE IF EXISTS PersonalAccount;
create table PersonalAccount(
PersonalActID varchar(60) NOT NULL PRIMARY KEY,
Foreign Key (PersonalActID) References Account(AccountID),
UserID varchar(40) NOT NULL,
Foreign Key (UserID) References User(UserID),
SubscriptionFee Integer,
SubscriptionDuration Integer);

DROP TABLE IF EXISTS BusinessAccount;
create table BusinessAccount(
BusinessActID varchar(60) NOT NULL PRIMARY KEY,
Foreign Key (BusinessActID) References Account(AccountID),
EmployerID varchar(40) NOT NULL,
Foreign Key (EmployerID) References Employer(EmployerID),
SubscriptionFee Integer,
SubscriptionDuration Integer);

