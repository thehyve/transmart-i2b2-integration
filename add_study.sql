
-- Remove any leftover studies, assuming the I2B2 data overwrote all preexisting Transmart data
truncate table biomart.bio_experiment cascade;
truncate table i2b2demodata.study;
truncate table i2b2demodata.trial_visit_dimension

insert into biomart.bio_experiment (title, etl_id, accession) values ('Metadata not available', 'METADATA:ALL_I2B2_DATA', 'ALL_I2B2_DATA');
insert into i2b2demodata.study (study_id, secure_obj_token, bio_experiment_id) values
  ('ALL_I2B2_DATA', 'PUBLIC', (select bio_experiment_id from biomart.bio_experiment where accession = 'ALL_I2B2_DATA'));
insert into i2b2demodata.trial_visit_dimension (rel_time_label, study_num) values ('General', (select study_num from i2b2demodata.study where study_id = 'ALL_I2B2_DATA'));


-- Tell transmart which dimensions are valid for this study
insert into i2b2metadata.study_dimension_descriptions (dimension_description_id, study_id)
  select id, study_num from i2b2metadata.dimension_description , i2b2demodata.study
  where name in ('study', 'patient', 'concept', 'start time', 'end time', 'visit', 'provider') and study_id = 'ALL_I2B2_DATA';


-- Manual: Create modifier dimensions in i2b2metadata.dimension_description for the modifiers that the I2B2 data uses, and link them in i2b2metadata.study_dimension_descriptions
