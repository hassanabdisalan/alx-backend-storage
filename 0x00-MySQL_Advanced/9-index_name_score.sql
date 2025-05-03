-- 9. Index by first letter and score
-- This script creates a composite index on the first letter of 'name' and 'score'

CREATE INDEX idx_name_first_score ON names (name(1), score);
