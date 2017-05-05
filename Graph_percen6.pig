step1 = Load '/user/hive/warehouse/h1b_final2'  using PigStorage('\t') as (s_no:int , case_status:chararray , employer_name:chararray , soc_name:chararray , job_title:chararray , full_time_position:chararray , prevailing_wage:int , year:chararray , worksite:chararray , longitute:double , latitute:double);

step2 = group step1 by ($7,$1);

step3 = group step1 by $7;

step4 = foreach step3 generate group, COUNT(step1);


step5 = foreach step2 generate group, COUNT(step1);

step6 = foreach step5 generate group.year,group.case_status, $1;

step7 = join step6 by $0, step4 by $0;

step8 = foreach step7 generate $0 ,$1, $2, ((double)$2/$4)*100;

dump step8
