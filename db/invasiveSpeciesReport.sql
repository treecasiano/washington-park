-- Table: public.invasive_species_report
-- DROP TABLE public.invasive_species_report;
CREATE TABLE public.invasive_species_report (
  gid serial PRIMARY KEY,
  date_created timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  observation_date DATE NOT NULL DEFAULT CURRENT_DATE,
  observer_email character varying(50) COLLATE pg_catalog."default",
  observer_first_name character varying(100) COLLATE pg_catalog."default",
  observer_last_name character varying(100) COLLATE pg_catalog."default",
  observer_phone character varying(15) COLLATE pg_catalog."default",
  organism_type character varying(150) COLLATE pg_catalog."default",
  organism_description character varying(250) COLLATE pg_catalog."default",
  location_details character varying(250) COLLATE pg_catalog."default",
  geom geometry(Point, 4326)
) WITH (OIDS = FALSE) TABLESPACE pg_default;
ALTER TABLE
  public.invasive_species_report OWNER to postgres;
-- Index: invasive_species_report_geom_idx
  -- DROP INDEX public.invasive_species_report_geom_idx;
  CREATE INDEX invasive_species_report_geom_idx ON public.invasive_species_report USING gist (geom) TABLESPACE pg_default;
