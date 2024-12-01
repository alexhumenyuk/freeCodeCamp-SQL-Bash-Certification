--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(100) NOT NULL,
    galaxy_type character varying(50) NOT NULL,
    number_of_planetary_systems integer,
    has_active_star_formation boolean DEFAULT true
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    planet_id integer,
    name character varying(50) NOT NULL,
    distance_from_earth_in_millions_of_km numeric(10,4) NOT NULL,
    orbital_period_in_days numeric(10,3) NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    has_known_life boolean DEFAULT false
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    galaxy_id integer,
    name character varying(100) NOT NULL,
    mass_in_solar_masses numeric(10,3),
    age_in_millions_of_years integer,
    star_type_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: star_type; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star_type (
    star_type_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.star_type OWNER TO freecodecamp;

--
-- Name: star_type_star_type_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_type_star_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_type_star_type_id_seq OWNER TO freecodecamp;

--
-- Name: star_type_star_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_type_star_type_id_seq OWNED BY public.star_type.star_type_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: star_type star_type_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type ALTER COLUMN star_type_id SET DEFAULT nextval('public.star_type_star_type_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Spiral', 250000000, true);
INSERT INTO public.galaxy VALUES (2, 'Messier 87', 'Elliptical', 1000000000, true);
INSERT INTO public.galaxy VALUES (3, 'Spindle', 'Lenticular', 500000, false);
INSERT INTO public.galaxy VALUES (4, 'Andromeda', 'Spiral', 100000000, true);
INSERT INTO public.galaxy VALUES (5, 'Triangulum', 'Spiral', 40000000, true);
INSERT INTO public.galaxy VALUES (6, 'Sombrero', 'Spiral', 800000000, false);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 1, 'Moon', 0.3840, 27.300);
INSERT INTO public.moon VALUES (2, 2, 'Phobos', 225.0000, 0.318);
INSERT INTO public.moon VALUES (3, 2, 'Deimos', 225.0000, 1.263);
INSERT INTO public.moon VALUES (4, 3, 'Io', 628.4000, 1.769);
INSERT INTO public.moon VALUES (5, 3, 'Europa', 628.7000, 3.551);
INSERT INTO public.moon VALUES (6, 3, 'Ganymede', 629.0000, 7.154);
INSERT INTO public.moon VALUES (7, 3, 'Callisto', 629.9000, 16.689);
INSERT INTO public.moon VALUES (8, 4, 'Titan', 1276.2000, 15.945);
INSERT INTO public.moon VALUES (9, 4, 'Rhea', 1275.5000, 4.518);
INSERT INTO public.moon VALUES (10, 4, 'Iapetus', 1278.6000, 79.321);
INSERT INTO public.moon VALUES (11, 4, 'Dione', 1275.7000, 2.737);
INSERT INTO public.moon VALUES (12, 4, 'Tethys', 1275.9000, 1.888);
INSERT INTO public.moon VALUES (13, 4, 'Enceladus', 1275.2000, 1.370);
INSERT INTO public.moon VALUES (14, 5, 'Titania', 2723.4000, 8.706);
INSERT INTO public.moon VALUES (15, 5, 'Oberon', 2723.6000, 13.463);
INSERT INTO public.moon VALUES (16, 5, 'Umbriel', 2723.3000, 4.144);
INSERT INTO public.moon VALUES (17, 5, 'Ariel', 2723.2000, 2.520);
INSERT INTO public.moon VALUES (18, 5, 'Miranda', 2723.1000, 1.413);
INSERT INTO public.moon VALUES (19, 6, 'Triton', 4352.0000, 5.876);
INSERT INTO public.moon VALUES (20, 7, 'Charon', 5906.2000, 6.387);
INSERT INTO public.moon VALUES (21, 8, 'Namaka', 5906.0000, 5.450);
INSERT INTO public.moon VALUES (22, 8, 'Hiʻiaka', 5906.0000, 6.380);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (2, 1, 'Mars', 'The fourth planet from the Sun, known for its red appearance and potential for past life.', false);
INSERT INTO public.planet VALUES (3, 1, 'Jupiter', 'The largest planet in the Solar System, a gas giant with many moons.', false);
INSERT INTO public.planet VALUES (4, 1, 'Saturn', 'Known for its prominent ring system, the second-largest planet in the Solar System.', false);
INSERT INTO public.planet VALUES (5, 1, 'Uranus', 'An ice giant with a unique tilt, resulting in extreme seasons.', false);
INSERT INTO public.planet VALUES (6, 1, 'Neptune', 'An ice giant known for its strong winds and deep blue color.', false);
INSERT INTO public.planet VALUES (7, 1, 'Pluto', 'A dwarf planet in the Kuiper belt, known for its moon Charon.', false);
INSERT INTO public.planet VALUES (8, 1, 'Haumea', 'A dwarf planet with a unique elongated shape and two moons.', false);
INSERT INTO public.planet VALUES (9, 4, 'Proxima Centauri b', 'An Earth-sized exoplanet in the habitable zone of Proxima Centauri.', false);
INSERT INTO public.planet VALUES (10, 4, 'Proxima Centauri c', 'A super-Earth orbiting Proxima Centauri.', false);
INSERT INTO public.planet VALUES (11, 6, 'Vega b', 'A candidate exoplanet orbiting Vega.', false);
INSERT INTO public.planet VALUES (12, 2, 'Sirius A b', 'A hypothetical exoplanet orbiting Sirius A.', false);
INSERT INTO public.planet VALUES (1, 1, 'Earth', 'The third planet from the Sun, and the only astronomical object known to harbor life.', true);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 1, 'Sun', 1.000, 4600, 1);
INSERT INTO public.star VALUES (2, 1, 'Sirius A', 2.020, 242, 2);
INSERT INTO public.star VALUES (3, 1, 'Betelgeuse', 17.750, 10, 3);
INSERT INTO public.star VALUES (4, 1, 'Proxima Centauri', 0.122, 4850, 4);
INSERT INTO public.star VALUES (5, 1, 'Rigel', 21.000, 8, 5);
INSERT INTO public.star VALUES (6, 1, 'Vega', 2.135, 455, 2);


--
-- Data for Name: star_type; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star_type VALUES (1, 'Yellow Dwarf', 'A small to medium-sized star, like the Sun, that shines with a yellowish light.');
INSERT INTO public.star_type VALUES (2, 'White Star', 'A bright, hot star that appears white to the naked eye, often younger than the Sun.');
INSERT INTO public.star_type VALUES (3, 'Red Giant', 'A huge, cooler star that swells up as it gets older, glowing red.');
INSERT INTO public.star_type VALUES (4, 'Red Dwarf', 'A small, dim, long-lived star that burns fuel slowly, making it last for billions of years.');
INSERT INTO public.star_type VALUES (5, 'Blue Supergiant', 'A massive, extremely hot star that shines brightly with a blue hue, often nearing the end of its life.');


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 22, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: star_type_star_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_type_star_type_id_seq', 5, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: star_type star_type_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type
    ADD CONSTRAINT star_type_name_key UNIQUE (name);


--
-- Name: star_type star_type_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star_type
    ADD CONSTRAINT star_type_pkey PRIMARY KEY (star_type_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: star star_star_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_star_type_id_fkey FOREIGN KEY (star_type_id) REFERENCES public.star_type(star_type_id);


--
-- PostgreSQL database dump complete
--

