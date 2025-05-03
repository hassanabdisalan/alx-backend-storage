-- Creates a stored procedure to compute and store the average weighted score for all students
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_id INT;
    DECLARE cur CURSOR FOR SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO user_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Calculate weighted average for each user
        UPDATE users u
        SET average_score = (
            SELECT IFNULL(SUM(c.score * p.weight) / SUM(p.weight), 0)
            FROM corrections c
            JOIN projects p ON c.project_id = p.id
            WHERE c.user_id = u.id
        )
        WHERE id = user_id;
    END LOOP;
    
    CLOSE cur;
END //
DELIMITER ;
