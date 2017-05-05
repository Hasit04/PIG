job_petition = LOAD '/user/hive/warehouse/h1b_final'  using PigStorage() as (s_no:int , case_status:chararray , employer_name:chararray , soc_name:chararray , job_title:chararray , full_time_position:chararray , prevailing_wage:int , year:chararray , worksite:chararray , longitute:double , latitute:double);

scase = FILTER job_petition by $1 in ('CERTIFIED' , 'CERTIFIED-WITHDRAWN');

step2 = group scase by $4;

step3 = group job_petition by $4;

step4 = FOREACH step2 GENERATE group , COUNT(scase.$0);

step5 = FOREACH step3 GENERATE group , COUNT(job_petition.$0);

step6 = JOIN step4 by $0 , step5 by $0;

step7 = FILTER step6 by $1>1000;

step8 = FOREACH step7 GENERATE $0,$1,((double)$1/$3)*100;

step9 = FILTER step8 by $2>70;



dump step9;

