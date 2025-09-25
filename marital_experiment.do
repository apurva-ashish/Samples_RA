
**BDM II Project with Lucas Mandrisch***

clear all
import delimited "/Users/apurv/Downloads/Marital_28+June+2025_18.20.csv"

/*==============================================================================
01. Data cleaning; min_age == range_lb, max_age == range_ub, relationships_1 - 8 == statement1 - 8
==============================================================================*/

drop if progress != 100
drop if age == .

drop startdate enddate status progress durationinseconds finished recordeddate responseid distributionchannel userlanguage consentform scenario1_54 scenario2_2 scenario3_2 scenario4_2 scenario5_2

rename range_1_1 range_lb
destring range_lb, replace force
label value range_lb range_lb
label var range_lb range_lb

rename range_1_2 range_ub
destring range_ub, replace force
label value range_ub range_ub
label var range_ub range_ub

drop if range_lb == .
drop if range_ub == .

label define sex 1 "[1] male", add 
label define sex 2 "[2] female", add
label define sex 3 "[3] non-binary / third gender", add
label define sex 4 "[4] if other, please specify", add
label value sex sex

rename sex_4_text sex_t
label var sex_t sex_t

label define orientation 1 "[1] heterosexual", add 
label define orientation 2 "[2] homosexual", add
label define orientation 3 "[3] bisexual", add
label define orientation 4 "[4] if other, please specify", add
label define orientation 5 "[5] prefer not to say", add
label value orientation orientation

rename orientation_4_text orientation_t
label var orientation_t orientation_t

g alt_orientation = 1 if orientation == 1
replace alt_orientation = 1 if orientation_t == "Straight "
replace alt_orientation = 2 if orientation == 2 | orientation == 3
replace alt_orientation = 2 if orientation_t == "Asexual" | orientation_t == "Asexual but heteroromantic" | orientation_t == "Asexual, biromantic" | orientation_t == "Pansexual" | orientation_t == "Queer" | orientation_t == "asexual" | orientation_t == "lesbian" | orientation_t == "pansexual"
label define alt_orientation 1 "[1] heterosexual", add 
label define alt_orientation 2 "[2] lgbtqiap+", add
label value alt_orientation alt_orientation
label var alt_orientation "Alternative sexual orientation classification"

label define country 1 "[1] Afghanistan", add 
label define country 2 "[2] Albania", add
label define country 3 "[3] Algeria", add
label define country 4 "[4] Andorra", add
label define country 5 "[5] Angola", add

label define country 6 "[6] Antigua and Barbuda", add 
label define country 7 "[7] Argentina", add
label define country 8 "[8] Armenia", add
label define country 9 "[9] Australia", add
label define country 10 "[10] Austria", add

label define country 11 "[11] Azerbaijan", add 
label define country 12 "[12] Bahamas", add
label define country 13 "[13] Bahrain", add
label define country 14 "[14] Bangladesh", add
label define country 15 "[15] Barbados", add

label define country 16 "[16] Belarus", add 
label define country 17 "[17] Belgium", add
label define country 18 "[18] Belize", add
label define country 19 "[19] Benin", add
label define country 20 "[20] Bhutan", add

label define country 21 "[21] Bolivia", add 
label define country 22 "[22] Bosnia and Herzegovina", add
label define country 23 "[23] Botswana", add
label define country 24 "[24] Brazil", add
label define country 25 "[25] Brunei Darussalam", add

label define country 26 "[26] Bulgaria", add 
label define country 27 "[27] Burkina Faso", add
label define country 28 "[28] Burundi", add
label define country 29 "[29] Cambodia", add
label define country 30 "[30] Cameroon", add

label define country 31 "[31] Canada", add 
label define country 32 "[32] Cape Verde", add
label define country 33 "[33] Central African Republic", add
label define country 34 "[34] Chad", add
label define country 35 "[35] Chile", add

label define country 36 "[36] China", add 
label define country 37 "[37] Colombia", add
label define country 38 "[38] Comoros", add
label define country 39 "[39] Congo, Republic of the ...", add
label define country 40 "[40] Costa Rica", add

label define country 41 "[41] Cote d'Ivoire", add 
label define country 42 "[42] Croatia", add
label define country 43 "[43] Cuba", add
label define country 44 "[44] Cyprus", add
label define country 45 "[45] Czech Republic", add

label define country 47 "[47] Democratic Republic of the Congo", add
label define country 48 "[48] Denmark", add
label define country 49 "[49] Djibouti", add
label define country 50 "[50] Dominica", add

label define country 51 "[51] Dominican Republic", add 
label define country 52 "[52] Ecuador", add
label define country 53 "[53] Egypt", add
label define country 54 "[54] El Salvador", add
label define country 55 "[55] Equatorial Guinea", add

label define country 56 "[56] Eritrea", add 
label define country 57 "[57] Estonia", add
label define country 58 "[58] Ethiopia", add
label define country 59 "[59] Fiji", add
label define country 60 "[60] Finland", add

label define country 61 "[61] France", add 
label define country 62 "[62] Gabon", add
label define country 63 "[63] Gambia", add
label define country 64 "[64] Georgia", add
label define country 65 "[65] Germany", add

label define country 66 "[66] Ghana", add 
label define country 67 "[67] Greece", add
label define country 68 "[68] Grenada", add
label define country 69 "[69] Guatemala", add
label define country 70 "[70] Guinea", add

label define country 71 "[71] Guinea-Bissau", add 
label define country 72 "[72] Guyana", add
label define country 73 "[73] Haiti", add
label define country 74 "[74] Honduras", add
label define country 75 "[75] Hong Kong (S.A.R.)", add

label define country 76 "[76] Hungary", add 
label define country 77 "[77] Iceland", add
label define country 78 "[78] India", add
label define country 79 "[79] Indonesia", add
label define country 80 "[80] Iran", add

label define country 81 "[81] Iraq", add 
label define country 82 "[82] Ireland", add
label define country 83 "[83] Israel", add
label define country 84 "[84] Italy", add
label define country 85 "[85] Jamaica", add

label define country 86 "[86] Japan", add 
label define country 87 "[87] Jordan", add
label define country 88 "[88] Kazakhstan", add
label define country 89 "[89] Kenya", add
label define country 90 "[90] Kiribati", add

label define country 91 "[91] Kuwait", add 
label define country 92 "[92] Kyrgyzstan", add
label define country 93 "[93] Lao People's Democratic Republic", add
label define country 94 "[94] Latvia", add
label define country 95 "[95] Lebanon", add

label define country 96 "[96] Lesotho", add 
label define country 97 "[97] Liberia", add
label define country 98 "[98] Libyan Arab Jamahiriya", add
label define country 99 "[99] Liechtenstein", add
label define country 100 "[100] Lithuania", add

label define country 101 "[101] Luxembourg", add 
label define country 102 "[102] Madagascar", add
label define country 103 "[103] Malawi", add
label define country 104 "[104] Malaysia", add
label define country 105 "[105] Maldives", add

label define country 106 "[106] Mali", add 
label define country 107 "[107] Malta", add
label define country 108 "[108] Marshall Islands", add
label define country 109 "[109] Mauritania", add
label define country 110 "[110] Mauritius", add

label define country 111 "[111] Mexico", add 
label define country 112 "[112] Micronesia, Federated States of...", add
label define country 113 "[113] Monaco", add
label define country 114 "[114] Mongolia", add
label define country 115 "[115] Montenegro", add

label define country 116 "[116] Morocco", add 
label define country 117 "[117] Mozambique", add
label define country 118 "[118] Myanmar", add
label define country 119 "[119] Namibia", add
label define country 120 "[120] Nauru", add

label define country 121 "[121] Nepal", add 
label define country 122 "[122] Netherlands", add
label define country 123 "[123] New Zealand", add
label define country 124 "[124] Nicaragua", add
label define country 125 "[125] Niger", add

label define country 126 "[126] Nigeria", add 
label define country 127 "[127] North Korea", add
label define country 128 "[128] Norway", add
label define country 129 "[129] Oman", add
label define country 130 "[130] Pakistan", add

label define country 131 "[131] Palau", add 
label define country 1358 "[1358] Palestine", add
label define country 132 "[132] Panama", add
label define country 133 "[133] Papua New Guinea", add
label define country 134 "[134] Paraguay", add
label define country 135 "[135] Peru", add

label define country 136 "[136] Philippines", add 
label define country 137 "[137] Poland", add
label define country 138 "[138] Portugal", add
label define country 139 "[139] Qatar", add

label define country 141 "[141] Republic of Moldova", add 
label define country 142 "[142] Romania", add
label define country 143 "[143] Russian Federation", add
label define country 144 "[144] Rwanda", add
label define country 145 "[145] Saint Kitts and Nevis", add

label define country 146 "[146] Saint Lucia", add 
label define country 147 "[147] Saint Vincent and the Grenadines", add
label define country 148 "[148] Samoa", add
label define country 149 "[149] San Marino", add
label define country 150 "[150] Sao Tome and Principe", add

label define country 151 "[151] Saudi Arabia", add 
label define country 152 "[152] Senegal", add
label define country 153 "[153] Serbia", add
label define country 154 "[154] Seychelles", add
label define country 155 "[155] Sierra Leone", add

label define country 156 "[156] Singapore", add 
label define country 157 "[157] Slovakia", add
label define country 158 "[158] Slovenia", add
label define country 159 "[159] Solomon Islands", add
label define country 160 "[160] Somalia", add

label define country 161 "[161] South Africa", add 
label define country 162 "[162] South Korea", add
label define country 163 "[163] Spain", add
label define country 164 "[164] Sri Lanka", add
label define country 165 "[165] Sudan", add

label define country 166 "[166] Suriname", add 
label define country 167 "[167] Swaziland", add
label define country 168 "[168] Sweden", add
label define country 169 "[169] Switzerland", add
label define country 170 "[170] Syrian Arab Republic", add

label define country 171 "[171] Tajikistan", add 
label define country 172 "[172] Thailand", add
label define country 173 "[173] The former Yugoslav Republic of Macedonia", add
label define country 174 "[174] Timor-Leste", add
label define country 175 "[175] Togo", add

label define country 176 "[176] Tonga", add 
label define country 177 "[177] Trinidad and Tobago", add
label define country 178 "[178] Tunisia", add
label define country 179 "[179] Turkey", add
label define country 180 "[180] Turkmenistan", add

label define country 181 "[181] Tuvalu", add 
label define country 182 "[182] Uganda", add
label define country 183 "[183] Ukraine", add
label define country 184 "[184] United Arab Emirates", add
label define country 185 "[185] United Kingdom of Great Britain and Northern Ireland", add

label define country 186 "[186] United Republic of Tanzania", add 
label define country 187 "[187] United States of America", add
label define country 188 "[188] Uruguay", add
label define country 189 "[189] Uzbekistan", add
label define country 190 "[190] Vanuatu", add

label define country 191 "[191] Venezuela, Bolivarian Republic of...", add 
label define country 192 "[192] Viet Nam", add
label define country 193 "[193] Yemen", add
label define country 580 "[580] Zambia", add
label define country 1357 "[1357] Zimbabwe", add
label value country country
label var country country

label var nationality nationality

rename nationality_2_text nationality_t
label var nationality_t nationality_t

label define education 1 "[1] lower education", add
label define education 2 "[2] medium education", add
label define education 3 "[3] higher education", add
label value education education
label var education education

g highereducation = 1 if education == 3
replace highereducation = 0 if highereducation == .

replace relationshipstatus = 8 if relationshipstatus == 7
replace relationshipstatus = 7 if relationshipstatus == 9
label define relationshipstatus 1 "[1] married", add
label define relationshipstatus 2 "[2] having a partner (living together or apart)", add
label define relationshipstatus 3 "[3] separated", add
label define relationshipstatus 4 "[4] divorced", add
label define relationshipstatus 5 "[5] widowed", add
label define relationshipstatus 6 "[6] single", add
label define relationshipstatus 7 "[7] if other, please specify", add
label define relationshipstatus 8 "[8] prefer not to say", add
label value relationshipstatus relationshipstatus
label var relationshipstatus relationshipstatus

rename relationshipstatus_9_text relationshipstatus_t
label var relationshipstatus_t relationshipstatus_t

replace polattitude = 1 if polattitude == 12
replace polattitude = 10 if polattitude == 13
replace polattitude = 11 if polattitude == 14
label define polattitude 1 "[1] Left", add
label define polattitude 11 "[11] Right", add
label value polattitude polattitude
label var polattitude polattitude

g alt1_polattitude = 0 if polattitude == 1
replace alt1_polattitude = 10 if polattitude == 2
replace alt1_polattitude = 20 if polattitude == 3
replace alt1_polattitude = 30 if polattitude == 4
replace alt1_polattitude = 40 if polattitude == 5
replace alt1_polattitude = 50 if polattitude == 6
replace alt1_polattitude = 60 if polattitude == 7
replace alt1_polattitude = 70 if polattitude == 8
replace alt1_polattitude = 80 if polattitude == 9
replace alt1_polattitude = 90 if polattitude == 10
replace alt1_polattitude = 100 if polattitude == 11
label define alt1_polattitude 0 "[0] left", add 
label define alt1_polattitude 100 "[100] right", add
label value alt1_polattitude alt1_polattitude
label var alt1_polattitude "Alternative 1 - political attitude classification"

g alt2_polattitude = 0 if polattitude == 1 | polattitude == 2 | polattitude == 3 | polattitude == 4 | polattitude == 5
replace alt2_polattitude = 100 if polattitude == 7 | polattitude == 8 | polattitude == 9 | polattitude == 10 | polattitude == 11
label define alt2_polattitude 0 "[0] left / left leaning", add 
label define alt2_polattitude 100 "[100] right leaning / right", add
label value alt2_polattitude alt2_polattitude
label var alt2_polattitude "Alternative 2 - political attitude classification"

label define familypolattitude 1 "[1] Left", add
label define familypolattitude 11 "[11] Right", add
label value familypolattitude familypolattitude
label var familypolattitude familypolattitude

g alt1_familypolattitude = 0 if familypolattitude == 1
replace alt1_familypolattitude = 10 if familypolattitude == 2
replace alt1_familypolattitude = 20 if familypolattitude == 3
replace alt1_familypolattitude = 30 if familypolattitude == 4
replace alt1_familypolattitude = 40 if familypolattitude == 5
replace alt1_familypolattitude = 50 if familypolattitude == 6
replace alt1_familypolattitude = 60 if familypolattitude == 7
replace alt1_familypolattitude = 70 if familypolattitude == 8
replace alt1_familypolattitude = 80 if familypolattitude == 9
replace alt1_familypolattitude = 90 if familypolattitude == 10
replace alt1_familypolattitude = 100 if familypolattitude == 11
label define alt1_familypolattitude 0 "[0] left", add 
label define alt1_familypolattitude 100 "[100] right", add
label value alt1_familypolattitude alt1_familypolattitude
label var alt1_familypolattitude "Alternative 1 - family political attitude classification"

g alt2_familypolattitude = 0 if familypolattitude == 1 | familypolattitude == 2 | familypolattitude == 3 | familypolattitude == 4 | familypolattitude == 5
replace alt2_familypolattitude = 100 if familypolattitude == 7 | familypolattitude == 8 | familypolattitude == 9 | familypolattitude == 10 | familypolattitude == 11
label define alt2_familypolattitude 0 "[0] left / left leaning", add 
label define alt2_familypolattitude 100 "[100] right leaning / right", add
label value alt2_familypolattitude alt2_familypolattitude
label var alt2_familypolattitude "Alternative 2 - family political attitude classification"

forval i = 1/5{
	label define neighbour_`i' 1 "[1] very comfortable", add
	label define neighbour_`i' 2 "[2] somewhat comfortable", add
	label define neighbour_`i' 3 "[3] indifferent", add
	label define neighbour_`i' 4 "[4] somewhat uncomfortable", add
	label define neighbour_`i' 5 "[5] very uncomfortable", add
	label value neighbour_`i' neighbour_`i'
	label var neighbour_`i' neighbour_`i'
}

forval i = 1/8{
	label define relationships_`i' 1 "[1] strongly diasgree", add
	label define relationships_`i' 2 "[2] disagree", add
	label define relationships_`i' 3 "[3] agree", add
	label define relationships_`i' 4 "[4] strongly agree", add
	label value relationships_`i' relationships_`i'
	label var relationships_`i' relationships_`i'
}

forval i = 1/5{
	rename scenario`i'_1 scenario`i'
	replace scenario`i' = 0 if scenario`i' == 1
	replace scenario`i' = 1 if scenario`i' == 2	
	label define scenario`i' 0 "[0] prefer age", add
	label define scenario`i' 1 "[1] prefer attitude", add
	label value scenario`i' scenario`i'
	label var scenario`i' scenario`i'
}

forval i = 1/10{
	label define scenario6_`i' 1 "[1] no, absolutely not", add
	label define scenario6_`i' 2 "[2] no, not likely", add
	label define scenario6_`i' 3 "[3] probably not", add
	label define scenario6_`i' 4 "[4] maybe / undecided", add
	label define scenario6_`i' 5 "[5] probably yes", add
	label define scenario6_`i' 6 "[6] yes, very likely", add
	label define scenario6_`i' 7 "[7] yes, absolutely", add
	label value scenario6_`i' scenario6_`i'
	label var scenario6_`i' scenario6_`i'
}

destring min_age, replace force
label value min_age min_age
label var min_age min_age

destring max_age, replace force
label value max_age max_age
label var max_age max_age

forval i = 1/8{
	label define statement`i' 1 "[1] very comfortable", add
	label define statement`i' 2 "[2] somewhat comfortable", add
	label define statement`i' 3 "[3] indifferent", add
	label define statement`i' 4 "[4] somewhat uncomfortable", add
	label value statement`i' statement`i'
	label var statement`i' statement`i'
}

label value scenario1_in_age scenario1_in_age
label var scenario1_in_age scenario1_in_age

label value scenario1_out_age scenario1_out_age
label var scenario1_out_age scenario1_out_age

label value scenario2_in_age scenario2_in_age
label var scenario2_in_age scenario2_in_age

label value scenario2_out_age scenario2_out_age
label var scenario2_out_age scenario2_out_age

label value scenario3_in_age scenario3_in_age
label var scenario3_in_age scenario3_in_age

label value scenario3_out_age scenario3_out_age
label var scenario3_out_age scenario3_out_age

label value scenario4_in_age scenario4_in_age
label var scenario4_in_age scenario4_in_age

label value scenario4_out_age scenario4_out_age
label var scenario4_out_age scenario4_out_age

label value scenario5_in_age scenario5_in_age
label var scenario5_in_age scenario5_in_age

label value scenario5_out_age scenario5_out_age
label var scenario5_out_age scenario5_out_age

forval i = 1/5{
	g scenario`i'_att = 0 if scenario`i'_participantattitude == "Conservative"
	replace scenario`i'_att = 1 if scenario`i'_participantattitude == "Liberal"
	label define scenario`i'_att 0 "[0] Conservative", add 
	label define scenario`i'_att 1 "[1] Liberal", add
	label value scenario`i'_att scenario`i'_att
	label var scenario`i'_att "scenario`i'_att"
}

/*==============================================================================
02. Calculating the age distance & absolute value of age distance & absolute value of age distance in combination of whether the number was below the lower bound or above the upper bound
==============================================================================*/

forval i = 1/5{
	g agedistance`i' = scenario`i'_out_age - range_ub
	replace agedistance`i' = scenario`i'_out_age - range_lb if agedistance`i' < 0
	label var agedistance`i' "Distance from lower / upper bound of age range"
}

egen mean_agedistance = rowmean(agedistance1 agedistance2 agedistance3 agedistance4 agedistance5)
label var mean_agedistance "Mean distance from lower / upper bound of age range over the five scenaria"

g abs_mean_agedistance = abs(mean_agedistance)
label var abs_mean_agedistance`i' "Absolute mean distance from lower / upper bound of age range over the five scenaria"

g round_abs_mean_agedistance = round(abs_mean_agedistance)
label var round_abs_mean_agedistance "Absolute mean distance from lower / upper bound of age range over the five scenaria (rounded)"

forval i = 1/5{
	g absagedistance`i' = abs(agedistance`i')
	label var absagedistance`i' "Absolute distance from lower / upper bound of age range"
}

egen mean_absagedistance = rowmean(absagedistance1 absagedistance2 absagedistance3 absagedistance4 absagedistance5)
label var mean_absagedistance "Mean absolute distance from lower / upper bound of age range over the five scenaria"

forval i = 1/5{
	g belowabove`i' = 0 if agedistance`i' < 0
	replace belowabove`i' = 1 if agedistance`i' > 0
	label var belowabove`i' "Whether scenario is below the lower bound or above the upper bound"
}

g abs_belowabove = 0 if mean_agedistance < 0
replace abs_belowabove = 1 if mean_agedistance >= 0
label var abs_belowabove "Absolute value over range of the five scenario of mean age distance"

/*==============================================================================
03. Make Scenaria 0/1 outcomes
==============================================================================*/

forval i = 1/5{
	g scenarioage`i' = 1 if scenario`i' == 0
	replace scenarioage`i' = 0 if scenario`i' == 1
	g scenarioatt`i' = 1 if scenario`i' == 1
	replace scenarioatt`i' = 0 if scenario`i' == 0
	label var scenarioage`i' "In scenario `i' the age option has been chosen"
	label var scenarioatt`i' "In scenario `i' the attitude option has been chosen"
}

/*==============================================================================
04. Build indices across the 5 scenaria
==============================================================================*/

*** Index for all 5 scenario answers (0/1 where 1 means the repsondent has always opted for the preferred attitude)

g count_1 = (scenario1 == 1) + (scenario2 == 1) + (scenario3 == 1) + (scenario4 == 1) + (scenario5 == 1)

g indexscenario = .
replace indexscenario = 100	if count_1 == 5
replace indexscenario = 80	if count_1 == 4
replace indexscenario = 60	if count_1 == 3
replace indexscenario = 40	if count_1 == 2
replace indexscenario = 20	if count_1 == 1
replace indexscenario = 0	if count_1 == 0

drop count_1
label var indexscenario "Index for the 5 scenaria"

*** Index for all 5 scenario answers (if not matched with statement on relgiious values), otherwise an index out of 4 scenario answers

g alt_indexscenario = indexscenario

g drop_scenario = .
replace drop_scenario = 1 if scenario1_matchedstatement == 6
replace drop_scenario = 2 if scenario2_matchedstatement == 6 & missing(drop_scenario)
replace drop_scenario = 3 if scenario3_matchedstatement == 6 & missing(drop_scenario)
replace drop_scenario = 4 if scenario4_matchedstatement == 6 & missing(drop_scenario)
replace drop_scenario = 5 if scenario5_matchedstatement == 6 & missing(drop_scenario)

g count_alt_1 = .
replace count_alt_1 = (scenario2 == 1) + (scenario3 == 1) + (scenario4 == 1) + (scenario5 == 1) if drop_scenario == 1
replace count_alt_1 = (scenario1 == 1) + (scenario3 == 1) + (scenario4 == 1) + (scenario5 == 1) if drop_scenario == 2
replace count_alt_1 = (scenario1 == 1) + (scenario2 == 1) + (scenario4 == 1) + (scenario5 == 1) if drop_scenario == 3
replace count_alt_1 = (scenario1 == 1) + (scenario2 == 1) + (scenario3 == 1) + (scenario5 == 1) if drop_scenario == 4
replace count_alt_1 = (scenario1 == 1) + (scenario2 == 1) + (scenario3 == 1) + (scenario4 == 1) if drop_scenario == 5

replace alt_indexscenario = 100		if count_alt_1 == 4
replace alt_indexscenario = 75		if count_alt_1 == 3
replace alt_indexscenario = 50		if count_alt_1 == 2
replace alt_indexscenario = 25		if count_alt_1 == 1
replace alt_indexscenario = 0		if count_alt_1 == 0 
		
drop drop_scenario count_alt_1
label var alt_indexscenario "Alternative index for 5 resp. 4 scenaria"

*** Index for 5 out of the 7 attitude answers which were matched to the scenaria (0 - 100 where 100 means the repsondent has always opted for being liberal)

g count_1 = (scenario1_att == 1) + (scenario2_att == 1) + (scenario3_att == 1) + (scenario4_att == 1) + (scenario5_att == 1)

g indexattitude = .
replace indexattitude = 100	if count_1 == 5
replace indexattitude = 80	if count_1 == 4
replace indexattitude = 60	if count_1 == 3
replace indexattitude = 40	if count_1 == 2
replace indexattitude = 20	if count_1 == 1
replace indexattitude = 0	if count_1 == 0

drop count_1
label var indexattitude "Index for the 5 attitudes"

*** Index for 5 attitude answers (if not matched with statement on relgiious values), otherwise an index out of 4 attitude answers

g alt_indexattitude = indexattitude

g drop_attitude = .
replace drop_attitude = 1 if scenario1_matchedstatement == 6
replace drop_attitude = 2 if scenario2_matchedstatement == 6 & missing(drop_attitude)
replace drop_attitude = 3 if scenario3_matchedstatement == 6 & missing(drop_attitude)
replace drop_attitude = 4 if scenario4_matchedstatement == 6 & missing(drop_attitude)
replace drop_attitude = 5 if scenario5_matchedstatement == 6 & missing(drop_attitude)

g count_alt_1 = .
replace count_alt_1 = (scenario2_att == 1) + (scenario3_att == 1) + (scenario4_att == 1) + (scenario5_att == 1) if drop_attitude == 1
replace count_alt_1 = (scenario1_att == 1) + (scenario3_att == 1) + (scenario4_att == 1) + (scenario5_att == 1) if drop_attitude == 2
replace count_alt_1 = (scenario1_att == 1) + (scenario2_att == 1) + (scenario4_att == 1) + (scenario5_att == 1) if drop_attitude == 3
replace count_alt_1 = (scenario1_att == 1) + (scenario2_att == 1) + (scenario3_att == 1) + (scenario5_att == 1) if drop_attitude == 4
replace count_alt_1 = (scenario1_att == 1) + (scenario2_att == 1) + (scenario3_att == 1) + (scenario4_att == 1) if drop_attitude == 5

replace alt_indexattitude = 100		if count_alt_1 == 4
replace alt_indexattitude = 75		if count_alt_1 == 3
replace alt_indexattitude = 50		if count_alt_1 == 2
replace alt_indexattitude = 25		if count_alt_1 == 1
replace alt_indexattitude = 0		if count_alt_1 == 0 

drop drop_attitude count_alt_1
label var alt_indexattitude "Alternative index for 5 resp. 4 attitudes"

/*==============================================================================
05. Summary Statistics 
==============================================================================*/

/*==============================================================================
06. Regressions 
==============================================================================*/
/*==============================================================================
06.01 H1
==============================================================================*/

reg indexscenario i.alt1_polattitude age highereducation, r
margins alt1_polattitude, atmeans
marginsplot, recast(line) recastci(rarea) xtitle("Political Orientation") ytitle("Predicted Preference Index") title("Predicted Attitude/Age Preference by Political Orientation", size(medium)) xscale(range(0 100)) xlabel(0 "Left" 50 "Centre" 100 "Right") yscale(range(0 100)) ylabel(0 "Age" 50 `" "Equally" "Likely" "' 100 "Attitude")
graph export "/Users/apurv/Downloads/h1.jpg", as(jpg) name("Graph") quality(100) replace

/*==============================================================================
06.02 H2
==============================================================================*/

reg indexscenario i.round_abs_mean_agedistance age highereducation, r
margins round_abs_mean_agedistance, atmeans
marginsplot, recast(line) recastci(rarea) xtitle("Absolute Age distance outside preferred Age range") ytitle("Predicted Preference Index") title("Predicted Attitude/Age Preference by Age distance outside preferred Age range", size(medium)) xscale(range(0 11)) xlabel(0(1)11) yscale(range(0 100)) ylabel(0 "Age" 50 `" "Equally" "Likely" "' 100 "Attitude")
graph export "/Users/apurv/Downloads/h2.jpg", as(jpg) name("Graph") quality(100) replace

forval i = 1/5{
	reg scenario`i' i.absagedistance`i' age highereducation, r
	margins absagedistance`i', atmeans
	marginsplot, recast(line) recastci(rarea) xtitle("Absolute Age distance outside preferred Age range") ytitle("Predicted Preference Index") title("Predicted Attitude/Age Preference by Age distance outside preferred Age range (Scenario `i')", size(medium)) xscale(range(1 15)) xlabel(1(1)15) yscale(range(0 1)) ylabel(0 "Age" 0.5 `" "Equally" "Likely" "' 1 "Attitude")
	graph export "/Users/apurv/Downloads/h2_s`i'.jpg", as(jpg) name("Graph") quality(100) replace
}

/*==============================================================================
06.03 H3
==============================================================================*/

*** Sex

reg indexscenario i.round_abs_mean_agedistance age highereducation if sex == 1, r
margins round_abs_mean_agedistance, atmeans saving(male, replace)

reg indexscenario i.round_abs_mean_agedistance age highereducation if sex == 2, r
margins round_abs_mean_agedistance, atmeans saving(female, replace)

combomarginsplot male female, recast(line) recastci(rarea) labels("Male" "Female") xtitle("Absolute Age distance outside preferred Age range") ytitle("Predicted Preference Index") title("Predicted Attitude/Age Preference by Age distance outside preferred Age range - by Sex", size(small)) xscale(range(0 11)) xlabel(0(1)11) yscale(range(0 100)) ylabel(0 "Age" 50 `" "Equally" "Likely" "' 100 "Attitude") legend(pos(6) row(1))
	graph export "/Users/apurv/Downloads/h3.1.jpg", as(jpg) name("Graph") quality(100) replace

forval i = 1/5{
	reg scenario`i' i.absagedistance`i' age highereducation if sex == 1, r
	margins absagedistance`i', atmeans saving(male, replace)

	reg scenario`i' i.absagedistance`i' age highereducation if sex == 2, r
	margins absagedistance`i', atmeans saving(female, replace)

combomarginsplot male female, recast(line) recastci(rarea) labels("Male" "Female") xtitle("Absolute Age dstance outside preferred Age range") ytitle("Predicted Preference Index") title("Predicted Attitude/Age Preference by Age distance outside preferred Age range - by Sex (Scenario `i')", size(small)) xscale(range(1 15)) xlabel(1(1)15) yscale(range(0 1)) ylabel(0 "Age" 0.5 `" "Equally" "Likely" "' 1 "Attitude") legend(pos(6) row(1))
	graph export "/Users/lucasmandrisch/Downloads/h3.1_s`i'.jpg", as(jpg) name("Graph") quality(100) replace
}

*** Sexual Orientation

reg indexscenario i.round_abs_mean_agedistance age highereducation if alt_orientation == 1, r
margins round_abs_mean_agedistance, atmeans saving(heterosexual, replace)

reg indexscenario i.round_abs_mean_agedistance age highereducation if alt_orientation == 2, r
margins round_abs_mean_agedistance, atmeans saving(lgbtqiap+, replace)

combomarginsplot heterosexual lgbtqiap+, recast(line) recastci(rarea) labels("Heterosexual" "LGBTQIAP+") xtitle("Absolute Age distance outside preferred Age range") ytitle("Predicted Preference Index") title("Predicted Attitude/Age Preference by Age distance outside preferred Age range - by Sexual Orientation", size(small)) xscale(range(0 11)) xlabel(0(1)11) yscale(range(0 100)) ylabel(0 "Age" 50 `" "Equally" "Likely" "' 100 "Attitude") legend(pos(6) row(1))
	graph export "/Users/apurv/Downloads/h3.2.jpg", as(jpg) name("Graph") quality(100) replace

forval i = 1/5{
	reg scenario`i' i.absagedistance`i' age highereducation if alt_orientation == 1, r
	margins absagedistance`i', atmeans saving(heterosexual, replace)

	reg scenario`i' i.absagedistance`i' age highereducation if alt_orientation == 2, r
	margins absagedistance`i', atmeans saving(lgbtqiap+, replace)

combomarginsplot heterosexual lgbtqiap+, recast(line) recastci(rarea) labels("Heterosexual" "LGBTQIAP+") xtitle("Absolute Age distance outside preferred Age range") ytitle("Predicted Preference Index") title("Predicted Attitude/Age Preference by Age distance outside preferred Age range - by Sexual Orientation (Scenario `i')", size(small)) xscale(range(1 15)) xlabel(1(1)15) yscale(range(0 1)) ylabel(0 "Age" 0.5 `" "Equally" "Likely" "' 1 "Attitude") legend(pos(6) row(1))
	graph export "/Users/apurv/Downloads/h3.2_s`i'.jpg", as(jpg) name("Graph") quality(100) replace
}

/*==============================================================================
06.04 H4
==============================================================================*/

reg indexscenario i.round_abs_mean_agedistance highereducation if age >= 18 & age <= 22, r
margins round_abs_mean_agedistance, atmeans saving(young, replace)

reg indexscenario i.round_abs_mean_agedistance highereducation if age >= 23 & age <= 30, r
margins round_abs_mean_agedistance, atmeans saving(old, replace)

combomarginsplot young old, recast(line) recastci(rarea) labels("18 - 22" "23 - 30") xtitle("Absolute Age distance outside preferred Age range") ytitle("Predicted Preference Index") title("Predicted Attitude/Age Preference by Age distance outside preferred Age range - by Age Group", size(small)) xscale(range(0 11)) xlabel(0(1)11) yscale(range(0 100)) ylabel(0 "Age" 50 `" "Equally" "Likely" "' 100 "Attitude") legend(pos(6) row(1))
	graph export "/Users/apurv/Downloads/h4.jpg", as(jpg) name("Graph") quality(100) replace

forval i = 1/5{
	reg scenario`i' i.absagedistance`i' age highereducation if age >= 18 & age <= 22, r
	margins absagedistance`i', atmeans saving(young, replace)

	reg scenario`i' i.absagedistance`i' age highereducation if age >= 23 & age <= 30, r
	margins absagedistance`i', atmeans saving(old, replace)

combomarginsplot young old, recast(line) recastci(rarea) labels("18 - 22" "23 - 30") xtitle("Absolute Age dstance outside preferred Age range") ytitle("Predicted Preference Index") title("Predicted Attitude/Age Preference by Age distance outside preferred Age range - by Age Group (Scenario `i')", size(small)) xscale(range(1 15)) xlabel(1(1)15) yscale(range(0 1)) ylabel(0 "Age" 0.5 `" "Equally" "Likely" "' 1 "Attitude") legend(pos(6) row(1))
	graph export "/Users/apurv/Downloads/h4_s`i'.jpg", as(jpg) name("Graph") quality(100) replace
}

save "/Users/apurv/Downloads/marital.dta", replace
