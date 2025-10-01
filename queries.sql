-- 1. Lawyer who is handling the most cases
SELECT L.Name,
       COUNT(*) AS CaseCount
FROM   Lawyer L
JOIN   "Case" C
       ON L.ID IN (C.DefendingLawyerID, C.ProsecutingLawyerID)
GROUP  BY L.Name
ORDER  BY CaseCount DESC
LIMIT  1;


-- 2. Distinct clients represented by a specific lawyer
SELECT DISTINCT CL.Name
FROM   Client CL
JOIN   "Case" C
       ON CL.ID IN (C.DefendantID, C.AccuserID)
JOIN   Lawyer L
       ON L.ID IN (C.DefendingLawyerID, C.ProsecutingLawyerID)
WHERE  L.Name = 'Arya Mehta';


-- 3. Licence-request queries accepted by the Advocacy department
SELECT LRQ.QueryFromID,
       LRQ.Name,
       LRQ.CLATScore
FROM   LicenseRequestQueries LRQ
JOIN   BarCouncil BC
       ON LRQ.QueryHandlerID = BC.ID
WHERE  BC.Name      = 'Advocacy Dept'
  AND  LRQ.QueryStatus = 'Accepted';


-- 4. Case volume per type (civil, criminal, family, etc.)
SELECT CT.CaseType,
       COUNT(*) AS NumCases
FROM   CaseType CT
GROUP  BY CT.CaseType
ORDER  BY NumCases DESC;


-- 5. Top five firms with the highest expenditure
SELECT FirmName,
       Expenditure
FROM   Firm
ORDER  BY Expenditure DESC
LIMIT  5;


-- 6. Civil-law specialists who have fewer than five ongoing cases
SELECT L.Name,
       COUNT(C.CaseID) AS OngoingCases
FROM   Lawyer L
JOIN   LawyerAreaOfExpertise LE
       ON L.ID = LE.ID
LEFT JOIN "Case" C
       ON L.ID IN (C.DefendingLawyerID, C.ProsecutingLawyerID)
      AND C.CaseStatus = 'Ongoing'
WHERE  LE.AreaOfExpertise = 'Civil'
GROUP  BY L.Name
HAVING COUNT(C.CaseID) < 5;


-- 7. Ongoing 2025 cases presided over by Justice Kavita Rao
SELECT C.CaseID,
       C.CaseStatus
FROM   "Case" C
JOIN   Judge J
       ON C.JudgeID = J.JudgeID
WHERE  J.Name              = 'Justice Kavita Rao'
  AND  C.CaseStatus         = 'Ongoing'
  AND  EXTRACT(YEAR FROM C.CaseDetailsDate) = 2025;


-- 8. Clients involved in more than one active matter
SELECT CL.Name,
       COUNT(C.CaseID) AS ActiveCases
FROM   Client CL
JOIN   "Case" C
       ON CL.ID IN (C.DefendantID, C.AccuserID)
WHERE  C.CaseStatus IN ('Not_Started', 'Ongoing')
GROUP  BY CL.Name
HAVING COUNT(*) > 1;


-- 9. Progress overdue cases from 'Not_Started' to 'Ongoing'
UPDATE "Case"
SET    CaseStatus = 'Ongoing'
WHERE  CaseStatus    = 'Not_Started'
  AND  CaseStartDate <= CURRENT_DATE;


-- 10. Delete completed tasks older than 60 days
DELETE
FROM   Task
WHERE  TaskStatus        = 'TaskCompleted'
  AND  TaskCompletionDate <= CURRENT_DATE - INTERVAL '60 day';
