-- 100. Create the stored procedure 'ComputeAverageWeightedScoreForUser'

DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE weighted_sum FLOAT DEFAULT 0;
    DECLARE total_weight INT DEFAULT 0;
    DECLARE project_weight INT;
    DECLARE project_score FLOAT;

    -- Cursor to calculate the weighted sum and total weight for the user
    DECLARE project_cursor CURSOR FOR 
    SELECT p.weight, c.score
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;

    -- Open the cursor
    OPEN project_cursor;

    -- Fetch values from cursor and compute weighted sum and total weight
    read_loop: LOOP
        FETCH project_cursor INTO project_weight, project_score;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET weighted_sum = weighted_sum + (project_score * project_weight);
        SET total_weight = total_weight + project_weight;
    END LOOP;

    -- Close the cursor
    CLOSE project_cursor;

    -- Calculate the weighted average and update the user's average_score
    IF total_weight > 0 THEN
        UPDATE users SET average_score = weighted_sum / total_weight WHERE id = user_id;
    ELSE
        UPDATE users SET average_score = 0 WHERE id = user_id;
    END IF;
END $$

DELIMITER ;
