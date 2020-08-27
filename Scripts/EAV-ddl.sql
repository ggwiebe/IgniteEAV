DROP TABLE Entity
;
CREATE TABLE Entity (
	Name VARCHAR(128),
	Description VARCHAR(1024),
	Ontology VARCHAR(1024),
    PRIMARY KEY (Name)
)
;

INSERT INTO Entity (Name, Description, Ontology) VALUES 
 ('Top','A type of Organization that is in commercial operation', '/')
,('Organization','A grouping type', '/TOP')
,('Person','A general person', '/TOP')
,('Company','A type of Organization that is in commercial operation', '/TOP/Organization')
,('Team','A type of Organization that performs activities together', '/TOP/Organization')
,('Employee','A type of person that is employed by Companies', '/TOP/Person')
,('Contractor','A type of person that performs work for consideration by Companies', '/TOP/Person')
,('Customer','A type of person that buys products or services from Companies', '/TOP/Person')
;

DROP TABLE Attribute
;
CREATE TABLE Attribute (
	Name VARCHAR(128),
	DataType VARCHAR(128),
	Description VARCHAR(1024),
    PRIMARY KEY (Name)
)
;

INSERT INTO Attribute (Name, DataType, Description) VALUES 
 ('CompanyID',  'VARCHAR', 'The identifier for a company')
,('EmployeeID', 'VARCHAR', 'The identifier for an employee')
,('ExitDate',   'DATE', 'The last date of employment')
,('FirstName',  'VARCHAR', 'The first name in a compound name')
,('Fullname',   'VARCHAR', 'The full name in one field')
,('HireDate',   'DATE', 'A Date for the commencement of employment')
,('LastName',   'VARCHAR', 'The last name in a compound name')
,('Role',       'VARCHAR', 'The role performed by the entity in question')
,('Segment',    'VARCHAR', 'A area or category of operation (e.g. Company segmentation, Market segment)')
,('UpdateDate', 'DATE', 'Date of an update to information')
,('UpdateDT',   'TIMESTAMP', 'Date/Time of an update to information')
;

DROP TABLE EntityAttribute
;
CREATE TABLE EntityAttribute (
	Entity VARCHAR(128),
	Attr VARCHAR(128),
	Sequence DECIMAL(5.3),
    PRIMARY KEY (Entity, Attr)
)
;

INSERT INTO EntityAttribute (Entity ,Attr, Sequence) VALUES 
('Company','CompanyID',1)
,('Company','Fullname',2)
,('Company','Segment',3)
,('Employee','EmployeeID',1)
,('Employee','Fullname',2)
,('Employee','HireDate',3)
,('Employee','Role',4)
;

DROP TABLE Value
;
CREATE TABLE Value (
	Entity VARCHAR(128) NOT NULL, 
	ID integer NOT NULL,
	Attr VARCHAR(128),
	Val VARCHAR(65000),
    PRIMARY KEY (Entity,ID,Attr)
)
;

INSERT INTO Value (ID, Entity, Attr, Val) VALUES 
 (1, 'Employee', 'EmployeeID', '10121')
,(1, 'Employee', 'Fullname', 'Glenn Wiebe')
,(1, 'Employee', 'HireDate', '2018-01-01')
,(1, 'Employee', 'Role', 'Solution Architect')
,(2, 'Employee', 'EmployeeID', '9948')
,(2, 'Employee', 'Fullname', 'Alexey Kushkal')
,(2, 'Employee', 'HireDate', '2017-06-30')
,(2, 'Employee', 'Role', 'Senior Consultant')
,(3, 'Employee', 'EmployeeID', '11232')
,(3, 'Employee', 'Fullname', 'Rohit Dharampal')
,(3, 'Employee', 'HireDate', '2019-02-28')
,(3, 'Employee', 'Role', 'Consultant')
,(1, 'Company',  'Fullname', 'GridGain Systems, Inc.')
,(1, 'Company',  'CompanyID', '1001')
,(1, 'Company',  'Segment', 'Software')
,(2, 'Company',  'Fullname', 'Hatch Engineering')
,(2, 'Company',  'CompanyID', '1002')
,(2, 'Company',  'Segment', 'Engineering')
;

SELECT * FROM Value
;

-- Employee Query
SELECT DISTINCT ID "EmployeeID",
	  (SELECT Val 
	     FROM Value i
	    WHERE Attr = 'EmployeeID'
	      AND i.ID = o.ID AND i.Entity = o.Entity) "EmployeeID",
	  (SELECT Val
	     FROM Value i
	    WHERE Attr = 'Fullname'
	      AND i.ID = o.ID AND i.Entity = o.Entity) "Fullname",
	  (SELECT STR_TO_DATE(Val,'%Y-%m-%d')
	     FROM Value i
	    WHERE Attr = 'HireDate'
	      AND i.ID = o.ID AND i.Entity = o.Entity) "HireDate",
	  (SELECT Val
	     FROM Value i
	    WHERE Attr = 'Role'
	      AND i.ID = o.ID AND i.Entity = o.Entity) "Role"
  FROM Value o
 WHERE Entity = 'Employee'
;

-- Company Query
SELECT DISTINCT ID "CompanyID",
	  (SELECT Val 
	     FROM Value i
	    WHERE Attr = 'CompanyID'
	      AND i.ID = o.ID AND i.Entity = o.Entity) "CompanyID",
	  (SELECT Val
	     FROM Value i
	    WHERE Attr = 'Fullname'
	      AND i.ID = o.ID AND i.Entity = o.Entity) "Fullname",
	  (SELECT Val
	     FROM Value i
	    WHERE Attr = 'Segment'
	      AND i.ID = o.ID AND i.Entity = o.Entity) "Segment"
  FROM Value o
 WHERE Entity = 'Company'
;
