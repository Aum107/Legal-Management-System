-- 1. User credentials
INSERT INTO "User" (User_ID, Password)
VALUES ('IL00100001', 'Pw12!abc');

-- 2. Lawyer profile linked to the user above
INSERT INTO "Lawyer" (ID, Email_ID, Name, Education, Salary, License_Year, Experience)
VALUES ('IL00100001', 'arya.il@example.com', 'Arya Mehta', 'LLB', 150000, 2014, 11);

-- 3. Client login
INSERT INTO "User" (User_ID, Password)
VALUES ('CL00100002', 'Cl34@xyz');

-- 4. Client details
INSERT INTO "Client" (ID, Name, Client_Details)
VALUES ('CL00100002', 'Rohan Sharma', 'Individual client—Mumbai');

-- 5. Judge account + profile
INSERT INTO "User" (User_ID, Password)
VALUES ('JU00100003', 'Ju56#def');

INSERT INTO "Judge" (JudgeID, Name, Experience, Salary, LicenseYear, Education)
VALUES ('JU00100003', 'Justice Kavita Rao', 22, 220000, 1999, 'LLM');

-- 6. Civil case shell
INSERT INTO "Case" (Case_ID, Case_Status, Judge_ID, Defendant_ID, Accuser_ID)
VALUES ('CASE0001', 'Not_Started', 'JU00100003', 'CL00100002', 'CL00100002');

INSERT INTO "Case_Type" (Case_ID, Case_Type)
VALUES ('CASE0001', 'Civil');

-- 7. Expertise tag for the lawyer
INSERT INTO "Lawyer_Area_Of_Expertise"
