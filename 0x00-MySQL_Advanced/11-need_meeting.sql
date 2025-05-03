-- 11. Create the view 'need_meeting' that lists all students with a score under 80
-- and no last meeting or more than 1 month ago.

DELIMITER $$

CREATE VIEW need_meeting AS
SELECT name
FROM students
WHERE score < 80
AND (last_meeting IS NULL OR last_meeting <= CURDATE() - INTERVAL 1 MONTH);

DELIMITER ;
