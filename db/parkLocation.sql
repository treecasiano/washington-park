-- Table: public.park_location
-- DROP TABLE public.park_location;
CREATE TABLE public.park_location (
  gid serial PRIMARY KEY,
  location_name character varying(250) UNIQUE NOT NULL COLLATE pg_catalog."default",
  street_addr_1 character varying(250) COLLATE pg_catalog."default",
  street_addr_2 character varying(100) COLLATE pg_catalog."default",
  city character varying(100) COLLATE pg_catalog."default",
  state character varying(2) COLLATE pg_catalog."default",
  zip character varying(10) COLLATE pg_catalog."default",
  location_type character varying(50) COLLATE pg_catalog."default",
  hrs_of_operation character varying(250) COLLATE pg_catalog."default",
  url character varying(250) COLLATE pg_catalog."default",
  image_url character varying(250) COLLATE pg_catalog."default",
  description character varying(250) COLLATE pg_catalog."default",
  geom geometry(Point, 4326)
) WITH (OIDS = FALSE) TABLESPACE pg_default;
ALTER TABLE
  public.park_location OWNER to postgres;
-- Index: park_location_geom_idx
  -- DROP INDEX public.park_location_geom_idx;
  CREATE INDEX park_location_geom_idx ON public.park_location USING gist (geom) TABLESPACE pg_default;
