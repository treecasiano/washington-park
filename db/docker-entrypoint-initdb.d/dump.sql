--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.2 (Debian 11.2-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO postgres;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO postgres;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: hello_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hello_table (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    favorite_color character varying(50),
    geom public.geometry(Point,4326)
);


ALTER TABLE public.hello_table OWNER TO postgres;

--
-- Name: account_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_user_id_seq OWNER TO postgres;

--
-- Name: account_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_user_id_seq OWNED BY public.hello_table.user_id;


--
-- Name: transit_stops; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transit_stops (
    gid integer NOT NULL,
    objectid bigint,
    keyitem character varying(4),
    rte character varying(3),
    dir numeric,
    loc_id numeric,
    location character varying(50),
    jurisdic character varying(40),
    zip numeric,
    route character varying(50),
    rte_desc character varying(50),
    dir_desc character varying(50),
    stop_seq bigint,
    type character varying(20),
    frequent character varying(5),
    geom public.geometry(Point,4326)
);


ALTER TABLE public.transit_stops OWNER TO postgres;

--
-- Name: transit_stops_gid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transit_stops_gid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transit_stops_gid_seq OWNER TO postgres;

--
-- Name: transit_stops_gid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transit_stops_gid_seq OWNED BY public.transit_stops.gid;


--
-- Name: hello_table user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hello_table ALTER COLUMN user_id SET DEFAULT nextval('public.account_user_id_seq'::regclass);


--
-- Name: transit_stops gid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transit_stops ALTER COLUMN gid SET DEFAULT nextval('public.transit_stops_gid_seq'::regclass);


--
-- Data for Name: hello_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hello_table (user_id, username, created_on, first_name, last_name, favorite_color, geom) FROM stdin;
1	blackbird127	2019-03-23 17:30:01.639481+00	Tereza	Averescu	teal	0101000020E610000085EB51B81E6552C05C8FC2F5283C4440
2	rkd	2019-03-23 17:55:39.339483+00	Roberto	Serra	black	0101000020E61000000AD7A3703D9A5EC048E17A14AEA74640
3	northstar27	2019-03-23 18:00:39.369594+00	Anthea	Christopoulos	chartreuse	0101000020E610000066666666665652C06666666666A64640
4	meridianprime	2019-03-23 18:01:46.522031+00	Cristofer	Romano	burgundy	0101000020E61000000000000000405AC09A99999999B94340
5	melodia	2019-03-23 18:02:41.248391+00	Adalynd	Jones	black	0101000020E610000085EB51B81E155DC0AE47E17A14AE4540
6	mixolydia	2019-03-23 18:04:01.980239+00	Yzobel	Mirren	green	0101000020E61000003D0AD7A3701D58C07B14AE47E13A4040
7	craftywench	2019-03-23 18:05:41.260574+00	Evelyn	Dunlap	navy blue	0101000020E6100000CDCCCCCCCC9C5EC09A99999999594740
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: transit_stops; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transit_stops (gid, objectid, keyitem, rte, dir, loc_id, location, jurisdic, zip, route, rte_desc, dir_desc, stop_seq, type, frequent, geom) FROM stdin;
1	1	0200	20	0.00000000000	8749.00000000	W Burnside & NW Uptown Terrace	Portland	97210.0000000	20	20-Burnside/Stark	To 23rd & Burnside or Beaverton Transit Center	2140	BUS	False	0101000020E6100000042CE8C700AD5EC0A37DC8991BC34640
2	2	0200	20	0.00000000000	9555.00000000	W Burnside & NW 23rd Pl	Portland	97210.0000000	20	20-Burnside/Stark	To 23rd & Burnside or Beaverton Transit Center	2132	BUS	False	0101000020E610000094D9FA30D8AC5EC09247FE5A0FC34640
3	3	0200	20	0.00000000000	9354.00000000	W Burnside & SW Osage	Portland	97205.0000000	20	20-Burnside/Stark	To 23rd & Burnside or Beaverton Transit Center	2152	BUS	False	0101000020E6100000765D333EDDAC5EC07BBC2E4D0BC34640
4	4	0200	20	0.00000000000	707.000000000	W Burnside & NW Hermosa	Portland	97210.0000000	20	20-Burnside/Stark	To 23rd & Burnside or Beaverton Transit Center	2160	BUS	False	0101000020E610000066BA67F4C2AD5EC0C0AF75C2E6C24640
5	5	1000	100	0.00000000000	10120.0000000	Washington Park MAX Station	Portland	97221.0000000	MAX	MAX Blue Line	To Gresham	2800	MAX	True	0101000020E6100000C744B5BED8AD5EC04D5318665DC14640
6	6	0200	20	0.00000000000	687.000000000	W Burnside & NW Barnes	Portland	97210.0000000	20	20-Burnside/Stark	To 23rd & Burnside or Beaverton Transit Center	2170	BUS	False	0101000020E6100000ACD80A6729AE5EC08252B37A97C24640
7	7	1001	100	1.00000000000	10121.0000000	Washington Park MAX Station	Portland	97221.0000000	MAX	MAX Blue Line	To Hillsboro	4050	MAX	True	0101000020E61000008992B590E7AD5EC0BC06EAAA5DC14640
8	8	0201	20	1.00000000000	685.000000000	W Burnside & SW Fischer Ln	Portland	97210.0000000	20	20-Burnside/Stark	To Gresham Transit Center	440	BUS	False	0101000020E610000035F3A9D537AE5EC05BDBF70274C24640
9	9	0201	20	1.00000000000	706.000000000	W Burnside & NW Hermosa	Portland	97221.0000000	20	20-Burnside/Stark	To Gresham Transit Center	460	BUS	False	0101000020E61000001EF53F3CC2AD5EC028E37ED8E1C24640
10	10	0201	20	1.00000000000	9354.00000000	W Burnside & SW Osage	Portland	97205.0000000	20	20-Burnside/Stark	To Gresham Transit Center	480	BUS	False	0101000020E6100000765D333EDDAC5EC07BBC2E4D0BC34640
11	11	0900	90	0.00000000000	10120.0000000	Washington Park MAX Station	Portland	97221.0000000	90	MAX Red Line	To Portland International Airport	1300	MAX	True	0101000020E6100000C744B5BED8AD5EC04D5318665DC14640
12	12	0201	20	1.00000000000	686.000000000	W Burnside & NW Barnes	Portland	97221.0000000	20	20-Burnside/Stark	To Gresham Transit Center	450	BUS	False	0101000020E61000005DE54EF51FAE5EC01250CF27A0C24640
13	13	0201	20	1.00000000000	8750.00000000	W Burnside & NW Uptown Terrace	Portland	97205.0000000	20	20-Burnside/Stark	To Gresham Transit Center	475	BUS	False	0101000020E6100000430F810E03AD5EC0D1E50F6916C34640
14	14	0901	90	1.00000000000	10121.0000000	Washington Park MAX Station	Portland	97221.0000000	90	MAX Red Line	To Beaverton Transit Center	2900	MAX	True	0101000020E61000008992B590E7AD5EC0BC06EAAA5DC14640
15	15	0630	63	0.00000000000	4343.00000000	SW Park Pl & Green	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	950	BUS	False	0101000020E61000004E4CB6EDBBAC5EC054AF3522BCC24640
16	16	0630	63	0.00000000000	4351.00000000	SW Rose Garden Way & Wright	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1050	BUS	False	0101000020E610000033279FF618AD5EC0865E3974C6C24640
17	17	0630	63	0.00000000000	1620.00000000	2800 Block SW Fairview	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1451	BUS	False	0101000020E61000005FC36DB98FAD5EC0A613FEFD69C24640
18	18	0630	63	0.00000000000	1639.00000000	SW Fairview & Wildwood Trail	Portland	97221.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1750	BUS	False	0101000020E6100000D6BA9FC7CBAD5EC0A4F14A6361C24640
19	19	0630	63	0.00000000000	12886.0000000	SW Fairview & Kingston	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1250	BUS	False	0101000020E6100000A19848B047AD5EC028274A18B7C24640
20	20	0630	63	0.00000000000	11151.0000000	SW Rose Garden Blvd & Sherwood	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1100	BUS	False	0101000020E61000002C4221A232AD5EC03A6018625CC24640
21	21	0630	63	0.00000000000	3277.00000000	SW Knight & Kingston	Portland	97221.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1850	BUS	False	0101000020E6100000E5909C1AE2AD5EC0EC3565DD96C14640
22	22	0630	63	0.00000000000	1637.00000000	SW Fairview & View Place	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1700	BUS	False	0101000020E6100000B460372CAAAD5EC0B4A7921191C24640
23	23	0630	63	0.00000000000	10299.0000000	MAX Station/Oregon Zoo	Portland	97221.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1950	BUS	False	0101000020E610000021CE2F99E8AD5EC0D28CE66657C14640
24	24	0630	63	0.00000000000	4346.00000000	SW Park Pl & Lewis & Clark	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1000	BUS	False	0101000020E610000013554A15D7AC5EC056C20955BCC24640
25	25	0630	63	0.00000000000	3276.00000000	SW Kingston & Japanese Garden	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1200	BUS	False	0101000020E61000003BC705EF3AAD5EC04E58880871C24640
26	26	0630	63	0.00000000000	1619.00000000	2700 Block SW Fairview	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1350	BUS	False	0101000020E610000090F1196F66AD5EC046E54DD297C24640
27	27	0630	63	0.00000000000	1623.00000000	2800 Block SW Fairview	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1500	BUS	False	0101000020E61000001FB879837DAD5EC0D45EE0B28FC24640
28	28	0630	63	0.00000000000	1625.00000000	4000 Block SW Fairview (Arboretum)	Portland	97221.0000000	63	63-Washington Park/Arlington Hts	To Washington Park	1800	BUS	False	0101000020E6100000C011BAEDD5AD5EC02750C14DFEC14640
29	29	0631	63	1.00000000000	1638.00000000	SW Fairview & Wildwood Trail	Portland	97221.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	350	BUS	False	0101000020E6100000D9896CA7CEAD5EC0D340EA3F50C24640
30	30	0631	63	1.00000000000	1627.00000000	SW Fairview & Bennington	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	500	BUS	False	0101000020E6100000AF7866747FAD5EC08FD8B956A8C24640
31	31	0631	63	1.00000000000	1632.00000000	SW Fairview & Champlain	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	700	BUS	False	0101000020E6100000ADBBE42D7DAD5EC06EEC93FC78C24640
32	32	0631	63	1.00000000000	1633.00000000	SW Fairview & Kingston	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	800	BUS	False	0101000020E6100000ADC856603FAD5EC0C84C9A0DBCC24640
33	33	0631	63	1.00000000000	1624.00000000	4000 Block SW Fairview (Arboretum)	Portland	97221.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	300	BUS	False	0101000020E610000096512389D2AD5EC0A5265FDCFFC14640
34	34	0631	63	1.00000000000	1622.00000000	2800 Block SW Fairview	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	525	BUS	False	0101000020E610000007D5BC438EAD5EC0750C77397FC24640
35	35	0631	63	1.00000000000	1618.00000000	2700 Block SW Fairview	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	750	BUS	False	0101000020E6100000CC29B40B5CAD5EC06D19A3989DC24640
36	36	0631	63	1.00000000000	3279.00000000	SW Kingston & Tichner	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	850	BUS	False	0101000020E61000004971FFED39AD5EC0EDDA0272FCC24640
37	37	0631	63	1.00000000000	4341.00000000	SW Park Pl & Douglas	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	1000	BUS	False	0101000020E6100000ED2EC819D3AC5EC02F708291B8C24640
38	38	0631	63	1.00000000000	10589.0000000	SW Park Pl & Wright	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	925	BUS	False	0101000020E610000079EECF2616AD5EC0218CC9A3C8C24640
39	39	0631	63	1.00000000000	3291.00000000	SW Knights & Kingston	Portland	97221.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	250	BUS	False	0101000020E610000029A4CF49E0AD5EC04FB2845298C14640
40	40	0631	63	1.00000000000	1629.00000000	SW Fairview & Cascade	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	651	BUS	False	0101000020E6100000A6E293C198AD5EC030DAA4126BC24640
41	41	0631	63	1.00000000000	6177.00000000	SW Sacajawea & Sherwood	Portland	97205.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	950	BUS	False	0101000020E61000002B593CC5FEAC5EC0D8429A16B5C24640
42	42	0631	63	1.00000000000	10299.0000000	MAX Station/Oregon Zoo	Portland	97221.0000000	63	63-Washington Park/Arlington Hts	To Providence Park	200	BUS	False	0101000020E610000021CE2F99E8AD5EC0D28CE66657C14640
43	43	0180	18	0.00000000000	9404.00000000	NW 23rd Place & Westover	Portland	97210.0000000	18	18-Hillside	To Hillside and Providence Park	350	BUS	False	0101000020E610000049D8223BC3AC5EC088F82A2B1DC34640
44	44	0180	18	0.00000000000	8750.00000000	W Burnside & NW Uptown Terrace	Portland	97205.0000000	18	18-Hillside	To Hillside and Providence Park	1200	BUS	False	0101000020E6100000430F810E03AD5EC0D1E50F6916C34640
45	45	0830	83	0.00000000000	10299.0000000	MAX Station/Oregon Zoo	Portland	97221.0000000	83	83-Washington Park Loop	To Providence Park	50	BUS	False	0101000020E610000021CE2F99E8AD5EC0D28CE66657C14640
46	46	0830	83	0.00000000000	3291.00000000	SW Knights & Kingston	Portland	97221.0000000	83	83-Washington Park Loop	To Providence Park	100	BUS	False	0101000020E610000029A4CF49E0AD5EC04FB2845298C14640
47	47	0830	83	0.00000000000	1624.00000000	4000 Block SW Fairview (Arboretum)	Portland	97221.0000000	83	83-Washington Park Loop	To Providence Park	150	BUS	False	0101000020E610000096512389D2AD5EC0A5265FDCFFC14640
48	48	0830	83	0.00000000000	1638.00000000	SW Fairview & Wildwood Trail	Portland	97221.0000000	83	83-Washington Park Loop	To Providence Park	200	BUS	False	0101000020E6100000D9896CA7CEAD5EC0D340EA3F50C24640
49	49	0830	83	0.00000000000	1627.00000000	SW Fairview & Bennington	Portland	97205.0000000	83	83-Washington Park Loop	To Providence Park	350	BUS	False	0101000020E6100000AF7866747FAD5EC08FD8B956A8C24640
50	50	0830	83	0.00000000000	1622.00000000	2800 Block SW Fairview	Portland	97205.0000000	83	83-Washington Park Loop	To Providence Park	400	BUS	False	0101000020E610000007D5BC438EAD5EC0750C77397FC24640
51	51	0830	83	0.00000000000	1629.00000000	SW Fairview & Cascade	Portland	97205.0000000	83	83-Washington Park Loop	To Providence Park	450	BUS	False	0101000020E6100000A6E293C198AD5EC030DAA4126BC24640
52	52	0830	83	0.00000000000	1632.00000000	SW Fairview & Champlain	Portland	97205.0000000	83	83-Washington Park Loop	To Providence Park	500	BUS	False	0101000020E6100000ADBBE42D7DAD5EC06EEC93FC78C24640
53	53	0830	83	0.00000000000	1618.00000000	2700 Block SW Fairview	Portland	97205.0000000	83	83-Washington Park Loop	To Providence Park	550	BUS	False	0101000020E6100000CC29B40B5CAD5EC06D19A3989DC24640
54	54	0830	83	0.00000000000	1633.00000000	SW Fairview & Kingston	Portland	97205.0000000	83	83-Washington Park Loop	To Providence Park	600	BUS	False	0101000020E6100000ADC856603FAD5EC0C84C9A0DBCC24640
55	55	0830	83	0.00000000000	11091.0000000	SW Kingston & Japanese Garden	Portland	97205.0000000	83	83-Washington Park Loop	To Providence Park	650	BUS	False	0101000020E6100000A06FE2CD3CAD5EC06BB8ACF178C24640
56	56	0830	83	0.00000000000	10488.0000000	SW Sherwood & Kingston	Portland	97205.0000000	83	83-Washington Park Loop	To Providence Park	700	BUS	False	0101000020E610000057D6264A31AD5EC073ED3ABD47C24640
57	57	0830	83	0.00000000000	10300.0000000	SW Sherwood & Children's Park	Portland	97205.0000000	83	83-Washington Park Loop	To Providence Park	750	BUS	False	0101000020E61000002225EE902EAD5EC04B69FEBE18C24640
58	58	0830	83	0.00000000000	4341.00000000	SW Park Pl & Douglas	Portland	97205.0000000	83	83-Washington Park Loop	To Providence Park	800	BUS	False	0101000020E6100000ED2EC819D3AC5EC02F708291B8C24640
59	59	0831	83	1.00000000000	4343.00000000	SW Park Pl & Green	Portland	97205.0000000	83	83-Washington Park Loop	To Washington Park/Oregon Zoo	300	BUS	False	0101000020E61000004E4CB6EDBBAC5EC054AF3522BCC24640
60	60	0831	83	1.00000000000	4346.00000000	SW Park Pl & Lewis & Clark	Portland	97205.0000000	83	83-Washington Park Loop	To Washington Park/Oregon Zoo	350	BUS	False	0101000020E610000013554A15D7AC5EC056C20955BCC24640
61	61	0831	83	1.00000000000	4351.00000000	SW Rose Garden Way & Wright	Portland	97205.0000000	83	83-Washington Park Loop	To Washington Park/Oregon Zoo	400	BUS	False	0101000020E610000033279FF618AD5EC0865E3974C6C24640
62	62	0831	83	1.00000000000	11151.0000000	SW Rose Garden Blvd & Sherwood	Portland	97205.0000000	83	83-Washington Park Loop	To Washington Park/Oregon Zoo	450	BUS	False	0101000020E61000002C4221A232AD5EC03A6018625CC24640
63	63	0831	83	1.00000000000	13253.0000000	SW Kingston & Archery Range	Portland	97205.0000000	83	83-Washington Park Loop	To Washington Park/Oregon Zoo	500	BUS	False	0101000020E61000001FE651716DAD5EC040A666E9D1C14640
64	64	0831	83	1.00000000000	3277.00000000	SW Knight & Kingston	Portland	97221.0000000	83	83-Washington Park Loop	To Washington Park/Oregon Zoo	550	BUS	False	0101000020E6100000E5909C1AE2AD5EC0EC3565DD96C14640
65	65	0831	83	1.00000000000	10299.0000000	MAX Station/Oregon Zoo	Portland	97221.0000000	83	83-Washington Park Loop	To Washington Park/Oregon Zoo	600	BUS	False	0101000020E610000021CE2F99E8AD5EC0D28CE66657C14640
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: account_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_user_id_seq', 7, true);


--
-- Name: transit_stops_gid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transit_stops_gid_seq', 65, true);


--
-- Name: hello_table account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hello_table
    ADD CONSTRAINT account_pkey PRIMARY KEY (user_id);


--
-- Name: hello_table account_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hello_table
    ADD CONSTRAINT account_username_key UNIQUE (username);


--
-- Name: transit_stops transit_stops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transit_stops
    ADD CONSTRAINT transit_stops_pkey PRIMARY KEY (gid);


--
-- Name: transit_stops_geom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transit_stops_geom_idx ON public.transit_stops USING gist (geom);


--
-- PostgreSQL database dump complete
--

