
SET search_path = i2b2metadata, pg_catalog;

ALTER TABLE custom_meta
	ALTER COLUMN c_hlevel TYPE bigint /* TYPE change - table: custom_meta original: integer new: bigint */,
	ALTER COLUMN c_totalnum TYPE bigint /* TYPE change - table: custom_meta original: integer new: bigint */,
	ALTER COLUMN c_dimcode TYPE character varying(900) /* TYPE change - table: custom_meta original: character varying(700) new: character varying(900) */;

ALTER TABLE i2b2
	ADD COLUMN i2b2_id bigint,
	ALTER COLUMN c_hlevel TYPE numeric(22,0) /* TYPE change - table: i2b2 original: integer new: numeric(22,0) */,
	ALTER COLUMN c_totalnum TYPE numeric(22,0) /* TYPE change - table: i2b2 original: integer new: numeric(22,0) */,
	ALTER COLUMN c_tablename TYPE character varying(150) /* TYPE change - table: i2b2 original: character varying(50) new: character varying(150) */;

ALTER TABLE ont_process_status
	ALTER COLUMN process_id TYPE numeric(5,0) /* TYPE change - table: ont_process_status original: integer new: numeric(5,0) */,
	ALTER COLUMN process_id SET DEFAULT nextval('ont_sq_ps_prid'::regclass),
	ALTER COLUMN crc_upload_id TYPE character varying(5) /* TYPE change - table: ont_process_status original: integer new: character varying(5) */,
	ALTER COLUMN message TYPE character varying(2000) /* TYPE change - table: ont_process_status original: text new: character varying(2000) */;

ALTER TABLE table_access
	ALTER COLUMN c_table_cd TYPE character varying(65) /* TYPE change - table: table_access original: character varying(50) new: character varying(65) */,
	ALTER COLUMN c_hlevel TYPE numeric(22,0) /* TYPE change - table: table_access original: integer new: numeric(22,0) */,
	ALTER COLUMN c_totalnum TYPE numeric(22,0) /* TYPE change - table: table_access original: integer new: numeric(22,0) */;

ALTER SEQUENCE dimension_description_id_seq
	OWNED BY dimension_description.id;
