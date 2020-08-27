 SELECT *
   FROM VALUE
 ;

------------------------------------------------
-- FLATTEN EAV to Entity-centric tabular result
------------------------------------------------

-- A) Sub-query based approach
------------------------------------------------

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
 	  (SELECT PARSEDATETIME(Val, 'yyyy-dd-MM')
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

-- JOIN-based approach
------------------------------------------------
SELECT
		Customer_Entity.ID
		, p1.VAL AS Fullname
		, p2.VAL AS HireDAte
		, p3.VAL AS [Role]
		, p4.VAL AS EmployeeID
FROM ( SELECT ID
		 FROM VALUE
		GROUP BY ID ) AS Customer_Entity
JOIN VALUE AS p1
  ON Customer_Entity.ID = p1.ID AND p1.ATTR = "Fullname"
JOIN Value AS p2
  ON Customer_Entity.ID = p2.ID AND p2.ATTR = "HireDate"
JOIN Value AS p3
  ON Customer_Entity.ID = p3.ID AND p3.ATTR = "Role"
JOIN Value AS p4
  ON Customer_Entity.ID = p4.ID AND p4.ATTR = "EmployeeID"
;

--Employee
SELECT Customer_Entity.ID,
       P1.VAL AS Fullname,
       P2.VAL AS HireDate,
       P3.VAL AS Role,
       P4.VAL AS EmployeeID
  FROM ( SELECT ID
	      FROM VALUE
	     WHERE Entity = 'Employee'
         GROUP BY ID ) AS Customer_Entity
JOIN VALUE AS p1
  ON Customer_Entity.ID = p1.ID AND p1.Entity = 'Employee' AND p1.ATTR = 'Fullname'
JOIN Value AS p2
  ON Customer_Entity.ID = p2.ID AND p2.Entity = 'Employee' AND p2.ATTR = 'HireDate'
JOIN Value AS p3
  ON Customer_Entity.ID = p3.ID AND p3.Entity = 'Employee' AND p3.ATTR = 'Role'
JOIN Value AS p4
  ON Customer_Entity.ID = p4.ID AND p4.Entity = 'Employee' AND p4.ATTR = 'EmployeeID'
;

--Company
SELECT Company_Entity.ID,
       P1.VAL AS CompanyID,
       P2.VAL AS Fullname,
       P3.VAL AS Segment
  FROM ( SELECT ID
	      FROM VALUE
	     WHERE Entity = 'Employee'
         GROUP BY ID ) AS Company_Entity
JOIN VALUE AS p1
  ON Company_Entity.ID = p1.ID AND p2.Entity = 'Company' AND p1.ATTR = 'CompanyID'
JOIN Value AS p2
  ON Company_Entity.ID = p2.ID AND p1.Entity = 'Company' AND p2.ATTR = 'Fullname'
JOIN Value AS p3
  ON Company_Entity.ID = p3.ID AND p3.Entity = 'Company' AND p3.ATTR = 'Segment'
;
