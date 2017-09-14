

-- Fix data of which TM doesn't understand the form. NB: This changes the data as I2B2 sees it. Alternatively you could just hide this data by setting trial_visit_num to null.


-- Change valtype_cd='D' to 'T' to treat them as text (D stands for Date in i2b2, TM doesn't support that (though it could))

update i2b2demodata.observation_fact set valtype_cd = 'T' where valtype_cd = 'D';

-- change L and G numeric types to E (exact)

update i2b2demodata.observation_fact set tval_char = 'E' where valtype_cd = 'N' and tval_char in ('G', 'L');

-- set valtype_cd to N where there is a number

update i2b2demodata.observation_fact set valtype_cd = 'N' where valtype_cd = '' and (tval_char = '' or tval_char is null) and nval_num is not null;

-- set tval_char to E for numbers that don't have it

update i2b2demodata.observation_fact set tval_char = 'E' where valtype_cd = 'N' and (tval_char = '' or tval_char is null);



-- Hide data that TM does not handle

-- This format is used (in this dataset) to store images, the tval_char containing a path to an image. We could also set type to T to make Transmart show the path as text.
update i2b2demodata.observation_fact set trial_visit_num = null where valtype_cd = '' and nval_num is null;


update i2b2demodata.observation_fact set trial_visit_num = null where valtype_cd = '@';

update i2b2demodata.observation_fact set trial_visit_num = null where valtype_cd = '' and nval_num is null and tval_char is null;
update i2b2demodata.observation_fact set trial_visit_num = null where valtype_cd = 'N' and nval_num is null;
update i2b2demodata.observation_fact set trial_visit_num = null where valtype_cd = 'T' and tval_char is null;

update i2b2demodata.observation_fact set trial_visit_num = null where valtype_cd = 'B';
