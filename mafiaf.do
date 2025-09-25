import excel using "C:/Users/apurv/Downloads/mafia_final_version.xlsx", firstrow clear
describe
drop _merge
save "C:/Users/apurv/Downloads/loveusa.dta", replace
use "C:/Users/apurv/Downloads/loveusa.dta", clear
egen n_assets_total = rowtotal(n_assetsAbitazione n_assetsAltro n_assetsAppartamento ///
                               n_assetsBox_garage n_assetsMagazzino ///
                               n_assetsTerreno_agricolo   n_assetsTerreno_non_definito)
egen cr_mean = rowmean(cr_c1 cr_c2 cr_c3 cr_c4 cr_c5 cr_c6 cr_c7 cr_c8 ///
                       cr_c9 cr_c10 cr_c11 cr_c12 cr_c13 cr_c14 cr_c15 cr_16)

rename observation income

gen ln_pop = ln(pop)


gen ln_income = ln(income)

gen ln_unemp = ln(unemptot)


gen ln_assetsAbitazione = ln(n_assetsAbitazione + 0.01)
gen ln_assetsAltro      = ln(n_assetsAltro + 0.01)
gen ln_assetsAppartamento = ln(n_assetsAppartamento + 0.01)
gen ln_assetsBox_garage = ln(n_assetsBox_garage + 0.01)
gen ln_assetsMagazzino  = ln(n_assetsMagazzino + 0.01)
gen ln_assetsTerreno_agricolo = ln(n_assetsTerreno_agricolo + 0.01)
gen ln_assetsTerreno_non_definito = ln(n_assetsTerreno_non_definito + 0.01)
gen tax_evasion_index = 1 - cr_mean   
est clear
reghdfe tax_evasion_index ln_pop ln_income ln_unemp  corruption  regulatory government voice assets_per100k, absorb(region year) vce(cluster region)
 esttab using "R.tex", replace se b(3) se(3) label title(" Fixed Effect: Tax Evasion")
 eststo pi8: reghdfe tax_evasion_index ln_pop ln_income ln_unemp iqi assets_per100k, absorb(region year) vce(cluster region)
 esttab using "pi8.tex", replace se b(3) se(3) label title(" Fixed Effect: Tax Evasion")
ssc install diff
ssc install lgraph


egen total_assets_region = total(n_assets_total), by(region)


egen median_assets = median(total_assets_region)
gen high_asset_region = total_assets_region > median_assets
label var high_asset_region "High confiscated-asset region" 

gen post2011 = year >= 2011
label var post2011 "Post 2011 policy"

bysort region (year): gen first_conf_year = year if n_assets_total > 0


bysort region: egen first_conf_year_region = min(first_conf_year)


gen rel_year = year - first_conf_year_region


gen rel_year_pre = rel_year
replace rel_year_pre = . if rel_year_pre > -1   years

summ rel_year, meanonly

gen rel_year_nonneg = rel_year - r(min)


egen min_rel = min(rel_year)
gen rel_year_non = rel_year - min_rel
label var rel_year_non "Relative year (shifted to non-negative)"
* Event-study: factor variable interaction with high_asset_region
*reghdfe tax_evasion_index i.rel_year_non##i.high_asset_region ///
        ln_pop ln_income ln_unemp iqi, absorb(region year) vce(cluster region)
******OBSERVATION-- TOTALLLY INEFFECTIVE BEACUSE OF DATA ISSUES;to change to decide????


summ rel_year, meanonly
local minyr = r(min)


reghdfe tax_evasion i.rel_year_shift##i.high_asset_region ///
        ln_pop ln_income ln_unemp iqi, absorb(region year) vce(cluster region)

Store the model
ereturn list
mat list e(b)


matrix b = e(b)
local coefnames : colnames b


local keeplist
forval i = 1/`=colsof(b)' {
   
    if strpos("`name'", "#1.high_asset_region") {
       
        matrix val = b[1,`i']
        if val!=0 {
            local keeplist "`keeplist' `name'"
        }
    }
}


coefplot ES_model_shift, ///
    keep(`keeplist') ///
    drop(_cons) vertical ///
    yline(0) ///
    recast(line) msymbol(O) mlwidth(medthick) ///
    title("Event Study: High Asset Regions") ///
    legend(off)

gen rel_year_trim = rel_year_shift
replace rel_year_trim = -5 if rel_year_trim < -5
replace rel_year_trim = 5  if rel_year_trim > 5
reghdfe tax_evasion i.rel_year_trim##i.high_asset_region ///
    ln_pop ln_income ln_unemp iqi, absorb(region year) vce(cluster region)
estimates store ES_trim

* Store estimates
estimates store ES_trim

reghdfe tax_evasion i.rel_year_trim##i.high_asset_region ///
       ln_pop ln_income ln_unemp iqi, absorb(region) vce(cluster region)

estimates store ES_plot
eststo clear
eststo po: reghdfe tax_evasion_index ///
        ln_pop ln_income ln_unemp corruption regulatory government voice total_dissolutions assets_per100k, absorb(region year) vce(cluster region)
 esttab using "po.tex", replace se b(3) se(3) label title(" Fixed Effect: Tax Evasion")	
reghdfe tax_evasion i.rel_year_shift##i.high_asset_region ///
        ln_pop ln_income ln_unemp iqi, absorb(region) vce(cluster region)
estimates store ES


estimates store ES


coefplot ES, keep(*#1) drop(_cons) vertical ///
         yline(0) ///
         xlabel(-5(1)24) ///
         title("Event Study: High Asset Regions") ///
         recast(line) msymbol(O) mlwidth(medthick) legend(off)

reghdfe tax_evasion_index i.post2011##i.high_asset_region ///
        ln_pop ln_income ln_unemp corruption  regulatory government voice, absorb(region year) vce(cluster region)

estimates store DID_model

esttab DID_model using "DID_model.tex",  replace se b(3) se(3) label title(" DiD model")


gen rel_year_pos = rel_year + 10


reghdfe tax_evasion_index i.rel_year_pos##i.high_asset_region ///
       ln_pop ln_income ln_unemp corruption regulatory government voice assets_per100k, ///
       absorb(region year) vce(cluster region)
	   ereturn list

estimates store ES


coefplot ES, keep(*#1.high_asset_region) drop(_cons) vertical ///
    yline(0) title("Event Study: High Asset Regions") legend(off)


ssc install coefplot

coefplot ES, keep(*#1.high_asset_region) drop(_cons) ///
    vertical recast(connected) ciopts(recast(rcap) lcolor(blue)) ///
    yline(0, lpattern(dash) lcolor(black)) ///
    xlabel(-5(2)10, angle(vertical)) ///
    xtitle("Years relative to reform") ///
    ytitle("Tax Evasion Index") ///
    title("Event Study: High Asset Regions") ///
    msymbol(O) mcolor(blue) lcolor(blue) ///
    legend(off) grid(y)
	


gen assets_percap = n_assets_total / pop
gen assets_per100k = ln(assets_percap + 0.0001)    

********new DID version try to choose (later decide for the paper)

bysort region: egen assets_region_mean = mean(assets_per100k)
gen assets_region_dev = assets_per100k - assets_region_mean


gen post2011 = year >= 2011

reghdfe tax_evasion_index c.assets_region_dev##i.post2011 ///
        ln_pop ln_income ln_unemp corruption regulatory government voice, ///
        absorb(region year) vce(cluster region)

		

gen relativee_year = year - 2011  


egen min_rela = min(relativee_year)
gen rel_year_shifting = relativee_year - min_rela
label var rel_year_shifting "Relative year (shifted to non-negative)"


reghdfe tax_evasion_index i.rel_year_shifting##c.assets_per100k ///
        ln_pop ln_income ln_unemp corruption regulatory government voice, ///
        absorb(region year) vce(cluster region)

* Store estimates for plotting
estimates store ES_assets
**Pre-trend valid?????? (to check later again!)
* continuous valid??
reghdfe tax_evasion_index c.assets_per100k##i.rel_year_shifting ///
       ln_pop ln_income ln_unemp corruption regulatory government voice, ///
       absorb(region year) vce(cluster region)


estimates store ESP

matrix b = e(b)
local coefnames : colnames b


local keep_interactions
forval i=1/`=colsof(b)' {
    local name : word `i' of `coefnames'
    if strpos("`name'", "#c.assets_per100k") {
        local keep_interactions "`keep_interactions' `name'"
    }
}
coefplot ESP, keep(`keep_interactions') drop(_cons) vertical ///
         yline(0) ///
         recast(line) msymbol(O) mlwidth(medthick) ///
         xlabel(-5(1)15) ///
         title("Event Study: Tax Evasion vs Asset Intensity") ///
         legend(off)

		 
gen rel_year_trimming = rel_year_shift
replace rel_year_trimming = -5 if rel_year_trimming < -5
replace rel_year_trimming = 5  if rel_year_trimming > 5
label var rel_year_trimming "Relative year (trimmed)"


reghdfe tax_evasion_index i.rel_year_trim##c.assets_per100k ///
       ln_pop ln_income ln_unemp corruption regulatory government voice, ///
       absorb(region year) vce(cluster region)

estimates store ES_trim

*
matrix b = e(b)
local coefnames : colnames b
local keeplist
foreach name of local coefnames {
    if strpos("`name'", "#c.high_asset_region") { 
        * Extract year number from variable name
        local yr = real(regexs(1)) if regexm("`name'", "rel_year_trimming_(\-?\d+)#c.assets_per100k")
        * Keep only pre-treatment years
        if `yr' < 0 {
            local keeplist "`keeplist' `name'"
        }
    }
}

* Step 4: Plot pre-trends
coefplot ES_trim, keep(`keeplist') ///
    drop(_cons) vertical ///
    yline(0) ///
    recast(line) msymbol(O) mlwidth(medthick) ///
    title("Event Study: Pre-Trends Check (High Asset Regions)") ///
    legend(off)		 

summarize assets_per100k
local mean_assets = r(mean)


gen effect_assets_avg = .

local preyears -5 -4 -3 -2 -1


foreach yr of local preyears {

    local coefname : list coefnames if regexm("`coefnames'", "`yr'#c.assets_per100k") 

    
    capture confirm matrix e(b)
    if _rc == 0 {
        replace effect_assets_avg = _b[`yr'#c.assets_per100k] * `mean_assets' ///
            if rel_year_shifting == `yr'
    }
}
twoway (line effect_assets_avg rel_year_shifting), ///
       yline(0) ///
       xlabel(-5(-1)) ///
       xtitle("Relative Year") ///
       ytitle("Marginal effect of assets") ///
       title("Event Study: Pre-Trends Check (High Asset Regions)")
	   

gen pre_trend = rel_year_shifting if rel_year_shifting < 0


gen effect_assets = .
foreach yr of numlist -5/-1 {
    quietly replace effect_assets = _b[rel_year_trimming_`yr'#c.assets_per100k] * assets_per100k ///
        if rel_year_shifting == `yr'
}


twoway (line effect_assets pre_trend, sort), ///
       yline(0) ///
       xtitle("Relative Year") ///
       ytitle("Marginal effect of assets") ///
       title("Event Study: Pre-Trends Check (High Asset Regions)")
	   

matrix b = e(b)

local coefnames : colnames b


clear
set obs 0
gen rel_year = .
gen effect_assets = .


foreach name of local coefnames {
  
    if strpos("`name'", "#c.assets_per100k") {
       
        if regexm("`name'", "rel_year_shifting_(\-?\d+)#c.assets_per100k") {
            local yr = real(regexs(1))
           
            if `yr' < 0 {
              
                expand 1
                replace rel_year = `yr' in L
                replace effect_assets = b[1,"`name'"] in L
            }
        }
    }
}

* check for pre trends again?
twoway (line effect_assets rel_year, sort), ///
       yline(0) ///
       xtitle("Relative Year") ///
       ytitle("Marginal effect of assets") ///
       title("Event Study: Pre-Trends Check (High Asset Regions)")
	   

gen pre_trend = rel_year_shifting if rel_year_shifting < 0

gen pre_trend_assets = pre_trend * assets_per100k

tsset region year
destring region, replace

gen time = year - year[1]
gen post_2011 = (year >= 2011)

gen time_post = time * post_2011

* Run the ITS regression
eststo poi: reg tax_evasion_index time post_2011 time_post ln_pop ln_income ln_unemp corruption regulatory government voice assets_per100k, vce(cluster region)
esttab poi using "poi.tex",  replace se b(3) se(3) label title(" ITS model")

predict tax_evasion_predicted, xb


twoway (scatter tax_evasion_index year) (line tax_evasion_predicted year, sort), ///
       title("Tax Evasion Trends Before and After 2011 Reform") ///
       ytitle("Tax Evasion Index") ///
       xtitle("Year") ///
       legend(label(1 "Actual Tax Evasion") label(2 "Predicted Trend")) ///
       xline(2011, lcolor(red) lpattern(dash))
	   
***DiD Framework (check validity)***

import excel using "C:/Users/apurv/Downloads/loveu.xlsx", firstrow clear
describe
save "C:/Users/apurv/Downloads/loveu.dta",replace
use "C:/Users/apurv/Downloads/loveusa.dta"
 merge m:1 region year using "C:/Users/apurv/Downloads/loveu.dta"
eststo clear
 eststo pi90: reghdfe tax_evasion_index ln_pop ln_income ln_unemp corruption regulatory government voice assets_per100k , absorb(region year) vce(cluster region)
 esttab using "pi90.tex", replace se b(3) se(3) label title(" Fixed Effect: Tax Evasion")

eststo poi7: reg tax_evasion_index time post_2011 time_post ln_pop ln_income ln_unemp corruption regulatory government voice  assets_per100k, vce(cluster region)
esttab poi7 using "poi7.tex",  replace se b(3) se(3) label title(" ITS model")
* Get the predicted values after running the ITS regression
predict tax_evasion_pred1, xb

twoway (scatter tax_evasion_index year) (line tax_evasion_predicted year, sort), ///
       title("Tax Evasion Trends Before and After 2011 Reform") ///
       ytitle("Tax Evasion Index") ///
       xtitle("Year") ///
       legend(label(1 "Actual Tax Evasion") label(2 "Predicted Trend")) ///
       xline(2011, lcolor(red) lpattern(dash))
	   
***final DiD***
gen treated = (total_dissolutions > 0)
egen treated_region = max(treated), by(region)
egen year_first_dissolution = min(year) if treated_region == 1, by(region)
gen event_time = year - year_first_dissolution
egen region_id = group(region)
ssc install did_multiplegt, replace
ssc install did_imputation

bysort region_id (year): gen first_treat = year if treated == 1
egen first_treat_year = min(first_treat), by(region_id)


sum year
local max_year = r(max)
replace first_treat_year = `max_year' + 1 if first_treat_year == .

bysort region_id: egen first_treated_year = min(year) if total_dissolutions > 0


sum year
local max_year = r(max)
replace first_treated_year = `max_year' + 1 if first_treated_year == .

did_imputation Dissolutions region_id year first_treat_year, horizon(0)


bysort region_id (year): gen treated_year = year if treated == 1
.
bysort region_id: egen first_treat_year1 = min(treated_year)


sum year
local max_year = r(max)
replace first_treat_year1 = `max_year' + 1 if first_treat_year1 == .

egen region_id = group(region)


bysort region_id: egen first_treat_year9 = min(year) if total_dissolutions > 0


sum year
local max_year = r(max)
replace first_treat_year99 = `max_year' + 1 if first_treat_year99 == .

gen temp_treat_year = year if total_dissolutions > 0
bysort region_id: egen first_treat_year99 = min(temp_treat_year)


***final version re-doing alllll**
// binaries
gen ever_treated = (total_dissolutions > 0)
egen never_treated = max(ever_treated), by(region)
replace never_treated = 1 - never_treated
egen first_diss_year = min(year) if total_dissolutions > 0, by(region)
gen post = (year >= first_diss_year)
// Run the main DiD regression
reghdfe total_dissolutions c.ever_treated#c.post ln_pop ln_income ln_unemp corruption regulatory government voice, ///
    absorb(region_id year) vce(cluster region_id)

bysort region_id: gen first_treat_year11 = year if total_dissolutions > 0
bysort region_id: egen first_treat_year_final = min(first_treat_year1)
	

gen event_time1 = year - first_treat_year_final	
reghdfe total_dissolutions i.event_time ln_pop ln_income ln_unemp corruption regulatory government voice, ///
    absorb(region_id year) vce(cluster region_id)
xtset region_id year
xtreg total_dissolutions i.ever_treated#i.post ln_pop ln_income ln_unemp corruption regulatory government voice, fe vce(cluster region_id)	

replace total_dissolutions = 0 if missing(total_dissolutions)

gen has_dissolution = 0 if total_dissolutions == 0
replace has_dissolution = 1 if total_dissolutions > 0


bysort region_id: egen first_treat_year12 = min(year) if has_dissolution == 1


sum year
local max_year = r(max)
replace first_treat_year12 = `max_year' + 1 if first_treat_year12 == .	

did_imputation total_dissolutions region_id year first_treat_year12, autosample
did_imputation total_dissolutions region_id year first_treat_year12, autosample allhorizons minn(0)

event_plot
ssc install estout
did_imputation total_dissolutions region_id year first_treat_year12, autosample allhorizons minn(0) pretrends(5)
matrix list e(b)
estimates store DID1
event_plot, graph_opt(xtitle("Years Relative to First Dissolution") ytitle("Effect on Total Dissolutions"))
esttab DID1 using "did_table.tex"
    se star(* 0.10 ** 0.05 *** 0.01) 
    label b(3) se(3) replace ///
    title("Difference-in-Differences Event Study (Imputation)") 
    alignment(c) ///
    compress

tab region
list region (unique)
levelsof region


ssc install outreg2