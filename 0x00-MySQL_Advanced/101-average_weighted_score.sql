-- 101. Create the stored procedure 'ComputeAverageWeightedScoreForUsers'

DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE user_id INT;
    DECLARE weighted_sum FLOAT;
    DECLARE total_weight INT;
    DECLARE project_weight INT;
    DECLARE project_score FLOAT;

    -- Declare a cursor to fetch all user IDs
    DECLARE user_cursor CURSOR FOR
        SELECT id FROM users;

    -- Declare the CONTINUE HANDLER for when the cursor reaches the end
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor to fetch users
    OPEN user_cursor;

    -- Loop through each user
    user_loop: LOOP
        FETCH user_cursor INTO user_id;
        IF done THEN
            LEAVE user_loop;
        END IF;

        -- Initialize the weighted sum and total weight for the user
        SET weighted_sum = 0;
        SET total_weight = 0;

        -- Cursor to calculate the weighted sum and total weight for the current user
        DECLARE project_cursor CURSOR FOR
            SELECT p.weight, c.score
            FROM corrections c
            JOIN projects p ON c.project_id = p.id
            WHERE c.user_id = user_id;

        -- Open the project cursor
        OPEN project_cursor;

        -- Calculate the weighted sum and total weight for the user
        project_loop: LOOP
            FETCH project_cursor INTO project_weight, project_score;
            IF done THEN
                LEAVE project_loop;
            END IF;
            SET weighted_sum = weighted_sum + (project_score * project_weight);
            SET total_weight = total_weight + project_weight;
        END LOOP;

        -- Close the project cursor
        CLOSE project_cursor;

        -- Calculate the weighted average and update the user's average_score
        IF total_weight > 0 THEN
            UPDATE users SET average_score = weighted_sum / total_weight WHERE id = user_id;
        ELSE
            UPDATE users SET average_score = 0 WHERE id = user_id;
        END IF;

        -- Reset the done flag for the user cursor
        SET done = 0;
    END LOOP;

    -- Close the user cursor
    CLOSE user_cursor;
END $$

DELIMITER ;
