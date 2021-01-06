filename in1 'SEERStat_Breast_2004_2009.txt';

data casedat;
  /*NOTE: The data file was created using the Windows format line delimiter.*/
  /*The TERMSTR=CRLF input option for reading the file in UNIX, requires SAS version 9.*/
  infile in1 LRECL = 32000 delimiter = ',' TERMSTR = CRLF;

  length Agee_All_50_50 $8
    Patient_ID $19
    Record_number $7
    Age_at_diagnosis $9
    Race_recode_White_Black_Other $59
    Sex $15
    Vitalstatusrecodestudycutoffus $5
    Month_of_diagnosis_recode $9
    Year_of_diagnosis $9
    Month_of_follow_up_recode $9
    Year_of_follow_up_recode $4
    End_Calc_Vital_Status_Adjusted $12
    ;
  /*NOTE: skipping over field names*/
  if _N_ = 1 then input;
  input Agee_All_50_50 $
    Patient_ID $
    Record_number $
    Age_at_diagnosis $
    Race_recode_White_Black_Other $
    Sex $
    Vitalstatusrecodestudycutoffus $
    Month_of_diagnosis_recode $
    Year_of_diagnosis $
    Month_of_follow_up_recode $
    Year_of_follow_up_recode $
    End_Calc_Vital_Status_Adjusted $
    Begin_Calc_Age_Adjusted
    Number_of_Intervals_Calculated
    ;
  label Agee_All_50_50 = "Agee (All, <50, 50+)"
    Patient_ID = "Patient ID"
    Record_number = "Record number"
    Age_at_diagnosis = "Age at diagnosis"
    Race_recode_White_Black_Other = "Race recode (White, Black, Other)"
    Sex = "Sex"
    Vitalstatusrecodestudycutoffus = "Vital status recode (study cutoff used)"
    Month_of_diagnosis_recode = "Month of diagnosis recode"
    Year_of_diagnosis = "Year of diagnosis"
    Month_of_follow_up_recode = "Month of follow-up recode"
    Year_of_follow_up_recode = "Year of follow-up recode"
    End_Calc_Vital_Status_Adjusted = "End Calc Vital Status (Adjusted)"
    Begin_Calc_Age_Adjusted = "Begin Calc Age (Adjusted)"
    Number_of_Intervals_Calculated = "Number of Intervals (Calculated)"
    ;
run;

