-- Creates a stored procedure AddBonus that adds a new correction score for a project
-- and creates the project if it does not already exist

DELIMITER $$

CREATE PROCEDURE AddBonus (
    IN p_user_id INT,
    IN p_project_name VARCHAR(255),
    IN p_score INT
)
BEGIN
    DECLARE projectId INT DEFAULT NULL;

    -- Handle the case where the project does not exist (no row found)
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET projectId = NULL;

    -- Try to get the project ID
    SELECT id INTO projectId
    FROM projects
    WHERE name = p_project_name
    LIMIT 1;

    -- If the project does not exist, insert it
    IF projectId IS NULL THEN
        INSERT INTO projects (name)
        VALUES (p_project_name);
        SET projectId = LAST_INSERT_ID();
    END IF;

    -- Insert the correction score
    INSERT INTO corrections (user_id, project_id, score)
    VALUES (p_user_id, projectId, p_score);
END$$

DELIMITER ;
