-- Creates a stored procedure to compute and store the average weighted score for a student
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_weighted_score FLOAT;
    DECLARE total_weight INT;
    
    -- Calculate the sum of (score * weight) for all projects by the user
    SELECT SUM(c.score * p.weight) INTO total_weighted_score
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;
    
    -- Calculate the sum of all weights for the user's projects
    SELECT SUM(p.weight) INTO total_weight
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;
    
    -- Update the user's average_score with the weighted average
    UPDATE users
    SET average_score = IFNULL(total_weighted_score / total_weight, 0)
    WHERE id = user_id;
END //
DELIMITER ;
