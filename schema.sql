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

-- Create a table named owners
CREATE TABLE owners (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	full_name TEXT,
	age INT
);

-- Create a table named species
CREATE TABLE species (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name TEXT
);

-- Modify animals table
-- Remove column species
ALTER TABLE animals
DROP COLUMN species CASCADE;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id int;

ALTER TABLE animals
ADD FOREIGN KEY (species_id) REFERENCES species(id)
ON DELETE CASCADE;

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id int;

ALTER TABLE animals
ADD FOREIGN KEY (owner_id) REFERENCES owners(id)
ON DELETE CASCADE;

-- Create a table named vets
CREATE TABLE vets (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name TEXT,
	age INT,
	date_of_graduation DATE
);

--  Create a "join table" called specializations
CREATE TABLE specializations (
	id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	species_id INT,
	vets_id INT,
	FOREIGN KEY (species_id) REFERENCES species(id),
	FOREIGN KEY (vets_id) REFERENCES vets(id),
	UNIQUE (species_id, vets_id)
);

--  Create a "join table" called visits
CREATE TABLE visits (
	id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	animal_id INT,
	vet_id INT,
	date_of_visit DATE,
	FOREIGN KEY (animal_id) REFERENCES animals(id),
	FOREIGN KEY (vet_id) REFERENCES vets(id)
);

-- Perfomance audit exercise
-- Create a non clustered index for animal id on  visits table
CREATE INDEX animal_id_asc ON visits(animal_id ASC);

-- Create a non clustered index for vet id on visits table
CREATE INDEX vet_id_asc ON visits(vet_id ASC);

-- Create a non clustered index for email on owners table
CREATE INDEX vet_id_desc ON owners(email DESC);