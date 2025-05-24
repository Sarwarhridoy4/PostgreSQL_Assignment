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
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range'),
(4, 'David Lee', 'Forest Edge'),
(5, 'Emma Stone', 'Wetlands'),
(6, 'Frank Miller', 'Grasslands'),
(7, 'Grace Kim', 'Eastern Plateau'),
(8, 'Henry Ford', 'Southern Valley'),
(9, 'Ivy Chen', 'Highland Forest'),
(10, 'Jack Black', 'Desert Fringe'),
(11, 'Karen Young', 'Coastal Zone'),
(12, 'Liam Scott', 'Central Plains'),
(13, 'Mona Patel', 'Rainforest'),
(14, 'Nate Brooks', 'Western Ridge'),
(15, 'Olivia Reed', 'Lake District'),
(16, 'Paul Adams', 'Pine Woods'),
(17, 'Quinn Davis', 'Rocky Outcrop'),
(18, 'Rita Singh', 'Marshlands');

-- Species
INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
(5, 'Indian Rhinoceros', 'Rhinoceros unicornis', '1758-01-01', 'Vulnerable'),
(6, 'Gharial', 'Gavialis gangeticus', '1827-01-01', 'Endangered'),
(7, 'Great Indian Bustard', 'Ardeotis nigriceps', '1863-01-01', 'Endangered'),
(8, 'Blackbuck', 'Antilope cervicapra', '1758-01-01', 'Vulnerable'),
(9, 'Hoolock Gibbon', 'Hoolock hoolock', '1837-01-01', 'Vulnerable'),
(10, 'Sloth Bear', 'Melursus ursinus', '1791-01-01', 'Vulnerable'),
(11, 'Indian Pangolin', 'Manis crassicaudata', '1822-01-01', 'Endangered'),
(12, 'Sarus Crane', 'Antigone antigone', '1758-01-01', 'Vulnerable'),
(13, 'Lion-tailed Macaque', 'Macaca silenus', '1758-01-01', 'Endangered'),
(14, 'Nilgiri Tahr', 'Nilgiritragus hylocrius', '1838-01-01', 'Endangered'),
(15, 'Olive Ridley Turtle', 'Lepidochelys olivacea', '1829-01-01', 'Vulnerable'),
(16, 'Indian Wolf', 'Canis lupus pallipes', '1832-01-01', 'Endangered'),
(17, 'Barasingha', 'Rucervus duvaucelii', '1823-01-01', 'Vulnerable'),
(18, 'Forest Owlet', 'Heteroglaux blewitti', '1873-01-01', 'Endangered'),
(19, 'Asiatic Lion', 'Panthera leo persica', '1826-01-01', 'Endangered');

-- Sightings
INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
(5, 4, 4, 'Elephant Crossing', '2024-05-20 14:00:00', 'Herd of 5 observed'),
(6, 5, 5, 'Rhino Lake', '2024-05-21 10:15:00', 'Single adult near water'),
(7, 6, 6, 'River Bend', '2024-05-22 11:30:00', 'Basking on sandbank'),
(8, 7, 7, 'Grassland Edge', '2024-05-23 08:50:00', 'Pair seen in flight'),
(9, 8, 8, 'Open Plains', '2024-05-24 17:05:00', 'Grazing herd'),
(10, 9, 9, 'Forest Canopy', '2024-05-25 13:40:00', 'Heard calls, not seen'),
(11, 10, 10, 'Bear Den', '2024-05-26 06:30:00', 'Tracks found'),
(12, 11, 11, 'Hillside', '2024-05-27 15:20:00', 'Burrow entrance spotted'),
(13, 12, 12, 'Wetland Marsh', '2024-05-28 09:55:00', 'Pair with chicks'),
(14, 13, 13, 'Rainforest Trail', '2024-05-29 12:10:00', 'Group of 3 in trees'),
(15, 14, 14, 'Cliffside', '2024-05-30 16:45:00', 'Single adult grazing'),
(16, 15, 15, 'Turtle Beach', '2024-05-31 05:00:00', 'Nesting activity'),
(17, 16, 16, 'Wolf Den', '2024-06-01 19:30:00', 'Howling heard at dusk'),
(18, 17, 17, 'Swamp Edge', '2024-06-02 08:20:00', 'Antlers visible in reeds'),
(19, 18, 18, 'Old Forest', '2024-06-03 07:10:00', 'Rare sighting, photo taken'),
(20, 19, 1, 'Lion Rock', '2024-06-04 18:00:00', 'Pride of 4 observed'),
(21, 2, 2, 'River Delta', '2024-06-05 15:25:00', 'Tracks along riverbank'),
(22, 3, 3, 'Bamboo Grove West', '2024-06-06 10:40:00', 'Feeding on bamboo'),
(23, 4, 4, 'Forest Edge', '2024-06-07 13:15:00', 'Calf with herd'),
(24, 5, 5, 'Lake District', '2024-06-08 11:50:00', 'Rhino wallowing'),
(25, 6, 6, 'River Mouth', '2024-06-09 09:30:00', 'Swimming downstream');

-- End Of Setup Process

--
