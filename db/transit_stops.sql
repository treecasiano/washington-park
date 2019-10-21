SET CLIENT_ENCODING TO UTF8;
SET STANDARD_CONFORMING_STRINGS TO ON;
BEGIN;
CREATE TABLE "public"."transit_stops" (gid serial,
"objectid" int8,
"keyitem" varchar(4),
"rte" varchar(3),
"dir" numeric,
"loc_id" numeric,
"location" varchar(50),
"jurisdic" varchar(40),
"zip" numeric,
"route" varchar(50),
"rte_desc" varchar(50),
"dir_desc" varchar(50),
"stop_seq" int8,
"type" varchar(20),
"frequent" varchar(5));
ALTER TABLE "public"."transit_stops" ADD PRIMARY KEY (gid);
SELECT AddGeometryColumn('public','transit_stops','geom','4326','POINT',2);
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('1','0200','20','0.00000000000e+00','8.74900000000e+03','W Burnside & NW Uptown Terrace','Portland','9.72100000000e+04','20','20-Burnside/Stark','To 23rd & Burnside or Beaverton Transit Center','2140','BUS','False','0101000020E6100000042CE8C700AD5EC0A37DC8991BC34640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('2','0200','20','0.00000000000e+00','9.55500000000e+03','W Burnside & NW 23rd Pl','Portland','9.72100000000e+04','20','20-Burnside/Stark','To 23rd & Burnside or Beaverton Transit Center','2132','BUS','False','0101000020E610000094D9FA30D8AC5EC09247FE5A0FC34640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('3','0200','20','0.00000000000e+00','9.35400000000e+03','W Burnside & SW Osage','Portland','9.72050000000e+04','20','20-Burnside/Stark','To 23rd & Burnside or Beaverton Transit Center','2152','BUS','False','0101000020E6100000765D333EDDAC5EC07BBC2E4D0BC34640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('4','0200','20','0.00000000000e+00','7.07000000000e+02','W Burnside & NW Hermosa','Portland','9.72100000000e+04','20','20-Burnside/Stark','To 23rd & Burnside or Beaverton Transit Center','2160','BUS','False','0101000020E610000066BA67F4C2AD5EC0C0AF75C2E6C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('5','1000','100','0.00000000000e+00','1.01200000000e+04','Washington Park MAX Station','Portland','9.72210000000e+04','MAX','MAX Blue Line','To Gresham','2800','MAX','True','0101000020E6100000C744B5BED8AD5EC04D5318665DC14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('6','0200','20','0.00000000000e+00','6.87000000000e+02','W Burnside & NW Barnes','Portland','9.72100000000e+04','20','20-Burnside/Stark','To 23rd & Burnside or Beaverton Transit Center','2170','BUS','False','0101000020E6100000ACD80A6729AE5EC08252B37A97C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('7','1001','100','1.00000000000e+00','1.01210000000e+04','Washington Park MAX Station','Portland','9.72210000000e+04','MAX','MAX Blue Line','To Hillsboro','4050','MAX','True','0101000020E61000008992B590E7AD5EC0BC06EAAA5DC14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('8','0201','20','1.00000000000e+00','6.85000000000e+02','W Burnside & SW Fischer Ln','Portland','9.72100000000e+04','20','20-Burnside/Stark','To Gresham Transit Center','440','BUS','False','0101000020E610000035F3A9D537AE5EC05BDBF70274C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('9','0201','20','1.00000000000e+00','7.06000000000e+02','W Burnside & NW Hermosa','Portland','9.72210000000e+04','20','20-Burnside/Stark','To Gresham Transit Center','460','BUS','False','0101000020E61000001EF53F3CC2AD5EC028E37ED8E1C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('10','0201','20','1.00000000000e+00','9.35400000000e+03','W Burnside & SW Osage','Portland','9.72050000000e+04','20','20-Burnside/Stark','To Gresham Transit Center','480','BUS','False','0101000020E6100000765D333EDDAC5EC07BBC2E4D0BC34640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('11','0900','90','0.00000000000e+00','1.01200000000e+04','Washington Park MAX Station','Portland','9.72210000000e+04','90','MAX Red Line','To Portland International Airport','1300','MAX','True','0101000020E6100000C744B5BED8AD5EC04D5318665DC14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('12','0201','20','1.00000000000e+00','6.86000000000e+02','W Burnside & NW Barnes','Portland','9.72210000000e+04','20','20-Burnside/Stark','To Gresham Transit Center','450','BUS','False','0101000020E61000005DE54EF51FAE5EC01250CF27A0C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('13','0201','20','1.00000000000e+00','8.75000000000e+03','W Burnside & NW Uptown Terrace','Portland','9.72050000000e+04','20','20-Burnside/Stark','To Gresham Transit Center','475','BUS','False','0101000020E6100000430F810E03AD5EC0D1E50F6916C34640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('14','0901','90','1.00000000000e+00','1.01210000000e+04','Washington Park MAX Station','Portland','9.72210000000e+04','90','MAX Red Line','To Beaverton Transit Center','2900','MAX','True','0101000020E61000008992B590E7AD5EC0BC06EAAA5DC14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('15','0630','63','0.00000000000e+00','4.34300000000e+03','SW Park Pl & Green','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','950','BUS','False','0101000020E61000004E4CB6EDBBAC5EC054AF3522BCC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('16','0630','63','0.00000000000e+00','4.35100000000e+03','SW Rose Garden Way & Wright','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1050','BUS','False','0101000020E610000033279FF618AD5EC0865E3974C6C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('17','0630','63','0.00000000000e+00','1.62000000000e+03','2800 Block SW Fairview','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1451','BUS','False','0101000020E61000005FC36DB98FAD5EC0A613FEFD69C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('18','0630','63','0.00000000000e+00','1.63900000000e+03','SW Fairview & Wildwood Trail','Portland','9.72210000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1750','BUS','False','0101000020E6100000D6BA9FC7CBAD5EC0A4F14A6361C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('19','0630','63','0.00000000000e+00','1.28860000000e+04','SW Fairview & Kingston','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1250','BUS','False','0101000020E6100000A19848B047AD5EC028274A18B7C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('20','0630','63','0.00000000000e+00','1.11510000000e+04','SW Rose Garden Blvd & Sherwood','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1100','BUS','False','0101000020E61000002C4221A232AD5EC03A6018625CC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('21','0630','63','0.00000000000e+00','3.27700000000e+03','SW Knight & Kingston','Portland','9.72210000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1850','BUS','False','0101000020E6100000E5909C1AE2AD5EC0EC3565DD96C14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('22','0630','63','0.00000000000e+00','1.63700000000e+03','SW Fairview & View Place','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1700','BUS','False','0101000020E6100000B460372CAAAD5EC0B4A7921191C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('23','0630','63','0.00000000000e+00','1.02990000000e+04','MAX Station/Oregon Zoo','Portland','9.72210000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1950','BUS','False','0101000020E610000021CE2F99E8AD5EC0D28CE66657C14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('24','0630','63','0.00000000000e+00','4.34600000000e+03','SW Park Pl & Lewis & Clark','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1000','BUS','False','0101000020E610000013554A15D7AC5EC056C20955BCC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('25','0630','63','0.00000000000e+00','3.27600000000e+03','SW Kingston & Japanese Garden','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1200','BUS','False','0101000020E61000003BC705EF3AAD5EC04E58880871C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('26','0630','63','0.00000000000e+00','1.61900000000e+03','2700 Block SW Fairview','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1350','BUS','False','0101000020E610000090F1196F66AD5EC046E54DD297C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('27','0630','63','0.00000000000e+00','1.62300000000e+03','2800 Block SW Fairview','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1500','BUS','False','0101000020E61000001FB879837DAD5EC0D45EE0B28FC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('28','0630','63','0.00000000000e+00','1.62500000000e+03','4000 Block SW Fairview (Arboretum)','Portland','9.72210000000e+04','63','63-Washington Park/Arlington Hts','To Washington Park','1800','BUS','False','0101000020E6100000C011BAEDD5AD5EC02750C14DFEC14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('29','0631','63','1.00000000000e+00','1.63800000000e+03','SW Fairview & Wildwood Trail','Portland','9.72210000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','350','BUS','False','0101000020E6100000D9896CA7CEAD5EC0D340EA3F50C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('30','0631','63','1.00000000000e+00','1.62700000000e+03','SW Fairview & Bennington','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','500','BUS','False','0101000020E6100000AF7866747FAD5EC08FD8B956A8C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('31','0631','63','1.00000000000e+00','1.63200000000e+03','SW Fairview & Champlain','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','700','BUS','False','0101000020E6100000ADBBE42D7DAD5EC06EEC93FC78C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('32','0631','63','1.00000000000e+00','1.63300000000e+03','SW Fairview & Kingston','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','800','BUS','False','0101000020E6100000ADC856603FAD5EC0C84C9A0DBCC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('33','0631','63','1.00000000000e+00','1.62400000000e+03','4000 Block SW Fairview (Arboretum)','Portland','9.72210000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','300','BUS','False','0101000020E610000096512389D2AD5EC0A5265FDCFFC14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('34','0631','63','1.00000000000e+00','1.62200000000e+03','2800 Block SW Fairview','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','525','BUS','False','0101000020E610000007D5BC438EAD5EC0750C77397FC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('35','0631','63','1.00000000000e+00','1.61800000000e+03','2700 Block SW Fairview','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','750','BUS','False','0101000020E6100000CC29B40B5CAD5EC06D19A3989DC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('36','0631','63','1.00000000000e+00','3.27900000000e+03','SW Kingston & Tichner','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','850','BUS','False','0101000020E61000004971FFED39AD5EC0EDDA0272FCC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('37','0631','63','1.00000000000e+00','4.34100000000e+03','SW Park Pl & Douglas','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','1000','BUS','False','0101000020E6100000ED2EC819D3AC5EC02F708291B8C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('38','0631','63','1.00000000000e+00','1.05890000000e+04','SW Park Pl & Wright','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','925','BUS','False','0101000020E610000079EECF2616AD5EC0218CC9A3C8C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('39','0631','63','1.00000000000e+00','3.29100000000e+03','SW Knights & Kingston','Portland','9.72210000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','250','BUS','False','0101000020E610000029A4CF49E0AD5EC04FB2845298C14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('40','0631','63','1.00000000000e+00','1.62900000000e+03','SW Fairview & Cascade','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','651','BUS','False','0101000020E6100000A6E293C198AD5EC030DAA4126BC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('41','0631','63','1.00000000000e+00','6.17700000000e+03','SW Sacajawea & Sherwood','Portland','9.72050000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','950','BUS','False','0101000020E61000002B593CC5FEAC5EC0D8429A16B5C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('42','0631','63','1.00000000000e+00','1.02990000000e+04','MAX Station/Oregon Zoo','Portland','9.72210000000e+04','63','63-Washington Park/Arlington Hts','To Providence Park','200','BUS','False','0101000020E610000021CE2F99E8AD5EC0D28CE66657C14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('43','0180','18','0.00000000000e+00','9.40400000000e+03','NW 23rd Place & Westover','Portland','9.72100000000e+04','18','18-Hillside','To Hillside and Providence Park','350','BUS','False','0101000020E610000049D8223BC3AC5EC088F82A2B1DC34640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('44','0180','18','0.00000000000e+00','8.75000000000e+03','W Burnside & NW Uptown Terrace','Portland','9.72050000000e+04','18','18-Hillside','To Hillside and Providence Park','1200','BUS','False','0101000020E6100000430F810E03AD5EC0D1E50F6916C34640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('45','0830','83','0.00000000000e+00','1.02990000000e+04','MAX Station/Oregon Zoo','Portland','9.72210000000e+04','83','83-Washington Park Loop','To Providence Park','50','BUS','False','0101000020E610000021CE2F99E8AD5EC0D28CE66657C14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('46','0830','83','0.00000000000e+00','3.29100000000e+03','SW Knights & Kingston','Portland','9.72210000000e+04','83','83-Washington Park Loop','To Providence Park','100','BUS','False','0101000020E610000029A4CF49E0AD5EC04FB2845298C14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('47','0830','83','0.00000000000e+00','1.62400000000e+03','4000 Block SW Fairview (Arboretum)','Portland','9.72210000000e+04','83','83-Washington Park Loop','To Providence Park','150','BUS','False','0101000020E610000096512389D2AD5EC0A5265FDCFFC14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('48','0830','83','0.00000000000e+00','1.63800000000e+03','SW Fairview & Wildwood Trail','Portland','9.72210000000e+04','83','83-Washington Park Loop','To Providence Park','200','BUS','False','0101000020E6100000D9896CA7CEAD5EC0D340EA3F50C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('49','0830','83','0.00000000000e+00','1.62700000000e+03','SW Fairview & Bennington','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Providence Park','350','BUS','False','0101000020E6100000AF7866747FAD5EC08FD8B956A8C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('50','0830','83','0.00000000000e+00','1.62200000000e+03','2800 Block SW Fairview','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Providence Park','400','BUS','False','0101000020E610000007D5BC438EAD5EC0750C77397FC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('51','0830','83','0.00000000000e+00','1.62900000000e+03','SW Fairview & Cascade','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Providence Park','450','BUS','False','0101000020E6100000A6E293C198AD5EC030DAA4126BC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('52','0830','83','0.00000000000e+00','1.63200000000e+03','SW Fairview & Champlain','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Providence Park','500','BUS','False','0101000020E6100000ADBBE42D7DAD5EC06EEC93FC78C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('53','0830','83','0.00000000000e+00','1.61800000000e+03','2700 Block SW Fairview','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Providence Park','550','BUS','False','0101000020E6100000CC29B40B5CAD5EC06D19A3989DC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('54','0830','83','0.00000000000e+00','1.63300000000e+03','SW Fairview & Kingston','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Providence Park','600','BUS','False','0101000020E6100000ADC856603FAD5EC0C84C9A0DBCC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('55','0830','83','0.00000000000e+00','1.10910000000e+04','SW Kingston & Japanese Garden','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Providence Park','650','BUS','False','0101000020E6100000A06FE2CD3CAD5EC06BB8ACF178C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('56','0830','83','0.00000000000e+00','1.04880000000e+04','SW Sherwood & Kingston','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Providence Park','700','BUS','False','0101000020E610000057D6264A31AD5EC073ED3ABD47C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('57','0830','83','0.00000000000e+00','1.03000000000e+04','SW Sherwood & Children''s Park','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Providence Park','750','BUS','False','0101000020E61000002225EE902EAD5EC04B69FEBE18C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('58','0830','83','0.00000000000e+00','4.34100000000e+03','SW Park Pl & Douglas','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Providence Park','800','BUS','False','0101000020E6100000ED2EC819D3AC5EC02F708291B8C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('59','0831','83','1.00000000000e+00','4.34300000000e+03','SW Park Pl & Green','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Washington Park/Oregon Zoo','300','BUS','False','0101000020E61000004E4CB6EDBBAC5EC054AF3522BCC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('60','0831','83','1.00000000000e+00','4.34600000000e+03','SW Park Pl & Lewis & Clark','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Washington Park/Oregon Zoo','350','BUS','False','0101000020E610000013554A15D7AC5EC056C20955BCC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('61','0831','83','1.00000000000e+00','4.35100000000e+03','SW Rose Garden Way & Wright','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Washington Park/Oregon Zoo','400','BUS','False','0101000020E610000033279FF618AD5EC0865E3974C6C24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('62','0831','83','1.00000000000e+00','1.11510000000e+04','SW Rose Garden Blvd & Sherwood','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Washington Park/Oregon Zoo','450','BUS','False','0101000020E61000002C4221A232AD5EC03A6018625CC24640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('63','0831','83','1.00000000000e+00','1.32530000000e+04','SW Kingston & Archery Range','Portland','9.72050000000e+04','83','83-Washington Park Loop','To Washington Park/Oregon Zoo','500','BUS','False','0101000020E61000001FE651716DAD5EC040A666E9D1C14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('64','0831','83','1.00000000000e+00','3.27700000000e+03','SW Knight & Kingston','Portland','9.72210000000e+04','83','83-Washington Park Loop','To Washington Park/Oregon Zoo','550','BUS','False','0101000020E6100000E5909C1AE2AD5EC0EC3565DD96C14640');
INSERT INTO "public"."transit_stops" ("objectid","keyitem","rte","dir","loc_id","location","jurisdic","zip","route","rte_desc","dir_desc","stop_seq","type","frequent",geom) VALUES ('65','0831','83','1.00000000000e+00','1.02990000000e+04','MAX Station/Oregon Zoo','Portland','9.72210000000e+04','83','83-Washington Park Loop','To Washington Park/Oregon Zoo','600','BUS','False','0101000020E610000021CE2F99E8AD5EC0D28CE66657C14640');
CREATE INDEX ON "public"."transit_stops" USING GIST ("geom");
COMMIT;
ANALYZE "public"."transit_stops";