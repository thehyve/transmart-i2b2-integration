Transmart on an I2b2 database
=============================


These scripts allow running Transmart on top of an I2b2 database. This is still a work in progress. 


The current scripts do not actually put the Transmart database dependencies into an I2b2 database, rather this works by importing the relevant tables from I2b2 into a transmart database, overwriting the transmart tables. Adding the tables transmart needs to an I2b2 database is still to be implemented.

Steps
-----

This assumes you already have a Transmart database set up on your local machine. Adapt commands as needed to connect to a remote machine.

Take dumps
~~~~~~~~~~

Take dumps of i2b2demodata and i2b2metadata from the I2b2 database

::

    pg_dump -h <i2b2_db_host> -U <i2b2_user> -n i2b2metadata -f i2b2metadata.sql --no-owner --no-acl i2b2
    pg_dump -h <i2b2_db_host> -U <i2b2_user> -n i2b2demodata -f i2b2demodata.sql --no-owner --no-acl i2b2

The i2b2 database usernames default to 'i2b2metadata' and 'i2b2demodata' with password 'demouser'.


Edit the database dump files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  - Remove the "CREATE DATABASE" statements near the top.
  - Remove the function definitions. I'm not sure how necessary this is, maybe it is not, but I did so to prevent any name clashes on those.
  - I also removed creation of COMMENTs and of constraints, though that is probably not necessary.

Remove the tables from the Transmart db
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    SET search_path = i2b2demodata, pg_catalog;

    DROP TABLE archive_observation_fact CASCADE;
    DROP TABLE code_lookup CASCADE;
    DROP TABLE concept_dimension CASCADE;
    DROP TABLE datamart_report CASCADE;
    DROP TABLE encounter_mapping CASCADE;
    DROP TABLE modifier_dimension CASCADE;
    DROP TABLE observation_fact CASCADE;
    DROP TABLE patient_dimension CASCADE;
    DROP TABLE patient_mapping CASCADE;
    DROP TABLE provider_dimension CASCADE;
    DROP TABLE qt_analysis_plugin CASCADE;
    DROP TABLE qt_analysis_plugin_result_type CASCADE;
    DROP TABLE qt_breakdown_path CASCADE;
    DROP TABLE qt_patient_enc_collection CASCADE;
    DROP TABLE qt_patient_set_collection CASCADE;
    DROP TABLE qt_pdo_query_master CASCADE;
    DROP TABLE qt_privilege CASCADE;
    DROP TABLE qt_query_instance CASCADE;
    DROP TABLE qt_query_master CASCADE;
    DROP TABLE qt_query_result_instance CASCADE;
    DROP TABLE qt_query_result_type CASCADE;
    DROP TABLE qt_query_status_type CASCADE;
    DROP TABLE qt_xml_result CASCADE;
    DROP TABLE set_type CASCADE;
    DROP TABLE set_upload_status CASCADE;
    DROP TABLE source_master CASCADE;
    DROP TABLE upload_status CASCADE;
    DROP TABLE visit_dimension CASCADE;


    SET search_path = i2b2metadata, pg_catalog;

    DROP TABLE birn CASCADE;
    DROP TABLE custom_meta CASCADE;
    DROP TABLE i2b2 CASCADE;
    DROP TABLE icd10_icd9 CASCADE;
    DROP TABLE ont_process_status CASCADE;
    DROP TABLE schemes CASCADE;
    DROP TABLE table_access CASCADE;


(Some of these tables may not exist in the transmart db)

This also drops a bunch of foreign key constraints that ideally should be added back again, but I have not done that.

Load the tables from the i2b2 dump
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

    psql -h localhost -U postgres transmart < i2b2metadata.sql
    psql -h localhost -U postgres transmart < i2b2demodata.sql

Dropping the tables in the previous step also removed a view that Transmart needs, so restore it:

::

    CREATE OR REPLACE VIEW i2b2demodata.modifier_dimension_view AS 
    SELECT md.modifier_path,
        md.modifier_cd,
        md.name_char,
        md.modifier_blob,
        md.update_date,
        md.download_date,
        md.import_date,
        md.sourcesystem_cd,
        md.upload_id,
        md.modifier_level,
        md.modifier_node_type,
        mm.valtype_cd,
        mm.std_units,
        mm.visit_ind
    FROM i2b2demodata.modifier_dimension md
        LEFT JOIN i2b2demodata.modifier_metadata mm ON md.modifier_cd::text = mm.modifier_cd::text;

    ALTER TABLE i2b2demodata.modifier_dimension_view
    OWNER TO i2b2demodata;
    GRANT ALL ON TABLE i2b2demodata.modifier_dimension_view TO i2b2demodata;
    GRANT ALL ON TABLE i2b2demodata.modifier_dimension_view TO tm_cz;
    GRANT SELECT ON TABLE i2b2demodata.modifier_dimension_view TO biomart_user;



Change table formats to what Transmart expects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change the format of the I2b2 tables to what Transmart expects. This mostly changes the type of numeric columns to another numeric type, so we need to check if this is in fact necessary. It also adds the trial_visit_num column to observation_fact.

These scripts were generated using apgdiff.

::

    psql -h localhost -U postgres transmart < meta_alter.sql
    psql -h localhost -U postgres transmart < demo_alter.sql


Create study
~~~~~~~~~~~~
    
Remove overwritten studies, and create a new study for the I2b2 data. Transmart works with studies, and all data must be part of a study as access control works at the study level. I2b2 does not have this notion.

::

    psql -h localhost -U postgres transmart < add_study.sql

This command creates a new study named ALL_I2B2_DATA, and adds the i2b2 data to it. It also registers a number of dimensions for this study, being 'study', 'patient', 'concept', 'start time', 'end time', 'visit' and 'provider'. If those dimensions don't match the actual i2b2 data you are importing, edit the command or change the study_dimension_descriptions table.

This script does not yet add dimensions for modifiers, that is still to be implemented. Without those the modifiers will be invisible to Transmart.

Fixup i2b2 data
~~~~~~~~~~~~~~~

I2b2 uses some datatypes that Transmart does not recognise such as date and blob, and numeric modifiers 'more than' and 'less than' while Transmart only supports 'exact'. The I2b2 demo dataset also has some invalid data that Transmart doesn't like. The following script fixes that up. It changes dates to text, makes all numbers exact, fixes some data that is unambiguous, and hides the rest from Transmart. This means it also modifies the data as I2b2 sees it if you run I2b2 and Transmart against the same database. If you don't want that you can choose to hide all data instead of changing it. In the long term Transmart should be updated to recognize more I2b2 datatypes, and the dataset should not include invalid data.

::

    psql -h localhost -U postgres transmart < fixup_i2b2_data.sql

Done
~~~~

At this point Transmart should be able to run against this database, and the data should be visible through the v2 rest api. The data is not visible in TransmartApp as we did not add the correct entries in i2b2_secure. I did not investigate this, so that is still to be done.

Other
-----

I have also added a database dump from what I got with this process. Transmart should readily run against this database. (Tested with transmart git revision 1ffe45b02acda82cc788125cbe4c2c5b5f9a39e8.)