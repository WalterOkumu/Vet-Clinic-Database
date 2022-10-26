/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	id INT GENERATED ALWAYS AS IDENTITY,
	name TEXT,
	date_of_birth  DATE NOT NULL DEFAULT CURRENT_DATE,
	escape_attempts INT,
	neutered BOOLEAN NOT NULL,
	weight_kg NUMERIC(5,2)
);

ALTER TABLE animals ADD COLUMN species TEXT;
