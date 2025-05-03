-- Creates a stored procedure ComputeAverageScoreForUser that computes
-- and updates the average score for a given user_id in the users table

-- Create the stored procedure
DELIMITER $$

CREATE PROCEDURE ComputeAverageScoreForUser (
    IN p_user_id INT
)
BEGIN
    -- Declare a variable to store the computed average
    DECLARE avg_score FLOAT;

    -- Compute the average score for the specified user from the corrections table
    SELECT AVG(score) INTO avg_score
    FROM corrections
    WHERE user_id = p_user_id;

    -- Update the users table with the computed average
    UPDATE users
    SET average_score = avg_score
    WHERE id = p_user_id;
END$$

DELIMITER ;
