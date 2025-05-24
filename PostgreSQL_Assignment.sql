-- Active: 1747456671913@@127.0.0.1@5432@conservation_db
-- Objectives : Wildlife Conservation Monitoring

-- Start of Setup Process
-- This script sets up a PostgreSQL database for monitoring wildlife conservation efforts.
-- It creates a database, defines the necessary tables, and populates them with sample data.
-- Database: conservation_db



-- Step 1: Create the database
CREATE DATABASE conservation_db;

-- Connect to the newly created database
\c conservation_db; -- This command is used in psql to connect to the database interactively.


-- Step 2.5 Delete existing tables if they exist

DROP TABLE IF EXISTS sightings;
DROP TABLE IF EXISTS rangers;
DROP TABLE IF EXISTS species;

-- Step 3: Create the tables

-- Table: rangers
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    region TEXT NOT NULL
);

-- Table: species
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name TEXT NOT NULL,
    scientific_name TEXT NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status TEXT NOT NULL CHECK (conservation_status IN ('Endangered', 'Vulnerable', 'Historic'))
);

-- Table: sightings
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INT REFERENCES species(species_id) ON DELETE CASCADE,
    ranger_id INT REFERENCES rangers(ranger_id) ON DELETE CASCADE,
    sighting_time TIMESTAMP NOT NULL,
    location TEXT NOT NULL,
    notes TEXT
);


-- Step 4: Insert sample data into the tables

INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Arjun Das', 'North Valley'),
(2, 'Meera Sen', 'South Ridge'),
(3, 'Kabir Khan', 'Eastern Hills'),
(4, 'Sneha Verma', 'Western Plateau'),
(5, 'Leela Bose', 'Central Forest');



-- Species
-- Common names, scientific names, discovery dates, and conservation statuses
INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Lion', 'Panthera leo persica', '1826-03-12', 'Endangered'),
(5, 'Great Indian Bustard', 'Ardeotis nigriceps', '1861-11-09', 'Vulnerable'),
(6, 'Woolly Mammoth', 'Mammuthus primigenius', '1799-06-15', 'Historic'),
(7, 'Dodo', 'Raphus cucullatus', '1598-01-01', 'Historic');


-- Sightings
INSERT INTO sightings (sighting_id, species_id, ranger_id, sighting_time, location, notes) VALUES
(1, 1, 1, '2024-05-10 07:45:00', 'North Ridge Pass', 'Camera trap capture'),
(2, 2, 2, '2024-05-12 16:20:00', 'South Creek', 'Tiger crossing spotted'),
(3, 3, 3, '2024-05-13 10:00:00', 'Bamboo Grove', 'Feeding behavior'),
(4, 4, 4, '2024-05-14 14:15:00', 'Plateau Edge', 'Tracks found near water'),
(5, 5, 5, '2024-05-15 08:00:00', 'Central Plains', 'Flock in flight'),
(6, 6, 1, '2024-05-16 13:00:00', 'Fossil Site A', 'Woolly Mammoth remains'),
(7, 7, 2, '2024-05-17 09:30:00', 'Historic Zone', 'Dodo statue and artifacts');



-- End Of Setup Process

--
-- Solve problems using SQL queries

-- Problem 1: Register a new ranger

-- Check ranger table to ensure it exists
SELECT * FROM rangers;

INSERT INTO rangers (ranger_id, name, region)
VALUES (6,'Derek Fox', 'Coastal Plains');

-- Problem 1: Register a new ranger
-- Expected: AffectedRows: 1
INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2: Count unique species ever sighted
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- Problem 3: Find all sightings where the location includes "Pass"
SELECT *
FROM sightings
WHERE location ILIKE '%Pass%';

