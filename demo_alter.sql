
SET search_path = i2b2demodata, pg_catalog;


ALTER TABLE archive_observation_fact
	DROP COLUMN text_search_index,
	ALTER COLUMN encounter_num TYPE numeric(38,0) /* TYPE change - table: archive_observation_fact original: integer new: numeric(38,0) */,
	ALTER COLUMN patient_num TYPE numeric(38,0) /* TYPE change - table: archive_observation_fact original: integer new: numeric(38,0) */,
	ALTER COLUMN instance_num TYPE numeric(18,0) /* TYPE change - table: archive_observation_fact original: integer new: numeric(18,0) */,
	ALTER COLUMN upload_id TYPE numeric(38,0) /* TYPE change - table: archive_observation_fact original: integer new: numeric(38,0) */,
	ALTER COLUMN archive_upload_id TYPE numeric(22,0) /* TYPE change - table: archive_observation_fact original: integer new: numeric(22,0) */;

ALTER TABLE code_lookup
	ALTER COLUMN upload_id TYPE numeric(38,0) /* TYPE change - table: code_lookup original: integer new: numeric(38,0) */;

ALTER TABLE concept_dimension
	ADD COLUMN table_name character varying(255),
	ALTER COLUMN concept_cd SET NOT NULL,
	ALTER COLUMN upload_id TYPE bigint /* TYPE change - table: concept_dimension original: integer new: bigint */;

ALTER TABLE datamart_report
	ALTER COLUMN total_patient TYPE numeric(38,0) /* TYPE change - table: datamart_report original: integer new: numeric(38,0) */,
	ALTER COLUMN total_observationfact TYPE numeric(38,0) /* TYPE change - table: datamart_report original: integer new: numeric(38,0) */,
	ALTER COLUMN total_event TYPE numeric(38,0) /* TYPE change - table: datamart_report original: integer new: numeric(38,0) */;

ALTER TABLE encounter_mapping
	DROP COLUMN project_id,
	ALTER COLUMN encounter_num TYPE numeric(38,0) /* TYPE change - table: encounter_mapping original: integer new: numeric(38,0) */,
	ALTER COLUMN patient_ide DROP NOT NULL,
	ALTER COLUMN patient_ide_source DROP NOT NULL,
	ALTER COLUMN upload_id TYPE numeric(38,0) /* TYPE change - table: encounter_mapping original: integer new: numeric(38,0) */;

ALTER TABLE modifier_dimension
	ADD COLUMN modifier_level bigint,
	ADD COLUMN modifier_node_type character varying(10),
	ALTER COLUMN upload_id TYPE bigint /* TYPE change - table: modifier_dimension original: integer new: bigint */;

ALTER TABLE observation_fact
	DROP COLUMN text_search_index,
	ADD COLUMN trial_visit_num numeric(38,0),
	ADD COLUMN sample_cd character varying(200),
	ALTER COLUMN encounter_num TYPE numeric(38,0) /* TYPE change - table: observation_fact original: integer new: numeric(38,0) */,
	ALTER COLUMN patient_num TYPE numeric(38,0) /* TYPE change - table: observation_fact original: integer new: numeric(38,0) */,
	ALTER COLUMN modifier_cd DROP DEFAULT,
	ALTER COLUMN instance_num TYPE numeric(18,0) /* TYPE change - table: observation_fact original: integer new: numeric(18,0) */,
	ALTER COLUMN instance_num DROP DEFAULT,
	ALTER COLUMN upload_id TYPE numeric(38,0) /* TYPE change - table: observation_fact original: integer new: numeric(38,0) */;

ALTER TABLE patient_dimension
	ALTER COLUMN patient_num TYPE numeric(38,0) /* TYPE change - table: patient_dimension original: integer new: numeric(38,0) */,
	ALTER COLUMN age_in_years_num TYPE numeric(38,0) /* TYPE change - table: patient_dimension original: integer new: numeric(38,0) */,
	ALTER COLUMN zip_cd TYPE character varying(50) /* TYPE change - table: patient_dimension original: character varying(10) new: character varying(50) */,
	ALTER COLUMN sourcesystem_cd TYPE character varying(107) /* TYPE change - table: patient_dimension original: character varying(50) new: character varying(107) */,
	ALTER COLUMN upload_id TYPE numeric(38,0) /* TYPE change - table: patient_dimension original: integer new: numeric(38,0) */;

ALTER TABLE patient_mapping
	DROP COLUMN project_id,
	ALTER COLUMN patient_num TYPE numeric(38,0) /* TYPE change - table: patient_mapping original: integer new: numeric(38,0) */,
	ALTER COLUMN upload_id TYPE numeric(38,0) /* TYPE change - table: patient_mapping original: integer new: numeric(38,0) */;

ALTER TABLE provider_dimension
	ALTER COLUMN upload_id TYPE numeric(38,0) /* TYPE change - table: provider_dimension original: integer new: numeric(38,0) */;

ALTER TABLE qt_analysis_plugin
	ALTER COLUMN plugin_id TYPE numeric(10,0) /* TYPE change - table: qt_analysis_plugin original: integer new: numeric(10,0) */;

ALTER TABLE qt_analysis_plugin_result_type
	ALTER COLUMN plugin_id TYPE numeric(10,0) /* TYPE change - table: qt_analysis_plugin_result_type original: integer new: numeric(10,0) */,
	ALTER COLUMN result_type_id TYPE numeric(10,0) /* TYPE change - table: qt_analysis_plugin_result_type original: integer new: numeric(10,0) */;

ALTER TABLE qt_patient_enc_collection
	ALTER COLUMN patient_enc_coll_id TYPE numeric(10,0) /* TYPE change - table: qt_patient_enc_collection original: integer new: numeric(10,0) */,
	ALTER COLUMN patient_enc_coll_id SET DEFAULT nextval('qt_sq_qper_pecid'::regclass),
	ALTER COLUMN result_instance_id TYPE numeric(5,0) /* TYPE change - table: qt_patient_enc_collection original: integer new: numeric(5,0) */,
	ALTER COLUMN set_index TYPE numeric(10,0) /* TYPE change - table: qt_patient_enc_collection original: integer new: numeric(10,0) */,
	ALTER COLUMN patient_num TYPE numeric(10,0) /* TYPE change - table: qt_patient_enc_collection original: integer new: numeric(10,0) */,
	ALTER COLUMN encounter_num TYPE numeric(10,0) /* TYPE change - table: qt_patient_enc_collection original: integer new: numeric(10,0) */;

ALTER TABLE qt_patient_set_collection
	ALTER COLUMN patient_set_coll_id TYPE numeric(10,0) /* TYPE change - table: qt_patient_set_collection original: bigint new: numeric(10,0) */,
	ALTER COLUMN patient_set_coll_id SET DEFAULT nextval('qt_sq_qpr_pcid'::regclass),
	ALTER COLUMN result_instance_id TYPE numeric(5,0) /* TYPE change - table: qt_patient_set_collection original: integer new: numeric(5,0) */,
	ALTER COLUMN set_index TYPE numeric(10,0) /* TYPE change - table: qt_patient_set_collection original: integer new: numeric(10,0) */,
	ALTER COLUMN patient_num TYPE numeric(10,0) /* TYPE change - table: qt_patient_set_collection original: integer new: numeric(10,0) */;

ALTER TABLE qt_pdo_query_master
	ALTER COLUMN query_master_id TYPE numeric(5,0) /* TYPE change - table: qt_pdo_query_master original: integer new: numeric(5,0) */,
	ALTER COLUMN query_master_id SET DEFAULT nextval('qt_sq_pqm_qmid'::regclass);

ALTER TABLE qt_privilege
	ALTER COLUMN protection_label_cd DROP NOT NULL,
	ALTER COLUMN plugin_id TYPE numeric(10,0) /* TYPE change - table: qt_privilege original: integer new: numeric(10,0) */;

ALTER TABLE qt_query_instance
	ALTER COLUMN query_instance_id TYPE numeric(5,0) /* TYPE change - table: qt_query_instance original: integer new: numeric(5,0) */,
	ALTER COLUMN query_instance_id SET DEFAULT nextval('qt_sq_qi_qiid'::regclass),
	ALTER COLUMN query_master_id TYPE numeric(5,0) /* TYPE change - table: qt_query_instance original: integer new: numeric(5,0) */,
	ALTER COLUMN status_type_id TYPE numeric(5,0) /* TYPE change - table: qt_query_instance original: integer new: numeric(5,0) */;

ALTER TABLE qt_query_master
	DROP COLUMN pm_xml,
	ADD COLUMN request_constraints text,
	ADD COLUMN api_version text,
	ALTER COLUMN query_master_id TYPE numeric(5,0) /* TYPE change - table: qt_query_master original: integer new: numeric(5,0) */,
	ALTER COLUMN query_master_id SET DEFAULT nextval('qt_sq_qm_qmid'::regclass),
	ALTER COLUMN plugin_id TYPE numeric(10,0) /* TYPE change - table: qt_query_master original: integer new: numeric(10,0) */;

ALTER TABLE qt_query_result_instance
	ALTER COLUMN result_instance_id TYPE numeric(5,0) /* TYPE change - table: qt_query_result_instance original: integer new: numeric(5,0) */,
	ALTER COLUMN result_instance_id SET DEFAULT nextval('qt_sq_qri_qriid'::regclass),
	ALTER COLUMN query_instance_id TYPE numeric(5,0) /* TYPE change - table: qt_query_result_instance original: integer new: numeric(5,0) */,
	ALTER COLUMN result_type_id TYPE numeric(3,0) /* TYPE change - table: qt_query_result_instance original: integer new: numeric(3,0) */,
	ALTER COLUMN set_size TYPE numeric(10,0) /* TYPE change - table: qt_query_result_instance original: integer new: numeric(10,0) */,
	ALTER COLUMN status_type_id TYPE numeric(3,0) /* TYPE change - table: qt_query_result_instance original: integer new: numeric(3,0) */,
	ALTER COLUMN real_set_size TYPE numeric(10,0) /* TYPE change - table: qt_query_result_instance original: integer new: numeric(10,0) */;

ALTER TABLE qt_query_result_type
	ALTER COLUMN result_type_id TYPE numeric(3,0) /* TYPE change - table: qt_query_result_type original: integer new: numeric(3,0) */,
	ALTER COLUMN result_type_id SET DEFAULT nextval('qt_sq_qr_qrid'::regclass);

ALTER TABLE qt_query_status_type
	ALTER COLUMN status_type_id TYPE numeric(3,0) /* TYPE change - table: qt_query_status_type original: integer new: numeric(3,0) */,
	ALTER COLUMN status_type_id SET DEFAULT nextval('qt_sq_qs_qsid'::regclass);

ALTER TABLE qt_xml_result
	ALTER COLUMN xml_result_id TYPE numeric(5,0) /* TYPE change - table: qt_xml_result original: integer new: numeric(5,0) */,
	ALTER COLUMN xml_result_id SET DEFAULT nextval('qt_sq_qxr_xrid'::regclass),
	ALTER COLUMN result_instance_id TYPE numeric(5,0) /* TYPE change - table: qt_xml_result original: integer new: numeric(5,0) */,
	ALTER COLUMN xml_value TYPE character varying(4000) /* TYPE change - table: qt_xml_result original: text new: character varying(4000) */;

ALTER TABLE set_type
	ALTER COLUMN id SET DEFAULT nextval('sq_up_patdim_patientnum'::regclass);

ALTER TABLE set_upload_status
	ALTER COLUMN upload_id TYPE numeric /* TYPE change - table: set_upload_status original: integer new: numeric */,
	ALTER COLUMN no_of_record TYPE numeric /* TYPE change - table: set_upload_status original: bigint new: numeric */,
	ALTER COLUMN loaded_record TYPE numeric /* TYPE change - table: set_upload_status original: bigint new: numeric */,
	ALTER COLUMN deleted_record TYPE numeric /* TYPE change - table: set_upload_status original: bigint new: numeric */;

ALTER TABLE upload_status
	ALTER COLUMN upload_id TYPE numeric(38,0) /* TYPE change - table: upload_status original: integer new: numeric(38,0) */,
	ALTER COLUMN upload_id SET DEFAULT nextval('sq_uploadstatus_uploadid'::regclass),
	ALTER COLUMN no_of_record TYPE numeric /* TYPE change - table: upload_status original: bigint new: numeric */,
	ALTER COLUMN loaded_record TYPE numeric /* TYPE change - table: upload_status original: bigint new: numeric */,
	ALTER COLUMN deleted_record TYPE numeric /* TYPE change - table: upload_status original: bigint new: numeric */;

ALTER TABLE visit_dimension
	ALTER COLUMN encounter_num TYPE numeric(38,0) /* TYPE change - table: visit_dimension original: integer new: numeric(38,0) */,
	ALTER COLUMN patient_num TYPE numeric(38,0) /* TYPE change - table: visit_dimension original: integer new: numeric(38,0) */,
	ALTER COLUMN length_of_stay TYPE numeric(38,0) /* TYPE change - table: visit_dimension original: integer new: numeric(38,0) */,
	ALTER COLUMN upload_id TYPE numeric(38,0) /* TYPE change - table: visit_dimension original: integer new: numeric(38,0) */;



/*
ALTER TABLE async_job
	ADD CONSTRAINT async_job_pkey PRIMARY KEY (id);

ALTER TABLE encounter_mapping
	ADD CONSTRAINT encounter_mapping_pk PRIMARY KEY (encounter_ide, encounter_ide_source);

ALTER TABLE jms_messages
	ADD CONSTRAINT jms_messages_pkey PRIMARY KEY (messageid, destination);

ALTER TABLE jms_roles
	ADD CONSTRAINT jms_roles_pkey PRIMARY KEY (userid, roleid);

ALTER TABLE jms_subscriptions
	ADD CONSTRAINT jms_subscriptions_pkey PRIMARY KEY (clientid, subname);

ALTER TABLE jms_users
	ADD CONSTRAINT jms_users_pkey PRIMARY KEY (userid);

ALTER TABLE linked_file_collection
	ADD CONSTRAINT linked_file_collection_pkey PRIMARY KEY (id);

ALTER TABLE observation_fact
	ADD CONSTRAINT observation_fact_pkey PRIMARY KEY (encounter_num, patient_num, concept_cd, provider_id, instance_num, modifier_cd, start_date);

ALTER TABLE patient_mapping
	ADD CONSTRAINT patient_mapping_pk PRIMARY KEY (patient_ide, patient_ide_source);

ALTER TABLE qt_patient_enc_collection
	ADD CONSTRAINT qt_patient_enc_coll_pk PRIMARY KEY (patient_enc_coll_id);

ALTER TABLE sample_dimension
	ADD CONSTRAINT sample_dimension_pk PRIMARY KEY (sample_cd);

ALTER TABLE storage_system
	ADD CONSTRAINT storage_system_pkey PRIMARY KEY (id);

ALTER TABLE study
	ADD CONSTRAINT study_pk PRIMARY KEY (study_num);

ALTER TABLE supported_workflow
	ADD CONSTRAINT supported_workflow_pkey PRIMARY KEY (id);

ALTER TABLE timers
	ADD CONSTRAINT timers_pk PRIMARY KEY (timerid, targetid);

ALTER TABLE trial_visit_dimension
	ADD CONSTRAINT trial_visit_dimension_pk PRIMARY KEY (trial_visit_num);

ALTER TABLE upload_status
	ADD CONSTRAINT pk_up_upstatus_uploadid PRIMARY KEY (upload_id);

ALTER TABLE linked_file_collection
	ADD CONSTRAINT "SOURCE_SYSTEM_ID_ID_FK" FOREIGN KEY (source_system_id) REFERENCES storage_system(id);

ALTER TABLE linked_file_collection
	ADD CONSTRAINT "STUDY_ID_FK" FOREIGN KEY (study_id) REFERENCES study(study_num);

ALTER TABLE observation_fact
	ADD CONSTRAINT observation_fact_trial_visit_fk FOREIGN KEY (trial_visit_num) REFERENCES trial_visit_dimension(trial_visit_num);

ALTER TABLE qt_patient_enc_collection
	ADD CONSTRAINT qt_fk_pec_ri FOREIGN KEY (result_instance_id) REFERENCES qt_query_result_instance(result_instance_id);

ALTER TABLE study
	ADD CONSTRAINT study_bio_experiment_id_fk FOREIGN KEY (bio_experiment_id) REFERENCES biomart.bio_experiment(bio_experiment_id);

ALTER TABLE trial_visit_dimension
	ADD CONSTRAINT trial_visit_dimension_study_fk FOREIGN KEY (study_num) REFERENCES study(study_num);*/
