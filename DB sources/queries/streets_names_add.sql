CREATE TABLE IF NOT EXISTS streets_names
(
  modern_name text,
  old_name text,
  both_names text
);
COPY streets_names FROM '/absolut/path/to/streets_names.csv' DELIMITER ',' HEADER CSV;