-- 8. Index my names
-- This script creates an index on the first letter of the 'name' column in the 'names' table

CREATE INDEX idx_name_first ON names (name(1));
