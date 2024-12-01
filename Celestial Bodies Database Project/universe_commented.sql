--DROP TABLE galaxy; -- Remove table to create a new modified one

CREATE TABLE galaxy (
	galaxy_id SERIAL PRIMARY KEY, -- SERIAL (PostgreSQL) == INT AUTO_INCREMENT
	name VARCHAR(100) NOT NULL UNIQUE,
	galaxy_type VARCHAR(50) NOT NULL,
	number_of_planetary_systems INT,
	has_active_star_formation BOOLEAN DEFAULT TRUE
);

INSERT INTO galaxy(name, galaxy_type, number_of_planetary_systems, has_active_star_formation)
VALUES
	('Milky Way', 'Spiral', 250000000, TRUE),
	('Messier 87', 'Elliptical', 1000000000, TRUE),
	('Spindle', 'Lenticular', 500000, FALSE),
	('Andromeda', 'Spiral', 100000000, TRUE),
	('Triangulum', 'Spiral', 40000000, TRUE),
	('Sombrero', 'Spiral', 800000000, FALSE);

-- View the table
SELECT * FROM galaxy;

--DROP TABLE star;

CREATE TABLE star (
	star_id SERIAL PRIMARY KEY,
	galaxy_id INT REFERENCES galaxy(galaxy_id),
	name VARCHAR(100) NOT NULL UNIQUE,
	star_type VARCHAR(50) NOT NULL,
	mass_in_solar_masses NUMERIC(10, 3),
	age_in_millions_of_years INT
);

INSERT INTO star(name, galaxy_id, star_type, mass_in_solar_masses, age_in_millions_of_years)
VALUES
	('Sun', 1, 'Yellow Dwarf', 1.000, 4600),
	('Sirius A', 1, 'White Star', 2.02, 242),
	('Betelgeuse', 1, 'Red Giant', 17.75, 10),
	('Proxima Centauri', 1, 'Red Dwarf', 0.122, 4850),
	('Rigel', 1, 'Blue Supergiant', 21, 8),
	('Vega', 1, 'White Star', 2.135, 455);

SELECT * FROM star;

--DROP TABLE planet;

CREATE TABLE planet (
	planet_id SERIAL PRIMARY KEY,
	star_id INT REFERENCES star(star_id) NOT NULL,
	name VARCHAR(50) NOT NULL UNIQUE,
	description TEXT,
	has_known_life BOOLEAN DEFAULT FALSE
);

INSERT INTO planet(star_id, name, description)
VALUES
	(1, 'Earth', 'The third planet from the Sun, and the only astronomical object known to harbor life.'),
	(1, 'Mars', 'The fourth planet from the Sun, known for its red appearance and potential for past life.'),
	(1, 'Jupiter', 'The largest planet in the Solar System, a gas giant with many moons.'),
	(1, 'Saturn', 'Known for its prominent ring system, the second-largest planet in the Solar System.'),
	(1, 'Uranus', 'An ice giant with a unique tilt, resulting in extreme seasons.'),
	(1, 'Neptune', 'An ice giant known for its strong winds and deep blue color.'),
	(1, 'Pluto', 'A dwarf planet in the Kuiper belt, known for its moon Charon.'),
	(1, 'Haumea', 'A dwarf planet with a unique elongated shape and two moons.'),
	(4, 'Proxima Centauri b', 'An Earth-sized exoplanet in the habitable zone of Proxima Centauri.'),
	(4, 'Proxima Centauri c', 'A super-Earth orbiting Proxima Centauri.'),
	(6, 'Vega b', 'A candidate exoplanet orbiting Vega.'),
	(2, 'Sirius A b', 'A hypothetical exoplanet orbiting Sirius A.');

UPDATE planet SET has_known_life = TRUE WHERE name = 'Earth';

SELECT * FROM planet;

CREATE TABLE moon (
	moon_id SERIAL PRIMARY KEY,
	planet_id INT REFERENCES planet(planet_id),
	name VARCHAR(50) NOT NULL UNIQUE,
	distance_from_earth_in_millions_of_km NUMERIC(10, 4) NOT NULL,
	orbital_period_in_days NUMERIC(10, 3) NOT NULL
);

INSERT INTO moon (planet_id, name, distance_from_earth_in_millions_of_km, orbital_period_in_days)
VALUES
    -- Earth
    (1, 'Moon', 0.38400, 27.3),
    -- Mars
    (2, 'Phobos', 225.0, 0.318),
    (2, 'Deimos', 225.0, 1.263),
    -- Jupiter
    (3, 'Io', 628.4, 1.769),
    (3, 'Europa', 628.7, 3.551),
    (3, 'Ganymede', 629.0, 7.154),
    (3, 'Callisto', 629.9, 16.689),
    -- Saturn
    (4, 'Titan', 1276.2, 15.945),
    (4, 'Rhea', 1275.5, 4.518),
    (4, 'Iapetus', 1278.6, 79.321),
    (4, 'Dione', 1275.7, 2.737),
    (4, 'Tethys', 1275.9, 1.888),
    (4, 'Enceladus', 1275.2, 1.370),
    -- Uranus
    (5, 'Titania', 2723.4, 8.706),
    (5, 'Oberon', 2723.6, 13.463),
    (5, 'Umbriel', 2723.3, 4.144),
    (5, 'Ariel', 2723.2, 2.520),
    (5, 'Miranda', 2723.1, 1.413),
    -- Neptune
    (6, 'Triton', 4352.0, 5.876),
    -- Pluto
    (7, 'Charon', 5906.2, 6.387),
    -- Haumea
    (8, 'Namaka', 5906.0, 5.45),
    (8, 'Hiʻiaka', 5906.0, 6.38);

SELECT * FROM moon;

CREATE TABLE star_type (
	star_type_id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE,
	description TEXT NOT NULL
);

INSERT INTO star_type(name, description)
VALUES
	('Yellow Dwarf', 'A small to medium-sized star, like the Sun, that shines with a yellowish light.'),
    ('White Star', 'A bright, hot star that appears white to the naked eye, often younger than the Sun.'),
    ('Red Giant', 'A huge, cooler star that swells up as it gets older, glowing red.'),
    ('Red Dwarf', 'A small, dim, long-lived star that burns fuel slowly, making it last for billions of years.'),
    ('Blue Supergiant', 'A massive, extremely hot star that shines brightly with a blue hue, often nearing the end of its life.');

SELECT * FROM star_type;

-- Update the star table to replace star_type with the star_type_id column from the star_type table, matching each type with its ID.

-- Add a star_type_id column to the star table
ALTER TABLE star -- Modify the structure of the table (columns)
ADD COLUMN star_type_id INT REFERENCES star_type(star_type_id); -- Foreign key column referencing star_type.star_type_id

-- Change the values in star.star_type_id to values matching the star type ID in star_type
UPDATE star -- Modify the data in the table
SET star_type_id = st.star_type_id -- Assign the value of star_type_id from the star_type table to the star_type_id column in the star table.
FROM star_type st -- Use the star_type table, aliased as st
WHERE star.star_type = st.name; -- Only update rows in the star table where the star_type value matches the name in the star_type table.

-- Remove the star_type column from the star table
ALTER TABLE star
DROP COLUMN star_type;

-- Removing star.star_type means that only 1 column is NOT NULL, when at least two are required
ALTER TABLE star
ALTER COLUMN star_type_id SET NOT NULL; -- Set the new column as NOT NULL

SELECT * FROM star_type;