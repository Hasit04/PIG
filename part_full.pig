Data_loading = LOAD '/user/hive/warehouse/h1b_final' using PigStorage('\t') as (s_no:int , case_status:chararray , employer_name:chararray , soc_name:chararray , job_title:chararray , full_time_position:chararray , prevailing_wage:int , year:chararray , worksite:chararray , longitute:double , latitute:double);

Filter_data = FOREACH Data_loading GENERATE $4 , $5 , $6 ,$7;

split Filter_data into PartTimeData if $1=='N', FullTimeData if $1=='Y';

part_time_year = GROUP PartTimeData by ($3 , $0);

full_time_year = GROUP FullTimeData by ($3 , $0);

PartTime_avg_wage = FOREACH part_time_year GENERATE group ,AVG(PartTimeData.$2), 'PartTime';

FullTime_avg_wage = FOREACH full_time_year GENERATE group ,AVG(FullTimeData.$2), 'FullTime';

Combine_Bag = UNION PartTime_avg_wage,FullTime_avg_wage;

Result_order = ORDER Combine_Bag by $1 desc;

--dump Data_loading;
--dump Filter_data;
--dump full_time_year;
--dump FullTime_avg_wage;
--dump Combine_Bag;(2016,SR. MANAGER I - INSIGHT ENGINE, GLOBAL CUSTOMER INSIGHTS &AMP; A),60112.0,PartTime)
dump Result_order;

-- 0 s.n-
-- 1 case_status
-- 2 employer_name
-- 5 JOB_TITLE: Title of the job
-- 6 FULL_TIME_POSITION
-- $2 Need to understand $2 stands for whiich column
