Introduction
------------

### Purpose of this memo

This memo is a slightly updated version of a previous preliminary
analysis memo. It uses data which has been processed more thoroughly
than the original and therefore updates the results. This data should be
used by field reporters to narrow their initial reporting, but findings
are still preliminary and therefore **should not be included in final
articles**.

Data outputs can be found
[here](https://github.com/shardsofblue/homelessness-project-fall2019/tree/master/documentation/memos/output-csvs).
(Click the file, right-click “Raw”, choose “Save Link As”, and change
the file extention from “.txt” to “.csv”).

### Important caveats

**Findings herein are preliminary estimates and should not be
published.** Please bear the following caveats in mind when reviewing
this memo:

1.  **Counting methodology changes:** Methods of counting the population
    of people experiencing homelessness may have changed over the years,
    which may have caused flucutations in counts that do not reflect
    actual changes.
2.  **2014/18 rate calculations:** Because we do not have estimates for
    the total population of CoCs for 2014 and 2018 yet, we used an
    available 2017 population estimate to calculate rates of change in
    the homeless population at 2014 and 2018. These rates are therefore
    only rough estimations, to be perfected when we have more accurate
    overall population data. 2014-18 rates should only be used as a
    general comparison over time.
3.  **2017 rate calculation:** For 2017, we used rates calculted by real
    estate firm Zillow, which attempted to compensate for the difference
    between homeless peple counted versus actual homeless. We consider
    the 2017 data the most reliable and correct in terms of rates and
    therefore are most comfortable ranking CoCs along this rate.
4.  **Problematic CoCs:** Some Continuums of Care have changed over the
    years, merging together or into new CoCs, or presented incomplete
    information in the PIT database. The following CoCs have known
    issues during the period covered here, and have therefore been
    removed from the analysis: “AR-502”, “AR-506”, “AR-507”, “AR-509”,
    “AR-510”, “AR-511”, “AR-512”, “CA-605”, “CA-610”, “CT-500”,
    “CT-501”, “CT-502”, “CT-504”, “CT-506”, “CT-507”, “CT-508”,
    “CT-509”, “CT-510”, “CT-511”, “CT-512”, “FL-516”, “IL-505”,
    “IN-500”, “IN-501”, “KS-500”, “LA-504”, “LA-508”, “MA-512”,
    “MA-513”, “MA-518”, “MA-520”, “ME-501”, “ME-502”, “MI-520”,
    “MI-521”, “MI-522”, “MI-524”, “MN-507”, “MN-510”, “MN-512”,
    “MO-601”, “MO-605”, “NC-508”, “NC-512”, “NC-514”, “NC-515”,
    “NC-517”, “NC-518”, “NC-519”, “NC-520”, “NC-521”, “NC-522”,
    “NC-523”, “NC-524”, “NC-525”, “NC-526”, “NE-503”, “NE-504”,
    “NE-505”, “NE-506”, “NJ-505”, “NJ-517”, “NJ-518”, “NJ-519”,
    “NJ-520”, “NY-502”, “NY-509”, “NY-515”, “NY-517”, “NY-521”,
    “NY-524”, “NY-605”, “OR-504”, “PA-507”, “PA-602”, “PR-501”,
    “PR-504”, “PR-510”, “SC-504”, “TN-505”, “TX-501”, “TX-504”,
    “TX-602”, “TX-608”, “TX-610”, “TX-612”, “TX-613”, “TX-616”,
    “TX-623”, “TX-702”, “TX-703”, “TX-704”, “VA-509”, “VA-510”,
    “VA-512”, “VA-517”, “VA-518”, “VA-519”, “WA-506”, “WA-507”,
    “ar-504”, “ar-508”, “ca-527”, “ca-528”, “ca-529”, “ca-530”,
    “ga-502”, “ga-508”, “ma-501”, “nj-512”, “ny-506”.

Calculations
------------

The code below calculates approximate rates for homelessness in 2014 and
2017 in order to compare changes over time.

``` r
######################
## Calculate Rates ###
######################

# Calculate rates and changes over time data 14-18
homeless_rates_14_18 <- hud_zillow_joined %>%
  rename(total_pop_2017 = coc_total_population_zillow_2017, 
         est_rate_perc_2017 = estimated_homeless_rate_percent_zillow_2017,
         cluster_num = cluster_number_zillow_2017) %>%
  ### RATES of homelessness for 2014 and 2018 based on available 2017 population numbers, as a percent
  # Note: Usual study methodology on homelessness uses per 10,000 people rather than as a percentage of 100
  mutate(homeless_rate_perc_2014 = (overall_homeless_2014/total_pop_2017)*100,
         OURhomeless_rate_perc_2017 = (overall_homeless_2017/total_pop_2017)*100,
         homeless_rate_perc_2018 = (overall_homeless_2018/total_pop_2017)*100) %>%
  ### CHANGES over time between 2014-2018
  # Change in OVERALL homelessness
  mutate(overall_change_2014_2018 = overall_homeless_2018 -  overall_homeless_2014,
         perc_change_2014_2018 = (overall_homeless_2018 - overall_homeless_2014)/overall_homeless_2014) %>%
  # Change in homelessness RATES
  mutate(rate_percpt_change_2014_2018 = homeless_rate_perc_2018 - homeless_rate_perc_2014) %>%
  # Rank the various factors
  mutate(rank_homeless_rate_perc_2018 = rank(desc(homeless_rate_perc_2018)),
         rank_overall_change_2014_2018 = rank(desc(overall_change_2014_2018)),
         rank_perc_change_2014_2018 = rank(desc(perc_change_2014_2018)),
         rank_rate_percpt_change_2014_2018 = rank(desc(rate_percpt_change_2014_2018)),
         rank_est_rate_perc_2017 = rank(desc(est_rate_perc_2017))) %>%
  mutate(diff_2017 = OURhomeless_rate_perc_2017 - est_rate_perc_2017)

# Save to file
# homeless_rates_14_18 %>%
#   write_csv(paste0(save_path, "homeless-rate-14-18.csv"))
```

``` r
###########################
### Arrange and Display ###
###########################

# Store slice of the data in temp working table
wk <- homeless_rates_14_18 %>%
  select(coc_code, coc_name,
         homeless_rate_perc_2014,
         est_rate_perc_2017, rank_est_rate_perc_2017, total_pop_2017,
         overall_homeless_2014, overall_homeless_2018, 
         homeless_rate_perc_2018, rank_homeless_rate_perc_2018, 
         overall_change_2014_2018, rank_overall_change_2014_2018,
         perc_change_2014_2018, rank_perc_change_2014_2018, 
         rate_percpt_change_2014_2018, rank_rate_percpt_change_2014_2018 
         )
```

Findings
--------

### Fact: Homelessness Rates by Continuum of Care 2017

In 2017, Mendocino County’s CoC had the nation’s highest rate of
homelessness, at 2 percent, followed by Washington, D.C. (1.2 percent).

Five of the top 10 were in California (Mendocino County, Santa Cruz
area, San Francisco, Monterey area, Imperial County). Other areas with
high rates: Boston, New York City, Atlanta and the Florida Keys (Monroe
County).

``` r
# Order by rate in 2017
wk %>% 
  arrange(desc(est_rate_perc_2017), coc_code) %>%
  select(coc_code, coc_name, est_rate_perc_2017, rank_est_rate_perc_2017, total_pop_2017) %>%
  # Write to CSV
  write_csv(paste0(save_path, "rates-of-homelessness-by-coc.csv")) %>%
  # Styling
  kable(caption = "Ordered by the homeless rate in 2017") %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<caption>
Ordered by the homeless rate in 2017
</caption>
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_code
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_name
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
est\_rate\_perc\_2017
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
rank\_est\_rate\_perc\_2017
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
total\_pop\_2017
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ca-509
</td>
<td style="text-align:left;">
mendocino county coc
</td>
<td style="text-align:right;">
2.13
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
87274
</td>
</tr>
<tr>
<td style="text-align:left;">
dc-500
</td>
<td style="text-align:left;">
district of columbia coc
</td>
<td style="text-align:right;">
1.20
</td>
<td style="text-align:right;">
2.0
</td>
<td style="text-align:right;">
670534
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-508
</td>
<td style="text-align:left;">
watsonville/santa cruz city & county coc
</td>
<td style="text-align:right;">
1.16
</td>
<td style="text-align:right;">
3.0
</td>
<td style="text-align:right;">
272584
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-604
</td>
<td style="text-align:left;">
monroe county coc
</td>
<td style="text-align:right;">
1.15
</td>
<td style="text-align:right;">
4.0
</td>
<td style="text-align:right;">
78399
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-501
</td>
<td style="text-align:left;">
san francisco coc
</td>
<td style="text-align:right;">
1.03
</td>
<td style="text-align:right;">
5.0
</td>
<td style="text-align:right;">
859801
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-500
</td>
<td style="text-align:left;">
boston coc
</td>
<td style="text-align:right;">
0.99
</td>
<td style="text-align:right;">
6.0
</td>
<td style="text-align:right;">
666277
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-600
</td>
<td style="text-align:left;">
new york city coc
</td>
<td style="text-align:right;">
0.96
</td>
<td style="text-align:right;">
7.0
</td>
<td style="text-align:right;">
8497179
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-506
</td>
<td style="text-align:left;">
salinas/monterey, san benito counties coc
</td>
<td style="text-align:right;">
0.95
</td>
<td style="text-align:right;">
8.0
</td>
<td style="text-align:right;">
490506
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-500
</td>
<td style="text-align:left;">
atlanta coc
</td>
<td style="text-align:right;">
0.93
</td>
<td style="text-align:right;">
9.0
</td>
<td style="text-align:right;">
460412
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-613
</td>
<td style="text-align:left;">
imperial county coc
</td>
<td style="text-align:right;">
0.89
</td>
<td style="text-align:right;">
10.0
</td>
<td style="text-align:right;">
179408
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-522
</td>
<td style="text-align:left;">
humboldt county coc
</td>
<td style="text-align:right;">
0.83
</td>
<td style="text-align:right;">
11.0
</td>
<td style="text-align:right;">
135330
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-504
</td>
<td style="text-align:left;">
santa rosa, petaluma/sonoma county coc
</td>
<td style="text-align:right;">
0.80
</td>
<td style="text-align:right;">
12.0
</td>
<td style="text-align:right;">
500474
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-600
</td>
<td style="text-align:left;">
los angeles city & county coc
</td>
<td style="text-align:right;">
0.79
</td>
<td style="text-align:right;">
13.0
</td>
<td style="text-align:right;">
9264635
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-519
</td>
<td style="text-align:left;">
pasco county coc
</td>
<td style="text-align:right;">
0.72
</td>
<td style="text-align:right;">
14.0
</td>
<td style="text-align:right;">
497332
</td>
</tr>
<tr>
<td style="text-align:left;">
hi-500
</td>
<td style="text-align:left;">
hawaii balance of state coc
</td>
<td style="text-align:right;">
0.70
</td>
<td style="text-align:right;">
15.0
</td>
<td style="text-align:right;">
431130
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-519
</td>
<td style="text-align:left;">
chico, paradise/butte county coc
</td>
<td style="text-align:right;">
0.68
</td>
<td style="text-align:right;">
16.0
</td>
<td style="text-align:right;">
225190
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-614
</td>
<td style="text-align:left;">
san luis obispo county coc
</td>
<td style="text-align:right;">
0.67
</td>
<td style="text-align:right;">
17.5
</td>
<td style="text-align:right;">
280843
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-502
</td>
<td style="text-align:left;">
lynn coc
</td>
<td style="text-align:right;">
0.67
</td>
<td style="text-align:right;">
17.5
</td>
<td style="text-align:right;">
92522
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-508
</td>
<td style="text-align:left;">
lowell coc
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
20.0
</td>
<td style="text-align:right;">
110393
</td>
</tr>
<tr>
<td style="text-align:left;">
or-501
</td>
<td style="text-align:left;">
portland, gresham/multnomah county coc
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
20.0
</td>
<td style="text-align:right;">
787968
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-500
</td>
<td style="text-align:left;">
seattle/king county coc
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
20.0
</td>
<td style="text-align:right;">
2119230
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-603
</td>
<td style="text-align:left;">
santa maria/santa barbara county coc
</td>
<td style="text-align:right;">
0.60
</td>
<td style="text-align:right;">
23.0
</td>
<td style="text-align:right;">
442940
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-518
</td>
<td style="text-align:left;">
columbia, hamilton, lafayette, suwannee counties coc
</td>
<td style="text-align:right;">
0.60
</td>
<td style="text-align:right;">
23.0
</td>
<td style="text-align:right;">
135313
</td>
</tr>
<tr>
<td style="text-align:left;">
hi-501
</td>
<td style="text-align:left;">
honolulu city and county coc
</td>
<td style="text-align:right;">
0.60
</td>
<td style="text-align:right;">
23.0
</td>
<td style="text-align:right;">
989820
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-607
</td>
<td style="text-align:left;">
pasadena coc
</td>
<td style="text-align:right;">
0.57
</td>
<td style="text-align:right;">
26.0
</td>
<td style="text-align:right;">
137876
</td>
</tr>
<tr>
<td style="text-align:left;">
or-500
</td>
<td style="text-align:left;">
eugene, springfield/lane county coc
</td>
<td style="text-align:right;">
0.57
</td>
<td style="text-align:right;">
26.0
</td>
<td style="text-align:right;">
363486
</td>
</tr>
<tr>
<td style="text-align:left;">
or-505
</td>
<td style="text-align:left;">
oregon balance of state coc
</td>
<td style="text-align:right;">
0.57
</td>
<td style="text-align:right;">
26.0
</td>
<td style="text-align:right;">
1468651
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-500
</td>
<td style="text-align:left;">
san jose/santa clara city & county coc
</td>
<td style="text-align:right;">
0.53
</td>
<td style="text-align:right;">
29.0
</td>
<td style="text-align:right;">
1901963
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-507
</td>
<td style="text-align:left;">
marin county coc
</td>
<td style="text-align:right;">
0.53
</td>
<td style="text-align:right;">
29.0
</td>
<td style="text-align:right;">
260367
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-509
</td>
<td style="text-align:left;">
cambridge coc
</td>
<td style="text-align:right;">
0.53
</td>
<td style="text-align:right;">
29.0
</td>
<td style="text-align:right;">
109598
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-524
</td>
<td style="text-align:left;">
yuba city & county/sutter county coc
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
32.0
</td>
<td style="text-align:right;">
169922
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-504
</td>
<td style="text-align:left;">
springfield/hampden county coc
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
32.0
</td>
<td style="text-align:right;">
468103
</td>
</tr>
<tr>
<td style="text-align:left;">
md-501
</td>
<td style="text-align:left;">
baltimore coc
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
32.0
</td>
<td style="text-align:right;">
619546
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-606
</td>
<td style="text-align:left;">
long beach coc
</td>
<td style="text-align:right;">
0.51
</td>
<td style="text-align:right;">
34.0
</td>
<td style="text-align:right;">
474605
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-509
</td>
<td style="text-align:left;">
fort pierce/st. lucie, indian river, martin counties coc
</td>
<td style="text-align:right;">
0.47
</td>
<td style="text-align:right;">
35.5
</td>
<td style="text-align:right;">
601682
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-501
</td>
<td style="text-align:left;">
st.louis city coc
</td>
<td style="text-align:right;">
0.47
</td>
<td style="text-align:right;">
35.5
</td>
<td style="text-align:right;">
314210
</td>
</tr>
<tr>
<td style="text-align:left;">
or-503
</td>
<td style="text-align:left;">
central oregon coc
</td>
<td style="text-align:right;">
0.46
</td>
<td style="text-align:right;">
37.0
</td>
<td style="text-align:right;">
219265
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-502
</td>
<td style="text-align:left;">
oakland, berkeley/alameda county coc
</td>
<td style="text-align:right;">
0.43
</td>
<td style="text-align:right;">
38.0
</td>
<td style="text-align:right;">
1625451
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-525
</td>
<td style="text-align:left;">
el dorado county coc
</td>
<td style="text-align:right;">
0.42
</td>
<td style="text-align:right;">
39.5
</td>
<td style="text-align:right;">
183907
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-507
</td>
<td style="text-align:left;">
savannah/chatham county coc
</td>
<td style="text-align:right;">
0.42
</td>
<td style="text-align:right;">
39.5
</td>
<td style="text-align:right;">
285936
</td>
</tr>
<tr>
<td style="text-align:left;">
ak-500
</td>
<td style="text-align:left;">
anchorage coc
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
44.0
</td>
<td style="text-align:right;">
299535
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-510
</td>
<td style="text-align:left;">
turlock, modesto/stanislaus county coc
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
44.0
</td>
<td style="text-align:right;">
533755
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-502
</td>
<td style="text-align:left;">
st. petersburg, clearwater, largo/pinellas county coc
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
44.0
</td>
<td style="text-align:right;">
947619
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-517
</td>
<td style="text-align:left;">
hendry, hardee, highlands counties coc
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
44.0
</td>
<td style="text-align:right;">
253385
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-505
</td>
<td style="text-align:left;">
new bedford coc
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
44.0
</td>
<td style="text-align:right;">
95067
</td>
</tr>
<tr>
<td style="text-align:left;">
nh-501
</td>
<td style="text-align:left;">
manchester coc
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
44.0
</td>
<td style="text-align:right;">
110323
</td>
</tr>
<tr>
<td style="text-align:left;">
or-502
</td>
<td style="text-align:left;">
medford, ashland/jackson county coc
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
44.0
</td>
<td style="text-align:right;">
213469
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-500
</td>
<td style="text-align:left;">
philadelphia coc
</td>
<td style="text-align:right;">
0.40
</td>
<td style="text-align:right;">
48.0
</td>
<td style="text-align:right;">
1564804
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-523
</td>
<td style="text-align:left;">
colusa, glenn, trinity counties coc
</td>
<td style="text-align:right;">
0.39
</td>
<td style="text-align:right;">
49.0
</td>
<td style="text-align:right;">
62236
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-504
</td>
<td style="text-align:left;">
nashville-davidson county coc
</td>
<td style="text-align:right;">
0.38
</td>
<td style="text-align:right;">
50.0
</td>
<td style="text-align:right;">
677264
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-518
</td>
<td style="text-align:left;">
vallejo/solano county coc
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
52.5
</td>
<td style="text-align:right;">
433439
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-526
</td>
<td style="text-align:left;">
amador, calaveras, mariposa, tuolumne counties coc
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
52.5
</td>
<td style="text-align:right;">
152888
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-601
</td>
<td style="text-align:left;">
san diego city and county coc
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
52.5
</td>
<td style="text-align:right;">
3283616
</td>
</tr>
<tr>
<td style="text-align:left;">
ky-502
</td>
<td style="text-align:left;">
lexington-fayette county coc
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
52.5
</td>
<td style="text-align:right;">
314752
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-516
</td>
<td style="text-align:left;">
redding/shasta, siskiyou, lassen, plumas, del norte, modoc, sierra
counties coc
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
56.5
</td>
<td style="text-align:right;">
311933
</td>
</tr>
<tr>
<td style="text-align:left;">
co-500
</td>
<td style="text-align:left;">
colorado balance of state coc
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
56.5
</td>
<td style="text-align:right;">
1702773
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-515
</td>
<td style="text-align:left;">
fall river coc
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
56.5
</td>
<td style="text-align:right;">
89077
</td>
</tr>
<tr>
<td style="text-align:left;">
nv-500
</td>
<td style="text-align:left;">
las vegas/clark county coc
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
56.5
</td>
<td style="text-align:right;">
2104734
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-501
</td>
<td style="text-align:left;">
detroit coc
</td>
<td style="text-align:right;">
0.34
</td>
<td style="text-align:right;">
59.0
</td>
<td style="text-align:right;">
676812
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-516
</td>
<td style="text-align:left;">
northwest north carolina coc
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
60.5
</td>
<td style="text-align:right;">
210136
</td>
</tr>
<tr>
<td style="text-align:left;">
nm-500
</td>
<td style="text-align:left;">
albuquerque coc
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
60.5
</td>
<td style="text-align:right;">
526332
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-512
</td>
<td style="text-align:left;">
st. johns county coc
</td>
<td style="text-align:right;">
0.31
</td>
<td style="text-align:right;">
62.0
</td>
<td style="text-align:right;">
226229
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-503
</td>
<td style="text-align:left;">
sacramento city & county coc
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
64.0
</td>
<td style="text-align:right;">
1492768
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-521
</td>
<td style="text-align:left;">
davis, woodland/yolo county coc
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
64.0
</td>
<td style="text-align:right;">
212022
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-611
</td>
<td style="text-align:left;">
amarillo coc
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
64.0
</td>
<td style="text-align:right;">
189080
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-508
</td>
<td style="text-align:left;">
gainesville/alachua, putnam counties coc
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
67.5
</td>
<td style="text-align:right;">
414138
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-501
</td>
<td style="text-align:left;">
saint paul/ramsey county coc
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
67.5
</td>
<td style="text-align:right;">
535645
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-509
</td>
<td style="text-align:left;">
duluth/st.louis county coc
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
67.5
</td>
<td style="text-align:right;">
200200
</td>
</tr>
<tr>
<td style="text-align:left;">
nv-501
</td>
<td style="text-align:left;">
reno, sparks/washoe county coc
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
67.5
</td>
<td style="text-align:right;">
444809
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-500
</td>
<td style="text-align:left;">
sarasota, bradenton/manatee, sarasota counties coc
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
71.0
</td>
<td style="text-align:right;">
767077
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-504
</td>
<td style="text-align:left;">
newark/essex county coc
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
71.0
</td>
<td style="text-align:right;">
793563
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-503
</td>
<td style="text-align:left;">
albany city & county coc
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
71.0
</td>
<td style="text-align:right;">
308319
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-517
</td>
<td style="text-align:left;">
napa city & county coc
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
75.0
</td>
<td style="text-align:right;">
141351
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-506
</td>
<td style="text-align:left;">
tallahassee/leon county coc
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
75.0
</td>
<td style="text-align:right;">
438911
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-500
</td>
<td style="text-align:left;">
minneapolis/hennepin county coc
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
75.0
</td>
<td style="text-align:right;">
1220754
</td>
</tr>
<tr>
<td style="text-align:left;">
ne-502
</td>
<td style="text-align:left;">
lincoln coc
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
75.0
</td>
<td style="text-align:right;">
253363
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-608
</td>
<td style="text-align:left;">
kingston/ulster county coc
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
75.0
</td>
<td style="text-align:right;">
179710
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-515
</td>
<td style="text-align:left;">
roseville, rocklin/placer, nevada counties coc
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
79.0
</td>
<td style="text-align:right;">
473570
</td>
</tr>
<tr>
<td style="text-align:left;">
co-504
</td>
<td style="text-align:left;">
colorado springs/el paso county coc
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
79.0
</td>
<td style="text-align:right;">
675318
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-514
</td>
<td style="text-align:left;">
ocala/marion county coc
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
79.0
</td>
<td style="text-align:right;">
343871
</td>
</tr>
<tr>
<td style="text-align:left;">
ia-500
</td>
<td style="text-align:left;">
sioux city/dakota, woodbury counties coc
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
82.5
</td>
<td style="text-align:right;">
122918
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-502
</td>
<td style="text-align:left;">
oklahoma city coc
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
82.5
</td>
<td style="text-align:right;">
629187
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-501
</td>
<td style="text-align:left;">
washington balance of state coc
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
82.5
</td>
<td style="text-align:right;">
2228592
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-502
</td>
<td style="text-align:left;">
spokane city & county coc
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
82.5
</td>
<td style="text-align:right;">
490886
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-514
</td>
<td style="text-align:left;">
fresno city & county/madera county coc
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
88.0
</td>
<td style="text-align:right;">
1123116
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-520
</td>
<td style="text-align:left;">
merced city & county coc
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
88.0
</td>
<td style="text-align:right;">
266117
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-503
</td>
<td style="text-align:left;">
athens-clarke county coc
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
88.0
</td>
<td style="text-align:right;">
123169
</td>
</tr>
<tr>
<td style="text-align:left;">
la-503
</td>
<td style="text-align:left;">
new orleans/jefferson parish coc
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
88.0
</td>
<td style="text-align:right;">
824422
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-501
</td>
<td style="text-align:left;">
asheville/buncombe county coc
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
88.0
</td>
<td style="text-align:right;">
252888
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-607
</td>
<td style="text-align:left;">
sullivan county coc
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
88.0
</td>
<td style="text-align:right;">
75306
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-507
</td>
<td style="text-align:left;">
jackson/west tennessee coc
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
88.0
</td>
<td style="text-align:right;">
668662
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-511
</td>
<td style="text-align:left;">
stockton/san joaquin county coc
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
93.0
</td>
<td style="text-align:right;">
721166
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-505
</td>
<td style="text-align:left;">
fort walton beach/okaloosa, walton counties coc
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
93.0
</td>
<td style="text-align:right;">
262928
</td>
</tr>
<tr>
<td style="text-align:left;">
il-510
</td>
<td style="text-align:left;">
chicago coc
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
93.0
</td>
<td style="text-align:right;">
2712975
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-512
</td>
<td style="text-align:left;">
daly/san mateo county coc
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
97.0
</td>
<td style="text-align:right;">
760765
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-602
</td>
<td style="text-align:left;">
santa ana, anaheim/orange county coc
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
97.0
</td>
<td style="text-align:right;">
3148353
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-503
</td>
<td style="text-align:left;">
topeka/shawnee county coc
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
97.0
</td>
<td style="text-align:right;">
178342
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-510
</td>
<td style="text-align:left;">
saginaw city & county coc
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
97.0
</td>
<td style="text-align:right;">
193923
</td>
</tr>
<tr>
<td style="text-align:left;">
vt-500
</td>
<td style="text-align:left;">
vermont balance of state coc
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
97.0
</td>
<td style="text-align:right;">
464585
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-505
</td>
<td style="text-align:left;">
richmond/contra costa county coc
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
103.5
</td>
<td style="text-align:right;">
1119782
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-511
</td>
<td style="text-align:left;">
pensacola/escambia, santa rosa counties coc
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
103.5
</td>
<td style="text-align:right;">
479606
</td>
</tr>
<tr>
<td style="text-align:left;">
id-500
</td>
<td style="text-align:left;">
boise/ada county coc
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
103.5
</td>
<td style="text-align:right;">
434095
</td>
</tr>
<tr>
<td style="text-align:left;">
in-503
</td>
<td style="text-align:left;">
indianapolis coc
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
103.5
</td>
<td style="text-align:right;">
937949
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-516
</td>
<td style="text-align:left;">
massachusetts balance of state coc
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
103.5
</td>
<td style="text-align:right;">
1076446
</td>
</tr>
<tr>
<td style="text-align:left;">
md-507
</td>
<td style="text-align:left;">
cecil county coc
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
103.5
</td>
<td style="text-align:right;">
102390
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-506
</td>
<td style="text-align:left;">
northwest minnesota coc
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
103.5
</td>
<td style="text-align:right;">
170369
</td>
</tr>
<tr>
<td style="text-align:left;">
vt-501
</td>
<td style="text-align:left;">
burlington/chittenden county coc
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
103.5
</td>
<td style="text-align:right;">
161309
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-500
</td>
<td style="text-align:left;">
little rock/central arkansas coc
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
113.5
</td>
<td style="text-align:right;">
590603
</td>
</tr>
<tr>
<td style="text-align:left;">
az-501
</td>
<td style="text-align:left;">
tucson/pima county coc
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
113.5
</td>
<td style="text-align:right;">
1008139
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-611
</td>
<td style="text-align:left;">
oxnard, san buenaventura/ventura county coc
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
113.5
</td>
<td style="text-align:right;">
845387
</td>
</tr>
<tr>
<td style="text-align:left;">
co-503
</td>
<td style="text-align:left;">
metropolitan denver coc
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
113.5
</td>
<td style="text-align:right;">
3049220
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-506
</td>
<td style="text-align:left;">
worcester city & county coc
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
113.5
</td>
<td style="text-align:right;">
816243
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-507
</td>
<td style="text-align:left;">
portage, kalamazoo city & county coc
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
113.5
</td>
<td style="text-align:right;">
260458
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-511
</td>
<td style="text-align:left;">
fayetteville/cumberland county coc
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
113.5
</td>
<td style="text-align:right;">
327079
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-604
</td>
<td style="text-align:left;">
yonkers, mount vernon/westchester county coc
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
113.5
</td>
<td style="text-align:right;">
974393
</td>
</tr>
<tr>
<td style="text-align:left;">
or-507
</td>
<td style="text-align:left;">
clackamas county coc
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
113.5
</td>
<td style="text-align:right;">
400496
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-502
</td>
<td style="text-align:left;">
knoxville/knox county coc
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
113.5
</td>
<td style="text-align:right;">
451980
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-503
</td>
<td style="text-align:left;">
austin/travis county coc
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
113.5
</td>
<td style="text-align:right;">
1250891
</td>
</tr>
<tr>
<td style="text-align:left;">
ut-500
</td>
<td style="text-align:left;">
salt lake city & county coc
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
113.5
</td>
<td style="text-align:right;">
1111517
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-513
</td>
<td style="text-align:left;">
visalia/kings, tulare counties coc
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
122.5
</td>
<td style="text-align:right;">
607029
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-510
</td>
<td style="text-align:left;">
jacksonville-duval, clay counties coc
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
122.5
</td>
<td style="text-align:right;">
1192876
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-606
</td>
<td style="text-align:left;">
naples/collier county coc
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
122.5
</td>
<td style="text-align:right;">
355381
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-603
</td>
<td style="text-align:left;">
st. joseph/andrew, buchanan, dekalb counties coc
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
122.5
</td>
<td style="text-align:right;">
119265
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-507
</td>
<td style="text-align:left;">
schenectady city & county coc
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
122.5
</td>
<td style="text-align:right;">
154894
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-501
</td>
<td style="text-align:left;">
harrisburg/dauphin county coc
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
122.5
</td>
<td style="text-align:right;">
272830
</td>
</tr>
<tr>
<td style="text-align:left;">
ak-501
</td>
<td style="text-align:left;">
alaska balance of state coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
440800
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-501
</td>
<td style="text-align:left;">
tampa/hillsborough county coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
1343234
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-507
</td>
<td style="text-align:left;">
pittsfield/berkshire, franklin, hampshire counties coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
359837
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-511
</td>
<td style="text-align:left;">
quincy, brockton, weymouth, plymouth city and county coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
659052
</td>
</tr>
<tr>
<td style="text-align:left;">
md-500
</td>
<td style="text-align:left;">
cumberland/allegany county coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
72571
</td>
</tr>
<tr>
<td style="text-align:left;">
md-508
</td>
<td style="text-align:left;">
charles, calvert, st.mary’s counties coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
358636
</td>
</tr>
<tr>
<td style="text-align:left;">
me-500
</td>
<td style="text-align:left;">
maine statewide coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
1330746
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-508
</td>
<td style="text-align:left;">
lansing, east lansing/ingham county coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
287438
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-514
</td>
<td style="text-align:left;">
battle creek/calhoun county coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
134592
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-604
</td>
<td style="text-align:left;">
kansas city, independence, lee’s summit/jackson, wyandotte counties, mo
& ks
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
1007389
</td>
</tr>
<tr>
<td style="text-align:left;">
ne-501
</td>
<td style="text-align:left;">
omaha, council bluffs coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
817762
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-500
</td>
<td style="text-align:left;">
atlantic city & county coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
272676
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-500
</td>
<td style="text-align:left;">
san antonio/bexar county coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
1919847
</td>
</tr>
<tr>
<td style="text-align:left;">
va-507
</td>
<td style="text-align:left;">
portsmouth coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
96007
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-508
</td>
<td style="text-align:left;">
vancouver/clark county coc
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
465567
</td>
</tr>
<tr>
<td style="text-align:left;">
az-502
</td>
<td style="text-align:left;">
phoenix, mesa/maricopa county coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
4163953
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-504
</td>
<td style="text-align:left;">
daytona beach, daytona/volusia, flagler counties coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
622944
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-513
</td>
<td style="text-align:left;">
palm bay, melbourne/brevard county coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
567775
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-602
</td>
<td style="text-align:left;">
punta gorda/charlotte county coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
173501
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-503
</td>
<td style="text-align:left;">
cape cod islands coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
242698
</td>
</tr>
<tr>
<td style="text-align:left;">
md-513
</td>
<td style="text-align:left;">
wicomico, somerset, worcester counties coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
179053
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-602
</td>
<td style="text-align:left;">
joplin/jasper, newton counties coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
176273
</td>
</tr>
<tr>
<td style="text-align:left;">
mt-500
</td>
<td style="text-align:left;">
montana statewide coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
1032083
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-505
</td>
<td style="text-align:left;">
charlotte/mecklenberg coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
1033260
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-516
</td>
<td style="text-align:left;">
clinton county coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
81325
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-501
</td>
<td style="text-align:left;">
tulsa city & county coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
690290
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-501
</td>
<td style="text-align:left;">
memphis/shelby county coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
936230
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-603
</td>
<td style="text-align:left;">
el paso city & county coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
836089
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-503
</td>
<td style="text-align:left;">
tacoma, lakewood/pierce county coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
837954
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-504
</td>
<td style="text-align:left;">
everett/snohomish county coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
770645
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-501
</td>
<td style="text-align:left;">
huntington/cabell, wayne counties coc
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
148.5
</td>
<td style="text-align:right;">
137397
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-600
</td>
<td style="text-align:left;">
miami-dade county coc
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
160.0
</td>
<td style="text-align:right;">
2689794
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-605
</td>
<td style="text-align:left;">
west palm beach/palm beach county coc
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
160.0
</td>
<td style="text-align:right;">
1418708
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-505
</td>
<td style="text-align:left;">
columbus-muscogee/russell county coc
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
160.0
</td>
<td style="text-align:right;">
259291
</td>
</tr>
<tr>
<td style="text-align:left;">
md-512
</td>
<td style="text-align:left;">
hagerstown/washington county coc
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
160.0
</td>
<td style="text-align:right;">
149872
</td>
</tr>
<tr>
<td style="text-align:left;">
nd-500
</td>
<td style="text-align:left;">
north dakota statewide coc
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
160.0
</td>
<td style="text-align:right;">
750684
</td>
</tr>
<tr>
<td style="text-align:left;">
va-603
</td>
<td style="text-align:left;">
alexandria coc
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
160.0
</td>
<td style="text-align:right;">
153631
</td>
</tr>
<tr>
<td style="text-align:left;">
wy-500
</td>
<td style="text-align:left;">
wyoming statewide coc
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
160.0
</td>
<td style="text-align:right;">
586379
</td>
</tr>
<tr>
<td style="text-align:left;">
al-500
</td>
<td style="text-align:left;">
birmingham/jefferson, st. clair, shelby counties coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
954826
</td>
</tr>
<tr>
<td style="text-align:left;">
az-500
</td>
<td style="text-align:left;">
arizona balance of state coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
1643134
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-601
</td>
<td style="text-align:left;">
ft lauderdale/broward county coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
1884408
</td>
</tr>
<tr>
<td style="text-align:left;">
ia-502
</td>
<td style="text-align:left;">
des moines/polk county coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
481896
</td>
</tr>
<tr>
<td style="text-align:left;">
il-508
</td>
<td style="text-align:left;">
east st. louis, belleville/st. clair county coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
271982
</td>
</tr>
<tr>
<td style="text-align:left;">
il-516
</td>
<td style="text-align:left;">
decatur/macon county coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
107615
</td>
</tr>
<tr>
<td style="text-align:left;">
ky-501
</td>
<td style="text-align:left;">
louisville-jefferson county coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
763639
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-506
</td>
<td style="text-align:left;">
grand rapids, wyoming/kent county coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
636114
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-512
</td>
<td style="text-align:left;">
grand traverse, antrim, leelanau counties coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
171217
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-503
</td>
<td style="text-align:left;">
st. charles city & county, lincoln, warren counties coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
473166
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-502
</td>
<td style="text-align:left;">
burlington county coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
449916
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-514
</td>
<td style="text-align:left;">
trenton/mercer county coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
371990
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-603
</td>
<td style="text-align:left;">
nassau, suffolk counties coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
2853877
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-500
</td>
<td style="text-align:left;">
cincinnati/hamilton county coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
811574
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-502
</td>
<td style="text-align:left;">
cleveland/cuyahoga county coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
1254231
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-605
</td>
<td style="text-align:left;">
erie city & county coc
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171.5
</td>
<td style="text-align:right;">
278408
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-608
</td>
<td style="text-align:left;">
riverside city & county coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
2349752
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-504
</td>
<td style="text-align:left;">
augusta-richmond county coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
201545
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-510
</td>
<td style="text-align:left;">
gloucester, haverhill, salem/essex county coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
602483
</td>
</tr>
<tr>
<td style="text-align:left;">
md-509
</td>
<td style="text-align:left;">
frederick city & county coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
245557
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-511
</td>
<td style="text-align:left;">
lenawee county coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
98444
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-500
</td>
<td style="text-align:left;">
winston-salem/forsyth county coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
367698
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-512
</td>
<td style="text-align:left;">
troy/rensselaer county coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
160018
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-519
</td>
<td style="text-align:left;">
columbia, greene counties coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
109351
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-601
</td>
<td style="text-align:left;">
poughkeepsie/dutchess county coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
294882
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-503
</td>
<td style="text-align:left;">
columbus/franklin county coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
1289308
</td>
</tr>
<tr>
<td style="text-align:left;">
or-506
</td>
<td style="text-align:left;">
hillsboro, beaverton/washington county coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
571966
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-506
</td>
<td style="text-align:left;">
reading/berks county coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
414229
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-503
</td>
<td style="text-align:left;">
myrtle beach, sumter city & county coc
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
905529
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-604
</td>
<td style="text-align:left;">
bakersfield/kern county coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
876938
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-507
</td>
<td style="text-align:left;">
orlando/orange, osceola, seminole counties coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
2054589
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-515
</td>
<td style="text-align:left;">
panama city/bay, jackson counties coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
304441
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-515
</td>
<td style="text-align:left;">
monroe city & county coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
149454
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-505
</td>
<td style="text-align:left;">
st. cloud/central minnesota coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
730221
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-600
</td>
<td style="text-align:left;">
springfield/greene, christian, webster counties coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
408354
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-502
</td>
<td style="text-align:left;">
durham city & county coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
300419
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-504
</td>
<td style="text-align:left;">
greensboro, high point coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
516867
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-506
</td>
<td style="text-align:left;">
jersey city, bayonne/hudson county coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
674433
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-505
</td>
<td style="text-align:left;">
syracuse, auburn/onondaga, oswego, cayuga counties coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
666032
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-513
</td>
<td style="text-align:left;">
wayne, ontario, seneca, yates counties coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
260993
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-501
</td>
<td style="text-align:left;">
toledo/lucas county coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
433339
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-505
</td>
<td style="text-align:left;">
dayton, kettering/montgomery county coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
536021
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-510
</td>
<td style="text-align:left;">
murfreesboro/rutherford county coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
298020
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-512
</td>
<td style="text-align:left;">
morristown/blount, sevier, campbell, cocke counties coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
663735
</td>
</tr>
<tr>
<td style="text-align:left;">
va-501
</td>
<td style="text-align:left;">
norfolk/chesapeake, suffolk, isle of wight, southampton counties coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
632576
</td>
</tr>
<tr>
<td style="text-align:left;">
va-600
</td>
<td style="text-align:left;">
arlington county coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
228239
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-503
</td>
<td style="text-align:left;">
charleston/kanawha, putnam, boone, clay counties coc
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
201.5
</td>
<td style="text-align:right;">
277596
</td>
</tr>
<tr>
<td style="text-align:left;">
al-501
</td>
<td style="text-align:left;">
mobile city & county/baldwin county coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
618230
</td>
</tr>
<tr>
<td style="text-align:left;">
al-504
</td>
<td style="text-align:left;">
montgomery city & county coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
383488
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-609
</td>
<td style="text-align:left;">
san bernardino city & county coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
2118739
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-520
</td>
<td style="text-align:left;">
citrus, hernando, lake, sumter counties coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
763325
</td>
</tr>
<tr>
<td style="text-align:left;">
id-501
</td>
<td style="text-align:left;">
idaho balance of state coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
1220324
</td>
</tr>
<tr>
<td style="text-align:left;">
il-513
</td>
<td style="text-align:left;">
springfield/sangamon county coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
198262
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-502
</td>
<td style="text-align:left;">
wichita/sedgwick county coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
509913
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-517
</td>
<td style="text-align:left;">
somerville coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
125107
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-505
</td>
<td style="text-align:left;">
flint/genesee county coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
410306
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-513
</td>
<td style="text-align:left;">
marquette, alger counties coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
76570
</td>
</tr>
<tr>
<td style="text-align:left;">
ms-500
</td>
<td style="text-align:left;">
jackson/rankin, madison counties coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
572084
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-504
</td>
<td style="text-align:left;">
youngstown/mahoning county coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
231480
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-504
</td>
<td style="text-align:left;">
norman/cleveland county coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
202712
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-505
</td>
<td style="text-align:left;">
chester county coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
514259
</td>
</tr>
<tr>
<td style="text-align:left;">
ri-500
</td>
<td style="text-align:left;">
rhode island statewide coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
1055321
</td>
</tr>
<tr>
<td style="text-align:left;">
sd-500
</td>
<td style="text-align:left;">
south dakota statewide coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
858926
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-503
</td>
<td style="text-align:left;">
madison/dane county coc
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
523438
</td>
</tr>
<tr>
<td style="text-align:left;">
al-506
</td>
<td style="text-align:left;">
tuscaloosa city & county coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
204484
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-503
</td>
<td style="text-align:left;">
arkansas balance of state coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
859633
</td>
</tr>
<tr>
<td style="text-align:left;">
ct-505
</td>
<td style="text-align:left;">
connecticut balance of state coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
2730533
</td>
</tr>
<tr>
<td style="text-align:left;">
de-500
</td>
<td style="text-align:left;">
delaware statewide coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
942936
</td>
</tr>
<tr>
<td style="text-align:left;">
il-509
</td>
<td style="text-align:left;">
dekalb city & county coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
104571
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-516
</td>
<td style="text-align:left;">
norton shores, muskegon city & county coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
172813
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-523
</td>
<td style="text-align:left;">
eaton county coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
108747
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-504
</td>
<td style="text-align:left;">
northeast minnesota coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
125218
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-508
</td>
<td style="text-align:left;">
moorhead/west central minnesota coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
240746
</td>
</tr>
<tr>
<td style="text-align:left;">
nh-502
</td>
<td style="text-align:left;">
nashua/hillsborough county coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
295601
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-500
</td>
<td style="text-align:left;">
rochester, irondequoit, greece/monroe county coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
749116
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-602
</td>
<td style="text-align:left;">
newburgh, middletown/orange county coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
377100
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-506
</td>
<td style="text-align:left;">
akron, barberton/summit county coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
540897
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-505
</td>
<td style="text-align:left;">
northeast oklahoma coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
441778
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-508
</td>
<td style="text-align:left;">
scranton/lackawanna county coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
212553
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-500
</td>
<td style="text-align:left;">
chattanooga/southeast tennessee coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
684710
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-600
</td>
<td style="text-align:left;">
dallas city & county, irving coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
3684054
</td>
</tr>
<tr>
<td style="text-align:left;">
va-502
</td>
<td style="text-align:left;">
roanoke city & county, salem coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
278757
</td>
</tr>
<tr>
<td style="text-align:left;">
va-505
</td>
<td style="text-align:left;">
newport news, hampton/virginia peninsula coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
486161
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-501
</td>
<td style="text-align:left;">
milwaukee city & county coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
954673
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-502
</td>
<td style="text-align:left;">
racine city & county coc
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
194851
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-612
</td>
<td style="text-align:left;">
glendale coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
198806
</td>
</tr>
<tr>
<td style="text-align:left;">
ct-503
</td>
<td style="text-align:left;">
bridgeport, stamford, norwalk/fairfield county coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
858949
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-503
</td>
<td style="text-align:left;">
lakeland, winterhaven/polk county coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
648706
</td>
</tr>
<tr>
<td style="text-align:left;">
il-501
</td>
<td style="text-align:left;">
rockford/winnebago, boone counties coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
340814
</td>
</tr>
<tr>
<td style="text-align:left;">
il-512
</td>
<td style="text-align:left;">
bloomington/central illinois coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
530800
</td>
</tr>
<tr>
<td style="text-align:left;">
md-506
</td>
<td style="text-align:left;">
carroll county coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
167626
</td>
</tr>
<tr>
<td style="text-align:left;">
md-511
</td>
<td style="text-align:left;">
mid-shore regional coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
171089
</td>
</tr>
<tr>
<td style="text-align:left;">
md-601
</td>
<td style="text-align:left;">
montgomery county coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
1034883
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-517
</td>
<td style="text-align:left;">
jackson city & county coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
159207
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-519
</td>
<td style="text-align:left;">
holland/ottawa county coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
287039
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-507
</td>
<td style="text-align:left;">
raleigh/wake county coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
1021133
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-513
</td>
<td style="text-align:left;">
chapel hill/orange county coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
140970
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-503
</td>
<td style="text-align:left;">
camden city & county/gloucester, cape may, cumberland counties coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
1052022
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-511
</td>
<td style="text-align:left;">
paterson/passaic county coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
506834
</td>
</tr>
<tr>
<td style="text-align:left;">
nv-502
</td>
<td style="text-align:left;">
nevada balance of state coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
330165
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-508
</td>
<td style="text-align:left;">
canton, massillon, alliance/stark county coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
374545
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-507
</td>
<td style="text-align:left;">
southeastern oklahoma regional coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
540654
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-600
</td>
<td style="text-align:left;">
pittsburgh, mckeesport, penn hills/allegheny county coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
1229575
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-501
</td>
<td style="text-align:left;">
greenville, anderson, spartanburg/upstate coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
1480081
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-502
</td>
<td style="text-align:left;">
columbia/midlands coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
1496796
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-509
</td>
<td style="text-align:left;">
appalachian regional coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
506973
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-601
</td>
<td style="text-align:left;">
fort worth, arlington/tarrant county coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
2090799
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-607
</td>
<td style="text-align:left;">
texas balance of state coc
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
10634996
</td>
</tr>
<tr>
<td style="text-align:left;">
al-503
</td>
<td style="text-align:left;">
huntsville/north alabama coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
564541
</td>
</tr>
<tr>
<td style="text-align:left;">
il-507
</td>
<td style="text-align:left;">
peoria, pekin/fulton, tazewell, peoria, woodford counties coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
396538
</td>
</tr>
<tr>
<td style="text-align:left;">
md-502
</td>
<td style="text-align:left;">
harford county coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
250586
</td>
</tr>
<tr>
<td style="text-align:left;">
md-505
</td>
<td style="text-align:left;">
baltimore county coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
828373
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-509
</td>
<td style="text-align:left;">
washtenaw county coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
362072
</td>
</tr>
<tr>
<td style="text-align:left;">
ms-503
</td>
<td style="text-align:left;">
gulf port/gulf coast regional coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
484997
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-506
</td>
<td style="text-align:left;">
wilmington/brunswick, new hanover, pender counties coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
399727
</td>
</tr>
<tr>
<td style="text-align:left;">
nh-500
</td>
<td style="text-align:left;">
new hampshire balance of state coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
924881
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-509
</td>
<td style="text-align:left;">
morris county coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
498238
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-515
</td>
<td style="text-align:left;">
elizabeth/union county coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
552128
</td>
</tr>
<tr>
<td style="text-align:left;">
nm-501
</td>
<td style="text-align:left;">
new mexico balance of state coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
1554889
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-502
</td>
<td style="text-align:left;">
upper darby, chester, haverford/delaware county coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
562949
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-511
</td>
<td style="text-align:left;">
bristol, bensalem/bucks county coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
625857
</td>
</tr>
<tr>
<td style="text-align:left;">
va-503
</td>
<td style="text-align:left;">
virginia beach coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
451176
</td>
</tr>
<tr>
<td style="text-align:left;">
va-513
</td>
<td style="text-align:left;">
harrisburg, winchester/western virginia coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
362584
</td>
</tr>
<tr>
<td style="text-align:left;">
va-601
</td>
<td style="text-align:left;">
fairfax county coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
1174776
</td>
</tr>
<tr>
<td style="text-align:left;">
va-604
</td>
<td style="text-align:left;">
prince william county coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
507573
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-500
</td>
<td style="text-align:left;">
wisconsin balance of state coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
4094517
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-500
</td>
<td style="text-align:left;">
wheeling, weirton area coc
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
143954
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-603
</td>
<td style="text-align:left;">
ft myers, cape coral/lee county coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
698265
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-501
</td>
<td style="text-align:left;">
georgia balance of state coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
6905893
</td>
</tr>
<tr>
<td style="text-align:left;">
ia-501
</td>
<td style="text-align:left;">
iowa balance of state coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
2442251
</td>
</tr>
<tr>
<td style="text-align:left;">
il-503
</td>
<td style="text-align:left;">
champaign, urbana, rantoul/champaign county coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
207074
</td>
</tr>
<tr>
<td style="text-align:left;">
il-504
</td>
<td style="text-align:left;">
madison county coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
266162
</td>
</tr>
<tr>
<td style="text-align:left;">
il-520
</td>
<td style="text-align:left;">
southern illinois coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
576910
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-507
</td>
<td style="text-align:left;">
kansas balance of state coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
1474552
</td>
</tr>
<tr>
<td style="text-align:left;">
la-502
</td>
<td style="text-align:left;">
shreveport, bossier/northwest louisiana coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
483539
</td>
</tr>
<tr>
<td style="text-align:left;">
md-503
</td>
<td style="text-align:left;">
annapolis/anne arundel county coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
564194
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-500
</td>
<td style="text-align:left;">
michigan balance of state coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
2358534
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-502
</td>
<td style="text-align:left;">
rochester/southeast minnesota coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
717982
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-509
</td>
<td style="text-align:left;">
gastonia/cleveland, gaston, lincoln counties coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
390735
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-513
</td>
<td style="text-align:left;">
somerset county coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
332768
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-516
</td>
<td style="text-align:left;">
warren, sussex, hunterdon counties coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
375588
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-501
</td>
<td style="text-align:left;">
elmira/steuben, allegany, livingston, chemung, schuyler counties coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
314889
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-508
</td>
<td style="text-align:left;">
buffalo, niagara falls/erie, niagara, orleans, genesee, wyoming counties
coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
1272364
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-510
</td>
<td style="text-align:left;">
ithaca/tompkins county coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
104681
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-523
</td>
<td style="text-align:left;">
glens falls, saratoga springs/saratoga, washington, warren, hamilton
counties co
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
357590
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-509
</td>
<td style="text-align:left;">
eastern pennsylvania coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
3104937
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-624
</td>
<td style="text-align:left;">
wichita falls/wise, palo pinto, wichita, archer counties coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
330725
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-700
</td>
<td style="text-align:left;">
houston, pasadena, conroe/harris, ft. bend, montgomery, counties coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
5748292
</td>
</tr>
<tr>
<td style="text-align:left;">
va-514
</td>
<td style="text-align:left;">
fredericksburg/spotsylvania, stafford counties coc
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
301.5
</td>
<td style="text-align:right;">
356451
</td>
</tr>
<tr>
<td style="text-align:left;">
al-502
</td>
<td style="text-align:left;">
florence/northwest alabama coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
265634
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-501
</td>
<td style="text-align:left;">
fayetteville/northwest arkansas coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
524887
</td>
</tr>
<tr>
<td style="text-align:left;">
il-517
</td>
<td style="text-align:left;">
aurora, elgin/kane county coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
589685
</td>
</tr>
<tr>
<td style="text-align:left;">
in-502
</td>
<td style="text-align:left;">
indiana balance of state coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
5672562
</td>
</tr>
<tr>
<td style="text-align:left;">
ky-500
</td>
<td style="text-align:left;">
kentucky balance of state coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
3348234
</td>
</tr>
<tr>
<td style="text-align:left;">
la-500
</td>
<td style="text-align:left;">
lafayette/acadiana coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
658150
</td>
</tr>
<tr>
<td style="text-align:left;">
la-509
</td>
<td style="text-align:left;">
louisiana balance of state coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
1111992
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-519
</td>
<td style="text-align:left;">
attleboro, taunton/bristol county coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
372829
</td>
</tr>
<tr>
<td style="text-align:left;">
md-504
</td>
<td style="text-align:left;">
howard county coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
312779
</td>
</tr>
<tr>
<td style="text-align:left;">
md-600
</td>
<td style="text-align:left;">
prince george’s county coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
902570
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-503
</td>
<td style="text-align:left;">
north carolina balance of state coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
5075411
</td>
</tr>
<tr>
<td style="text-align:left;">
ne-500
</td>
<td style="text-align:left;">
nebraska balance of state coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
894615
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-507
</td>
<td style="text-align:left;">
new brunswick/middlesex county coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
833404
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-511
</td>
<td style="text-align:left;">
binghamton, union town/broome, otsego, chenango, delaware, cortland,
tioga count
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
449792
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-514
</td>
<td style="text-align:left;">
jamestown, dunkirk/chautauqua county coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
130850
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-522
</td>
<td style="text-align:left;">
jefferson, lewis, st. lawrence counties coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
255122
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-500
</td>
<td style="text-align:left;">
north central oklahoma coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
314750
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-503
</td>
<td style="text-align:left;">
oklahoma balance of state coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
669481
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-510
</td>
<td style="text-align:left;">
lancaster city & county coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
536004
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-512
</td>
<td style="text-align:left;">
york city & county coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
441548
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-506
</td>
<td style="text-align:left;">
upper cumberland coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
567870
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-604
</td>
<td style="text-align:left;">
waco/mclennan county coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
358285
</td>
</tr>
<tr>
<td style="text-align:left;">
va-500
</td>
<td style="text-align:left;">
richmond/henrico, chesterfield, hanover counties coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
1061547
</td>
</tr>
<tr>
<td style="text-align:left;">
va-504
</td>
<td style="text-align:left;">
charlottesville coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
246286
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-508
</td>
<td style="text-align:left;">
west virginia balance of state coc
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
1281817
</td>
</tr>
<tr>
<td style="text-align:left;">
al-507
</td>
<td style="text-align:left;">
alabama balance of state coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
1522513
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-506
</td>
<td style="text-align:left;">
marietta/cobb county coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
737643
</td>
</tr>
<tr>
<td style="text-align:left;">
il-500
</td>
<td style="text-align:left;">
mchenry county coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
300660
</td>
</tr>
<tr>
<td style="text-align:left;">
la-505
</td>
<td style="text-align:left;">
monroe/northeast louisiana coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
355418
</td>
</tr>
<tr>
<td style="text-align:left;">
la-506
</td>
<td style="text-align:left;">
slidell/southeast louisiana coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
573011
</td>
</tr>
<tr>
<td style="text-align:left;">
la-507
</td>
<td style="text-align:left;">
alexandria/central louisiana coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
307404
</td>
</tr>
<tr>
<td style="text-align:left;">
md-510
</td>
<td style="text-align:left;">
garrett county coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
29541
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-503
</td>
<td style="text-align:left;">
st. clair shores, warren/macomb county coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
864717
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-518
</td>
<td style="text-align:left;">
livingston county coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
187091
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-500
</td>
<td style="text-align:left;">
st. louis county coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
999793
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-606
</td>
<td style="text-align:left;">
missouri balance of state coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
2738152
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-504
</td>
<td style="text-align:left;">
cattaragus county coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
78050
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-518
</td>
<td style="text-align:left;">
utica, rome/oneida, madison counties coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
306907
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-606
</td>
<td style="text-align:left;">
rockland county coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
324596
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-507
</td>
<td style="text-align:left;">
ohio balance of state coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
6126510
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-506
</td>
<td style="text-align:left;">
southwest oklahoma regional coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
407894
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-503
</td>
<td style="text-align:left;">
wilkes-barre, hazleton/luzerne county coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
317739
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-603
</td>
<td style="text-align:left;">
beaver county coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
168625
</td>
</tr>
<tr>
<td style="text-align:left;">
ut-503
</td>
<td style="text-align:left;">
utah balance of state coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
1242374
</td>
</tr>
<tr>
<td style="text-align:left;">
va-508
</td>
<td style="text-align:left;">
lynchburg coc
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
347.5
</td>
<td style="text-align:right;">
259135
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-503
</td>
<td style="text-align:left;">
dakota, anoka, washington, scott, carver counties
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
361.0
</td>
<td style="text-align:right;">
1264398
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-511
</td>
<td style="text-align:left;">
southwest minnesota coc
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
361.0
</td>
<td style="text-align:right;">
277032
</td>
</tr>
<tr>
<td style="text-align:left;">
ms-501
</td>
<td style="text-align:left;">
mississippi balance of state coc
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
361.0
</td>
<td style="text-align:right;">
1933222
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-508
</td>
<td style="text-align:left;">
monmouth county coc
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
361.0
</td>
<td style="text-align:right;">
625879
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-601
</td>
<td style="text-align:left;">
western pennsylvania coc
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
361.0
</td>
<td style="text-align:right;">
1725296
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-500
</td>
<td style="text-align:left;">
charleston/low country coc
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
361.0
</td>
<td style="text-align:right;">
1009228
</td>
</tr>
<tr>
<td style="text-align:left;">
va-521
</td>
<td style="text-align:left;">
virginia balance of state coc
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
361.0
</td>
<td style="text-align:right;">
1695332
</td>
</tr>
<tr>
<td style="text-align:left;">
il-502
</td>
<td style="text-align:left;">
waukegan, north chicago/lake county coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
729261
</td>
</tr>
<tr>
<td style="text-align:left;">
il-506
</td>
<td style="text-align:left;">
joliet, bolingbrook/will county coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
803325
</td>
</tr>
<tr>
<td style="text-align:left;">
il-511
</td>
<td style="text-align:left;">
cook county coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
2494027
</td>
</tr>
<tr>
<td style="text-align:left;">
il-514
</td>
<td style="text-align:left;">
dupage county coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
917503
</td>
</tr>
<tr>
<td style="text-align:left;">
il-518
</td>
<td style="text-align:left;">
rock island, moline/northwestern illinois coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
656316
</td>
</tr>
<tr>
<td style="text-align:left;">
il-519
</td>
<td style="text-align:left;">
west central illinois coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
223572
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-504
</td>
<td style="text-align:left;">
pontiac, royal oak/oakland county coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
1240927
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-501
</td>
<td style="text-align:left;">
bergen county coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
934290
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-510
</td>
<td style="text-align:left;">
lakewood township/ocean county coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
588882
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-520
</td>
<td style="text-align:left;">
franklin, essex counties coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
89018
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-504
</td>
<td style="text-align:left;">
lower merion, norristown, abington/montgomery county coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
818782
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-701
</td>
<td style="text-align:left;">
bryan, college station/brazos valley coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
331198
</td>
</tr>
<tr>
<td style="text-align:left;">
ut-504
</td>
<td style="text-align:left;">
provo/mountainland coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
639584
</td>
</tr>
<tr>
<td style="text-align:left;">
va-602
</td>
<td style="text-align:left;">
loudoun county coc
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
371.5
</td>
<td style="text-align:right;">
373741
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-505
</td>
<td style="text-align:left;">
southeast arkansas coc
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
380.5
</td>
<td style="text-align:right;">
304531
</td>
</tr>
<tr>
<td style="text-align:left;">
il-515
</td>
<td style="text-align:left;">
south central illinois coc
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
380.5
</td>
<td style="text-align:right;">
401555
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-505
</td>
<td style="text-align:left;">
overland park, shawnee/johnson county coc
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
380.5
</td>
<td style="text-align:right;">
578042
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-503
</td>
<td style="text-align:left;">
central tennessee coc
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
380.5
</td>
<td style="text-align:right;">
1140959
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-502
</td>
<td style="text-align:left;">
dearborn, dearborn heights, westland/wayne county coc
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
383.0
</td>
<td style="text-align:right;">
1079405
</td>
</tr>
</tbody>
</table>
</div>
### Fact: Change in rates over time, 2014-2018

*See caveat \#2 above.*

The CoC with the greatest increase between 2014 and 2018 was the Lynn
CoC in Massachusetts, followed by Imperial County in California and
Monroe County in Florida.

The CoC with the greatest decrease between 2014 and 2018 was Mendocino
County in California, followed by the Colusa, Glenn and Trinity County
CoC in California and the St. John’s County CoC in Florida.

``` r
# Order by change in rate
wk %>%
  arrange(rank_rate_percpt_change_2014_2018, coc_code) %>%
  select(coc_code, coc_name, 
         rate_percpt_change_2014_2018, rank_rate_percpt_change_2014_2018, 
         homeless_rate_perc_2014, homeless_rate_perc_2018,
         total_pop_2017) %>%
  # Write to CSV
  write_csv(paste0(save_path, "change-rates-of-homelessness-by-coc.csv")) %>%
  # Styling
  kable(caption = "Ordered by the change in the homeless rate from 2014 to 2018") %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<caption>
Ordered by the change in the homeless rate from 2014 to 2018
</caption>
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_code
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_name
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
rate\_percpt\_change\_2014\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
rank\_rate\_percpt\_change\_2014\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
homeless\_rate\_perc\_2014
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
homeless\_rate\_perc\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
total\_pop\_2017
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ma-502
</td>
<td style="text-align:left;">
lynn coc
</td>
<td style="text-align:right;">
0.7338795
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0.4128748
</td>
<td style="text-align:right;">
1.1467543
</td>
<td style="text-align:right;">
92522
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-613
</td>
<td style="text-align:left;">
imperial county coc
</td>
<td style="text-align:right;">
0.6660796
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
0.1661018
</td>
<td style="text-align:right;">
0.8321814
</td>
<td style="text-align:right;">
179408
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-604
</td>
<td style="text-align:left;">
monroe county coc
</td>
<td style="text-align:right;">
0.3762803
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
0.8648069
</td>
<td style="text-align:right;">
1.2410873
</td>
<td style="text-align:right;">
78399
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-525
</td>
<td style="text-align:left;">
el dorado county coc
</td>
<td style="text-align:right;">
0.2446889
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
0.1060319
</td>
<td style="text-align:right;">
0.3507207
</td>
<td style="text-align:right;">
183907
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-519
</td>
<td style="text-align:left;">
chico, paradise/butte county coc
</td>
<td style="text-align:right;">
0.1905058
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
0.3090723
</td>
<td style="text-align:right;">
0.4995781
</td>
<td style="text-align:right;">
225190
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-508
</td>
<td style="text-align:left;">
lowell coc
</td>
<td style="text-align:right;">
0.1766416
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
0.5326425
</td>
<td style="text-align:right;">
0.7092841
</td>
<td style="text-align:right;">
110393
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-600
</td>
<td style="text-align:left;">
los angeles city & county coc
</td>
<td style="text-align:right;">
0.1679721
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:right;">
0.3712289
</td>
<td style="text-align:right;">
0.5392010
</td>
<td style="text-align:right;">
9264635
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-516
</td>
<td style="text-align:left;">
redding/shasta, siskiyou, lassen, plumas, del norte, modoc, sierra
counties coc
</td>
<td style="text-align:right;">
0.1663819
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
0.2019664
</td>
<td style="text-align:right;">
0.3683483
</td>
<td style="text-align:right;">
311933
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-507
</td>
<td style="text-align:left;">
marin county coc
</td>
<td style="text-align:right;">
0.1597745
</td>
<td style="text-align:right;">
9
</td>
<td style="text-align:right;">
0.2607857
</td>
<td style="text-align:right;">
0.4205602
</td>
<td style="text-align:right;">
260367
</td>
</tr>
<tr>
<td style="text-align:left;">
or-505
</td>
<td style="text-align:left;">
oregon balance of state coc
</td>
<td style="text-align:right;">
0.1545636
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
0.2806657
</td>
<td style="text-align:right;">
0.4352293
</td>
<td style="text-align:right;">
1468651
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-500
</td>
<td style="text-align:left;">
seattle/king county coc
</td>
<td style="text-align:right;">
0.1492523
</td>
<td style="text-align:right;">
11
</td>
<td style="text-align:right;">
0.4222760
</td>
<td style="text-align:right;">
0.5715283
</td>
<td style="text-align:right;">
2119230
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-504
</td>
<td style="text-align:left;">
springfield/hampden county coc
</td>
<td style="text-align:right;">
0.1448399
</td>
<td style="text-align:right;">
12
</td>
<td style="text-align:right;">
0.5746599
</td>
<td style="text-align:right;">
0.7194998
</td>
<td style="text-align:right;">
468103
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-600
</td>
<td style="text-align:left;">
new york city coc
</td>
<td style="text-align:right;">
0.1278777
</td>
<td style="text-align:right;">
13
</td>
<td style="text-align:right;">
0.7980296
</td>
<td style="text-align:right;">
0.9259073
</td>
<td style="text-align:right;">
8497179
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-611
</td>
<td style="text-align:left;">
amarillo coc
</td>
<td style="text-align:right;">
0.1131796
</td>
<td style="text-align:right;">
14
</td>
<td style="text-align:right;">
0.2385234
</td>
<td style="text-align:right;">
0.3517030
</td>
<td style="text-align:right;">
189080
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-504
</td>
<td style="text-align:left;">
norman/cleveland county coc
</td>
<td style="text-align:right;">
0.1105016
</td>
<td style="text-align:right;">
15
</td>
<td style="text-align:right;">
0.0690635
</td>
<td style="text-align:right;">
0.1795651
</td>
<td style="text-align:right;">
202712
</td>
</tr>
<tr>
<td style="text-align:left;">
co-500
</td>
<td style="text-align:left;">
colorado balance of state coc
</td>
<td style="text-align:right;">
0.1057686
</td>
<td style="text-align:right;">
16
</td>
<td style="text-align:right;">
0.1284963
</td>
<td style="text-align:right;">
0.2342649
</td>
<td style="text-align:right;">
1702773
</td>
</tr>
<tr>
<td style="text-align:left;">
or-503
</td>
<td style="text-align:left;">
central oregon coc
</td>
<td style="text-align:right;">
0.0998791
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:right;">
0.2590473
</td>
<td style="text-align:right;">
0.3589264
</td>
<td style="text-align:right;">
219265
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-507
</td>
<td style="text-align:left;">
schenectady city & county coc
</td>
<td style="text-align:right;">
0.0968404
</td>
<td style="text-align:right;">
18
</td>
<td style="text-align:right;">
0.1568815
</td>
<td style="text-align:right;">
0.2537219
</td>
<td style="text-align:right;">
154894
</td>
</tr>
<tr>
<td style="text-align:left;">
nv-501
</td>
<td style="text-align:left;">
reno, sparks/washoe county coc
</td>
<td style="text-align:right;">
0.0950970
</td>
<td style="text-align:right;">
19
</td>
<td style="text-align:right;">
0.1728832
</td>
<td style="text-align:right;">
0.2679802
</td>
<td style="text-align:right;">
444809
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-504
</td>
<td style="text-align:left;">
newark/essex county coc
</td>
<td style="text-align:right;">
0.0938804
</td>
<td style="text-align:right;">
20
</td>
<td style="text-align:right;">
0.1868787
</td>
<td style="text-align:right;">
0.2807591
</td>
<td style="text-align:right;">
793563
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-606
</td>
<td style="text-align:left;">
naples/collier county coc
</td>
<td style="text-align:right;">
0.0821653
</td>
<td style="text-align:right;">
21
</td>
<td style="text-align:right;">
0.1015811
</td>
<td style="text-align:right;">
0.1837465
</td>
<td style="text-align:right;">
355381
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-516
</td>
<td style="text-align:left;">
clinton county coc
</td>
<td style="text-align:right;">
0.0786966
</td>
<td style="text-align:right;">
22
</td>
<td style="text-align:right;">
0.1635413
</td>
<td style="text-align:right;">
0.2422379
</td>
<td style="text-align:right;">
81325
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-503
</td>
<td style="text-align:left;">
sacramento city & county coc
</td>
<td style="text-align:right;">
0.0785119
</td>
<td style="text-align:right;">
23
</td>
<td style="text-align:right;">
0.1640576
</td>
<td style="text-align:right;">
0.2425695
</td>
<td style="text-align:right;">
1492768
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-607
</td>
<td style="text-align:left;">
sullivan county coc
</td>
<td style="text-align:right;">
0.0770191
</td>
<td style="text-align:right;">
24
</td>
<td style="text-align:right;">
0.1739569
</td>
<td style="text-align:right;">
0.2509760
</td>
<td style="text-align:right;">
75306
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-502
</td>
<td style="text-align:left;">
oakland, berkeley/alameda county coc
</td>
<td style="text-align:right;">
0.0753022
</td>
<td style="text-align:right;">
25
</td>
<td style="text-align:right;">
0.2628194
</td>
<td style="text-align:right;">
0.3381215
</td>
<td style="text-align:right;">
1625451
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-514
</td>
<td style="text-align:left;">
jamestown, dunkirk/chautauqua county coc
</td>
<td style="text-align:right;">
0.0703095
</td>
<td style="text-align:right;">
26
</td>
<td style="text-align:right;">
0.0405044
</td>
<td style="text-align:right;">
0.1108139
</td>
<td style="text-align:right;">
130850
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-506
</td>
<td style="text-align:left;">
salinas/monterey, san benito counties coc
</td>
<td style="text-align:right;">
0.0687046
</td>
<td style="text-align:right;">
27
</td>
<td style="text-align:right;">
0.6038662
</td>
<td style="text-align:right;">
0.6725708
</td>
<td style="text-align:right;">
490506
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-608
</td>
<td style="text-align:left;">
kingston/ulster county coc
</td>
<td style="text-align:right;">
0.0684436
</td>
<td style="text-align:right;">
28
</td>
<td style="text-align:right;">
0.1897502
</td>
<td style="text-align:right;">
0.2581938
</td>
<td style="text-align:right;">
179710
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-505
</td>
<td style="text-align:left;">
new bedford coc
</td>
<td style="text-align:right;">
0.0631134
</td>
<td style="text-align:right;">
29
</td>
<td style="text-align:right;">
0.3671095
</td>
<td style="text-align:right;">
0.4302229
</td>
<td style="text-align:right;">
95067
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-519
</td>
<td style="text-align:left;">
columbia, greene counties coc
</td>
<td style="text-align:right;">
0.0621851
</td>
<td style="text-align:right;">
30
</td>
<td style="text-align:right;">
0.1170543
</td>
<td style="text-align:right;">
0.1792393
</td>
<td style="text-align:right;">
109351
</td>
</tr>
<tr>
<td style="text-align:left;">
md-512
</td>
<td style="text-align:left;">
hagerstown/washington county coc
</td>
<td style="text-align:right;">
0.0613857
</td>
<td style="text-align:right;">
31
</td>
<td style="text-align:right;">
0.0713943
</td>
<td style="text-align:right;">
0.1327800
</td>
<td style="text-align:right;">
149872
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-503
</td>
<td style="text-align:left;">
albany city & county coc
</td>
<td style="text-align:right;">
0.0600028
</td>
<td style="text-align:right;">
32
</td>
<td style="text-align:right;">
0.2108206
</td>
<td style="text-align:right;">
0.2708234
</td>
<td style="text-align:right;">
308319
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-501
</td>
<td style="text-align:left;">
san francisco coc
</td>
<td style="text-align:right;">
0.0522214
</td>
<td style="text-align:right;">
33
</td>
<td style="text-align:right;">
0.7452887
</td>
<td style="text-align:right;">
0.7975101
</td>
<td style="text-align:right;">
859801
</td>
</tr>
<tr>
<td style="text-align:left;">
or-502
</td>
<td style="text-align:left;">
medford, ashland/jackson county coc
</td>
<td style="text-align:right;">
0.0501244
</td>
<td style="text-align:right;">
34
</td>
<td style="text-align:right;">
0.2927826
</td>
<td style="text-align:right;">
0.3429069
</td>
<td style="text-align:right;">
213469
</td>
</tr>
<tr>
<td style="text-align:left;">
co-504
</td>
<td style="text-align:left;">
colorado springs/el paso county coc
</td>
<td style="text-align:right;">
0.0491620
</td>
<td style="text-align:right;">
35
</td>
<td style="text-align:right;">
0.1805076
</td>
<td style="text-align:right;">
0.2296696
</td>
<td style="text-align:right;">
675318
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-510
</td>
<td style="text-align:left;">
ithaca/tompkins county coc
</td>
<td style="text-align:right;">
0.0420325
</td>
<td style="text-align:right;">
36
</td>
<td style="text-align:right;">
0.0448983
</td>
<td style="text-align:right;">
0.0869308
</td>
<td style="text-align:right;">
104681
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-515
</td>
<td style="text-align:left;">
roseville, rocklin/placer, nevada counties coc
</td>
<td style="text-align:right;">
0.0396985
</td>
<td style="text-align:right;">
37
</td>
<td style="text-align:right;">
0.1609055
</td>
<td style="text-align:right;">
0.2006039
</td>
<td style="text-align:right;">
473570
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-510
</td>
<td style="text-align:left;">
turlock, modesto/stanislaus county coc
</td>
<td style="text-align:right;">
0.0374704
</td>
<td style="text-align:right;">
38
</td>
<td style="text-align:right;">
0.2165788
</td>
<td style="text-align:right;">
0.2540491
</td>
<td style="text-align:right;">
533755
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-515
</td>
<td style="text-align:left;">
panama city/bay, jackson counties coc
</td>
<td style="text-align:right;">
0.0371172
</td>
<td style="text-align:right;">
39
</td>
<td style="text-align:right;">
0.0880302
</td>
<td style="text-align:right;">
0.1251474
</td>
<td style="text-align:right;">
304441
</td>
</tr>
<tr>
<td style="text-align:left;">
ak-501
</td>
<td style="text-align:left;">
alaska balance of state coc
</td>
<td style="text-align:right;">
0.0365245
</td>
<td style="text-align:right;">
40
</td>
<td style="text-align:right;">
0.1726407
</td>
<td style="text-align:right;">
0.2091652
</td>
<td style="text-align:right;">
440800
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-602
</td>
<td style="text-align:left;">
santa ana, anaheim/orange county coc
</td>
<td style="text-align:right;">
0.0356377
</td>
<td style="text-align:right;">
41
</td>
<td style="text-align:right;">
0.1217462
</td>
<td style="text-align:right;">
0.1573839
</td>
<td style="text-align:right;">
3148353
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-513
</td>
<td style="text-align:left;">
wayne, ontario, seneca, yates counties coc
</td>
<td style="text-align:right;">
0.0344837
</td>
<td style="text-align:right;">
42
</td>
<td style="text-align:right;">
0.0352500
</td>
<td style="text-align:right;">
0.0697337
</td>
<td style="text-align:right;">
260993
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-513
</td>
<td style="text-align:left;">
visalia/kings, tulare counties coc
</td>
<td style="text-align:right;">
0.0336063
</td>
<td style="text-align:right;">
43
</td>
<td style="text-align:right;">
0.1256942
</td>
<td style="text-align:right;">
0.1593005
</td>
<td style="text-align:right;">
607029
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-502
</td>
<td style="text-align:left;">
racine city & county coc
</td>
<td style="text-align:right;">
0.0333588
</td>
<td style="text-align:right;">
44
</td>
<td style="text-align:right;">
0.1077747
</td>
<td style="text-align:right;">
0.1411335
</td>
<td style="text-align:right;">
194851
</td>
</tr>
<tr>
<td style="text-align:left;">
sd-500
</td>
<td style="text-align:left;">
south dakota statewide coc
</td>
<td style="text-align:right;">
0.0319003
</td>
<td style="text-align:right;">
45
</td>
<td style="text-align:right;">
0.1030357
</td>
<td style="text-align:right;">
0.1349360
</td>
<td style="text-align:right;">
858926
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-513
</td>
<td style="text-align:left;">
chapel hill/orange county coc
</td>
<td style="text-align:right;">
0.0312123
</td>
<td style="text-align:right;">
46
</td>
<td style="text-align:right;">
0.0766120
</td>
<td style="text-align:right;">
0.1078244
</td>
<td style="text-align:right;">
140970
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-500
</td>
<td style="text-align:left;">
boston coc
</td>
<td style="text-align:right;">
0.0301676
</td>
<td style="text-align:right;">
47
</td>
<td style="text-align:right;">
0.8985752
</td>
<td style="text-align:right;">
0.9287429
</td>
<td style="text-align:right;">
666277
</td>
</tr>
<tr>
<td style="text-align:left;">
md-506
</td>
<td style="text-align:left;">
carroll county coc
</td>
<td style="text-align:right;">
0.0292317
</td>
<td style="text-align:right;">
48
</td>
<td style="text-align:right;">
0.0739742
</td>
<td style="text-align:right;">
0.1032059
</td>
<td style="text-align:right;">
167626
</td>
</tr>
<tr>
<td style="text-align:left;">
md-509
</td>
<td style="text-align:left;">
frederick city & county coc
</td>
<td style="text-align:right;">
0.0285066
</td>
<td style="text-align:right;">
49
</td>
<td style="text-align:right;">
0.1001804
</td>
<td style="text-align:right;">
0.1286870
</td>
<td style="text-align:right;">
245557
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-520
</td>
<td style="text-align:left;">
citrus, hernando, lake, sumter counties coc
</td>
<td style="text-align:right;">
0.0262012
</td>
<td style="text-align:right;">
50
</td>
<td style="text-align:right;">
0.0669440
</td>
<td style="text-align:right;">
0.0931451
</td>
<td style="text-align:right;">
763325
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-517
</td>
<td style="text-align:left;">
napa city & county coc
</td>
<td style="text-align:right;">
0.0261760
</td>
<td style="text-align:right;">
51
</td>
<td style="text-align:right;">
0.2016257
</td>
<td style="text-align:right;">
0.2278017
</td>
<td style="text-align:right;">
141351
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-515
</td>
<td style="text-align:left;">
fall river coc
</td>
<td style="text-align:right;">
0.0258204
</td>
<td style="text-align:right;">
52
</td>
<td style="text-align:right;">
0.3974090
</td>
<td style="text-align:right;">
0.4232293
</td>
<td style="text-align:right;">
89077
</td>
</tr>
<tr>
<td style="text-align:left;">
ak-500
</td>
<td style="text-align:left;">
anchorage coc
</td>
<td style="text-align:right;">
0.0237034
</td>
<td style="text-align:right;">
53
</td>
<td style="text-align:right;">
0.3415294
</td>
<td style="text-align:right;">
0.3652328
</td>
<td style="text-align:right;">
299535
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-506
</td>
<td style="text-align:left;">
tallahassee/leon county coc
</td>
<td style="text-align:right;">
0.0236950
</td>
<td style="text-align:right;">
54
</td>
<td style="text-align:right;">
0.1834085
</td>
<td style="text-align:right;">
0.2071035
</td>
<td style="text-align:right;">
438911
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-603
</td>
<td style="text-align:left;">
nassau, suffolk counties coc
</td>
<td style="text-align:right;">
0.0231615
</td>
<td style="text-align:right;">
55
</td>
<td style="text-align:right;">
0.1123734
</td>
<td style="text-align:right;">
0.1355349
</td>
<td style="text-align:right;">
2853877
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-524
</td>
<td style="text-align:left;">
yuba city & county/sutter county coc
</td>
<td style="text-align:right;">
0.0229517
</td>
<td style="text-align:right;">
56
</td>
<td style="text-align:right;">
0.4272549
</td>
<td style="text-align:right;">
0.4502066
</td>
<td style="text-align:right;">
169922
</td>
</tr>
<tr>
<td style="text-align:left;">
md-505
</td>
<td style="text-align:left;">
baltimore county coc
</td>
<td style="text-align:right;">
0.0228158
</td>
<td style="text-align:right;">
57
</td>
<td style="text-align:right;">
0.0686889
</td>
<td style="text-align:right;">
0.0915047
</td>
<td style="text-align:right;">
828373
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-508
</td>
<td style="text-align:left;">
vancouver/clark county coc
</td>
<td style="text-align:right;">
0.0214792
</td>
<td style="text-align:right;">
58
</td>
<td style="text-align:right;">
0.1492803
</td>
<td style="text-align:right;">
0.1707595
</td>
<td style="text-align:right;">
465567
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-505
</td>
<td style="text-align:left;">
richmond/contra costa county coc
</td>
<td style="text-align:right;">
0.0200932
</td>
<td style="text-align:right;">
59
</td>
<td style="text-align:right;">
0.1794099
</td>
<td style="text-align:right;">
0.1995031
</td>
<td style="text-align:right;">
1119782
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-503
</td>
<td style="text-align:left;">
tacoma, lakewood/pierce county coc
</td>
<td style="text-align:right;">
0.0195715
</td>
<td style="text-align:right;">
60
</td>
<td style="text-align:right;">
0.1747113
</td>
<td style="text-align:right;">
0.1942827
</td>
<td style="text-align:right;">
837954
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-502
</td>
<td style="text-align:left;">
spokane city & county coc
</td>
<td style="text-align:right;">
0.0195565
</td>
<td style="text-align:right;">
61
</td>
<td style="text-align:right;">
0.2340666
</td>
<td style="text-align:right;">
0.2536230
</td>
<td style="text-align:right;">
490886
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-501
</td>
<td style="text-align:left;">
washington balance of state coc
</td>
<td style="text-align:right;">
0.0192947
</td>
<td style="text-align:right;">
62
</td>
<td style="text-align:right;">
0.2349465
</td>
<td style="text-align:right;">
0.2542412
</td>
<td style="text-align:right;">
2228592
</td>
</tr>
<tr>
<td style="text-align:left;">
de-500
</td>
<td style="text-align:left;">
delaware statewide coc
</td>
<td style="text-align:right;">
0.0191954
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
0.0955526
</td>
<td style="text-align:right;">
0.1147480
</td>
<td style="text-align:right;">
942936
</td>
</tr>
<tr>
<td style="text-align:left;">
nh-501
</td>
<td style="text-align:left;">
manchester coc
</td>
<td style="text-align:right;">
0.0181286
</td>
<td style="text-align:right;">
64
</td>
<td style="text-align:right;">
0.3689167
</td>
<td style="text-align:right;">
0.3870453
</td>
<td style="text-align:right;">
110323
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-501
</td>
<td style="text-align:left;">
harrisburg/dauphin county coc
</td>
<td style="text-align:right;">
0.0179599
</td>
<td style="text-align:right;">
65
</td>
<td style="text-align:right;">
0.1451453
</td>
<td style="text-align:right;">
0.1631052
</td>
<td style="text-align:right;">
272830
</td>
</tr>
<tr>
<td style="text-align:left;">
al-502
</td>
<td style="text-align:left;">
florence/northwest alabama coc
</td>
<td style="text-align:right;">
0.0176935
</td>
<td style="text-align:right;">
66
</td>
<td style="text-align:right;">
0.0786797
</td>
<td style="text-align:right;">
0.0963732
</td>
<td style="text-align:right;">
265634
</td>
</tr>
<tr>
<td style="text-align:left;">
md-511
</td>
<td style="text-align:left;">
mid-shore regional coc
</td>
<td style="text-align:right;">
0.0175347
</td>
<td style="text-align:right;">
67
</td>
<td style="text-align:right;">
0.0648785
</td>
<td style="text-align:right;">
0.0824132
</td>
<td style="text-align:right;">
171089
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-606
</td>
<td style="text-align:left;">
rockland county coc
</td>
<td style="text-align:right;">
0.0169441
</td>
<td style="text-align:right;">
68
</td>
<td style="text-align:right;">
0.0385094
</td>
<td style="text-align:right;">
0.0554535
</td>
<td style="text-align:right;">
324596
</td>
</tr>
<tr>
<td style="text-align:left;">
va-501
</td>
<td style="text-align:left;">
norfolk/chesapeake, suffolk, isle of wight, southampton counties coc
</td>
<td style="text-align:right;">
0.0165988
</td>
<td style="text-align:right;">
69
</td>
<td style="text-align:right;">
0.1056000
</td>
<td style="text-align:right;">
0.1221988
</td>
<td style="text-align:right;">
632576
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-510
</td>
<td style="text-align:left;">
saginaw city & county coc
</td>
<td style="text-align:right;">
0.0165014
</td>
<td style="text-align:right;">
70
</td>
<td style="text-align:right;">
0.1675923
</td>
<td style="text-align:right;">
0.1840937
</td>
<td style="text-align:right;">
193923
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-600
</td>
<td style="text-align:left;">
dallas city & county, irving coc
</td>
<td style="text-align:right;">
0.0164764
</td>
<td style="text-align:right;">
71
</td>
<td style="text-align:right;">
0.0953841
</td>
<td style="text-align:right;">
0.1118605
</td>
<td style="text-align:right;">
3684054
</td>
</tr>
<tr>
<td style="text-align:left;">
nm-500
</td>
<td style="text-align:left;">
albuquerque coc
</td>
<td style="text-align:right;">
0.0163395
</td>
<td style="text-align:right;">
72
</td>
<td style="text-align:right;">
0.2382527
</td>
<td style="text-align:right;">
0.2545922
</td>
<td style="text-align:right;">
526332
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-515
</td>
<td style="text-align:left;">
monroe city & county coc
</td>
<td style="text-align:right;">
0.0160585
</td>
<td style="text-align:right;">
73
</td>
<td style="text-align:right;">
0.1237839
</td>
<td style="text-align:right;">
0.1398424
</td>
<td style="text-align:right;">
149454
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-516
</td>
<td style="text-align:left;">
warren, sussex, hunterdon counties coc
</td>
<td style="text-align:right;">
0.0157087
</td>
<td style="text-align:right;">
74
</td>
<td style="text-align:right;">
0.0742835
</td>
<td style="text-align:right;">
0.0899922
</td>
<td style="text-align:right;">
375588
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-602
</td>
<td style="text-align:left;">
newburgh, middletown/orange county coc
</td>
<td style="text-align:right;">
0.0156457
</td>
<td style="text-align:right;">
75
</td>
<td style="text-align:right;">
0.1116415
</td>
<td style="text-align:right;">
0.1272872
</td>
<td style="text-align:right;">
377100
</td>
</tr>
<tr>
<td style="text-align:left;">
va-513
</td>
<td style="text-align:left;">
harrisburg, winchester/western virginia coc
</td>
<td style="text-align:right;">
0.0151689
</td>
<td style="text-align:right;">
76
</td>
<td style="text-align:right;">
0.0686737
</td>
<td style="text-align:right;">
0.0838426
</td>
<td style="text-align:right;">
362584
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-503
</td>
<td style="text-align:left;">
columbus/franklin county coc
</td>
<td style="text-align:right;">
0.0149693
</td>
<td style="text-align:right;">
77
</td>
<td style="text-align:right;">
0.1251834
</td>
<td style="text-align:right;">
0.1401527
</td>
<td style="text-align:right;">
1289308
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-511
</td>
<td style="text-align:left;">
stockton/san joaquin county coc
</td>
<td style="text-align:right;">
0.0134504
</td>
<td style="text-align:right;">
78
</td>
<td style="text-align:right;">
0.2201990
</td>
<td style="text-align:right;">
0.2336494
</td>
<td style="text-align:right;">
721166
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-508
</td>
<td style="text-align:left;">
moorhead/west central minnesota coc
</td>
<td style="text-align:right;">
0.0132920
</td>
<td style="text-align:right;">
79
</td>
<td style="text-align:right;">
0.0888904
</td>
<td style="text-align:right;">
0.1021824
</td>
<td style="text-align:right;">
240746
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-603
</td>
<td style="text-align:left;">
beaver county coc
</td>
<td style="text-align:right;">
0.0130467
</td>
<td style="text-align:right;">
80
</td>
<td style="text-align:right;">
0.0563380
</td>
<td style="text-align:right;">
0.0693847
</td>
<td style="text-align:right;">
168625
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-503
</td>
<td style="text-align:left;">
austin/travis county coc
</td>
<td style="text-align:right;">
0.0127909
</td>
<td style="text-align:right;">
81
</td>
<td style="text-align:right;">
0.1588468
</td>
<td style="text-align:right;">
0.1716377
</td>
<td style="text-align:right;">
1250891
</td>
</tr>
<tr>
<td style="text-align:left;">
la-507
</td>
<td style="text-align:left;">
alexandria/central louisiana coc
</td>
<td style="text-align:right;">
0.0117110
</td>
<td style="text-align:right;">
82
</td>
<td style="text-align:right;">
0.0458680
</td>
<td style="text-align:right;">
0.0575790
</td>
<td style="text-align:right;">
307404
</td>
</tr>
<tr>
<td style="text-align:left;">
or-501
</td>
<td style="text-align:left;">
portland, gresham/multnomah county coc
</td>
<td style="text-align:right;">
0.0116756
</td>
<td style="text-align:right;">
83
</td>
<td style="text-align:right;">
0.4983705
</td>
<td style="text-align:right;">
0.5100461
</td>
<td style="text-align:right;">
787968
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-511
</td>
<td style="text-align:left;">
paterson/passaic county coc
</td>
<td style="text-align:right;">
0.0114436
</td>
<td style="text-align:right;">
84
</td>
<td style="text-align:right;">
0.0741860
</td>
<td style="text-align:right;">
0.0856296
</td>
<td style="text-align:right;">
506834
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-501
</td>
<td style="text-align:left;">
tulsa city & county coc
</td>
<td style="text-align:right;">
0.0105753
</td>
<td style="text-align:right;">
85
</td>
<td style="text-align:right;">
0.1463153
</td>
<td style="text-align:right;">
0.1568906
</td>
<td style="text-align:right;">
690290
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-526
</td>
<td style="text-align:left;">
amador, calaveras, mariposa, tuolumne counties coc
</td>
<td style="text-align:right;">
0.0104652
</td>
<td style="text-align:right;">
86
</td>
<td style="text-align:right;">
0.2498561
</td>
<td style="text-align:right;">
0.2603213
</td>
<td style="text-align:right;">
152888
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-505
</td>
<td style="text-align:left;">
southeast arkansas coc
</td>
<td style="text-align:right;">
0.0101796
</td>
<td style="text-align:right;">
87
</td>
<td style="text-align:right;">
0.0229862
</td>
<td style="text-align:right;">
0.0331658
</td>
<td style="text-align:right;">
304531
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-501
</td>
<td style="text-align:left;">
asheville/buncombe county coc
</td>
<td style="text-align:right;">
0.0094904
</td>
<td style="text-align:right;">
88
</td>
<td style="text-align:right;">
0.2095789
</td>
<td style="text-align:right;">
0.2190693
</td>
<td style="text-align:right;">
252888
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-504
</td>
<td style="text-align:left;">
nashville-davidson county coc
</td>
<td style="text-align:right;">
0.0094498
</td>
<td style="text-align:right;">
89
</td>
<td style="text-align:right;">
0.3298566
</td>
<td style="text-align:right;">
0.3393064
</td>
<td style="text-align:right;">
677264
</td>
</tr>
<tr>
<td style="text-align:left;">
ut-503
</td>
<td style="text-align:left;">
utah balance of state coc
</td>
<td style="text-align:right;">
0.0094175
</td>
<td style="text-align:right;">
90
</td>
<td style="text-align:right;">
0.0629440
</td>
<td style="text-align:right;">
0.0723615
</td>
<td style="text-align:right;">
1242374
</td>
</tr>
<tr>
<td style="text-align:left;">
az-502
</td>
<td style="text-align:left;">
phoenix, mesa/maricopa county coc
</td>
<td style="text-align:right;">
0.0091259
</td>
<td style="text-align:right;">
91
</td>
<td style="text-align:right;">
0.1421246
</td>
<td style="text-align:right;">
0.1512505
</td>
<td style="text-align:right;">
4163953
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-509
</td>
<td style="text-align:left;">
cambridge coc
</td>
<td style="text-align:right;">
0.0091243
</td>
<td style="text-align:right;">
92
</td>
<td style="text-align:right;">
0.5027464
</td>
<td style="text-align:right;">
0.5118707
</td>
<td style="text-align:right;">
109598
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-500
</td>
<td style="text-align:left;">
san antonio/bexar county coc
</td>
<td style="text-align:right;">
0.0090632
</td>
<td style="text-align:right;">
93
</td>
<td style="text-align:right;">
0.1506370
</td>
<td style="text-align:right;">
0.1597002
</td>
<td style="text-align:right;">
1919847
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-500
</td>
<td style="text-align:left;">
cincinnati/hamilton county coc
</td>
<td style="text-align:right;">
0.0087484
</td>
<td style="text-align:right;">
94
</td>
<td style="text-align:right;">
0.1285157
</td>
<td style="text-align:right;">
0.1372641
</td>
<td style="text-align:right;">
811574
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-510
</td>
<td style="text-align:left;">
murfreesboro/rutherford county coc
</td>
<td style="text-align:right;">
0.0083887
</td>
<td style="text-align:right;">
95
</td>
<td style="text-align:right;">
0.0865714
</td>
<td style="text-align:right;">
0.0949601
</td>
<td style="text-align:right;">
298020
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-607
</td>
<td style="text-align:left;">
pasadena coc
</td>
<td style="text-align:right;">
0.0079782
</td>
<td style="text-align:right;">
96
</td>
<td style="text-align:right;">
0.4830427
</td>
<td style="text-align:right;">
0.4910209
</td>
<td style="text-align:right;">
137876
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-500
</td>
<td style="text-align:left;">
wheeling, weirton area coc
</td>
<td style="text-align:right;">
0.0076413
</td>
<td style="text-align:right;">
97
</td>
<td style="text-align:right;">
0.0673826
</td>
<td style="text-align:right;">
0.0750240
</td>
<td style="text-align:right;">
143954
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-506
</td>
<td style="text-align:left;">
worcester city & county coc
</td>
<td style="text-align:right;">
0.0068607
</td>
<td style="text-align:right;">
98
</td>
<td style="text-align:right;">
0.2200325
</td>
<td style="text-align:right;">
0.2268932
</td>
<td style="text-align:right;">
816243
</td>
</tr>
<tr>
<td style="text-align:left;">
md-510
</td>
<td style="text-align:left;">
garrett county coc
</td>
<td style="text-align:right;">
0.0067703
</td>
<td style="text-align:right;">
99
</td>
<td style="text-align:right;">
0.0440066
</td>
<td style="text-align:right;">
0.0507769
</td>
<td style="text-align:right;">
29541
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-518
</td>
<td style="text-align:left;">
utica, rome/oneida, madison counties coc
</td>
<td style="text-align:right;">
0.0061908
</td>
<td style="text-align:right;">
100
</td>
<td style="text-align:right;">
0.0518072
</td>
<td style="text-align:right;">
0.0579980
</td>
<td style="text-align:right;">
306907
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-506
</td>
<td style="text-align:left;">
jersey city, bayonne/hudson county coc
</td>
<td style="text-align:right;">
0.0057826
</td>
<td style="text-align:right;">
101
</td>
<td style="text-align:right;">
0.1217319
</td>
<td style="text-align:right;">
0.1275145
</td>
<td style="text-align:right;">
674433
</td>
</tr>
<tr>
<td style="text-align:left;">
nh-500
</td>
<td style="text-align:left;">
new hampshire balance of state coc
</td>
<td style="text-align:right;">
0.0057305
</td>
<td style="text-align:right;">
102
</td>
<td style="text-align:right;">
0.0744961
</td>
<td style="text-align:right;">
0.0802265
</td>
<td style="text-align:right;">
924881
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-512
</td>
<td style="text-align:left;">
york city & county coc
</td>
<td style="text-align:right;">
0.0049825
</td>
<td style="text-align:right;">
103
</td>
<td style="text-align:right;">
0.0683957
</td>
<td style="text-align:right;">
0.0733782
</td>
<td style="text-align:right;">
441548
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-500
</td>
<td style="text-align:left;">
st. louis county coc
</td>
<td style="text-align:right;">
0.0048010
</td>
<td style="text-align:right;">
104
</td>
<td style="text-align:right;">
0.0402083
</td>
<td style="text-align:right;">
0.0450093
</td>
<td style="text-align:right;">
999793
</td>
</tr>
<tr>
<td style="text-align:left;">
il-500
</td>
<td style="text-align:left;">
mchenry county coc
</td>
<td style="text-align:right;">
0.0043238
</td>
<td style="text-align:right;">
105
</td>
<td style="text-align:right;">
0.0552119
</td>
<td style="text-align:right;">
0.0595357
</td>
<td style="text-align:right;">
300660
</td>
</tr>
<tr>
<td style="text-align:left;">
il-517
</td>
<td style="text-align:left;">
aurora, elgin/kane county coc
</td>
<td style="text-align:right;">
0.0042396
</td>
<td style="text-align:right;">
106
</td>
<td style="text-align:right;">
0.0686807
</td>
<td style="text-align:right;">
0.0729203
</td>
<td style="text-align:right;">
589685
</td>
</tr>
<tr>
<td style="text-align:left;">
il-506
</td>
<td style="text-align:left;">
joliet, bolingbrook/will county coc
</td>
<td style="text-align:right;">
0.0039834
</td>
<td style="text-align:right;">
107
</td>
<td style="text-align:right;">
0.0384651
</td>
<td style="text-align:right;">
0.0424486
</td>
<td style="text-align:right;">
803325
</td>
</tr>
<tr>
<td style="text-align:left;">
il-509
</td>
<td style="text-align:left;">
dekalb city & county coc
</td>
<td style="text-align:right;">
0.0038252
</td>
<td style="text-align:right;">
108
</td>
<td style="text-align:right;">
0.0918037
</td>
<td style="text-align:right;">
0.0956288
</td>
<td style="text-align:right;">
104571
</td>
</tr>
<tr>
<td style="text-align:left;">
ut-504
</td>
<td style="text-align:left;">
provo/mountainland coc
</td>
<td style="text-align:right;">
0.0037524
</td>
<td style="text-align:right;">
109
</td>
<td style="text-align:right;">
0.0232964
</td>
<td style="text-align:right;">
0.0270488
</td>
<td style="text-align:right;">
639584
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-603
</td>
<td style="text-align:left;">
st. joseph/andrew, buchanan, dekalb counties coc
</td>
<td style="text-align:right;">
0.0033539
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
0.1676938
</td>
<td style="text-align:right;">
0.1710477
</td>
<td style="text-align:right;">
119265
</td>
</tr>
<tr>
<td style="text-align:left;">
va-521
</td>
<td style="text-align:left;">
virginia balance of state coc
</td>
<td style="text-align:right;">
0.0033032
</td>
<td style="text-align:right;">
111
</td>
<td style="text-align:right;">
0.0390484
</td>
<td style="text-align:right;">
0.0423516
</td>
<td style="text-align:right;">
1695332
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-500
</td>
<td style="text-align:left;">
philadelphia coc
</td>
<td style="text-align:right;">
0.0031953
</td>
<td style="text-align:right;">
112
</td>
<td style="text-align:right;">
0.3666913
</td>
<td style="text-align:right;">
0.3698866
</td>
<td style="text-align:right;">
1564804
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-506
</td>
<td style="text-align:left;">
wilmington/brunswick, new hanover, pender counties coc
</td>
<td style="text-align:right;">
0.0030020
</td>
<td style="text-align:right;">
113
</td>
<td style="text-align:right;">
0.0803048
</td>
<td style="text-align:right;">
0.0833069
</td>
<td style="text-align:right;">
399727
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-521
</td>
<td style="text-align:left;">
davis, woodland/yolo county coc
</td>
<td style="text-align:right;">
0.0028299
</td>
<td style="text-align:right;">
114
</td>
<td style="text-align:right;">
0.2084689
</td>
<td style="text-align:right;">
0.2112988
</td>
<td style="text-align:right;">
212022
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-701
</td>
<td style="text-align:left;">
bryan, college station/brazos valley coc
</td>
<td style="text-align:right;">
0.0027174
</td>
<td style="text-align:right;">
115
</td>
<td style="text-align:right;">
0.0567636
</td>
<td style="text-align:right;">
0.0594810
</td>
<td style="text-align:right;">
331198
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-503
</td>
<td style="text-align:left;">
lakeland, winterhaven/polk county coc
</td>
<td style="text-align:right;">
0.0024664
</td>
<td style="text-align:right;">
116
</td>
<td style="text-align:right;">
0.0826260
</td>
<td style="text-align:right;">
0.0850925
</td>
<td style="text-align:right;">
648706
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-601
</td>
<td style="text-align:left;">
san diego city and county coc
</td>
<td style="text-align:right;">
0.0021318
</td>
<td style="text-align:right;">
117
</td>
<td style="text-align:right;">
0.2590437
</td>
<td style="text-align:right;">
0.2611755
</td>
<td style="text-align:right;">
3283616
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-502
</td>
<td style="text-align:left;">
rochester/southeast minnesota coc
</td>
<td style="text-align:right;">
0.0020892
</td>
<td style="text-align:right;">
118
</td>
<td style="text-align:right;">
0.0671326
</td>
<td style="text-align:right;">
0.0692218
</td>
<td style="text-align:right;">
717982
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-505
</td>
<td style="text-align:left;">
northeast oklahoma coc
</td>
<td style="text-align:right;">
0.0020372
</td>
<td style="text-align:right;">
119
</td>
<td style="text-align:right;">
0.0866951
</td>
<td style="text-align:right;">
0.0887323
</td>
<td style="text-align:right;">
441778
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-509
</td>
<td style="text-align:left;">
morris county coc
</td>
<td style="text-align:right;">
0.0018064
</td>
<td style="text-align:right;">
120
</td>
<td style="text-align:right;">
0.0780751
</td>
<td style="text-align:right;">
0.0798815
</td>
<td style="text-align:right;">
498238
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-500
</td>
<td style="text-align:left;">
little rock/central arkansas coc
</td>
<td style="text-align:right;">
0.0011852
</td>
<td style="text-align:right;">
121
</td>
<td style="text-align:right;">
0.1818480
</td>
<td style="text-align:right;">
0.1830333
</td>
<td style="text-align:right;">
590603
</td>
</tr>
<tr>
<td style="text-align:left;">
il-513
</td>
<td style="text-align:left;">
springfield/sangamon county coc
</td>
<td style="text-align:right;">
0.0010088
</td>
<td style="text-align:right;">
122
</td>
<td style="text-align:right;">
0.1356791
</td>
<td style="text-align:right;">
0.1366878
</td>
<td style="text-align:right;">
198262
</td>
</tr>
<tr>
<td style="text-align:left;">
al-507
</td>
<td style="text-align:left;">
alabama balance of state coc
</td>
<td style="text-align:right;">
0.0009195
</td>
<td style="text-align:right;">
123
</td>
<td style="text-align:right;">
0.0470275
</td>
<td style="text-align:right;">
0.0479470
</td>
<td style="text-align:right;">
1522513
</td>
</tr>
<tr>
<td style="text-align:left;">
id-500
</td>
<td style="text-align:left;">
boise/ada county coc
</td>
<td style="text-align:right;">
0.0006911
</td>
<td style="text-align:right;">
124
</td>
<td style="text-align:right;">
0.1734643
</td>
<td style="text-align:right;">
0.1741554
</td>
<td style="text-align:right;">
434095
</td>
</tr>
<tr>
<td style="text-align:left;">
nh-502
</td>
<td style="text-align:left;">
nashua/hillsborough county coc
</td>
<td style="text-align:right;">
0.0003383
</td>
<td style="text-align:right;">
125
</td>
<td style="text-align:right;">
0.0947223
</td>
<td style="text-align:right;">
0.0950606
</td>
<td style="text-align:right;">
295601
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-505
</td>
<td style="text-align:left;">
overland park, shawnee/johnson county coc
</td>
<td style="text-align:right;">
0.0001730
</td>
<td style="text-align:right;">
126
</td>
<td style="text-align:right;">
0.0288906
</td>
<td style="text-align:right;">
0.0290636
</td>
<td style="text-align:right;">
578042
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-504
</td>
<td style="text-align:left;">
cattaragus county coc
</td>
<td style="text-align:right;">
0.0000000
</td>
<td style="text-align:right;">
127
</td>
<td style="text-align:right;">
0.0422806
</td>
<td style="text-align:right;">
0.0422806
</td>
<td style="text-align:right;">
78050
</td>
</tr>
<tr>
<td style="text-align:left;">
ne-500
</td>
<td style="text-align:left;">
nebraska balance of state coc
</td>
<td style="text-align:right;">
-0.0001118
</td>
<td style="text-align:right;">
128
</td>
<td style="text-align:right;">
0.0625968
</td>
<td style="text-align:right;">
0.0624850
</td>
<td style="text-align:right;">
894615
</td>
</tr>
<tr>
<td style="text-align:left;">
va-514
</td>
<td style="text-align:left;">
fredericksburg/spotsylvania, stafford counties coc
</td>
<td style="text-align:right;">
-0.0002805
</td>
<td style="text-align:right;">
129
</td>
<td style="text-align:right;">
0.0563892
</td>
<td style="text-align:right;">
0.0561087
</td>
<td style="text-align:right;">
356451
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-500
</td>
<td style="text-align:left;">
rochester, irondequoit, greece/monroe county coc
</td>
<td style="text-align:right;">
-0.0004005
</td>
<td style="text-align:right;">
130
</td>
<td style="text-align:right;">
0.1118652
</td>
<td style="text-align:right;">
0.1114647
</td>
<td style="text-align:right;">
749116
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-500
</td>
<td style="text-align:left;">
chattanooga/southeast tennessee coc
</td>
<td style="text-align:right;">
-0.0005842
</td>
<td style="text-align:right;">
131
</td>
<td style="text-align:right;">
0.0915716
</td>
<td style="text-align:right;">
0.0909874
</td>
<td style="text-align:right;">
684710
</td>
</tr>
<tr>
<td style="text-align:left;">
md-504
</td>
<td style="text-align:left;">
howard county coc
</td>
<td style="text-align:right;">
-0.0006394
</td>
<td style="text-align:right;">
132
</td>
<td style="text-align:right;">
0.0543515
</td>
<td style="text-align:right;">
0.0537120
</td>
<td style="text-align:right;">
312779
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-509
</td>
<td style="text-align:left;">
eastern pennsylvania coc
</td>
<td style="text-align:right;">
-0.0007408
</td>
<td style="text-align:right;">
133
</td>
<td style="text-align:right;">
0.0650899
</td>
<td style="text-align:right;">
0.0643491
</td>
<td style="text-align:right;">
3104937
</td>
</tr>
<tr>
<td style="text-align:left;">
il-507
</td>
<td style="text-align:left;">
peoria, pekin/fulton, tazewell, peoria, woodford counties coc
</td>
<td style="text-align:right;">
-0.0012609
</td>
<td style="text-align:right;">
134
</td>
<td style="text-align:right;">
0.1021340
</td>
<td style="text-align:right;">
0.1008731
</td>
<td style="text-align:right;">
396538
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-601
</td>
<td style="text-align:left;">
poughkeepsie/dutchess county coc
</td>
<td style="text-align:right;">
-0.0013565
</td>
<td style="text-align:right;">
135
</td>
<td style="text-align:right;">
0.1366648
</td>
<td style="text-align:right;">
0.1353084
</td>
<td style="text-align:right;">
294882
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-523
</td>
<td style="text-align:left;">
glens falls, saratoga springs/saratoga, washington, warren, hamilton
counties co
</td>
<td style="text-align:right;">
-0.0013982
</td>
<td style="text-align:right;">
136
</td>
<td style="text-align:right;">
0.0732683
</td>
<td style="text-align:right;">
0.0718700
</td>
<td style="text-align:right;">
357590
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-503
</td>
<td style="text-align:left;">
central tennessee coc
</td>
<td style="text-align:right;">
-0.0015776
</td>
<td style="text-align:right;">
137
</td>
<td style="text-align:right;">
0.0250666
</td>
<td style="text-align:right;">
0.0234890
</td>
<td style="text-align:right;">
1140959
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-501
</td>
<td style="text-align:left;">
bergen county coc
</td>
<td style="text-align:right;">
-0.0018196
</td>
<td style="text-align:right;">
138
</td>
<td style="text-align:right;">
0.0397093
</td>
<td style="text-align:right;">
0.0378897
</td>
<td style="text-align:right;">
934290
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-509
</td>
<td style="text-align:left;">
duluth/st.louis county coc
</td>
<td style="text-align:right;">
-0.0019980
</td>
<td style="text-align:right;">
139
</td>
<td style="text-align:right;">
0.2142857
</td>
<td style="text-align:right;">
0.2122877
</td>
<td style="text-align:right;">
200200
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-504
</td>
<td style="text-align:left;">
pontiac, royal oak/oakland county coc
</td>
<td style="text-align:right;">
-0.0024175
</td>
<td style="text-align:right;">
140
</td>
<td style="text-align:right;">
0.0368273
</td>
<td style="text-align:right;">
0.0344098
</td>
<td style="text-align:right;">
1240927
</td>
</tr>
<tr>
<td style="text-align:left;">
or-506
</td>
<td style="text-align:left;">
hillsboro, beaverton/washington county coc
</td>
<td style="text-align:right;">
-0.0026225
</td>
<td style="text-align:right;">
141
</td>
<td style="text-align:right;">
0.0938867
</td>
<td style="text-align:right;">
0.0912642
</td>
<td style="text-align:right;">
571966
</td>
</tr>
<tr>
<td style="text-align:left;">
il-518
</td>
<td style="text-align:left;">
rock island, moline/northwestern illinois coc
</td>
<td style="text-align:right;">
-0.0030473
</td>
<td style="text-align:right;">
142
</td>
<td style="text-align:right;">
0.0332157
</td>
<td style="text-align:right;">
0.0301684
</td>
<td style="text-align:right;">
656316
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-505
</td>
<td style="text-align:left;">
st. cloud/central minnesota coc
</td>
<td style="text-align:right;">
-0.0031497
</td>
<td style="text-align:right;">
143
</td>
<td style="text-align:right;">
0.0831255
</td>
<td style="text-align:right;">
0.0799758
</td>
<td style="text-align:right;">
730221
</td>
</tr>
<tr>
<td style="text-align:left;">
md-503
</td>
<td style="text-align:left;">
annapolis/anne arundel county coc
</td>
<td style="text-align:right;">
-0.0031904
</td>
<td style="text-align:right;">
144
</td>
<td style="text-align:right;">
0.0680617
</td>
<td style="text-align:right;">
0.0648713
</td>
<td style="text-align:right;">
564194
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-508
</td>
<td style="text-align:left;">
lansing, east lansing/ingham county coc
</td>
<td style="text-align:right;">
-0.0034790
</td>
<td style="text-align:right;">
145
</td>
<td style="text-align:right;">
0.1492496
</td>
<td style="text-align:right;">
0.1457706
</td>
<td style="text-align:right;">
287438
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-523
</td>
<td style="text-align:left;">
eaton county coc
</td>
<td style="text-align:right;">
-0.0036783
</td>
<td style="text-align:right;">
146
</td>
<td style="text-align:right;">
0.1158653
</td>
<td style="text-align:right;">
0.1121870
</td>
<td style="text-align:right;">
108747
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-519
</td>
<td style="text-align:left;">
attleboro, taunton/bristol county coc
</td>
<td style="text-align:right;">
-0.0037551
</td>
<td style="text-align:right;">
147
</td>
<td style="text-align:right;">
0.0595447
</td>
<td style="text-align:right;">
0.0557897
</td>
<td style="text-align:right;">
372829
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-503
</td>
<td style="text-align:left;">
north carolina balance of state coc
</td>
<td style="text-align:right;">
-0.0040194
</td>
<td style="text-align:right;">
148
</td>
<td style="text-align:right;">
0.0629506
</td>
<td style="text-align:right;">
0.0589312
</td>
<td style="text-align:right;">
5075411
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-503
</td>
<td style="text-align:left;">
topeka/shawnee county coc
</td>
<td style="text-align:right;">
-0.0044858
</td>
<td style="text-align:right;">
149
</td>
<td style="text-align:right;">
0.2332597
</td>
<td style="text-align:right;">
0.2287739
</td>
<td style="text-align:right;">
178342
</td>
</tr>
<tr>
<td style="text-align:left;">
ky-500
</td>
<td style="text-align:left;">
kentucky balance of state coc
</td>
<td style="text-align:right;">
-0.0045397
</td>
<td style="text-align:right;">
150
</td>
<td style="text-align:right;">
0.0665724
</td>
<td style="text-align:right;">
0.0620327
</td>
<td style="text-align:right;">
3348234
</td>
</tr>
<tr>
<td style="text-align:left;">
ct-505
</td>
<td style="text-align:left;">
connecticut balance of state coc
</td>
<td style="text-align:right;">
-0.0048342
</td>
<td style="text-align:right;">
151
</td>
<td style="text-align:right;">
0.1233093
</td>
<td style="text-align:right;">
0.1184750
</td>
<td style="text-align:right;">
2730533
</td>
</tr>
<tr>
<td style="text-align:left;">
md-601
</td>
<td style="text-align:left;">
montgomery county coc
</td>
<td style="text-align:right;">
-0.0049281
</td>
<td style="text-align:right;">
152
</td>
<td style="text-align:right;">
0.0860967
</td>
<td style="text-align:right;">
0.0811686
</td>
<td style="text-align:right;">
1034883
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-500
</td>
<td style="text-align:left;">
north central oklahoma coc
</td>
<td style="text-align:right;">
-0.0063542
</td>
<td style="text-align:right;">
153
</td>
<td style="text-align:right;">
0.0638602
</td>
<td style="text-align:right;">
0.0575060
</td>
<td style="text-align:right;">
314750
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-500
</td>
<td style="text-align:left;">
charleston/low country coc
</td>
<td style="text-align:right;">
-0.0064406
</td>
<td style="text-align:right;">
154
</td>
<td style="text-align:right;">
0.0511282
</td>
<td style="text-align:right;">
0.0446876
</td>
<td style="text-align:right;">
1009228
</td>
</tr>
<tr>
<td style="text-align:left;">
il-515
</td>
<td style="text-align:left;">
south central illinois coc
</td>
<td style="text-align:right;">
-0.0064748
</td>
<td style="text-align:right;">
155
</td>
<td style="text-align:right;">
0.0293858
</td>
<td style="text-align:right;">
0.0229109
</td>
<td style="text-align:right;">
401555
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-606
</td>
<td style="text-align:left;">
missouri balance of state coc
</td>
<td style="text-align:right;">
-0.0066833
</td>
<td style="text-align:right;">
156
</td>
<td style="text-align:right;">
0.0558041
</td>
<td style="text-align:right;">
0.0491207
</td>
<td style="text-align:right;">
2738152
</td>
</tr>
<tr>
<td style="text-align:left;">
il-520
</td>
<td style="text-align:left;">
southern illinois coc
</td>
<td style="text-align:right;">
-0.0074535
</td>
<td style="text-align:right;">
157
</td>
<td style="text-align:right;">
0.0563346
</td>
<td style="text-align:right;">
0.0488811
</td>
<td style="text-align:right;">
576910
</td>
</tr>
<tr>
<td style="text-align:left;">
al-501
</td>
<td style="text-align:left;">
mobile city & county/baldwin county coc
</td>
<td style="text-align:right;">
-0.0076023
</td>
<td style="text-align:right;">
158
</td>
<td style="text-align:right;">
0.0967278
</td>
<td style="text-align:right;">
0.0891254
</td>
<td style="text-align:right;">
618230
</td>
</tr>
<tr>
<td style="text-align:left;">
id-501
</td>
<td style="text-align:left;">
idaho balance of state coc
</td>
<td style="text-align:right;">
-0.0077848
</td>
<td style="text-align:right;">
159
</td>
<td style="text-align:right;">
0.1107083
</td>
<td style="text-align:right;">
0.1029235
</td>
<td style="text-align:right;">
1220324
</td>
</tr>
<tr>
<td style="text-align:left;">
il-503
</td>
<td style="text-align:left;">
champaign, urbana, rantoul/champaign county coc
</td>
<td style="text-align:right;">
-0.0082096
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
0.0989984
</td>
<td style="text-align:right;">
0.0907888
</td>
<td style="text-align:right;">
207074
</td>
</tr>
<tr>
<td style="text-align:left;">
ri-500
</td>
<td style="text-align:left;">
rhode island statewide coc
</td>
<td style="text-align:right;">
-0.0084335
</td>
<td style="text-align:right;">
161
</td>
<td style="text-align:right;">
0.1127619
</td>
<td style="text-align:right;">
0.1043284
</td>
<td style="text-align:right;">
1055321
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-503
</td>
<td style="text-align:left;">
st. clair shores, warren/macomb county coc
</td>
<td style="text-align:right;">
-0.0084421
</td>
<td style="text-align:right;">
162
</td>
<td style="text-align:right;">
0.0396662
</td>
<td style="text-align:right;">
0.0312241
</td>
<td style="text-align:right;">
864717
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-503
</td>
<td style="text-align:left;">
wilkes-barre, hazleton/luzerne county coc
</td>
<td style="text-align:right;">
-0.0084975
</td>
<td style="text-align:right;">
163
</td>
<td style="text-align:right;">
0.0604270
</td>
<td style="text-align:right;">
0.0519294
</td>
<td style="text-align:right;">
317739
</td>
</tr>
<tr>
<td style="text-align:left;">
va-504
</td>
<td style="text-align:left;">
charlottesville coc
</td>
<td style="text-align:right;">
-0.0085267
</td>
<td style="text-align:right;">
164
</td>
<td style="text-align:right;">
0.0828305
</td>
<td style="text-align:right;">
0.0743039
</td>
<td style="text-align:right;">
246286
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-503
</td>
<td style="text-align:left;">
dakota, anoka, washington, scott, carver counties
</td>
<td style="text-align:right;">
-0.0086998
</td>
<td style="text-align:right;">
165
</td>
<td style="text-align:right;">
0.0581304
</td>
<td style="text-align:right;">
0.0494306
</td>
<td style="text-align:right;">
1264398
</td>
</tr>
<tr>
<td style="text-align:left;">
in-502
</td>
<td style="text-align:left;">
indiana balance of state coc
</td>
<td style="text-align:right;">
-0.0089025
</td>
<td style="text-align:right;">
166
</td>
<td style="text-align:right;">
0.0719428
</td>
<td style="text-align:right;">
0.0630403
</td>
<td style="text-align:right;">
5672562
</td>
</tr>
<tr>
<td style="text-align:left;">
ia-501
</td>
<td style="text-align:left;">
iowa balance of state coc
</td>
<td style="text-align:right;">
-0.0089262
</td>
<td style="text-align:right;">
167
</td>
<td style="text-align:right;">
0.0793940
</td>
<td style="text-align:right;">
0.0704678
</td>
<td style="text-align:right;">
2442251
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-503
</td>
<td style="text-align:left;">
oklahoma balance of state coc
</td>
<td style="text-align:right;">
-0.0092609
</td>
<td style="text-align:right;">
168
</td>
<td style="text-align:right;">
0.0440640
</td>
<td style="text-align:right;">
0.0348031
</td>
<td style="text-align:right;">
669481
</td>
</tr>
<tr>
<td style="text-align:left;">
la-505
</td>
<td style="text-align:left;">
monroe/northeast louisiana coc
</td>
<td style="text-align:right;">
-0.0092848
</td>
<td style="text-align:right;">
169
</td>
<td style="text-align:right;">
0.0618989
</td>
<td style="text-align:right;">
0.0526141
</td>
<td style="text-align:right;">
355418
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-609
</td>
<td style="text-align:left;">
san bernardino city & county coc
</td>
<td style="text-align:right;">
-0.0092980
</td>
<td style="text-align:right;">
170
</td>
<td style="text-align:right;">
0.1092631
</td>
<td style="text-align:right;">
0.0999651
</td>
<td style="text-align:right;">
2118739
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-503
</td>
<td style="text-align:left;">
cape cod islands coc
</td>
<td style="text-align:right;">
-0.0094768
</td>
<td style="text-align:right;">
171
</td>
<td style="text-align:right;">
0.1569852
</td>
<td style="text-align:right;">
0.1475084
</td>
<td style="text-align:right;">
242698
</td>
</tr>
<tr>
<td style="text-align:left;">
md-501
</td>
<td style="text-align:left;">
baltimore coc
</td>
<td style="text-align:right;">
-0.0095231
</td>
<td style="text-align:right;">
172
</td>
<td style="text-align:right;">
0.4143357
</td>
<td style="text-align:right;">
0.4048126
</td>
<td style="text-align:right;">
619546
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-507
</td>
<td style="text-align:left;">
orlando/orange, osceola, seminole counties coc
</td>
<td style="text-align:right;">
-0.0097830
</td>
<td style="text-align:right;">
173
</td>
<td style="text-align:right;">
0.1097056
</td>
<td style="text-align:right;">
0.0999227
</td>
<td style="text-align:right;">
2054589
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-506
</td>
<td style="text-align:left;">
reading/berks county coc
</td>
<td style="text-align:right;">
-0.0101393
</td>
<td style="text-align:right;">
174
</td>
<td style="text-align:right;">
0.1458131
</td>
<td style="text-align:right;">
0.1356737
</td>
<td style="text-align:right;">
414229
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-508
</td>
<td style="text-align:left;">
buffalo, niagara falls/erie, niagara, orleans, genesee, wyoming counties
coc
</td>
<td style="text-align:right;">
-0.0102958
</td>
<td style="text-align:right;">
175
</td>
<td style="text-align:right;">
0.0855101
</td>
<td style="text-align:right;">
0.0752143
</td>
<td style="text-align:right;">
1272364
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-500
</td>
<td style="text-align:left;">
wisconsin balance of state coc
</td>
<td style="text-align:right;">
-0.0103065
</td>
<td style="text-align:right;">
176
</td>
<td style="text-align:right;">
0.0871653
</td>
<td style="text-align:right;">
0.0768589
</td>
<td style="text-align:right;">
4094517
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-507
</td>
<td style="text-align:left;">
ohio balance of state coc
</td>
<td style="text-align:right;">
-0.0109850
</td>
<td style="text-align:right;">
177
</td>
<td style="text-align:right;">
0.0621235
</td>
<td style="text-align:right;">
0.0511384
</td>
<td style="text-align:right;">
6126510
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-506
</td>
<td style="text-align:left;">
grand rapids, wyoming/kent county coc
</td>
<td style="text-align:right;">
-0.0110043
</td>
<td style="text-align:right;">
178
</td>
<td style="text-align:right;">
0.1246632
</td>
<td style="text-align:right;">
0.1136589
</td>
<td style="text-align:right;">
636114
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-501
</td>
<td style="text-align:left;">
tampa/hillsborough county coc
</td>
<td style="text-align:right;">
-0.0110926
</td>
<td style="text-align:right;">
179
</td>
<td style="text-align:right;">
0.1447253
</td>
<td style="text-align:right;">
0.1336327
</td>
<td style="text-align:right;">
1343234
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-502
</td>
<td style="text-align:left;">
wichita/sedgwick county coc
</td>
<td style="text-align:right;">
-0.0113745
</td>
<td style="text-align:right;">
180
</td>
<td style="text-align:right;">
0.1237466
</td>
<td style="text-align:right;">
0.1123721
</td>
<td style="text-align:right;">
509913
</td>
</tr>
<tr>
<td style="text-align:left;">
va-602
</td>
<td style="text-align:left;">
loudoun county coc
</td>
<td style="text-align:right;">
-0.0115053
</td>
<td style="text-align:right;">
181
</td>
<td style="text-align:right;">
0.0473590
</td>
<td style="text-align:right;">
0.0358537
</td>
<td style="text-align:right;">
373741
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-506
</td>
<td style="text-align:left;">
southwest oklahoma regional coc
</td>
<td style="text-align:right;">
-0.0117678
</td>
<td style="text-align:right;">
182
</td>
<td style="text-align:right;">
0.0585937
</td>
<td style="text-align:right;">
0.0468259
</td>
<td style="text-align:right;">
407894
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-504
</td>
<td style="text-align:left;">
everett/snohomish county coc
</td>
<td style="text-align:right;">
-0.0118083
</td>
<td style="text-align:right;">
183
</td>
<td style="text-align:right;">
0.1231436
</td>
<td style="text-align:right;">
0.1113353
</td>
<td style="text-align:right;">
770645
</td>
</tr>
<tr>
<td style="text-align:left;">
la-506
</td>
<td style="text-align:left;">
slidell/southeast louisiana coc
</td>
<td style="text-align:right;">
-0.0118671
</td>
<td style="text-align:right;">
184
</td>
<td style="text-align:right;">
0.0457234
</td>
<td style="text-align:right;">
0.0338562
</td>
<td style="text-align:right;">
573011
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-604
</td>
<td style="text-align:left;">
bakersfield/kern county coc
</td>
<td style="text-align:right;">
-0.0122015
</td>
<td style="text-align:right;">
185
</td>
<td style="text-align:right;">
0.1131209
</td>
<td style="text-align:right;">
0.1009193
</td>
<td style="text-align:right;">
876938
</td>
</tr>
<tr>
<td style="text-align:left;">
il-511
</td>
<td style="text-align:left;">
cook county coc
</td>
<td style="text-align:right;">
-0.0123896
</td>
<td style="text-align:right;">
186
</td>
<td style="text-align:right;">
0.0473932
</td>
<td style="text-align:right;">
0.0350036
</td>
<td style="text-align:right;">
2494027
</td>
</tr>
<tr>
<td style="text-align:left;">
az-500
</td>
<td style="text-align:left;">
arizona balance of state coc
</td>
<td style="text-align:right;">
-0.0128413
</td>
<td style="text-align:right;">
187
</td>
<td style="text-align:right;">
0.1459406
</td>
<td style="text-align:right;">
0.1330993
</td>
<td style="text-align:right;">
1643134
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-624
</td>
<td style="text-align:left;">
wichita falls/wise, palo pinto, wichita, archer counties coc
</td>
<td style="text-align:right;">
-0.0130017
</td>
<td style="text-align:right;">
188
</td>
<td style="text-align:right;">
0.0849648
</td>
<td style="text-align:right;">
0.0719631
</td>
<td style="text-align:right;">
330725
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-513
</td>
<td style="text-align:left;">
marquette, alger counties coc
</td>
<td style="text-align:right;">
-0.0130599
</td>
<td style="text-align:right;">
189
</td>
<td style="text-align:right;">
0.1044796
</td>
<td style="text-align:right;">
0.0914196
</td>
<td style="text-align:right;">
76570
</td>
</tr>
<tr>
<td style="text-align:left;">
md-502
</td>
<td style="text-align:left;">
harford county coc
</td>
<td style="text-align:right;">
-0.0131691
</td>
<td style="text-align:right;">
190
</td>
<td style="text-align:right;">
0.0889914
</td>
<td style="text-align:right;">
0.0758223
</td>
<td style="text-align:right;">
250586
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-505
</td>
<td style="text-align:left;">
columbus-muscogee/russell county coc
</td>
<td style="text-align:right;">
-0.0138840
</td>
<td style="text-align:right;">
191
</td>
<td style="text-align:right;">
0.1203281
</td>
<td style="text-align:right;">
0.1064441
</td>
<td style="text-align:right;">
259291
</td>
</tr>
<tr>
<td style="text-align:left;">
va-604
</td>
<td style="text-align:left;">
prince william county coc
</td>
<td style="text-align:right;">
-0.0139881
</td>
<td style="text-align:right;">
192
</td>
<td style="text-align:right;">
0.0876721
</td>
<td style="text-align:right;">
0.0736840
</td>
<td style="text-align:right;">
507573
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-501
</td>
<td style="text-align:left;">
saint paul/ramsey county coc
</td>
<td style="text-align:right;">
-0.0141885
</td>
<td style="text-align:right;">
193
</td>
<td style="text-align:right;">
0.2800362
</td>
<td style="text-align:right;">
0.2658477
</td>
<td style="text-align:right;">
535645
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-611
</td>
<td style="text-align:left;">
oxnard, san buenaventura/ventura county coc
</td>
<td style="text-align:right;">
-0.0141947
</td>
<td style="text-align:right;">
194
</td>
<td style="text-align:right;">
0.1689167
</td>
<td style="text-align:right;">
0.1547220
</td>
<td style="text-align:right;">
845387
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-511
</td>
<td style="text-align:left;">
binghamton, union town/broome, otsego, chenango, delaware, cortland,
tioga count
</td>
<td style="text-align:right;">
-0.0144511
</td>
<td style="text-align:right;">
195
</td>
<td style="text-align:right;">
0.0686984
</td>
<td style="text-align:right;">
0.0542473
</td>
<td style="text-align:right;">
449792
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-501
</td>
<td style="text-align:left;">
fayetteville/northwest arkansas coc
</td>
<td style="text-align:right;">
-0.0146698
</td>
<td style="text-align:right;">
196
</td>
<td style="text-align:right;">
0.1049750
</td>
<td style="text-align:right;">
0.0903052
</td>
<td style="text-align:right;">
524887
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-506
</td>
<td style="text-align:left;">
northwest minnesota coc
</td>
<td style="text-align:right;">
-0.0146740
</td>
<td style="text-align:right;">
197
</td>
<td style="text-align:right;">
0.1755014
</td>
<td style="text-align:right;">
0.1608274
</td>
<td style="text-align:right;">
170369
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-506
</td>
<td style="text-align:left;">
upper cumberland coc
</td>
<td style="text-align:right;">
-0.0147921
</td>
<td style="text-align:right;">
198
</td>
<td style="text-align:right;">
0.0602251
</td>
<td style="text-align:right;">
0.0454329
</td>
<td style="text-align:right;">
567870
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-511
</td>
<td style="text-align:left;">
bristol, bensalem/bucks county coc
</td>
<td style="text-align:right;">
-0.0151792
</td>
<td style="text-align:right;">
199
</td>
<td style="text-align:right;">
0.0786122
</td>
<td style="text-align:right;">
0.0634330
</td>
<td style="text-align:right;">
625857
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-503
</td>
<td style="text-align:left;">
charleston/kanawha, putnam, boone, clay counties coc
</td>
<td style="text-align:right;">
-0.0154901
</td>
<td style="text-align:right;">
200
</td>
<td style="text-align:right;">
0.1296849
</td>
<td style="text-align:right;">
0.1141947
</td>
<td style="text-align:right;">
277596
</td>
</tr>
<tr>
<td style="text-align:left;">
me-500
</td>
<td style="text-align:left;">
maine statewide coc
</td>
<td style="text-align:right;">
-0.0157806
</td>
<td style="text-align:right;">
201
</td>
<td style="text-align:right;">
0.2048475
</td>
<td style="text-align:right;">
0.1890669
</td>
<td style="text-align:right;">
1330746
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-517
</td>
<td style="text-align:left;">
somerville coc
</td>
<td style="text-align:right;">
-0.0159863
</td>
<td style="text-align:right;">
202
</td>
<td style="text-align:right;">
0.1230946
</td>
<td style="text-align:right;">
0.1071083
</td>
<td style="text-align:right;">
125107
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-612
</td>
<td style="text-align:left;">
glendale coc
</td>
<td style="text-align:right;">
-0.0160961
</td>
<td style="text-align:right;">
203
</td>
<td style="text-align:right;">
0.1468769
</td>
<td style="text-align:right;">
0.1307808
</td>
<td style="text-align:right;">
198806
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-604
</td>
<td style="text-align:left;">
waco/mclennan county coc
</td>
<td style="text-align:right;">
-0.0161882
</td>
<td style="text-align:right;">
204
</td>
<td style="text-align:right;">
0.0686604
</td>
<td style="text-align:right;">
0.0524722
</td>
<td style="text-align:right;">
358285
</td>
</tr>
<tr>
<td style="text-align:left;">
la-500
</td>
<td style="text-align:left;">
lafayette/acadiana coc
</td>
<td style="text-align:right;">
-0.0164096
</td>
<td style="text-align:right;">
205
</td>
<td style="text-align:right;">
0.0715642
</td>
<td style="text-align:right;">
0.0551546
</td>
<td style="text-align:right;">
658150
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-500
</td>
<td style="text-align:left;">
san jose/santa clara city & county coc
</td>
<td style="text-align:right;">
-0.0164567
</td>
<td style="text-align:right;">
206
</td>
<td style="text-align:right;">
0.3978521
</td>
<td style="text-align:right;">
0.3813954
</td>
<td style="text-align:right;">
1901963
</td>
</tr>
<tr>
<td style="text-align:left;">
ms-503
</td>
<td style="text-align:left;">
gulf port/gulf coast regional coc
</td>
<td style="text-align:right;">
-0.0164949
</td>
<td style="text-align:right;">
207
</td>
<td style="text-align:right;">
0.0878356
</td>
<td style="text-align:right;">
0.0713406
</td>
<td style="text-align:right;">
484997
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-502
</td>
<td style="text-align:left;">
upper darby, chester, haverford/delaware county coc
</td>
<td style="text-align:right;">
-0.0168754
</td>
<td style="text-align:right;">
208
</td>
<td style="text-align:right;">
0.0904167
</td>
<td style="text-align:right;">
0.0735413
</td>
<td style="text-align:right;">
562949
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-510
</td>
<td style="text-align:left;">
lancaster city & county coc
</td>
<td style="text-align:right;">
-0.0171641
</td>
<td style="text-align:right;">
209
</td>
<td style="text-align:right;">
0.0929098
</td>
<td style="text-align:right;">
0.0757457
</td>
<td style="text-align:right;">
536004
</td>
</tr>
<tr>
<td style="text-align:left;">
va-505
</td>
<td style="text-align:left;">
newport news, hampton/virginia peninsula coc
</td>
<td style="text-align:right;">
-0.0176896
</td>
<td style="text-align:right;">
210
</td>
<td style="text-align:right;">
0.1079889
</td>
<td style="text-align:right;">
0.0902993
</td>
<td style="text-align:right;">
486161
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-504
</td>
<td style="text-align:left;">
lower merion, norristown, abington/montgomery county coc
</td>
<td style="text-align:right;">
-0.0179535
</td>
<td style="text-align:right;">
211
</td>
<td style="text-align:right;">
0.0534941
</td>
<td style="text-align:right;">
0.0355406
</td>
<td style="text-align:right;">
818782
</td>
</tr>
<tr>
<td style="text-align:left;">
nm-501
</td>
<td style="text-align:left;">
new mexico balance of state coc
</td>
<td style="text-align:right;">
-0.0180720
</td>
<td style="text-align:right;">
212
</td>
<td style="text-align:right;">
0.0959554
</td>
<td style="text-align:right;">
0.0778834
</td>
<td style="text-align:right;">
1554889
</td>
</tr>
<tr>
<td style="text-align:left;">
il-502
</td>
<td style="text-align:left;">
waukegan, north chicago/lake county coc
</td>
<td style="text-align:right;">
-0.0181005
</td>
<td style="text-align:right;">
213
</td>
<td style="text-align:right;">
0.0560842
</td>
<td style="text-align:right;">
0.0379837
</td>
<td style="text-align:right;">
729261
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-507
</td>
<td style="text-align:left;">
raleigh/wake county coc
</td>
<td style="text-align:right;">
-0.0183130
</td>
<td style="text-align:right;">
214
</td>
<td style="text-align:right;">
0.1145786
</td>
<td style="text-align:right;">
0.0962656
</td>
<td style="text-align:right;">
1021133
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-506
</td>
<td style="text-align:left;">
marietta/cobb county coc
</td>
<td style="text-align:right;">
-0.0188438
</td>
<td style="text-align:right;">
215
</td>
<td style="text-align:right;">
0.0709015
</td>
<td style="text-align:right;">
0.0520577
</td>
<td style="text-align:right;">
737643
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-505
</td>
<td style="text-align:left;">
chester county coc
</td>
<td style="text-align:right;">
-0.0194455
</td>
<td style="text-align:right;">
216
</td>
<td style="text-align:right;">
0.1320346
</td>
<td style="text-align:right;">
0.1125892
</td>
<td style="text-align:right;">
514259
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-601
</td>
<td style="text-align:left;">
fort worth, arlington/tarrant county coc
</td>
<td style="text-align:right;">
-0.0196097
</td>
<td style="text-align:right;">
217
</td>
<td style="text-align:right;">
0.1159844
</td>
<td style="text-align:right;">
0.0963746
</td>
<td style="text-align:right;">
2090799
</td>
</tr>
<tr>
<td style="text-align:left;">
al-503
</td>
<td style="text-align:left;">
huntsville/north alabama coc
</td>
<td style="text-align:right;">
-0.0198391
</td>
<td style="text-align:right;">
218
</td>
<td style="text-align:right;">
0.0949444
</td>
<td style="text-align:right;">
0.0751053
</td>
<td style="text-align:right;">
564541
</td>
</tr>
<tr>
<td style="text-align:left;">
md-600
</td>
<td style="text-align:left;">
prince george’s county coc
</td>
<td style="text-align:right;">
-0.0200538
</td>
<td style="text-align:right;">
219
</td>
<td style="text-align:right;">
0.0730137
</td>
<td style="text-align:right;">
0.0529599
</td>
<td style="text-align:right;">
902570
</td>
</tr>
<tr>
<td style="text-align:left;">
wy-500
</td>
<td style="text-align:left;">
wyoming statewide coc
</td>
<td style="text-align:right;">
-0.0201235
</td>
<td style="text-align:right;">
220
</td>
<td style="text-align:right;">
0.1290974
</td>
<td style="text-align:right;">
0.1089739
</td>
<td style="text-align:right;">
586379
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-605
</td>
<td style="text-align:left;">
west palm beach/palm beach county coc
</td>
<td style="text-align:right;">
-0.0202297
</td>
<td style="text-align:right;">
221
</td>
<td style="text-align:right;">
0.1124967
</td>
<td style="text-align:right;">
0.0922670
</td>
<td style="text-align:right;">
1418708
</td>
</tr>
<tr>
<td style="text-align:left;">
va-601
</td>
<td style="text-align:left;">
fairfax county coc
</td>
<td style="text-align:right;">
-0.0202592
</td>
<td style="text-align:right;">
222
</td>
<td style="text-align:right;">
0.1042752
</td>
<td style="text-align:right;">
0.0840160
</td>
<td style="text-align:right;">
1174776
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-700
</td>
<td style="text-align:left;">
houston, pasadena, conroe/harris, ft. bend, montgomery, counties coc
</td>
<td style="text-align:right;">
-0.0202669
</td>
<td style="text-align:right;">
223
</td>
<td style="text-align:right;">
0.0923405
</td>
<td style="text-align:right;">
0.0720736
</td>
<td style="text-align:right;">
5748292
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-512
</td>
<td style="text-align:left;">
morristown/blount, sevier, campbell, cocke counties coc
</td>
<td style="text-align:right;">
-0.0203394
</td>
<td style="text-align:right;">
224
</td>
<td style="text-align:right;">
0.1405681
</td>
<td style="text-align:right;">
0.1202287
</td>
<td style="text-align:right;">
663735
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-501
</td>
<td style="text-align:left;">
huntington/cabell, wayne counties coc
</td>
<td style="text-align:right;">
-0.0203789
</td>
<td style="text-align:right;">
225
</td>
<td style="text-align:right;">
0.1586643
</td>
<td style="text-align:right;">
0.1382854
</td>
<td style="text-align:right;">
137397
</td>
</tr>
<tr>
<td style="text-align:left;">
ms-501
</td>
<td style="text-align:left;">
mississippi balance of state coc
</td>
<td style="text-align:right;">
-0.0203805
</td>
<td style="text-align:right;">
226
</td>
<td style="text-align:right;">
0.0493477
</td>
<td style="text-align:right;">
0.0289672
</td>
<td style="text-align:right;">
1933222
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-500
</td>
<td style="text-align:left;">
winston-salem/forsyth county coc
</td>
<td style="text-align:right;">
-0.0203972
</td>
<td style="text-align:right;">
227
</td>
<td style="text-align:right;">
0.1400606
</td>
<td style="text-align:right;">
0.1196634
</td>
<td style="text-align:right;">
367698
</td>
</tr>
<tr>
<td style="text-align:left;">
vt-500
</td>
<td style="text-align:left;">
vermont balance of state coc
</td>
<td style="text-align:right;">
-0.0204484
</td>
<td style="text-align:right;">
228
</td>
<td style="text-align:right;">
0.2210575
</td>
<td style="text-align:right;">
0.2006091
</td>
<td style="text-align:right;">
464585
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-601
</td>
<td style="text-align:left;">
western pennsylvania coc
</td>
<td style="text-align:right;">
-0.0204603
</td>
<td style="text-align:right;">
229
</td>
<td style="text-align:right;">
0.0638151
</td>
<td style="text-align:right;">
0.0433549
</td>
<td style="text-align:right;">
1725296
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-603
</td>
<td style="text-align:left;">
ft myers, cape coral/lee county coc
</td>
<td style="text-align:right;">
-0.0204793
</td>
<td style="text-align:right;">
230
</td>
<td style="text-align:right;">
0.1247377
</td>
<td style="text-align:right;">
0.1042584
</td>
<td style="text-align:right;">
698265
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-505
</td>
<td style="text-align:left;">
dayton, kettering/montgomery county coc
</td>
<td style="text-align:right;">
-0.0207081
</td>
<td style="text-align:right;">
231
</td>
<td style="text-align:right;">
0.1475688
</td>
<td style="text-align:right;">
0.1268607
</td>
<td style="text-align:right;">
536021
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-522
</td>
<td style="text-align:left;">
jefferson, lewis, st. lawrence counties coc
</td>
<td style="text-align:right;">
-0.0207744
</td>
<td style="text-align:right;">
232
</td>
<td style="text-align:right;">
0.0584034
</td>
<td style="text-align:right;">
0.0376291
</td>
<td style="text-align:right;">
255122
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-511
</td>
<td style="text-align:left;">
lenawee county coc
</td>
<td style="text-align:right;">
-0.0213319
</td>
<td style="text-align:right;">
233
</td>
<td style="text-align:right;">
0.1401812
</td>
<td style="text-align:right;">
0.1188493
</td>
<td style="text-align:right;">
98444
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-510
</td>
<td style="text-align:left;">
jacksonville-duval, clay counties coc
</td>
<td style="text-align:right;">
-0.0213769
</td>
<td style="text-align:right;">
234
</td>
<td style="text-align:right;">
0.1717697
</td>
<td style="text-align:right;">
0.1503928
</td>
<td style="text-align:right;">
1192876
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-607
</td>
<td style="text-align:left;">
texas balance of state coc
</td>
<td style="text-align:right;">
-0.0216737
</td>
<td style="text-align:right;">
235
</td>
<td style="text-align:right;">
0.0934932
</td>
<td style="text-align:right;">
0.0718195
</td>
<td style="text-align:right;">
10634996
</td>
</tr>
<tr>
<td style="text-align:left;">
hi-501
</td>
<td style="text-align:left;">
honolulu city and county coc
</td>
<td style="text-align:right;">
-0.0219232
</td>
<td style="text-align:right;">
236
</td>
<td style="text-align:right;">
0.4760461
</td>
<td style="text-align:right;">
0.4541230
</td>
<td style="text-align:right;">
989820
</td>
</tr>
<tr>
<td style="text-align:left;">
in-503
</td>
<td style="text-align:left;">
indianapolis coc
</td>
<td style="text-align:right;">
-0.0221760
</td>
<td style="text-align:right;">
237
</td>
<td style="text-align:right;">
0.2015035
</td>
<td style="text-align:right;">
0.1793274
</td>
<td style="text-align:right;">
937949
</td>
</tr>
<tr>
<td style="text-align:left;">
va-500
</td>
<td style="text-align:left;">
richmond/henrico, chesterfield, hanover counties coc
</td>
<td style="text-align:right;">
-0.0223259
</td>
<td style="text-align:right;">
238
</td>
<td style="text-align:right;">
0.0796950
</td>
<td style="text-align:right;">
0.0573691
</td>
<td style="text-align:right;">
1061547
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-602
</td>
<td style="text-align:left;">
joplin/jasper, newton counties coc
</td>
<td style="text-align:right;">
-0.0226921
</td>
<td style="text-align:right;">
239
</td>
<td style="text-align:right;">
0.1787001
</td>
<td style="text-align:right;">
0.1560080
</td>
<td style="text-align:right;">
176273
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-502
</td>
<td style="text-align:left;">
dearborn, dearborn heights, westland/wayne county coc
</td>
<td style="text-align:right;">
-0.0226977
</td>
<td style="text-align:right;">
240
</td>
<td style="text-align:right;">
0.0422455
</td>
<td style="text-align:right;">
0.0195478
</td>
<td style="text-align:right;">
1079405
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-502
</td>
<td style="text-align:left;">
cleveland/cuyahoga county coc
</td>
<td style="text-align:right;">
-0.0235204
</td>
<td style="text-align:right;">
241
</td>
<td style="text-align:right;">
0.1676725
</td>
<td style="text-align:right;">
0.1441521
</td>
<td style="text-align:right;">
1254231
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-509
</td>
<td style="text-align:left;">
gastonia/cleveland, gaston, lincoln counties coc
</td>
<td style="text-align:right;">
-0.0235454
</td>
<td style="text-align:right;">
242
</td>
<td style="text-align:right;">
0.1082575
</td>
<td style="text-align:right;">
0.0847121
</td>
<td style="text-align:right;">
390735
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-512
</td>
<td style="text-align:left;">
troy/rensselaer county coc
</td>
<td style="text-align:right;">
-0.0237473
</td>
<td style="text-align:right;">
243
</td>
<td style="text-align:right;">
0.1349848
</td>
<td style="text-align:right;">
0.1112375
</td>
<td style="text-align:right;">
160018
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-601
</td>
<td style="text-align:left;">
ft lauderdale/broward county coc
</td>
<td style="text-align:right;">
-0.0237740
</td>
<td style="text-align:right;">
244
</td>
<td style="text-align:right;">
0.1467835
</td>
<td style="text-align:right;">
0.1230095
</td>
<td style="text-align:right;">
1884408
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-600
</td>
<td style="text-align:left;">
miami-dade county coc
</td>
<td style="text-align:right;">
-0.0237936
</td>
<td style="text-align:right;">
245
</td>
<td style="text-align:right;">
0.1545100
</td>
<td style="text-align:right;">
0.1307163
</td>
<td style="text-align:right;">
2689794
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-518
</td>
<td style="text-align:left;">
livingston county coc
</td>
<td style="text-align:right;">
-0.0240525
</td>
<td style="text-align:right;">
246
</td>
<td style="text-align:right;">
0.0721574
</td>
<td style="text-align:right;">
0.0481049
</td>
<td style="text-align:right;">
187091
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-500
</td>
<td style="text-align:left;">
sarasota, bradenton/manatee, sarasota counties coc
</td>
<td style="text-align:right;">
-0.0241175
</td>
<td style="text-align:right;">
247
</td>
<td style="text-align:right;">
0.1795126
</td>
<td style="text-align:right;">
0.1553951
</td>
<td style="text-align:right;">
767077
</td>
</tr>
<tr>
<td style="text-align:left;">
md-513
</td>
<td style="text-align:left;">
wicomico, somerset, worcester counties coc
</td>
<td style="text-align:right;">
-0.0245737
</td>
<td style="text-align:right;">
248
</td>
<td style="text-align:right;">
0.1876539
</td>
<td style="text-align:right;">
0.1630802
</td>
<td style="text-align:right;">
179053
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-507
</td>
<td style="text-align:left;">
new brunswick/middlesex county coc
</td>
<td style="text-align:right;">
-0.0245979
</td>
<td style="text-align:right;">
249
</td>
<td style="text-align:right;">
0.0962318
</td>
<td style="text-align:right;">
0.0716339
</td>
<td style="text-align:right;">
833404
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-503
</td>
<td style="text-align:left;">
myrtle beach, sumter city & county coc
</td>
<td style="text-align:right;">
-0.0248474
</td>
<td style="text-align:right;">
250
</td>
<td style="text-align:right;">
0.1454398
</td>
<td style="text-align:right;">
0.1205925
</td>
<td style="text-align:right;">
905529
</td>
</tr>
<tr>
<td style="text-align:left;">
ia-502
</td>
<td style="text-align:left;">
des moines/polk county coc
</td>
<td style="text-align:right;">
-0.0253167
</td>
<td style="text-align:right;">
251
</td>
<td style="text-align:right;">
0.1838571
</td>
<td style="text-align:right;">
0.1585404
</td>
<td style="text-align:right;">
481896
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-502
</td>
<td style="text-align:left;">
columbia/midlands coc
</td>
<td style="text-align:right;">
-0.0255880
</td>
<td style="text-align:right;">
252
</td>
<td style="text-align:right;">
0.1060933
</td>
<td style="text-align:right;">
0.0805053
</td>
<td style="text-align:right;">
1496796
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-605
</td>
<td style="text-align:left;">
erie city & county coc
</td>
<td style="text-align:right;">
-0.0258613
</td>
<td style="text-align:right;">
253
</td>
<td style="text-align:right;">
0.1465475
</td>
<td style="text-align:right;">
0.1206862
</td>
<td style="text-align:right;">
278408
</td>
</tr>
<tr>
<td style="text-align:left;">
va-507
</td>
<td style="text-align:left;">
portsmouth coc
</td>
<td style="text-align:right;">
-0.0260398
</td>
<td style="text-align:right;">
254
</td>
<td style="text-align:right;">
0.1666545
</td>
<td style="text-align:right;">
0.1406147
</td>
<td style="text-align:right;">
96007
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-502
</td>
<td style="text-align:left;">
knoxville/knox county coc
</td>
<td style="text-align:right;">
-0.0261073
</td>
<td style="text-align:right;">
255
</td>
<td style="text-align:right;">
0.1904952
</td>
<td style="text-align:right;">
0.1643878
</td>
<td style="text-align:right;">
451980
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-507
</td>
<td style="text-align:left;">
kansas balance of state coc
</td>
<td style="text-align:right;">
-0.0263809
</td>
<td style="text-align:right;">
256
</td>
<td style="text-align:right;">
0.0886371
</td>
<td style="text-align:right;">
0.0622562
</td>
<td style="text-align:right;">
1474552
</td>
</tr>
<tr>
<td style="text-align:left;">
va-603
</td>
<td style="text-align:left;">
alexandria coc
</td>
<td style="text-align:right;">
-0.0266873
</td>
<td style="text-align:right;">
257
</td>
<td style="text-align:right;">
0.1737930
</td>
<td style="text-align:right;">
0.1471057
</td>
<td style="text-align:right;">
153631
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-608
</td>
<td style="text-align:left;">
riverside city & county coc
</td>
<td style="text-align:right;">
-0.0267688
</td>
<td style="text-align:right;">
258
</td>
<td style="text-align:right;">
0.1253324
</td>
<td style="text-align:right;">
0.0985636
</td>
<td style="text-align:right;">
2349752
</td>
</tr>
<tr>
<td style="text-align:left;">
ne-501
</td>
<td style="text-align:left;">
omaha, council bluffs coc
</td>
<td style="text-align:right;">
-0.0267804
</td>
<td style="text-align:right;">
259
</td>
<td style="text-align:right;">
0.1993245
</td>
<td style="text-align:right;">
0.1725441
</td>
<td style="text-align:right;">
817762
</td>
</tr>
<tr>
<td style="text-align:left;">
ia-500
</td>
<td style="text-align:left;">
sioux city/dakota, woodbury counties coc
</td>
<td style="text-align:right;">
-0.0268472
</td>
<td style="text-align:right;">
260
</td>
<td style="text-align:right;">
0.2416245
</td>
<td style="text-align:right;">
0.2147773
</td>
<td style="text-align:right;">
122918
</td>
</tr>
<tr>
<td style="text-align:left;">
la-509
</td>
<td style="text-align:left;">
louisiana balance of state coc
</td>
<td style="text-align:right;">
-0.0270685
</td>
<td style="text-align:right;">
261
</td>
<td style="text-align:right;">
0.0787775
</td>
<td style="text-align:right;">
0.0517090
</td>
<td style="text-align:right;">
1111992
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-507
</td>
<td style="text-align:left;">
pittsfield/berkshire, franklin, hampshire counties coc
</td>
<td style="text-align:right;">
-0.0283462
</td>
<td style="text-align:right;">
262
</td>
<td style="text-align:right;">
0.2092614
</td>
<td style="text-align:right;">
0.1809152
</td>
<td style="text-align:right;">
359837
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-503
</td>
<td style="text-align:left;">
athens-clarke county coc
</td>
<td style="text-align:right;">
-0.0284162
</td>
<td style="text-align:right;">
263
</td>
<td style="text-align:right;">
0.2005375
</td>
<td style="text-align:right;">
0.1721212
</td>
<td style="text-align:right;">
123169
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-603
</td>
<td style="text-align:left;">
santa maria/santa barbara county coc
</td>
<td style="text-align:right;">
-0.0284463
</td>
<td style="text-align:right;">
264
</td>
<td style="text-align:right;">
0.4136000
</td>
<td style="text-align:right;">
0.3851537
</td>
<td style="text-align:right;">
442940
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-501
</td>
<td style="text-align:left;">
greenville, anderson, spartanburg/upstate coc
</td>
<td style="text-align:right;">
-0.0304713
</td>
<td style="text-align:right;">
265
</td>
<td style="text-align:right;">
0.1105345
</td>
<td style="text-align:right;">
0.0800632
</td>
<td style="text-align:right;">
1480081
</td>
</tr>
<tr>
<td style="text-align:left;">
nv-502
</td>
<td style="text-align:left;">
nevada balance of state coc
</td>
<td style="text-align:right;">
-0.0305908
</td>
<td style="text-align:right;">
266
</td>
<td style="text-align:right;">
0.1120652
</td>
<td style="text-align:right;">
0.0814744
</td>
<td style="text-align:right;">
330165
</td>
</tr>
<tr>
<td style="text-align:left;">
va-600
</td>
<td style="text-align:left;">
arlington county coc
</td>
<td style="text-align:right;">
-0.0306696
</td>
<td style="text-align:right;">
267
</td>
<td style="text-align:right;">
0.1274979
</td>
<td style="text-align:right;">
0.0968283
</td>
<td style="text-align:right;">
228239
</td>
</tr>
<tr>
<td style="text-align:left;">
il-510
</td>
<td style="text-align:left;">
chicago coc
</td>
<td style="text-align:right;">
-0.0308517
</td>
<td style="text-align:right;">
268
</td>
<td style="text-align:right;">
0.2317382
</td>
<td style="text-align:right;">
0.2008865
</td>
<td style="text-align:right;">
2712975
</td>
</tr>
<tr>
<td style="text-align:left;">
ut-500
</td>
<td style="text-align:left;">
salt lake city & county coc
</td>
<td style="text-align:right;">
-0.0311286
</td>
<td style="text-align:right;">
269
</td>
<td style="text-align:right;">
0.1934293
</td>
<td style="text-align:right;">
0.1623007
</td>
<td style="text-align:right;">
1111517
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-503
</td>
<td style="text-align:left;">
madison/dane county coc
</td>
<td style="text-align:right;">
-0.0311403
</td>
<td style="text-align:right;">
270
</td>
<td style="text-align:right;">
0.1484416
</td>
<td style="text-align:right;">
0.1173014
</td>
<td style="text-align:right;">
523438
</td>
</tr>
<tr>
<td style="text-align:left;">
al-504
</td>
<td style="text-align:left;">
montgomery city & county coc
</td>
<td style="text-align:right;">
-0.0315525
</td>
<td style="text-align:right;">
271
</td>
<td style="text-align:right;">
0.1277745
</td>
<td style="text-align:right;">
0.0962220
</td>
<td style="text-align:right;">
383488
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-513
</td>
<td style="text-align:left;">
somerset county coc
</td>
<td style="text-align:right;">
-0.0315535
</td>
<td style="text-align:right;">
272
</td>
<td style="text-align:right;">
0.0970646
</td>
<td style="text-align:right;">
0.0655111
</td>
<td style="text-align:right;">
332768
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-604
</td>
<td style="text-align:left;">
yonkers, mount vernon/westchester county coc
</td>
<td style="text-align:right;">
-0.0319173
</td>
<td style="text-align:right;">
273
</td>
<td style="text-align:right;">
0.2194187
</td>
<td style="text-align:right;">
0.1875013
</td>
<td style="text-align:right;">
974393
</td>
</tr>
<tr>
<td style="text-align:left;">
il-508
</td>
<td style="text-align:left;">
east st. louis, belleville/st. clair county coc
</td>
<td style="text-align:right;">
-0.0327228
</td>
<td style="text-align:right;">
274
</td>
<td style="text-align:right;">
0.1246406
</td>
<td style="text-align:right;">
0.0919178
</td>
<td style="text-align:right;">
271982
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-504
</td>
<td style="text-align:left;">
youngstown/mahoning county coc
</td>
<td style="text-align:right;">
-0.0328322
</td>
<td style="text-align:right;">
275
</td>
<td style="text-align:right;">
0.1105927
</td>
<td style="text-align:right;">
0.0777605
</td>
<td style="text-align:right;">
231480
</td>
</tr>
<tr>
<td style="text-align:left;">
mt-500
</td>
<td style="text-align:left;">
montana statewide coc
</td>
<td style="text-align:right;">
-0.0329431
</td>
<td style="text-align:right;">
276
</td>
<td style="text-align:right;">
0.1690755
</td>
<td style="text-align:right;">
0.1361325
</td>
<td style="text-align:right;">
1032083
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-505
</td>
<td style="text-align:left;">
charlotte/mecklenberg coc
</td>
<td style="text-align:right;">
-0.0334862
</td>
<td style="text-align:right;">
277
</td>
<td style="text-align:right;">
0.1949171
</td>
<td style="text-align:right;">
0.1614308
</td>
<td style="text-align:right;">
1033260
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-503
</td>
<td style="text-align:left;">
arkansas balance of state coc
</td>
<td style="text-align:right;">
-0.0335027
</td>
<td style="text-align:right;">
278
</td>
<td style="text-align:right;">
0.1228431
</td>
<td style="text-align:right;">
0.0893405
</td>
<td style="text-align:right;">
859633
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-501
</td>
<td style="text-align:left;">
toledo/lucas county coc
</td>
<td style="text-align:right;">
-0.0339226
</td>
<td style="text-align:right;">
279
</td>
<td style="text-align:right;">
0.1866899
</td>
<td style="text-align:right;">
0.1527672
</td>
<td style="text-align:right;">
433339
</td>
</tr>
<tr>
<td style="text-align:left;">
or-500
</td>
<td style="text-align:left;">
eugene, springfield/lane county coc
</td>
<td style="text-align:right;">
-0.0346643
</td>
<td style="text-align:right;">
280
</td>
<td style="text-align:right;">
0.4861260
</td>
<td style="text-align:right;">
0.4514617
</td>
<td style="text-align:right;">
363486
</td>
</tr>
<tr>
<td style="text-align:left;">
il-519
</td>
<td style="text-align:left;">
west central illinois coc
</td>
<td style="text-align:right;">
-0.0348881
</td>
<td style="text-align:right;">
281
</td>
<td style="text-align:right;">
0.0648561
</td>
<td style="text-align:right;">
0.0299680
</td>
<td style="text-align:right;">
223572
</td>
</tr>
<tr>
<td style="text-align:left;">
il-504
</td>
<td style="text-align:left;">
madison county coc
</td>
<td style="text-align:right;">
-0.0353168
</td>
<td style="text-align:right;">
282
</td>
<td style="text-align:right;">
0.0901706
</td>
<td style="text-align:right;">
0.0548538
</td>
<td style="text-align:right;">
266162
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-514
</td>
<td style="text-align:left;">
battle creek/calhoun county coc
</td>
<td style="text-align:right;">
-0.0356633
</td>
<td style="text-align:right;">
283
</td>
<td style="text-align:right;">
0.2110081
</td>
<td style="text-align:right;">
0.1753447
</td>
<td style="text-align:right;">
134592
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-507
</td>
<td style="text-align:left;">
southeastern oklahoma regional coc
</td>
<td style="text-align:right;">
-0.0366223
</td>
<td style="text-align:right;">
284
</td>
<td style="text-align:right;">
0.0817528
</td>
<td style="text-align:right;">
0.0451305
</td>
<td style="text-align:right;">
540654
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-518
</td>
<td style="text-align:left;">
vallejo/solano county coc
</td>
<td style="text-align:right;">
-0.0382984
</td>
<td style="text-align:right;">
285
</td>
<td style="text-align:right;">
0.2987733
</td>
<td style="text-align:right;">
0.2604749
</td>
<td style="text-align:right;">
433439
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-500
</td>
<td style="text-align:left;">
michigan balance of state coc
</td>
<td style="text-align:right;">
-0.0385833
</td>
<td style="text-align:right;">
286
</td>
<td style="text-align:right;">
0.0955254
</td>
<td style="text-align:right;">
0.0569422
</td>
<td style="text-align:right;">
2358534
</td>
</tr>
<tr>
<td style="text-align:left;">
il-514
</td>
<td style="text-align:left;">
dupage county coc
</td>
<td style="text-align:right;">
-0.0391279
</td>
<td style="text-align:right;">
287
</td>
<td style="text-align:right;">
0.0712804
</td>
<td style="text-align:right;">
0.0321525
</td>
<td style="text-align:right;">
917503
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-604
</td>
<td style="text-align:left;">
kansas city, independence, lee’s summit/jackson, wyandotte counties, mo
& ks
</td>
<td style="text-align:right;">
-0.0392103
</td>
<td style="text-align:right;">
288
</td>
<td style="text-align:right;">
0.2176915
</td>
<td style="text-align:right;">
0.1784812
</td>
<td style="text-align:right;">
1007389
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-500
</td>
<td style="text-align:left;">
atlantic city & county coc
</td>
<td style="text-align:right;">
-0.0392407
</td>
<td style="text-align:right;">
289
</td>
<td style="text-align:right;">
0.1995042
</td>
<td style="text-align:right;">
0.1602635
</td>
<td style="text-align:right;">
272676
</td>
</tr>
<tr>
<td style="text-align:left;">
hi-500
</td>
<td style="text-align:left;">
hawaii balance of state coc
</td>
<td style="text-align:right;">
-0.0396632
</td>
<td style="text-align:right;">
290
</td>
<td style="text-align:right;">
0.5116786
</td>
<td style="text-align:right;">
0.4720154
</td>
<td style="text-align:right;">
431130
</td>
</tr>
<tr>
<td style="text-align:left;">
ct-503
</td>
<td style="text-align:left;">
bridgeport, stamford, norwalk/fairfield county coc
</td>
<td style="text-align:right;">
-0.0398161
</td>
<td style="text-align:right;">
291
</td>
<td style="text-align:right;">
0.1260843
</td>
<td style="text-align:right;">
0.0862682
</td>
<td style="text-align:right;">
858949
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-514
</td>
<td style="text-align:left;">
fresno city & county/madera county coc
</td>
<td style="text-align:right;">
-0.0398890
</td>
<td style="text-align:right;">
292
</td>
<td style="text-align:right;">
0.2307865
</td>
<td style="text-align:right;">
0.1908975
</td>
<td style="text-align:right;">
1123116
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-502
</td>
<td style="text-align:left;">
burlington county coc
</td>
<td style="text-align:right;">
-0.0400075
</td>
<td style="text-align:right;">
293
</td>
<td style="text-align:right;">
0.2267090
</td>
<td style="text-align:right;">
0.1867015
</td>
<td style="text-align:right;">
449916
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-508
</td>
<td style="text-align:left;">
monmouth county coc
</td>
<td style="text-align:right;">
-0.0404231
</td>
<td style="text-align:right;">
294
</td>
<td style="text-align:right;">
0.0939479
</td>
<td style="text-align:right;">
0.0535247
</td>
<td style="text-align:right;">
625879
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-520
</td>
<td style="text-align:left;">
franklin, essex counties coc
</td>
<td style="text-align:right;">
-0.0404413
</td>
<td style="text-align:right;">
295
</td>
<td style="text-align:right;">
0.0876227
</td>
<td style="text-align:right;">
0.0471815
</td>
<td style="text-align:right;">
89018
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-514
</td>
<td style="text-align:left;">
trenton/mercer county coc
</td>
<td style="text-align:right;">
-0.0411301
</td>
<td style="text-align:right;">
296
</td>
<td style="text-align:right;">
0.1698970
</td>
<td style="text-align:right;">
0.1287669
</td>
<td style="text-align:right;">
371990
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-511
</td>
<td style="text-align:left;">
southwest minnesota coc
</td>
<td style="text-align:right;">
-0.0415114
</td>
<td style="text-align:right;">
297
</td>
<td style="text-align:right;">
0.0649744
</td>
<td style="text-align:right;">
0.0234630
</td>
<td style="text-align:right;">
277032
</td>
</tr>
<tr>
<td style="text-align:left;">
va-508
</td>
<td style="text-align:left;">
lynchburg coc
</td>
<td style="text-align:right;">
-0.0416771
</td>
<td style="text-align:right;">
298
</td>
<td style="text-align:right;">
0.0848978
</td>
<td style="text-align:right;">
0.0432207
</td>
<td style="text-align:right;">
259135
</td>
</tr>
<tr>
<td style="text-align:left;">
co-503
</td>
<td style="text-align:left;">
metropolitan denver coc
</td>
<td style="text-align:right;">
-0.0427650
</td>
<td style="text-align:right;">
299
</td>
<td style="text-align:right;">
0.2171375
</td>
<td style="text-align:right;">
0.1743725
</td>
<td style="text-align:right;">
3049220
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-600
</td>
<td style="text-align:left;">
springfield/greene, christian, webster counties coc
</td>
<td style="text-align:right;">
-0.0433447
</td>
<td style="text-align:right;">
300
</td>
<td style="text-align:right;">
0.1606449
</td>
<td style="text-align:right;">
0.1173002
</td>
<td style="text-align:right;">
408354
</td>
</tr>
<tr>
<td style="text-align:left;">
va-503
</td>
<td style="text-align:left;">
virginia beach coc
</td>
<td style="text-align:right;">
-0.0436637
</td>
<td style="text-align:right;">
301
</td>
<td style="text-align:right;">
0.0975229
</td>
<td style="text-align:right;">
0.0538592
</td>
<td style="text-align:right;">
451176
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-507
</td>
<td style="text-align:left;">
portage, kalamazoo city & county coc
</td>
<td style="text-align:right;">
-0.0437691
</td>
<td style="text-align:right;">
302
</td>
<td style="text-align:right;">
0.2614625
</td>
<td style="text-align:right;">
0.2176934
</td>
<td style="text-align:right;">
260458
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-511
</td>
<td style="text-align:left;">
pensacola/escambia, santa rosa counties coc
</td>
<td style="text-align:right;">
-0.0439944
</td>
<td style="text-align:right;">
303
</td>
<td style="text-align:right;">
0.1757693
</td>
<td style="text-align:right;">
0.1317748
</td>
<td style="text-align:right;">
479606
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-603
</td>
<td style="text-align:left;">
el paso city & county coc
</td>
<td style="text-align:right;">
-0.0440145
</td>
<td style="text-align:right;">
304
</td>
<td style="text-align:right;">
0.1507017
</td>
<td style="text-align:right;">
0.1066872
</td>
<td style="text-align:right;">
836089
</td>
</tr>
<tr>
<td style="text-align:left;">
va-502
</td>
<td style="text-align:left;">
roanoke city & county, salem coc
</td>
<td style="text-align:right;">
-0.0441245
</td>
<td style="text-align:right;">
305
</td>
<td style="text-align:right;">
0.1578436
</td>
<td style="text-align:right;">
0.1137191
</td>
<td style="text-align:right;">
278757
</td>
</tr>
<tr>
<td style="text-align:left;">
al-500
</td>
<td style="text-align:left;">
birmingham/jefferson, st. clair, shelby counties coc
</td>
<td style="text-align:right;">
-0.0448249
</td>
<td style="text-align:right;">
306
</td>
<td style="text-align:right;">
0.1391877
</td>
<td style="text-align:right;">
0.0943627
</td>
<td style="text-align:right;">
954826
</td>
</tr>
<tr>
<td style="text-align:left;">
il-501
</td>
<td style="text-align:left;">
rockford/winnebago, boone counties coc
</td>
<td style="text-align:right;">
-0.0451859
</td>
<td style="text-align:right;">
307
</td>
<td style="text-align:right;">
0.1203002
</td>
<td style="text-align:right;">
0.0751143
</td>
<td style="text-align:right;">
340814
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-505
</td>
<td style="text-align:left;">
syracuse, auburn/onondaga, oswego, cayuga counties coc
</td>
<td style="text-align:right;">
-0.0453432
</td>
<td style="text-align:right;">
308
</td>
<td style="text-align:right;">
0.1537464
</td>
<td style="text-align:right;">
0.1084032
</td>
<td style="text-align:right;">
666032
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-510
</td>
<td style="text-align:left;">
lakewood township/ocean county coc
</td>
<td style="text-align:right;">
-0.0463590
</td>
<td style="text-align:right;">
309
</td>
<td style="text-align:right;">
0.1064729
</td>
<td style="text-align:right;">
0.0601139
</td>
<td style="text-align:right;">
588882
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-504
</td>
<td style="text-align:left;">
greensboro, high point coc
</td>
<td style="text-align:right;">
-0.0464336
</td>
<td style="text-align:right;">
310
</td>
<td style="text-align:right;">
0.1735456
</td>
<td style="text-align:right;">
0.1271120
</td>
<td style="text-align:right;">
516867
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-509
</td>
<td style="text-align:left;">
appalachian regional coc
</td>
<td style="text-align:right;">
-0.0469453
</td>
<td style="text-align:right;">
311
</td>
<td style="text-align:right;">
0.1179550
</td>
<td style="text-align:right;">
0.0710097
</td>
<td style="text-align:right;">
506973
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-502
</td>
<td style="text-align:left;">
oklahoma city coc
</td>
<td style="text-align:right;">
-0.0473627
</td>
<td style="text-align:right;">
312
</td>
<td style="text-align:right;">
0.2353831
</td>
<td style="text-align:right;">
0.1880204
</td>
<td style="text-align:right;">
629187
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-501
</td>
<td style="text-align:left;">
memphis/shelby county coc
</td>
<td style="text-align:right;">
-0.0479583
</td>
<td style="text-align:right;">
313
</td>
<td style="text-align:right;">
0.1789090
</td>
<td style="text-align:right;">
0.1309507
</td>
<td style="text-align:right;">
936230
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-505
</td>
<td style="text-align:left;">
flint/genesee county coc
</td>
<td style="text-align:right;">
-0.0480129
</td>
<td style="text-align:right;">
314
</td>
<td style="text-align:right;">
0.1547625
</td>
<td style="text-align:right;">
0.1067496
</td>
<td style="text-align:right;">
410306
</td>
</tr>
<tr>
<td style="text-align:left;">
ky-501
</td>
<td style="text-align:left;">
louisville-jefferson county coc
</td>
<td style="text-align:right;">
-0.0510713
</td>
<td style="text-align:right;">
315
</td>
<td style="text-align:right;">
0.1723327
</td>
<td style="text-align:right;">
0.1212615
</td>
<td style="text-align:right;">
763639
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-506
</td>
<td style="text-align:left;">
akron, barberton/summit county coc
</td>
<td style="text-align:right;">
-0.0523205
</td>
<td style="text-align:right;">
316
</td>
<td style="text-align:right;">
0.1608439
</td>
<td style="text-align:right;">
0.1085234
</td>
<td style="text-align:right;">
540897
</td>
</tr>
<tr>
<td style="text-align:left;">
il-512
</td>
<td style="text-align:left;">
bloomington/central illinois coc
</td>
<td style="text-align:right;">
-0.0531274
</td>
<td style="text-align:right;">
317
</td>
<td style="text-align:right;">
0.1260362
</td>
<td style="text-align:right;">
0.0729088
</td>
<td style="text-align:right;">
530800
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-508
</td>
<td style="text-align:left;">
west virginia balance of state coc
</td>
<td style="text-align:right;">
-0.0553901
</td>
<td style="text-align:right;">
318
</td>
<td style="text-align:right;">
0.1043831
</td>
<td style="text-align:right;">
0.0489930
</td>
<td style="text-align:right;">
1281817
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-501
</td>
<td style="text-align:left;">
georgia balance of state coc
</td>
<td style="text-align:right;">
-0.0557060
</td>
<td style="text-align:right;">
319
</td>
<td style="text-align:right;">
0.1097179
</td>
<td style="text-align:right;">
0.0540118
</td>
<td style="text-align:right;">
6905893
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-519
</td>
<td style="text-align:left;">
holland/ottawa county coc
</td>
<td style="text-align:right;">
-0.0560899
</td>
<td style="text-align:right;">
320
</td>
<td style="text-align:right;">
0.1348249
</td>
<td style="text-align:right;">
0.0787349
</td>
<td style="text-align:right;">
287039
</td>
</tr>
<tr>
<td style="text-align:left;">
md-500
</td>
<td style="text-align:left;">
cumberland/allegany county coc
</td>
<td style="text-align:right;">
-0.0564964
</td>
<td style="text-align:right;">
321
</td>
<td style="text-align:right;">
0.1653553
</td>
<td style="text-align:right;">
0.1088589
</td>
<td style="text-align:right;">
72571
</td>
</tr>
<tr>
<td style="text-align:left;">
la-502
</td>
<td style="text-align:left;">
shreveport, bossier/northwest louisiana coc
</td>
<td style="text-align:right;">
-0.0579064
</td>
<td style="text-align:right;">
322
</td>
<td style="text-align:right;">
0.1354596
</td>
<td style="text-align:right;">
0.0775532
</td>
<td style="text-align:right;">
483539
</td>
</tr>
<tr>
<td style="text-align:left;">
or-507
</td>
<td style="text-align:left;">
clackamas county coc
</td>
<td style="text-align:right;">
-0.0586772
</td>
<td style="text-align:right;">
323
</td>
<td style="text-align:right;">
0.1543087
</td>
<td style="text-align:right;">
0.0956314
</td>
<td style="text-align:right;">
400496
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-500
</td>
<td style="text-align:left;">
minneapolis/hennepin county coc
</td>
<td style="text-align:right;">
-0.0588161
</td>
<td style="text-align:right;">
324
</td>
<td style="text-align:right;">
0.3056308
</td>
<td style="text-align:right;">
0.2468147
</td>
<td style="text-align:right;">
1220754
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-508
</td>
<td style="text-align:left;">
scranton/lackawanna county coc
</td>
<td style="text-align:right;">
-0.0602203
</td>
<td style="text-align:right;">
325
</td>
<td style="text-align:right;">
0.1350251
</td>
<td style="text-align:right;">
0.0748049
</td>
<td style="text-align:right;">
212553
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-600
</td>
<td style="text-align:left;">
pittsburgh, mckeesport, penn hills/allegheny county coc
</td>
<td style="text-align:right;">
-0.0642498
</td>
<td style="text-align:right;">
326
</td>
<td style="text-align:right;">
0.1279304
</td>
<td style="text-align:right;">
0.0636805
</td>
<td style="text-align:right;">
1229575
</td>
</tr>
<tr>
<td style="text-align:left;">
md-507
</td>
<td style="text-align:left;">
cecil county coc
</td>
<td style="text-align:right;">
-0.0644594
</td>
<td style="text-align:right;">
327
</td>
<td style="text-align:right;">
0.1904483
</td>
<td style="text-align:right;">
0.1259889
</td>
<td style="text-align:right;">
102390
</td>
</tr>
<tr>
<td style="text-align:left;">
nv-500
</td>
<td style="text-align:left;">
las vegas/clark county coc
</td>
<td style="text-align:right;">
-0.0646162
</td>
<td style="text-align:right;">
328
</td>
<td style="text-align:right;">
0.3536314
</td>
<td style="text-align:right;">
0.2890151
</td>
<td style="text-align:right;">
2104734
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-501
</td>
<td style="text-align:left;">
milwaukee city & county coc
</td>
<td style="text-align:right;">
-0.0657817
</td>
<td style="text-align:right;">
329
</td>
<td style="text-align:right;">
0.1570171
</td>
<td style="text-align:right;">
0.0912354
</td>
<td style="text-align:right;">
954673
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-503
</td>
<td style="text-align:left;">
camden city & county/gloucester, cape may, cumberland counties coc
</td>
<td style="text-align:right;">
-0.0661583
</td>
<td style="text-align:right;">
330
</td>
<td style="text-align:right;">
0.1611183
</td>
<td style="text-align:right;">
0.0949600
</td>
<td style="text-align:right;">
1052022
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-508
</td>
<td style="text-align:left;">
canton, massillon, alliance/stark county coc
</td>
<td style="text-align:right;">
-0.0675486
</td>
<td style="text-align:right;">
331
</td>
<td style="text-align:right;">
0.1417720
</td>
<td style="text-align:right;">
0.0742234
</td>
<td style="text-align:right;">
374545
</td>
</tr>
<tr>
<td style="text-align:left;">
ms-500
</td>
<td style="text-align:left;">
jackson/rankin, madison counties coc
</td>
<td style="text-align:right;">
-0.0699198
</td>
<td style="text-align:right;">
332
</td>
<td style="text-align:right;">
0.1478804
</td>
<td style="text-align:right;">
0.0779606
</td>
<td style="text-align:right;">
572084
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-509
</td>
<td style="text-align:left;">
washtenaw county coc
</td>
<td style="text-align:right;">
-0.0726375
</td>
<td style="text-align:right;">
333
</td>
<td style="text-align:right;">
0.1505225
</td>
<td style="text-align:right;">
0.0778851
</td>
<td style="text-align:right;">
362072
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-503
</td>
<td style="text-align:left;">
st. charles city & county, lincoln, warren counties coc
</td>
<td style="text-align:right;">
-0.0769286
</td>
<td style="text-align:right;">
334
</td>
<td style="text-align:right;">
0.1893627
</td>
<td style="text-align:right;">
0.1124341
</td>
<td style="text-align:right;">
473166
</td>
</tr>
<tr>
<td style="text-align:left;">
az-501
</td>
<td style="text-align:left;">
tucson/pima county coc
</td>
<td style="text-align:right;">
-0.0792549
</td>
<td style="text-align:right;">
335
</td>
<td style="text-align:right;">
0.2161408
</td>
<td style="text-align:right;">
0.1368859
</td>
<td style="text-align:right;">
1008139
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-502
</td>
<td style="text-align:left;">
st. petersburg, clearwater, largo/pinellas county coc
</td>
<td style="text-align:right;">
-0.0822060
</td>
<td style="text-align:right;">
336
</td>
<td style="text-align:right;">
0.3578442
</td>
<td style="text-align:right;">
0.2756382
</td>
<td style="text-align:right;">
947619
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-511
</td>
<td style="text-align:left;">
quincy, brockton, weymouth, plymouth city and county coc
</td>
<td style="text-align:right;">
-0.0839084
</td>
<td style="text-align:right;">
337
</td>
<td style="text-align:right;">
0.2492975
</td>
<td style="text-align:right;">
0.1653891
</td>
<td style="text-align:right;">
659052
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-511
</td>
<td style="text-align:left;">
fayetteville/cumberland county coc
</td>
<td style="text-align:right;">
-0.0859120
</td>
<td style="text-align:right;">
338
</td>
<td style="text-align:right;">
0.1996460
</td>
<td style="text-align:right;">
0.1137340
</td>
<td style="text-align:right;">
327079
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-507
</td>
<td style="text-align:left;">
jackson/west tennessee coc
</td>
<td style="text-align:right;">
-0.0859926
</td>
<td style="text-align:right;">
339
</td>
<td style="text-align:right;">
0.2394334
</td>
<td style="text-align:right;">
0.1534408
</td>
<td style="text-align:right;">
668662
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-504
</td>
<td style="text-align:left;">
northeast minnesota coc
</td>
<td style="text-align:right;">
-0.0878468
</td>
<td style="text-align:right;">
340
</td>
<td style="text-align:right;">
0.1597214
</td>
<td style="text-align:right;">
0.0718747
</td>
<td style="text-align:right;">
125218
</td>
</tr>
<tr>
<td style="text-align:left;">
il-516
</td>
<td style="text-align:left;">
decatur/macon county coc
</td>
<td style="text-align:right;">
-0.0882777
</td>
<td style="text-align:right;">
341
</td>
<td style="text-align:right;">
0.2378851
</td>
<td style="text-align:right;">
0.1496074
</td>
<td style="text-align:right;">
107615
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-501
</td>
<td style="text-align:left;">
elmira/steuben, allegany, livingston, chemung, schuyler counties coc
</td>
<td style="text-align:right;">
-0.0886027
</td>
<td style="text-align:right;">
342
</td>
<td style="text-align:right;">
0.1625970
</td>
<td style="text-align:right;">
0.0739943
</td>
<td style="text-align:right;">
314889
</td>
</tr>
<tr>
<td style="text-align:left;">
al-506
</td>
<td style="text-align:left;">
tuscaloosa city & county coc
</td>
<td style="text-align:right;">
-0.0919387
</td>
<td style="text-align:right;">
343
</td>
<td style="text-align:right;">
0.1198138
</td>
<td style="text-align:right;">
0.0278750
</td>
<td style="text-align:right;">
204484
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-512
</td>
<td style="text-align:left;">
grand traverse, antrim, leelanau counties coc
</td>
<td style="text-align:right;">
-0.0940327
</td>
<td style="text-align:right;">
344
</td>
<td style="text-align:right;">
0.2312854
</td>
<td style="text-align:right;">
0.1372527
</td>
<td style="text-align:right;">
171217
</td>
</tr>
<tr>
<td style="text-align:left;">
nd-500
</td>
<td style="text-align:left;">
north dakota statewide coc
</td>
<td style="text-align:right;">
-0.0953797
</td>
<td style="text-align:right;">
345
</td>
<td style="text-align:right;">
0.1675805
</td>
<td style="text-align:right;">
0.0722008
</td>
<td style="text-align:right;">
750684
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-520
</td>
<td style="text-align:left;">
merced city & county coc
</td>
<td style="text-align:right;">
-0.0954467
</td>
<td style="text-align:right;">
346
</td>
<td style="text-align:right;">
0.2885949
</td>
<td style="text-align:right;">
0.1931481
</td>
<td style="text-align:right;">
266117
</td>
</tr>
<tr>
<td style="text-align:left;">
la-503
</td>
<td style="text-align:left;">
new orleans/jefferson parish coc
</td>
<td style="text-align:right;">
-0.0961886
</td>
<td style="text-align:right;">
347
</td>
<td style="text-align:right;">
0.2402896
</td>
<td style="text-align:right;">
0.1441010
</td>
<td style="text-align:right;">
824422
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-517
</td>
<td style="text-align:left;">
jackson city & county coc
</td>
<td style="text-align:right;">
-0.0998700
</td>
<td style="text-align:right;">
348
</td>
<td style="text-align:right;">
0.1507471
</td>
<td style="text-align:right;">
0.0508772
</td>
<td style="text-align:right;">
159207
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-514
</td>
<td style="text-align:left;">
ocala/marion county coc
</td>
<td style="text-align:right;">
-0.1006191
</td>
<td style="text-align:right;">
349
</td>
<td style="text-align:right;">
0.2669606
</td>
<td style="text-align:right;">
0.1663414
</td>
<td style="text-align:right;">
343871
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-504
</td>
<td style="text-align:left;">
augusta-richmond county coc
</td>
<td style="text-align:right;">
-0.1007219
</td>
<td style="text-align:right;">
350
</td>
<td style="text-align:right;">
0.2341909
</td>
<td style="text-align:right;">
0.1334690
</td>
<td style="text-align:right;">
201545
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-512
</td>
<td style="text-align:left;">
daly/san mateo county coc
</td>
<td style="text-align:right;">
-0.1033171
</td>
<td style="text-align:right;">
351
</td>
<td style="text-align:right;">
0.2660480
</td>
<td style="text-align:right;">
0.1627309
</td>
<td style="text-align:right;">
760765
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-507
</td>
<td style="text-align:left;">
savannah/chatham county coc
</td>
<td style="text-align:right;">
-0.1070170
</td>
<td style="text-align:right;">
352
</td>
<td style="text-align:right;">
0.4598931
</td>
<td style="text-align:right;">
0.3528762
</td>
<td style="text-align:right;">
285936
</td>
</tr>
<tr>
<td style="text-align:left;">
vt-501
</td>
<td style="text-align:left;">
burlington/chittenden county coc
</td>
<td style="text-align:right;">
-0.1072476
</td>
<td style="text-align:right;">
353
</td>
<td style="text-align:right;">
0.3298018
</td>
<td style="text-align:right;">
0.2225542
</td>
<td style="text-align:right;">
161309
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-508
</td>
<td style="text-align:left;">
gainesville/alachua, putnam counties coc
</td>
<td style="text-align:right;">
-0.1207327
</td>
<td style="text-align:right;">
354
</td>
<td style="text-align:right;">
0.3032805
</td>
<td style="text-align:right;">
0.1825478
</td>
<td style="text-align:right;">
414138
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-510
</td>
<td style="text-align:left;">
gloucester, haverhill, salem/essex county coc
</td>
<td style="text-align:right;">
-0.1253147
</td>
<td style="text-align:right;">
355
</td>
<td style="text-align:right;">
0.2468119
</td>
<td style="text-align:right;">
0.1214972
</td>
<td style="text-align:right;">
602483
</td>
</tr>
<tr>
<td style="text-align:left;">
dc-500
</td>
<td style="text-align:left;">
district of columbia coc
</td>
<td style="text-align:right;">
-0.1258698
</td>
<td style="text-align:right;">
356
</td>
<td style="text-align:right;">
1.1554970
</td>
<td style="text-align:right;">
1.0296271
</td>
<td style="text-align:right;">
670534
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-501
</td>
<td style="text-align:left;">
st.louis city coc
</td>
<td style="text-align:right;">
-0.1288947
</td>
<td style="text-align:right;">
357
</td>
<td style="text-align:right;">
0.4309220
</td>
<td style="text-align:right;">
0.3020273
</td>
<td style="text-align:right;">
314210
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-513
</td>
<td style="text-align:left;">
palm bay, melbourne/brevard county coc
</td>
<td style="text-align:right;">
-0.1308617
</td>
<td style="text-align:right;">
358
</td>
<td style="text-align:right;">
0.2601383
</td>
<td style="text-align:right;">
0.1292766
</td>
<td style="text-align:right;">
567775
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-519
</td>
<td style="text-align:left;">
pasco county coc
</td>
<td style="text-align:right;">
-0.1383382
</td>
<td style="text-align:right;">
359
</td>
<td style="text-align:right;">
0.6748007
</td>
<td style="text-align:right;">
0.5364626
</td>
<td style="text-align:right;">
497332
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-501
</td>
<td style="text-align:left;">
detroit coc
</td>
<td style="text-align:right;">
-0.1456830
</td>
<td style="text-align:right;">
360
</td>
<td style="text-align:right;">
0.4070554
</td>
<td style="text-align:right;">
0.2613724
</td>
<td style="text-align:right;">
676812
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-516
</td>
<td style="text-align:left;">
massachusetts balance of state coc
</td>
<td style="text-align:right;">
-0.1490089
</td>
<td style="text-align:right;">
361
</td>
<td style="text-align:right;">
0.3623034
</td>
<td style="text-align:right;">
0.2132945
</td>
<td style="text-align:right;">
1076446
</td>
</tr>
<tr>
<td style="text-align:left;">
ne-502
</td>
<td style="text-align:left;">
lincoln coc
</td>
<td style="text-align:right;">
-0.1519559
</td>
<td style="text-align:right;">
362
</td>
<td style="text-align:right;">
0.3299614
</td>
<td style="text-align:right;">
0.1780055
</td>
<td style="text-align:right;">
253363
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-504
</td>
<td style="text-align:left;">
daytona beach, daytona/volusia, flagler counties coc
</td>
<td style="text-align:right;">
-0.1525017
</td>
<td style="text-align:right;">
363
</td>
<td style="text-align:right;">
0.2621423
</td>
<td style="text-align:right;">
0.1096407
</td>
<td style="text-align:right;">
622944
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-502
</td>
<td style="text-align:left;">
durham city & county coc
</td>
<td style="text-align:right;">
-0.1574468
</td>
<td style="text-align:right;">
364
</td>
<td style="text-align:right;">
0.2699563
</td>
<td style="text-align:right;">
0.1125095
</td>
<td style="text-align:right;">
300419
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-522
</td>
<td style="text-align:left;">
humboldt county coc
</td>
<td style="text-align:right;">
-0.1692160
</td>
<td style="text-align:right;">
365
</td>
<td style="text-align:right;">
0.6886869
</td>
<td style="text-align:right;">
0.5194709
</td>
<td style="text-align:right;">
135330
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-509
</td>
<td style="text-align:left;">
fort pierce/st. lucie, indian river, martin counties coc
</td>
<td style="text-align:right;">
-0.1743446
</td>
<td style="text-align:right;">
366
</td>
<td style="text-align:right;">
0.4306261
</td>
<td style="text-align:right;">
0.2562816
</td>
<td style="text-align:right;">
601682
</td>
</tr>
<tr>
<td style="text-align:left;">
md-508
</td>
<td style="text-align:left;">
charles, calvert, st.mary’s counties coc
</td>
<td style="text-align:right;">
-0.1809634
</td>
<td style="text-align:right;">
367
</td>
<td style="text-align:right;">
0.3181499
</td>
<td style="text-align:right;">
0.1371865
</td>
<td style="text-align:right;">
358636
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-606
</td>
<td style="text-align:left;">
long beach coc
</td>
<td style="text-align:right;">
-0.1822568
</td>
<td style="text-align:right;">
368
</td>
<td style="text-align:right;">
0.5769008
</td>
<td style="text-align:right;">
0.3946440
</td>
<td style="text-align:right;">
474605
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-516
</td>
<td style="text-align:left;">
northwest north carolina coc
</td>
<td style="text-align:right;">
-0.1927323
</td>
<td style="text-align:right;">
369
</td>
<td style="text-align:right;">
0.4064035
</td>
<td style="text-align:right;">
0.2136711
</td>
<td style="text-align:right;">
210136
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-602
</td>
<td style="text-align:left;">
punta gorda/charlotte county coc
</td>
<td style="text-align:right;">
-0.1999988
</td>
<td style="text-align:right;">
370
</td>
<td style="text-align:right;">
0.2945228
</td>
<td style="text-align:right;">
0.0945240
</td>
<td style="text-align:right;">
173501
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-515
</td>
<td style="text-align:left;">
elizabeth/union county coc
</td>
<td style="text-align:right;">
-0.2175220
</td>
<td style="text-align:right;">
371
</td>
<td style="text-align:right;">
0.3040962
</td>
<td style="text-align:right;">
0.0865741
</td>
<td style="text-align:right;">
552128
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-516
</td>
<td style="text-align:left;">
norton shores, muskegon city & county coc
</td>
<td style="text-align:right;">
-0.2459306
</td>
<td style="text-align:right;">
372
</td>
<td style="text-align:right;">
0.3379375
</td>
<td style="text-align:right;">
0.0920070
</td>
<td style="text-align:right;">
172813
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-504
</td>
<td style="text-align:left;">
santa rosa, petaluma/sonoma county coc
</td>
<td style="text-align:right;">
-0.2537594
</td>
<td style="text-align:right;">
373
</td>
<td style="text-align:right;">
0.8523919
</td>
<td style="text-align:right;">
0.5986325
</td>
<td style="text-align:right;">
500474
</td>
</tr>
<tr>
<td style="text-align:left;">
ky-502
</td>
<td style="text-align:left;">
lexington-fayette county coc
</td>
<td style="text-align:right;">
-0.2729133
</td>
<td style="text-align:right;">
374
</td>
<td style="text-align:right;">
0.4905449
</td>
<td style="text-align:right;">
0.2176317
</td>
<td style="text-align:right;">
314752
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-517
</td>
<td style="text-align:left;">
hendry, hardee, highlands counties coc
</td>
<td style="text-align:right;">
-0.3524281
</td>
<td style="text-align:right;">
375
</td>
<td style="text-align:right;">
0.5312075
</td>
<td style="text-align:right;">
0.1787793
</td>
<td style="text-align:right;">
253385
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-500
</td>
<td style="text-align:left;">
atlanta coc
</td>
<td style="text-align:right;">
-0.3737956
</td>
<td style="text-align:right;">
376
</td>
<td style="text-align:right;">
1.0418929
</td>
<td style="text-align:right;">
0.6680973
</td>
<td style="text-align:right;">
460412
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-505
</td>
<td style="text-align:left;">
fort walton beach/okaloosa, walton counties coc
</td>
<td style="text-align:right;">
-0.4115195
</td>
<td style="text-align:right;">
377
</td>
<td style="text-align:right;">
0.5997840
</td>
<td style="text-align:right;">
0.1882645
</td>
<td style="text-align:right;">
262928
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-518
</td>
<td style="text-align:left;">
columbia, hamilton, lafayette, suwannee counties coc
</td>
<td style="text-align:right;">
-0.4264187
</td>
<td style="text-align:right;">
378
</td>
<td style="text-align:right;">
0.7907592
</td>
<td style="text-align:right;">
0.3643405
</td>
<td style="text-align:right;">
135313
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-508
</td>
<td style="text-align:left;">
watsonville/santa cruz city & county coc
</td>
<td style="text-align:right;">
-0.4435330
</td>
<td style="text-align:right;">
379
</td>
<td style="text-align:right;">
1.2946468
</td>
<td style="text-align:right;">
0.8511138
</td>
<td style="text-align:right;">
272584
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-614
</td>
<td style="text-align:left;">
san luis obispo county coc
</td>
<td style="text-align:right;">
-0.4525660
</td>
<td style="text-align:right;">
380
</td>
<td style="text-align:right;">
0.8424636
</td>
<td style="text-align:right;">
0.3898976
</td>
<td style="text-align:right;">
280843
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-512
</td>
<td style="text-align:left;">
st. johns county coc
</td>
<td style="text-align:right;">
-0.4681097
</td>
<td style="text-align:right;">
381
</td>
<td style="text-align:right;">
0.6192840
</td>
<td style="text-align:right;">
0.1511743
</td>
<td style="text-align:right;">
226229
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-523
</td>
<td style="text-align:left;">
colusa, glenn, trinity counties coc
</td>
<td style="text-align:right;">
-0.4804293
</td>
<td style="text-align:right;">
382
</td>
<td style="text-align:right;">
0.9110483
</td>
<td style="text-align:right;">
0.4306189
</td>
<td style="text-align:right;">
62236
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-509
</td>
<td style="text-align:left;">
mendocino county coc
</td>
<td style="text-align:right;">
-0.6004079
</td>
<td style="text-align:right;">
383
</td>
<td style="text-align:right;">
1.6087265
</td>
<td style="text-align:right;">
1.0083186
</td>
<td style="text-align:right;">
87274
</td>
</tr>
</tbody>
</table>
</div>
### Fact: Percent change in overall homeless count

The CoC with the greatest percent increase in homeless count is the
Imperial County CoC in California, followed by El Dorado County in
California, the Lynn CoC in Massachusetts, and the Jamestown,
Dunkirk/Chautauqua County CoC in New York.

The CoC with the greatest percent decrease in homeless count is the
Tuscaloosa City & County CoC in Alabama, followed by St. Johns County in
FL, and the Norton Shores, Muskegon City & Count CoC in Michigan.

``` r
# Order by percent change in overall counts
wk %>%
  arrange(rank_perc_change_2014_2018, coc_code) %>%
  select(coc_code, coc_name, 
         perc_change_2014_2018, rank_perc_change_2014_2018, 
         overall_homeless_2014, overall_homeless_2018) %>%
  # Write to CSV
  write_csv(paste0(save_path, "perc-change-counts-of-homelessness-by-coc.csv")) %>%
  # Styling
  kable(caption = "Ordered by the percent change in homeless count from 2014 to 2018") %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<caption>
Ordered by the percent change in homeless count from 2014 to 2018
</caption>
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_code
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_name
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
perc\_change\_2014\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
rank\_perc\_change\_2014\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
overall\_homeless\_2014
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
overall\_homeless\_2018
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ca-613
</td>
<td style="text-align:left;">
imperial county coc
</td>
<td style="text-align:right;">
4.0100671
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
298
</td>
<td style="text-align:right;">
1493
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-525
</td>
<td style="text-align:left;">
el dorado county coc
</td>
<td style="text-align:right;">
2.3076923
</td>
<td style="text-align:right;">
2.0
</td>
<td style="text-align:right;">
195
</td>
<td style="text-align:right;">
645
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-502
</td>
<td style="text-align:left;">
lynn coc
</td>
<td style="text-align:right;">
1.7774869
</td>
<td style="text-align:right;">
3.0
</td>
<td style="text-align:right;">
382
</td>
<td style="text-align:right;">
1061
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-514
</td>
<td style="text-align:left;">
jamestown, dunkirk/chautauqua county coc
</td>
<td style="text-align:right;">
1.7358491
</td>
<td style="text-align:right;">
4.0
</td>
<td style="text-align:right;">
53
</td>
<td style="text-align:right;">
145
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-504
</td>
<td style="text-align:left;">
norman/cleveland county coc
</td>
<td style="text-align:right;">
1.6000000
</td>
<td style="text-align:right;">
5.0
</td>
<td style="text-align:right;">
140
</td>
<td style="text-align:right;">
364
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-513
</td>
<td style="text-align:left;">
wayne, ontario, seneca, yates counties coc
</td>
<td style="text-align:right;">
0.9782609
</td>
<td style="text-align:right;">
6.0
</td>
<td style="text-align:right;">
92
</td>
<td style="text-align:right;">
182
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-510
</td>
<td style="text-align:left;">
ithaca/tompkins county coc
</td>
<td style="text-align:right;">
0.9361702
</td>
<td style="text-align:right;">
7.0
</td>
<td style="text-align:right;">
47
</td>
<td style="text-align:right;">
91
</td>
</tr>
<tr>
<td style="text-align:left;">
md-512
</td>
<td style="text-align:left;">
hagerstown/washington county coc
</td>
<td style="text-align:right;">
0.8598131
</td>
<td style="text-align:right;">
8.0
</td>
<td style="text-align:right;">
107
</td>
<td style="text-align:right;">
199
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-516
</td>
<td style="text-align:left;">
redding/shasta, siskiyou, lassen, plumas, del norte, modoc, sierra
counties coc
</td>
<td style="text-align:right;">
0.8238095
</td>
<td style="text-align:right;">
9.0
</td>
<td style="text-align:right;">
630
</td>
<td style="text-align:right;">
1149
</td>
</tr>
<tr>
<td style="text-align:left;">
co-500
</td>
<td style="text-align:left;">
colorado balance of state coc
</td>
<td style="text-align:right;">
0.8231261
</td>
<td style="text-align:right;">
10.0
</td>
<td style="text-align:right;">
2188
</td>
<td style="text-align:right;">
3989
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-606
</td>
<td style="text-align:left;">
naples/collier county coc
</td>
<td style="text-align:right;">
0.8088643
</td>
<td style="text-align:right;">
11.0
</td>
<td style="text-align:right;">
361
</td>
<td style="text-align:right;">
653
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-507
</td>
<td style="text-align:left;">
schenectady city & county coc
</td>
<td style="text-align:right;">
0.6172840
</td>
<td style="text-align:right;">
12.0
</td>
<td style="text-align:right;">
243
</td>
<td style="text-align:right;">
393
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-519
</td>
<td style="text-align:left;">
chico, paradise/butte county coc
</td>
<td style="text-align:right;">
0.6163793
</td>
<td style="text-align:right;">
13.0
</td>
<td style="text-align:right;">
696
</td>
<td style="text-align:right;">
1125
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-507
</td>
<td style="text-align:left;">
marin county coc
</td>
<td style="text-align:right;">
0.6126657
</td>
<td style="text-align:right;">
14.0
</td>
<td style="text-align:right;">
679
</td>
<td style="text-align:right;">
1095
</td>
</tr>
<tr>
<td style="text-align:left;">
or-505
</td>
<td style="text-align:left;">
oregon balance of state coc
</td>
<td style="text-align:right;">
0.5507035
</td>
<td style="text-align:right;">
15.0
</td>
<td style="text-align:right;">
4122
</td>
<td style="text-align:right;">
6392
</td>
</tr>
<tr>
<td style="text-align:left;">
nv-501
</td>
<td style="text-align:left;">
reno, sparks/washoe county coc
</td>
<td style="text-align:right;">
0.5500650
</td>
<td style="text-align:right;">
16.0
</td>
<td style="text-align:right;">
769
</td>
<td style="text-align:right;">
1192
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-519
</td>
<td style="text-align:left;">
columbia, greene counties coc
</td>
<td style="text-align:right;">
0.5312500
</td>
<td style="text-align:right;">
17.0
</td>
<td style="text-align:right;">
128
</td>
<td style="text-align:right;">
196
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-504
</td>
<td style="text-align:left;">
newark/essex county coc
</td>
<td style="text-align:right;">
0.5023601
</td>
<td style="text-align:right;">
18.0
</td>
<td style="text-align:right;">
1483
</td>
<td style="text-align:right;">
2228
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-516
</td>
<td style="text-align:left;">
clinton county coc
</td>
<td style="text-align:right;">
0.4812030
</td>
<td style="text-align:right;">
19.0
</td>
<td style="text-align:right;">
133
</td>
<td style="text-align:right;">
197
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-503
</td>
<td style="text-align:left;">
sacramento city & county coc
</td>
<td style="text-align:right;">
0.4785627
</td>
<td style="text-align:right;">
20.0
</td>
<td style="text-align:right;">
2449
</td>
<td style="text-align:right;">
3621
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-611
</td>
<td style="text-align:left;">
amarillo coc
</td>
<td style="text-align:right;">
0.4745011
</td>
<td style="text-align:right;">
21.0
</td>
<td style="text-align:right;">
451
</td>
<td style="text-align:right;">
665
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-600
</td>
<td style="text-align:left;">
los angeles city & county coc
</td>
<td style="text-align:right;">
0.4524758
</td>
<td style="text-align:right;">
22.0
</td>
<td style="text-align:right;">
34393
</td>
<td style="text-align:right;">
49955
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-505
</td>
<td style="text-align:left;">
southeast arkansas coc
</td>
<td style="text-align:right;">
0.4428571
</td>
<td style="text-align:right;">
23.0
</td>
<td style="text-align:right;">
70
</td>
<td style="text-align:right;">
101
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-607
</td>
<td style="text-align:left;">
sullivan county coc
</td>
<td style="text-align:right;">
0.4427481
</td>
<td style="text-align:right;">
24.0
</td>
<td style="text-align:right;">
131
</td>
<td style="text-align:right;">
189
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-606
</td>
<td style="text-align:left;">
rockland county coc
</td>
<td style="text-align:right;">
0.4400000
</td>
<td style="text-align:right;">
25.0
</td>
<td style="text-align:right;">
125
</td>
<td style="text-align:right;">
180
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-604
</td>
<td style="text-align:left;">
monroe county coc
</td>
<td style="text-align:right;">
0.4351032
</td>
<td style="text-align:right;">
26.0
</td>
<td style="text-align:right;">
678
</td>
<td style="text-align:right;">
973
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-515
</td>
<td style="text-align:left;">
panama city/bay, jackson counties coc
</td>
<td style="text-align:right;">
0.4216418
</td>
<td style="text-align:right;">
27.0
</td>
<td style="text-align:right;">
268
</td>
<td style="text-align:right;">
381
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-513
</td>
<td style="text-align:left;">
chapel hill/orange county coc
</td>
<td style="text-align:right;">
0.4074074
</td>
<td style="text-align:right;">
28.0
</td>
<td style="text-align:right;">
108
</td>
<td style="text-align:right;">
152
</td>
</tr>
<tr>
<td style="text-align:left;">
md-506
</td>
<td style="text-align:left;">
carroll county coc
</td>
<td style="text-align:right;">
0.3951613
</td>
<td style="text-align:right;">
29.0
</td>
<td style="text-align:right;">
124
</td>
<td style="text-align:right;">
173
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-520
</td>
<td style="text-align:left;">
citrus, hernando, lake, sumter counties coc
</td>
<td style="text-align:right;">
0.3913894
</td>
<td style="text-align:right;">
30.0
</td>
<td style="text-align:right;">
511
</td>
<td style="text-align:right;">
711
</td>
</tr>
<tr>
<td style="text-align:left;">
or-503
</td>
<td style="text-align:left;">
central oregon coc
</td>
<td style="text-align:right;">
0.3855634
</td>
<td style="text-align:right;">
31.0
</td>
<td style="text-align:right;">
568
</td>
<td style="text-align:right;">
787
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-608
</td>
<td style="text-align:left;">
kingston/ulster county coc
</td>
<td style="text-align:right;">
0.3607038
</td>
<td style="text-align:right;">
32.0
</td>
<td style="text-align:right;">
341
</td>
<td style="text-align:right;">
464
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-500
</td>
<td style="text-align:left;">
seattle/king county coc
</td>
<td style="text-align:right;">
0.3534473
</td>
<td style="text-align:right;">
33.0
</td>
<td style="text-align:right;">
8949
</td>
<td style="text-align:right;">
12112
</td>
</tr>
<tr>
<td style="text-align:left;">
md-505
</td>
<td style="text-align:left;">
baltimore county coc
</td>
<td style="text-align:right;">
0.3321617
</td>
<td style="text-align:right;">
34.0
</td>
<td style="text-align:right;">
569
</td>
<td style="text-align:right;">
758
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-508
</td>
<td style="text-align:left;">
lowell coc
</td>
<td style="text-align:right;">
0.3316327
</td>
<td style="text-align:right;">
35.0
</td>
<td style="text-align:right;">
588
</td>
<td style="text-align:right;">
783
</td>
</tr>
<tr>
<td style="text-align:left;">
sd-500
</td>
<td style="text-align:left;">
south dakota statewide coc
</td>
<td style="text-align:right;">
0.3096045
</td>
<td style="text-align:right;">
36.0
</td>
<td style="text-align:right;">
885
</td>
<td style="text-align:right;">
1159
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-502
</td>
<td style="text-align:left;">
racine city & county coc
</td>
<td style="text-align:right;">
0.3095238
</td>
<td style="text-align:right;">
37.0
</td>
<td style="text-align:right;">
210
</td>
<td style="text-align:right;">
275
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-602
</td>
<td style="text-align:left;">
santa ana, anaheim/orange county coc
</td>
<td style="text-align:right;">
0.2927211
</td>
<td style="text-align:right;">
38.0
</td>
<td style="text-align:right;">
3833
</td>
<td style="text-align:right;">
4955
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-502
</td>
<td style="text-align:left;">
oakland, berkeley/alameda county coc
</td>
<td style="text-align:right;">
0.2865169
</td>
<td style="text-align:right;">
39.0
</td>
<td style="text-align:right;">
4272
</td>
<td style="text-align:right;">
5496
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-503
</td>
<td style="text-align:left;">
albany city & county coc
</td>
<td style="text-align:right;">
0.2846154
</td>
<td style="text-align:right;">
40.0
</td>
<td style="text-align:right;">
650
</td>
<td style="text-align:right;">
835
</td>
</tr>
<tr>
<td style="text-align:left;">
md-509
</td>
<td style="text-align:left;">
frederick city & county coc
</td>
<td style="text-align:right;">
0.2845528
</td>
<td style="text-align:right;">
41.0
</td>
<td style="text-align:right;">
246
</td>
<td style="text-align:right;">
316
</td>
</tr>
<tr>
<td style="text-align:left;">
co-504
</td>
<td style="text-align:left;">
colorado springs/el paso county coc
</td>
<td style="text-align:right;">
0.2723544
</td>
<td style="text-align:right;">
42.0
</td>
<td style="text-align:right;">
1219
</td>
<td style="text-align:right;">
1551
</td>
</tr>
<tr>
<td style="text-align:left;">
md-511
</td>
<td style="text-align:left;">
mid-shore regional coc
</td>
<td style="text-align:right;">
0.2702703
</td>
<td style="text-align:right;">
43.0
</td>
<td style="text-align:right;">
111
</td>
<td style="text-align:right;">
141
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-513
</td>
<td style="text-align:left;">
visalia/kings, tulare counties coc
</td>
<td style="text-align:right;">
0.2673657
</td>
<td style="text-align:right;">
44.0
</td>
<td style="text-align:right;">
763
</td>
<td style="text-align:right;">
967
</td>
</tr>
<tr>
<td style="text-align:left;">
la-507
</td>
<td style="text-align:left;">
alexandria/central louisiana coc
</td>
<td style="text-align:right;">
0.2553191
</td>
<td style="text-align:right;">
45.0
</td>
<td style="text-align:right;">
141
</td>
<td style="text-align:right;">
177
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-504
</td>
<td style="text-align:left;">
springfield/hampden county coc
</td>
<td style="text-align:right;">
0.2520446
</td>
<td style="text-align:right;">
46.0
</td>
<td style="text-align:right;">
2690
</td>
<td style="text-align:right;">
3368
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-515
</td>
<td style="text-align:left;">
roseville, rocklin/placer, nevada counties coc
</td>
<td style="text-align:right;">
0.2467192
</td>
<td style="text-align:right;">
47.0
</td>
<td style="text-align:right;">
762
</td>
<td style="text-align:right;">
950
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-603
</td>
<td style="text-align:left;">
beaver county coc
</td>
<td style="text-align:right;">
0.2315789
</td>
<td style="text-align:right;">
48.0
</td>
<td style="text-align:right;">
95
</td>
<td style="text-align:right;">
117
</td>
</tr>
<tr>
<td style="text-align:left;">
al-502
</td>
<td style="text-align:left;">
florence/northwest alabama coc
</td>
<td style="text-align:right;">
0.2248804
</td>
<td style="text-align:right;">
49.0
</td>
<td style="text-align:right;">
209
</td>
<td style="text-align:right;">
256
</td>
</tr>
<tr>
<td style="text-align:left;">
va-513
</td>
<td style="text-align:left;">
harrisburg, winchester/western virginia coc
</td>
<td style="text-align:right;">
0.2208835
</td>
<td style="text-align:right;">
50.0
</td>
<td style="text-align:right;">
249
</td>
<td style="text-align:right;">
304
</td>
</tr>
<tr>
<td style="text-align:left;">
ak-501
</td>
<td style="text-align:left;">
alaska balance of state coc
</td>
<td style="text-align:right;">
0.2115637
</td>
<td style="text-align:right;">
51.0
</td>
<td style="text-align:right;">
761
</td>
<td style="text-align:right;">
922
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-516
</td>
<td style="text-align:left;">
warren, sussex, hunterdon counties coc
</td>
<td style="text-align:right;">
0.2114695
</td>
<td style="text-align:right;">
52.0
</td>
<td style="text-align:right;">
279
</td>
<td style="text-align:right;">
338
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-603
</td>
<td style="text-align:left;">
nassau, suffolk counties coc
</td>
<td style="text-align:right;">
0.2061116
</td>
<td style="text-align:right;">
53.0
</td>
<td style="text-align:right;">
3207
</td>
<td style="text-align:right;">
3868
</td>
</tr>
<tr>
<td style="text-align:left;">
de-500
</td>
<td style="text-align:left;">
delaware statewide coc
</td>
<td style="text-align:right;">
0.2008879
</td>
<td style="text-align:right;">
54.0
</td>
<td style="text-align:right;">
901
</td>
<td style="text-align:right;">
1082
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-510
</td>
<td style="text-align:left;">
turlock, modesto/stanislaus county coc
</td>
<td style="text-align:right;">
0.1730104
</td>
<td style="text-align:right;">
55.0
</td>
<td style="text-align:right;">
1156
</td>
<td style="text-align:right;">
1356
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-600
</td>
<td style="text-align:left;">
dallas city & county, irving coc
</td>
<td style="text-align:right;">
0.1727376
</td>
<td style="text-align:right;">
56.0
</td>
<td style="text-align:right;">
3514
</td>
<td style="text-align:right;">
4121
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-505
</td>
<td style="text-align:left;">
new bedford coc
</td>
<td style="text-align:right;">
0.1719198
</td>
<td style="text-align:right;">
57.0
</td>
<td style="text-align:right;">
349
</td>
<td style="text-align:right;">
409
</td>
</tr>
<tr>
<td style="text-align:left;">
or-502
</td>
<td style="text-align:left;">
medford, ashland/jackson county coc
</td>
<td style="text-align:right;">
0.1712000
</td>
<td style="text-align:right;">
58.0
</td>
<td style="text-align:right;">
625
</td>
<td style="text-align:right;">
732
</td>
</tr>
<tr>
<td style="text-align:left;">
ut-504
</td>
<td style="text-align:left;">
provo/mountainland coc
</td>
<td style="text-align:right;">
0.1610738
</td>
<td style="text-align:right;">
59.0
</td>
<td style="text-align:right;">
149
</td>
<td style="text-align:right;">
173
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-600
</td>
<td style="text-align:left;">
new york city coc
</td>
<td style="text-align:right;">
0.1602419
</td>
<td style="text-align:right;">
60.0
</td>
<td style="text-align:right;">
67810
</td>
<td style="text-align:right;">
78676
</td>
</tr>
<tr>
<td style="text-align:left;">
va-501
</td>
<td style="text-align:left;">
norfolk/chesapeake, suffolk, isle of wight, southampton counties coc
</td>
<td style="text-align:right;">
0.1571856
</td>
<td style="text-align:right;">
61.0
</td>
<td style="text-align:right;">
668
</td>
<td style="text-align:right;">
773
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-511
</td>
<td style="text-align:left;">
paterson/passaic county coc
</td>
<td style="text-align:right;">
0.1542553
</td>
<td style="text-align:right;">
62.0
</td>
<td style="text-align:right;">
376
</td>
<td style="text-align:right;">
434
</td>
</tr>
<tr>
<td style="text-align:left;">
md-510
</td>
<td style="text-align:left;">
garrett county coc
</td>
<td style="text-align:right;">
0.1538462
</td>
<td style="text-align:right;">
63.0
</td>
<td style="text-align:right;">
13
</td>
<td style="text-align:right;">
15
</td>
</tr>
<tr>
<td style="text-align:left;">
ut-503
</td>
<td style="text-align:left;">
utah balance of state coc
</td>
<td style="text-align:right;">
0.1496164
</td>
<td style="text-align:right;">
64.0
</td>
<td style="text-align:right;">
782
</td>
<td style="text-align:right;">
899
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-508
</td>
<td style="text-align:left;">
moorhead/west central minnesota coc
</td>
<td style="text-align:right;">
0.1495327
</td>
<td style="text-align:right;">
65.0
</td>
<td style="text-align:right;">
214
</td>
<td style="text-align:right;">
246
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-508
</td>
<td style="text-align:left;">
vancouver/clark county coc
</td>
<td style="text-align:right;">
0.1438849
</td>
<td style="text-align:right;">
66.0
</td>
<td style="text-align:right;">
695
</td>
<td style="text-align:right;">
795
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-602
</td>
<td style="text-align:left;">
newburgh, middletown/orange county coc
</td>
<td style="text-align:right;">
0.1401425
</td>
<td style="text-align:right;">
67.0
</td>
<td style="text-align:right;">
421
</td>
<td style="text-align:right;">
480
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-517
</td>
<td style="text-align:left;">
napa city & county coc
</td>
<td style="text-align:right;">
0.1298246
</td>
<td style="text-align:right;">
68.0
</td>
<td style="text-align:right;">
285
</td>
<td style="text-align:right;">
322
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-515
</td>
<td style="text-align:left;">
monroe city & county coc
</td>
<td style="text-align:right;">
0.1297297
</td>
<td style="text-align:right;">
69.0
</td>
<td style="text-align:right;">
185
</td>
<td style="text-align:right;">
209
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-506
</td>
<td style="text-align:left;">
tallahassee/leon county coc
</td>
<td style="text-align:right;">
0.1291925
</td>
<td style="text-align:right;">
70.0
</td>
<td style="text-align:right;">
805
</td>
<td style="text-align:right;">
909
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-501
</td>
<td style="text-align:left;">
harrisburg/dauphin county coc
</td>
<td style="text-align:right;">
0.1237374
</td>
<td style="text-align:right;">
71.0
</td>
<td style="text-align:right;">
396
</td>
<td style="text-align:right;">
445
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-503
</td>
<td style="text-align:left;">
columbus/franklin county coc
</td>
<td style="text-align:right;">
0.1195787
</td>
<td style="text-align:right;">
72.0
</td>
<td style="text-align:right;">
1614
</td>
<td style="text-align:right;">
1807
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-518
</td>
<td style="text-align:left;">
utica, rome/oneida, madison counties coc
</td>
<td style="text-align:right;">
0.1194969
</td>
<td style="text-align:right;">
73.0
</td>
<td style="text-align:right;">
159
</td>
<td style="text-align:right;">
178
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-500
</td>
<td style="text-align:left;">
st. louis county coc
</td>
<td style="text-align:right;">
0.1194030
</td>
<td style="text-align:right;">
74.0
</td>
<td style="text-align:right;">
402
</td>
<td style="text-align:right;">
450
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-506
</td>
<td style="text-align:left;">
salinas/monterey, san benito counties coc
</td>
<td style="text-align:right;">
0.1137745
</td>
<td style="text-align:right;">
75.0
</td>
<td style="text-align:right;">
2962
</td>
<td style="text-align:right;">
3299
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-500
</td>
<td style="text-align:left;">
wheeling, weirton area coc
</td>
<td style="text-align:right;">
0.1134021
</td>
<td style="text-align:right;">
76.0
</td>
<td style="text-align:right;">
97
</td>
<td style="text-align:right;">
108
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-503
</td>
<td style="text-align:left;">
tacoma, lakewood/pierce county coc
</td>
<td style="text-align:right;">
0.1120219
</td>
<td style="text-align:right;">
77.0
</td>
<td style="text-align:right;">
1464
</td>
<td style="text-align:right;">
1628
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-505
</td>
<td style="text-align:left;">
richmond/contra costa county coc
</td>
<td style="text-align:right;">
0.1119960
</td>
<td style="text-align:right;">
78.0
</td>
<td style="text-align:right;">
2009
</td>
<td style="text-align:right;">
2234
</td>
</tr>
<tr>
<td style="text-align:left;">
il-506
</td>
<td style="text-align:left;">
joliet, bolingbrook/will county coc
</td>
<td style="text-align:right;">
0.1035599
</td>
<td style="text-align:right;">
79.0
</td>
<td style="text-align:right;">
309
</td>
<td style="text-align:right;">
341
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-510
</td>
<td style="text-align:left;">
saginaw city & county coc
</td>
<td style="text-align:right;">
0.0984615
</td>
<td style="text-align:right;">
80.0
</td>
<td style="text-align:right;">
325
</td>
<td style="text-align:right;">
357
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-510
</td>
<td style="text-align:left;">
murfreesboro/rutherford county coc
</td>
<td style="text-align:right;">
0.0968992
</td>
<td style="text-align:right;">
81.0
</td>
<td style="text-align:right;">
258
</td>
<td style="text-align:right;">
283
</td>
</tr>
<tr>
<td style="text-align:left;">
va-521
</td>
<td style="text-align:left;">
virginia balance of state coc
</td>
<td style="text-align:right;">
0.0845921
</td>
<td style="text-align:right;">
82.0
</td>
<td style="text-align:right;">
662
</td>
<td style="text-align:right;">
718
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-502
</td>
<td style="text-align:left;">
spokane city & county coc
</td>
<td style="text-align:right;">
0.0835509
</td>
<td style="text-align:right;">
83.0
</td>
<td style="text-align:right;">
1149
</td>
<td style="text-align:right;">
1245
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-501
</td>
<td style="text-align:left;">
washington balance of state coc
</td>
<td style="text-align:right;">
0.0821238
</td>
<td style="text-align:right;">
84.0
</td>
<td style="text-align:right;">
5236
</td>
<td style="text-align:right;">
5666
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-503
</td>
<td style="text-align:left;">
austin/travis county coc
</td>
<td style="text-align:right;">
0.0805234
</td>
<td style="text-align:right;">
85.0
</td>
<td style="text-align:right;">
1987
</td>
<td style="text-align:right;">
2147
</td>
</tr>
<tr>
<td style="text-align:left;">
il-500
</td>
<td style="text-align:left;">
mchenry county coc
</td>
<td style="text-align:right;">
0.0783133
</td>
<td style="text-align:right;">
86.0
</td>
<td style="text-align:right;">
166
</td>
<td style="text-align:right;">
179
</td>
</tr>
<tr>
<td style="text-align:left;">
nh-500
</td>
<td style="text-align:left;">
new hampshire balance of state coc
</td>
<td style="text-align:right;">
0.0769231
</td>
<td style="text-align:right;">
87.0
</td>
<td style="text-align:right;">
689
</td>
<td style="text-align:right;">
742
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-512
</td>
<td style="text-align:left;">
york city & county coc
</td>
<td style="text-align:right;">
0.0728477
</td>
<td style="text-align:right;">
88.0
</td>
<td style="text-align:right;">
302
</td>
<td style="text-align:right;">
324
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-501
</td>
<td style="text-align:left;">
tulsa city & county coc
</td>
<td style="text-align:right;">
0.0722772
</td>
<td style="text-align:right;">
89.0
</td>
<td style="text-align:right;">
1010
</td>
<td style="text-align:right;">
1083
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-501
</td>
<td style="text-align:left;">
san francisco coc
</td>
<td style="text-align:right;">
0.0700687
</td>
<td style="text-align:right;">
90.0
</td>
<td style="text-align:right;">
6408
</td>
<td style="text-align:right;">
6857
</td>
</tr>
<tr>
<td style="text-align:left;">
ak-500
</td>
<td style="text-align:left;">
anchorage coc
</td>
<td style="text-align:right;">
0.0694037
</td>
<td style="text-align:right;">
91.0
</td>
<td style="text-align:right;">
1023
</td>
<td style="text-align:right;">
1094
</td>
</tr>
<tr>
<td style="text-align:left;">
nm-500
</td>
<td style="text-align:left;">
albuquerque coc
</td>
<td style="text-align:right;">
0.0685805
</td>
<td style="text-align:right;">
92.0
</td>
<td style="text-align:right;">
1254
</td>
<td style="text-align:right;">
1340
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-500
</td>
<td style="text-align:left;">
cincinnati/hamilton county coc
</td>
<td style="text-align:right;">
0.0680729
</td>
<td style="text-align:right;">
93.0
</td>
<td style="text-align:right;">
1043
</td>
<td style="text-align:right;">
1114
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-515
</td>
<td style="text-align:left;">
fall river coc
</td>
<td style="text-align:right;">
0.0649718
</td>
<td style="text-align:right;">
94.0
</td>
<td style="text-align:right;">
354
</td>
<td style="text-align:right;">
377
</td>
</tr>
<tr>
<td style="text-align:left;">
az-502
</td>
<td style="text-align:left;">
phoenix, mesa/maricopa county coc
</td>
<td style="text-align:right;">
0.0642109
</td>
<td style="text-align:right;">
95.0
</td>
<td style="text-align:right;">
5918
</td>
<td style="text-align:right;">
6298
</td>
</tr>
<tr>
<td style="text-align:left;">
il-517
</td>
<td style="text-align:left;">
aurora, elgin/kane county coc
</td>
<td style="text-align:right;">
0.0617284
</td>
<td style="text-align:right;">
96.0
</td>
<td style="text-align:right;">
405
</td>
<td style="text-align:right;">
430
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-511
</td>
<td style="text-align:left;">
stockton/san joaquin county coc
</td>
<td style="text-align:right;">
0.0610831
</td>
<td style="text-align:right;">
97.0
</td>
<td style="text-align:right;">
1588
</td>
<td style="text-align:right;">
1685
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-500
</td>
<td style="text-align:left;">
san antonio/bexar county coc
</td>
<td style="text-align:right;">
0.0601660
</td>
<td style="text-align:right;">
98.0
</td>
<td style="text-align:right;">
2892
</td>
<td style="text-align:right;">
3066
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-524
</td>
<td style="text-align:left;">
yuba city & county/sutter county coc
</td>
<td style="text-align:right;">
0.0537190
</td>
<td style="text-align:right;">
99.0
</td>
<td style="text-align:right;">
726
</td>
<td style="text-align:right;">
765
</td>
</tr>
<tr>
<td style="text-align:left;">
nh-501
</td>
<td style="text-align:left;">
manchester coc
</td>
<td style="text-align:right;">
0.0491400
</td>
<td style="text-align:right;">
100.0
</td>
<td style="text-align:right;">
407
</td>
<td style="text-align:right;">
427
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-701
</td>
<td style="text-align:left;">
bryan, college station/brazos valley coc
</td>
<td style="text-align:right;">
0.0478723
</td>
<td style="text-align:right;">
101.0
</td>
<td style="text-align:right;">
188
</td>
<td style="text-align:right;">
197
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-506
</td>
<td style="text-align:left;">
jersey city, bayonne/hudson county coc
</td>
<td style="text-align:right;">
0.0475030
</td>
<td style="text-align:right;">
102.0
</td>
<td style="text-align:right;">
821
</td>
<td style="text-align:right;">
860
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-501
</td>
<td style="text-align:left;">
asheville/buncombe county coc
</td>
<td style="text-align:right;">
0.0452830
</td>
<td style="text-align:right;">
103.0
</td>
<td style="text-align:right;">
530
</td>
<td style="text-align:right;">
554
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-526
</td>
<td style="text-align:left;">
amador, calaveras, mariposa, tuolumne counties coc
</td>
<td style="text-align:right;">
0.0418848
</td>
<td style="text-align:right;">
104.0
</td>
<td style="text-align:right;">
382
</td>
<td style="text-align:right;">
398
</td>
</tr>
<tr>
<td style="text-align:left;">
il-509
</td>
<td style="text-align:left;">
dekalb city & county coc
</td>
<td style="text-align:right;">
0.0416667
</td>
<td style="text-align:right;">
105.0
</td>
<td style="text-align:right;">
96
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-506
</td>
<td style="text-align:left;">
wilmington/brunswick, new hanover, pender counties coc
</td>
<td style="text-align:right;">
0.0373832
</td>
<td style="text-align:right;">
106.0
</td>
<td style="text-align:right;">
321
</td>
<td style="text-align:right;">
333
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-500
</td>
<td style="text-align:left;">
boston coc
</td>
<td style="text-align:right;">
0.0335727
</td>
<td style="text-align:right;">
107.0
</td>
<td style="text-align:right;">
5987
</td>
<td style="text-align:right;">
6188
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-506
</td>
<td style="text-align:left;">
worcester city & county coc
</td>
<td style="text-align:right;">
0.0311804
</td>
<td style="text-align:right;">
108.0
</td>
<td style="text-align:right;">
1796
</td>
<td style="text-align:right;">
1852
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-502
</td>
<td style="text-align:left;">
rochester/southeast minnesota coc
</td>
<td style="text-align:right;">
0.0311203
</td>
<td style="text-align:right;">
109.0
</td>
<td style="text-align:right;">
482
</td>
<td style="text-align:right;">
497
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-503
</td>
<td style="text-align:left;">
lakeland, winterhaven/polk county coc
</td>
<td style="text-align:right;">
0.0298507
</td>
<td style="text-align:right;">
110.0
</td>
<td style="text-align:right;">
536
</td>
<td style="text-align:right;">
552
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-504
</td>
<td style="text-align:left;">
nashville-davidson county coc
</td>
<td style="text-align:right;">
0.0286482
</td>
<td style="text-align:right;">
111.0
</td>
<td style="text-align:right;">
2234
</td>
<td style="text-align:right;">
2298
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-505
</td>
<td style="text-align:left;">
northeast oklahoma coc
</td>
<td style="text-align:right;">
0.0234987
</td>
<td style="text-align:right;">
112.0
</td>
<td style="text-align:right;">
383
</td>
<td style="text-align:right;">
392
</td>
</tr>
<tr>
<td style="text-align:left;">
or-501
</td>
<td style="text-align:left;">
portland, gresham/multnomah county coc
</td>
<td style="text-align:right;">
0.0234276
</td>
<td style="text-align:right;">
113.0
</td>
<td style="text-align:right;">
3927
</td>
<td style="text-align:right;">
4019
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-509
</td>
<td style="text-align:left;">
morris county coc
</td>
<td style="text-align:right;">
0.0231362
</td>
<td style="text-align:right;">
114.0
</td>
<td style="text-align:right;">
389
</td>
<td style="text-align:right;">
398
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-603
</td>
<td style="text-align:left;">
st. joseph/andrew, buchanan, dekalb counties coc
</td>
<td style="text-align:right;">
0.0200000
</td>
<td style="text-align:right;">
115.0
</td>
<td style="text-align:right;">
200
</td>
<td style="text-align:right;">
204
</td>
</tr>
<tr>
<td style="text-align:left;">
al-507
</td>
<td style="text-align:left;">
alabama balance of state coc
</td>
<td style="text-align:right;">
0.0195531
</td>
<td style="text-align:right;">
116.0
</td>
<td style="text-align:right;">
716
</td>
<td style="text-align:right;">
730
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-509
</td>
<td style="text-align:left;">
cambridge coc
</td>
<td style="text-align:right;">
0.0181488
</td>
<td style="text-align:right;">
117.0
</td>
<td style="text-align:right;">
551
</td>
<td style="text-align:right;">
561
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-607
</td>
<td style="text-align:left;">
pasadena coc
</td>
<td style="text-align:right;">
0.0165165
</td>
<td style="text-align:right;">
118.0
</td>
<td style="text-align:right;">
666
</td>
<td style="text-align:right;">
677
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-521
</td>
<td style="text-align:left;">
davis, woodland/yolo county coc
</td>
<td style="text-align:right;">
0.0135747
</td>
<td style="text-align:right;">
119.0
</td>
<td style="text-align:right;">
442
</td>
<td style="text-align:right;">
448
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-500
</td>
<td style="text-align:left;">
philadelphia coc
</td>
<td style="text-align:right;">
0.0087138
</td>
<td style="text-align:right;">
120.0
</td>
<td style="text-align:right;">
5738
</td>
<td style="text-align:right;">
5788
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-601
</td>
<td style="text-align:left;">
san diego city and county coc
</td>
<td style="text-align:right;">
0.0082295
</td>
<td style="text-align:right;">
121.0
</td>
<td style="text-align:right;">
8506
</td>
<td style="text-align:right;">
8576
</td>
</tr>
<tr>
<td style="text-align:left;">
il-513
</td>
<td style="text-align:left;">
springfield/sangamon county coc
</td>
<td style="text-align:right;">
0.0074349
</td>
<td style="text-align:right;">
122.0
</td>
<td style="text-align:right;">
269
</td>
<td style="text-align:right;">
271
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-500
</td>
<td style="text-align:left;">
little rock/central arkansas coc
</td>
<td style="text-align:right;">
0.0065177
</td>
<td style="text-align:right;">
123.0
</td>
<td style="text-align:right;">
1074
</td>
<td style="text-align:right;">
1081
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-505
</td>
<td style="text-align:left;">
overland park, shawnee/johnson county coc
</td>
<td style="text-align:right;">
0.0059880
</td>
<td style="text-align:right;">
124.0
</td>
<td style="text-align:right;">
167
</td>
<td style="text-align:right;">
168
</td>
</tr>
<tr>
<td style="text-align:left;">
id-500
</td>
<td style="text-align:left;">
boise/ada county coc
</td>
<td style="text-align:right;">
0.0039841
</td>
<td style="text-align:right;">
125.0
</td>
<td style="text-align:right;">
753
</td>
<td style="text-align:right;">
756
</td>
</tr>
<tr>
<td style="text-align:left;">
nh-502
</td>
<td style="text-align:left;">
nashua/hillsborough county coc
</td>
<td style="text-align:right;">
0.0035714
</td>
<td style="text-align:right;">
126.0
</td>
<td style="text-align:right;">
280
</td>
<td style="text-align:right;">
281
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-504
</td>
<td style="text-align:left;">
cattaragus county coc
</td>
<td style="text-align:right;">
0.0000000
</td>
<td style="text-align:right;">
127.0
</td>
<td style="text-align:right;">
33
</td>
<td style="text-align:right;">
33
</td>
</tr>
<tr>
<td style="text-align:left;">
ne-500
</td>
<td style="text-align:left;">
nebraska balance of state coc
</td>
<td style="text-align:right;">
-0.0017857
</td>
<td style="text-align:right;">
128.0
</td>
<td style="text-align:right;">
560
</td>
<td style="text-align:right;">
559
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-500
</td>
<td style="text-align:left;">
rochester, irondequoit, greece/monroe county coc
</td>
<td style="text-align:right;">
-0.0035800
</td>
<td style="text-align:right;">
129.0
</td>
<td style="text-align:right;">
838
</td>
<td style="text-align:right;">
835
</td>
</tr>
<tr>
<td style="text-align:left;">
va-514
</td>
<td style="text-align:left;">
fredericksburg/spotsylvania, stafford counties coc
</td>
<td style="text-align:right;">
-0.0049751
</td>
<td style="text-align:right;">
130.0
</td>
<td style="text-align:right;">
201
</td>
<td style="text-align:right;">
200
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-500
</td>
<td style="text-align:left;">
chattanooga/southeast tennessee coc
</td>
<td style="text-align:right;">
-0.0063796
</td>
<td style="text-align:right;">
131.0
</td>
<td style="text-align:right;">
627
</td>
<td style="text-align:right;">
623
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-509
</td>
<td style="text-align:left;">
duluth/st.louis county coc
</td>
<td style="text-align:right;">
-0.0093240
</td>
<td style="text-align:right;">
132.0
</td>
<td style="text-align:right;">
429
</td>
<td style="text-align:right;">
425
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-601
</td>
<td style="text-align:left;">
poughkeepsie/dutchess county coc
</td>
<td style="text-align:right;">
-0.0099256
</td>
<td style="text-align:right;">
133.0
</td>
<td style="text-align:right;">
403
</td>
<td style="text-align:right;">
399
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-509
</td>
<td style="text-align:left;">
eastern pennsylvania coc
</td>
<td style="text-align:right;">
-0.0113805
</td>
<td style="text-align:right;">
134.0
</td>
<td style="text-align:right;">
2021
</td>
<td style="text-align:right;">
1998
</td>
</tr>
<tr>
<td style="text-align:left;">
md-504
</td>
<td style="text-align:left;">
howard county coc
</td>
<td style="text-align:right;">
-0.0117647
</td>
<td style="text-align:right;">
135.0
</td>
<td style="text-align:right;">
170
</td>
<td style="text-align:right;">
168
</td>
</tr>
<tr>
<td style="text-align:left;">
il-507
</td>
<td style="text-align:left;">
peoria, pekin/fulton, tazewell, peoria, woodford counties coc
</td>
<td style="text-align:right;">
-0.0123457
</td>
<td style="text-align:right;">
136.0
</td>
<td style="text-align:right;">
405
</td>
<td style="text-align:right;">
400
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-523
</td>
<td style="text-align:left;">
glens falls, saratoga springs/saratoga, washington, warren, hamilton
counties co
</td>
<td style="text-align:right;">
-0.0190840
</td>
<td style="text-align:right;">
137.0
</td>
<td style="text-align:right;">
262
</td>
<td style="text-align:right;">
257
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-503
</td>
<td style="text-align:left;">
topeka/shawnee county coc
</td>
<td style="text-align:right;">
-0.0192308
</td>
<td style="text-align:right;">
138.0
</td>
<td style="text-align:right;">
416
</td>
<td style="text-align:right;">
408
</td>
</tr>
<tr>
<td style="text-align:left;">
md-501
</td>
<td style="text-align:left;">
baltimore coc
</td>
<td style="text-align:right;">
-0.0229840
</td>
<td style="text-align:right;">
139.0
</td>
<td style="text-align:right;">
2567
</td>
<td style="text-align:right;">
2508
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-508
</td>
<td style="text-align:left;">
lansing, east lansing/ingham county coc
</td>
<td style="text-align:right;">
-0.0233100
</td>
<td style="text-align:right;">
140.0
</td>
<td style="text-align:right;">
429
</td>
<td style="text-align:right;">
419
</td>
</tr>
<tr>
<td style="text-align:left;">
or-506
</td>
<td style="text-align:left;">
hillsboro, beaverton/washington county coc
</td>
<td style="text-align:right;">
-0.0279330
</td>
<td style="text-align:right;">
141.0
</td>
<td style="text-align:right;">
537
</td>
<td style="text-align:right;">
522
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-523
</td>
<td style="text-align:left;">
eaton county coc
</td>
<td style="text-align:right;">
-0.0317460
</td>
<td style="text-align:right;">
142.0
</td>
<td style="text-align:right;">
126
</td>
<td style="text-align:right;">
122
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-505
</td>
<td style="text-align:left;">
st. cloud/central minnesota coc
</td>
<td style="text-align:right;">
-0.0378913
</td>
<td style="text-align:right;">
143.0
</td>
<td style="text-align:right;">
607
</td>
<td style="text-align:right;">
584
</td>
</tr>
<tr>
<td style="text-align:left;">
ct-505
</td>
<td style="text-align:left;">
connecticut balance of state coc
</td>
<td style="text-align:right;">
-0.0392040
</td>
<td style="text-align:right;">
144.0
</td>
<td style="text-align:right;">
3367
</td>
<td style="text-align:right;">
3235
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-500
</td>
<td style="text-align:left;">
san jose/santa clara city & county coc
</td>
<td style="text-align:right;">
-0.0413638
</td>
<td style="text-align:right;">
145.0
</td>
<td style="text-align:right;">
7567
</td>
<td style="text-align:right;">
7254
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-501
</td>
<td style="text-align:left;">
bergen county coc
</td>
<td style="text-align:right;">
-0.0458221
</td>
<td style="text-align:right;">
146.0
</td>
<td style="text-align:right;">
371
</td>
<td style="text-align:right;">
354
</td>
</tr>
<tr>
<td style="text-align:left;">
hi-501
</td>
<td style="text-align:left;">
honolulu city and county coc
</td>
<td style="text-align:right;">
-0.0460526
</td>
<td style="text-align:right;">
147.0
</td>
<td style="text-align:right;">
4712
</td>
<td style="text-align:right;">
4495
</td>
</tr>
<tr>
<td style="text-align:left;">
md-503
</td>
<td style="text-align:left;">
annapolis/anne arundel county coc
</td>
<td style="text-align:right;">
-0.0468750
</td>
<td style="text-align:right;">
148.0
</td>
<td style="text-align:right;">
384
</td>
<td style="text-align:right;">
366
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-501
</td>
<td style="text-align:left;">
saint paul/ramsey county coc
</td>
<td style="text-align:right;">
-0.0506667
</td>
<td style="text-align:right;">
149.0
</td>
<td style="text-align:right;">
1500
</td>
<td style="text-align:right;">
1424
</td>
</tr>
<tr>
<td style="text-align:left;">
md-601
</td>
<td style="text-align:left;">
montgomery county coc
</td>
<td style="text-align:right;">
-0.0572391
</td>
<td style="text-align:right;">
150.0
</td>
<td style="text-align:right;">
891
</td>
<td style="text-align:right;">
840
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-503
</td>
<td style="text-align:left;">
cape cod islands coc
</td>
<td style="text-align:right;">
-0.0603675
</td>
<td style="text-align:right;">
151.0
</td>
<td style="text-align:right;">
381
</td>
<td style="text-align:right;">
358
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-503
</td>
<td style="text-align:left;">
central tennessee coc
</td>
<td style="text-align:right;">
-0.0629371
</td>
<td style="text-align:right;">
152.0
</td>
<td style="text-align:right;">
286
</td>
<td style="text-align:right;">
268
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-519
</td>
<td style="text-align:left;">
attleboro, taunton/bristol county coc
</td>
<td style="text-align:right;">
-0.0630631
</td>
<td style="text-align:right;">
153.0
</td>
<td style="text-align:right;">
222
</td>
<td style="text-align:right;">
208
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-503
</td>
<td style="text-align:left;">
north carolina balance of state coc
</td>
<td style="text-align:right;">
-0.0638498
</td>
<td style="text-align:right;">
154.0
</td>
<td style="text-align:right;">
3195
</td>
<td style="text-align:right;">
2991
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-504
</td>
<td style="text-align:left;">
pontiac, royal oak/oakland county coc
</td>
<td style="text-align:right;">
-0.0656455
</td>
<td style="text-align:right;">
155.0
</td>
<td style="text-align:right;">
457
</td>
<td style="text-align:right;">
427
</td>
</tr>
<tr>
<td style="text-align:left;">
ky-500
</td>
<td style="text-align:left;">
kentucky balance of state coc
</td>
<td style="text-align:right;">
-0.0681920
</td>
<td style="text-align:right;">
156.0
</td>
<td style="text-align:right;">
2229
</td>
<td style="text-align:right;">
2077
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-603
</td>
<td style="text-align:left;">
santa maria/santa barbara county coc
</td>
<td style="text-align:right;">
-0.0687773
</td>
<td style="text-align:right;">
157.0
</td>
<td style="text-align:right;">
1832
</td>
<td style="text-align:right;">
1706
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-506
</td>
<td style="text-align:left;">
reading/berks county coc
</td>
<td style="text-align:right;">
-0.0695364
</td>
<td style="text-align:right;">
158.0
</td>
<td style="text-align:right;">
604
</td>
<td style="text-align:right;">
562
</td>
</tr>
<tr>
<td style="text-align:left;">
id-501
</td>
<td style="text-align:left;">
idaho balance of state coc
</td>
<td style="text-align:right;">
-0.0703183
</td>
<td style="text-align:right;">
159.0
</td>
<td style="text-align:right;">
1351
</td>
<td style="text-align:right;">
1256
</td>
</tr>
<tr>
<td style="text-align:left;">
or-500
</td>
<td style="text-align:left;">
eugene, springfield/lane county coc
</td>
<td style="text-align:right;">
-0.0713073
</td>
<td style="text-align:right;">
160.0
</td>
<td style="text-align:right;">
1767
</td>
<td style="text-align:right;">
1641
</td>
</tr>
<tr>
<td style="text-align:left;">
ri-500
</td>
<td style="text-align:left;">
rhode island statewide coc
</td>
<td style="text-align:right;">
-0.0747899
</td>
<td style="text-align:right;">
161.0
</td>
<td style="text-align:right;">
1190
</td>
<td style="text-align:right;">
1101
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-501
</td>
<td style="text-align:left;">
tampa/hillsborough county coc
</td>
<td style="text-align:right;">
-0.0766461
</td>
<td style="text-align:right;">
162.0
</td>
<td style="text-align:right;">
1944
</td>
<td style="text-align:right;">
1795
</td>
</tr>
<tr>
<td style="text-align:left;">
me-500
</td>
<td style="text-align:left;">
maine statewide coc
</td>
<td style="text-align:right;">
-0.0770360
</td>
<td style="text-align:right;">
163.0
</td>
<td style="text-align:right;">
2726
</td>
<td style="text-align:right;">
2516
</td>
</tr>
<tr>
<td style="text-align:left;">
hi-500
</td>
<td style="text-align:left;">
hawaii balance of state coc
</td>
<td style="text-align:right;">
-0.0775159
</td>
<td style="text-align:right;">
164.0
</td>
<td style="text-align:right;">
2206
</td>
<td style="text-align:right;">
2035
</td>
</tr>
<tr>
<td style="text-align:left;">
al-501
</td>
<td style="text-align:left;">
mobile city & county/baldwin county coc
</td>
<td style="text-align:right;">
-0.0785953
</td>
<td style="text-align:right;">
165.0
</td>
<td style="text-align:right;">
598
</td>
<td style="text-align:right;">
551
</td>
</tr>
<tr>
<td style="text-align:left;">
il-503
</td>
<td style="text-align:left;">
champaign, urbana, rantoul/champaign county coc
</td>
<td style="text-align:right;">
-0.0829268
</td>
<td style="text-align:right;">
166.0
</td>
<td style="text-align:right;">
205
</td>
<td style="text-align:right;">
188
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-506
</td>
<td style="text-align:left;">
northwest minnesota coc
</td>
<td style="text-align:right;">
-0.0836120
</td>
<td style="text-align:right;">
167.0
</td>
<td style="text-align:right;">
299
</td>
<td style="text-align:right;">
274
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-611
</td>
<td style="text-align:left;">
oxnard, san buenaventura/ventura county coc
</td>
<td style="text-align:right;">
-0.0840336
</td>
<td style="text-align:right;">
168.0
</td>
<td style="text-align:right;">
1428
</td>
<td style="text-align:right;">
1308
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-609
</td>
<td style="text-align:left;">
san bernardino city & county coc
</td>
<td style="text-align:right;">
-0.0850972
</td>
<td style="text-align:right;">
169.0
</td>
<td style="text-align:right;">
2315
</td>
<td style="text-align:right;">
2118
</td>
</tr>
<tr>
<td style="text-align:left;">
az-500
</td>
<td style="text-align:left;">
arizona balance of state coc
</td>
<td style="text-align:right;">
-0.0879900
</td>
<td style="text-align:right;">
170.0
</td>
<td style="text-align:right;">
2398
</td>
<td style="text-align:right;">
2187
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-506
</td>
<td style="text-align:left;">
grand rapids, wyoming/kent county coc
</td>
<td style="text-align:right;">
-0.0882724
</td>
<td style="text-align:right;">
171.0
</td>
<td style="text-align:right;">
793
</td>
<td style="text-align:right;">
723
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-507
</td>
<td style="text-align:left;">
orlando/orange, osceola, seminole counties coc
</td>
<td style="text-align:right;">
-0.0891748
</td>
<td style="text-align:right;">
172.0
</td>
<td style="text-align:right;">
2254
</td>
<td style="text-align:right;">
2053
</td>
</tr>
<tr>
<td style="text-align:left;">
il-518
</td>
<td style="text-align:left;">
rock island, moline/northwestern illinois coc
</td>
<td style="text-align:right;">
-0.0917431
</td>
<td style="text-align:right;">
173.0
</td>
<td style="text-align:right;">
218
</td>
<td style="text-align:right;">
198
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-502
</td>
<td style="text-align:left;">
wichita/sedgwick county coc
</td>
<td style="text-align:right;">
-0.0919176
</td>
<td style="text-align:right;">
174.0
</td>
<td style="text-align:right;">
631
</td>
<td style="text-align:right;">
573
</td>
</tr>
<tr>
<td style="text-align:left;">
vt-500
</td>
<td style="text-align:left;">
vermont balance of state coc
</td>
<td style="text-align:right;">
-0.0925024
</td>
<td style="text-align:right;">
175.0
</td>
<td style="text-align:right;">
1027
</td>
<td style="text-align:right;">
932
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-504
</td>
<td style="text-align:left;">
everett/snohomish county coc
</td>
<td style="text-align:right;">
-0.0958904
</td>
<td style="text-align:right;">
176.0
</td>
<td style="text-align:right;">
949
</td>
<td style="text-align:right;">
858
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-500
</td>
<td style="text-align:left;">
north central oklahoma coc
</td>
<td style="text-align:right;">
-0.0995025
</td>
<td style="text-align:right;">
177.0
</td>
<td style="text-align:right;">
201
</td>
<td style="text-align:right;">
181
</td>
</tr>
<tr>
<td style="text-align:left;">
va-504
</td>
<td style="text-align:left;">
charlottesville coc
</td>
<td style="text-align:right;">
-0.1029412
</td>
<td style="text-align:right;">
178.0
</td>
<td style="text-align:right;">
204
</td>
<td style="text-align:right;">
183
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-604
</td>
<td style="text-align:left;">
bakersfield/kern county coc
</td>
<td style="text-align:right;">
-0.1078629
</td>
<td style="text-align:right;">
179.0
</td>
<td style="text-align:right;">
992
</td>
<td style="text-align:right;">
885
</td>
</tr>
<tr>
<td style="text-align:left;">
dc-500
</td>
<td style="text-align:left;">
district of columbia coc
</td>
<td style="text-align:right;">
-0.1089313
</td>
<td style="text-align:right;">
180.0
</td>
<td style="text-align:right;">
7748
</td>
<td style="text-align:right;">
6904
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-612
</td>
<td style="text-align:left;">
glendale coc
</td>
<td style="text-align:right;">
-0.1095890
</td>
<td style="text-align:right;">
181.0
</td>
<td style="text-align:right;">
292
</td>
<td style="text-align:right;">
260
</td>
</tr>
<tr>
<td style="text-align:left;">
in-503
</td>
<td style="text-align:left;">
indianapolis coc
</td>
<td style="text-align:right;">
-0.1100529
</td>
<td style="text-align:right;">
182.0
</td>
<td style="text-align:right;">
1890
</td>
<td style="text-align:right;">
1682
</td>
</tr>
<tr>
<td style="text-align:left;">
ia-500
</td>
<td style="text-align:left;">
sioux city/dakota, woodbury counties coc
</td>
<td style="text-align:right;">
-0.1111111
</td>
<td style="text-align:right;">
183.0
</td>
<td style="text-align:right;">
297
</td>
<td style="text-align:right;">
264
</td>
</tr>
<tr>
<td style="text-align:left;">
ia-501
</td>
<td style="text-align:left;">
iowa balance of state coc
</td>
<td style="text-align:right;">
-0.1124291
</td>
<td style="text-align:right;">
184.0
</td>
<td style="text-align:right;">
1939
</td>
<td style="text-align:right;">
1721
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-505
</td>
<td style="text-align:left;">
columbus-muscogee/russell county coc
</td>
<td style="text-align:right;">
-0.1153846
</td>
<td style="text-align:right;">
185.0
</td>
<td style="text-align:right;">
312
</td>
<td style="text-align:right;">
276
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-500
</td>
<td style="text-align:left;">
wisconsin balance of state coc
</td>
<td style="text-align:right;">
-0.1182404
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
3569
</td>
<td style="text-align:right;">
3147
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-503
</td>
<td style="text-align:left;">
charleston/kanawha, putnam, boone, clay counties coc
</td>
<td style="text-align:right;">
-0.1194444
</td>
<td style="text-align:right;">
187.0
</td>
<td style="text-align:right;">
360
</td>
<td style="text-align:right;">
317
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-606
</td>
<td style="text-align:left;">
missouri balance of state coc
</td>
<td style="text-align:right;">
-0.1197644
</td>
<td style="text-align:right;">
188.0
</td>
<td style="text-align:right;">
1528
</td>
<td style="text-align:right;">
1345
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-508
</td>
<td style="text-align:left;">
buffalo, niagara falls/erie, niagara, orleans, genesee, wyoming counties
coc
</td>
<td style="text-align:right;">
-0.1204044
</td>
<td style="text-align:right;">
189.0
</td>
<td style="text-align:right;">
1088
</td>
<td style="text-align:right;">
957
</td>
</tr>
<tr>
<td style="text-align:left;">
in-502
</td>
<td style="text-align:left;">
indiana balance of state coc
</td>
<td style="text-align:right;">
-0.1237442
</td>
<td style="text-align:right;">
190.0
</td>
<td style="text-align:right;">
4081
</td>
<td style="text-align:right;">
3576
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-510
</td>
<td style="text-align:left;">
jacksonville-duval, clay counties coc
</td>
<td style="text-align:right;">
-0.1244510
</td>
<td style="text-align:right;">
191.0
</td>
<td style="text-align:right;">
2049
</td>
<td style="text-align:right;">
1794
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-513
</td>
<td style="text-align:left;">
marquette, alger counties coc
</td>
<td style="text-align:right;">
-0.1250000
</td>
<td style="text-align:right;">
192.0
</td>
<td style="text-align:right;">
80
</td>
<td style="text-align:right;">
70
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-500
</td>
<td style="text-align:left;">
charleston/low country coc
</td>
<td style="text-align:right;">
-0.1259690
</td>
<td style="text-align:right;">
193.0
</td>
<td style="text-align:right;">
516
</td>
<td style="text-align:right;">
451
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-602
</td>
<td style="text-align:left;">
joplin/jasper, newton counties coc
</td>
<td style="text-align:right;">
-0.1269841
</td>
<td style="text-align:right;">
194.0
</td>
<td style="text-align:right;">
315
</td>
<td style="text-align:right;">
275
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-518
</td>
<td style="text-align:left;">
vallejo/solano county coc
</td>
<td style="text-align:right;">
-0.1281853
</td>
<td style="text-align:right;">
195.0
</td>
<td style="text-align:right;">
1295
</td>
<td style="text-align:right;">
1129
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-501
</td>
<td style="text-align:left;">
huntington/cabell, wayne counties coc
</td>
<td style="text-align:right;">
-0.1284404
</td>
<td style="text-align:right;">
196.0
</td>
<td style="text-align:right;">
218
</td>
<td style="text-align:right;">
190
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-517
</td>
<td style="text-align:left;">
somerville coc
</td>
<td style="text-align:right;">
-0.1298701
</td>
<td style="text-align:right;">
197.0
</td>
<td style="text-align:right;">
154
</td>
<td style="text-align:right;">
134
</td>
</tr>
<tr>
<td style="text-align:left;">
md-513
</td>
<td style="text-align:left;">
wicomico, somerset, worcester counties coc
</td>
<td style="text-align:right;">
-0.1309524
</td>
<td style="text-align:right;">
198.0
</td>
<td style="text-align:right;">
336
</td>
<td style="text-align:right;">
292
</td>
</tr>
<tr>
<td style="text-align:left;">
il-520
</td>
<td style="text-align:left;">
southern illinois coc
</td>
<td style="text-align:right;">
-0.1323077
</td>
<td style="text-align:right;">
199.0
</td>
<td style="text-align:right;">
325
</td>
<td style="text-align:right;">
282
</td>
</tr>
<tr>
<td style="text-align:left;">
il-510
</td>
<td style="text-align:left;">
chicago coc
</td>
<td style="text-align:right;">
-0.1331319
</td>
<td style="text-align:right;">
200.0
</td>
<td style="text-align:right;">
6287
</td>
<td style="text-align:right;">
5450
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-500
</td>
<td style="text-align:left;">
sarasota, bradenton/manatee, sarasota counties coc
</td>
<td style="text-align:right;">
-0.1343500
</td>
<td style="text-align:right;">
201.0
</td>
<td style="text-align:right;">
1377
</td>
<td style="text-align:right;">
1192
</td>
</tr>
<tr>
<td style="text-align:left;">
ne-501
</td>
<td style="text-align:left;">
omaha, council bluffs coc
</td>
<td style="text-align:right;">
-0.1343558
</td>
<td style="text-align:right;">
202.0
</td>
<td style="text-align:right;">
1630
</td>
<td style="text-align:right;">
1411
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-507
</td>
<td style="text-align:left;">
pittsfield/berkshire, franklin, hampshire counties coc
</td>
<td style="text-align:right;">
-0.1354582
</td>
<td style="text-align:right;">
203.0
</td>
<td style="text-align:right;">
753
</td>
<td style="text-align:right;">
651
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-502
</td>
<td style="text-align:left;">
knoxville/knox county coc
</td>
<td style="text-align:right;">
-0.1370499
</td>
<td style="text-align:right;">
204.0
</td>
<td style="text-align:right;">
861
</td>
<td style="text-align:right;">
743
</td>
</tr>
<tr>
<td style="text-align:left;">
ia-502
</td>
<td style="text-align:left;">
des moines/polk county coc
</td>
<td style="text-align:right;">
-0.1376975
</td>
<td style="text-align:right;">
205.0
</td>
<td style="text-align:right;">
886
</td>
<td style="text-align:right;">
764
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-501
</td>
<td style="text-align:left;">
fayetteville/northwest arkansas coc
</td>
<td style="text-align:right;">
-0.1397459
</td>
<td style="text-align:right;">
206.0
</td>
<td style="text-align:right;">
551
</td>
<td style="text-align:right;">
474
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-502
</td>
<td style="text-align:left;">
cleveland/cuyahoga county coc
</td>
<td style="text-align:right;">
-0.1402758
</td>
<td style="text-align:right;">
207.0
</td>
<td style="text-align:right;">
2103
</td>
<td style="text-align:right;">
1808
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-505
</td>
<td style="text-align:left;">
dayton, kettering/montgomery county coc
</td>
<td style="text-align:right;">
-0.1403287
</td>
<td style="text-align:right;">
208.0
</td>
<td style="text-align:right;">
791
</td>
<td style="text-align:right;">
680
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-503
</td>
<td style="text-align:left;">
wilkes-barre, hazleton/luzerne county coc
</td>
<td style="text-align:right;">
-0.1406250
</td>
<td style="text-align:right;">
209.0
</td>
<td style="text-align:right;">
192
</td>
<td style="text-align:right;">
165
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-503
</td>
<td style="text-align:left;">
athens-clarke county coc
</td>
<td style="text-align:right;">
-0.1417004
</td>
<td style="text-align:right;">
210.0
</td>
<td style="text-align:right;">
247
</td>
<td style="text-align:right;">
212
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-512
</td>
<td style="text-align:left;">
morristown/blount, sevier, campbell, cocke counties coc
</td>
<td style="text-align:right;">
-0.1446945
</td>
<td style="text-align:right;">
211.0
</td>
<td style="text-align:right;">
933
</td>
<td style="text-align:right;">
798
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-604
</td>
<td style="text-align:left;">
yonkers, mount vernon/westchester county coc
</td>
<td style="text-align:right;">
-0.1454630
</td>
<td style="text-align:right;">
212.0
</td>
<td style="text-align:right;">
2138
</td>
<td style="text-align:right;">
1827
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-500
</td>
<td style="text-align:left;">
winston-salem/forsyth county coc
</td>
<td style="text-align:right;">
-0.1456311
</td>
<td style="text-align:right;">
213.0
</td>
<td style="text-align:right;">
515
</td>
<td style="text-align:right;">
440
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-505
</td>
<td style="text-align:left;">
chester county coc
</td>
<td style="text-align:right;">
-0.1472754
</td>
<td style="text-align:right;">
214.0
</td>
<td style="text-align:right;">
679
</td>
<td style="text-align:right;">
579
</td>
</tr>
<tr>
<td style="text-align:left;">
md-502
</td>
<td style="text-align:left;">
harford county coc
</td>
<td style="text-align:right;">
-0.1479821
</td>
<td style="text-align:right;">
215.0
</td>
<td style="text-align:right;">
223
</td>
<td style="text-align:right;">
190
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-503
</td>
<td style="text-align:left;">
dakota, anoka, washington, scott, carver counties
</td>
<td style="text-align:right;">
-0.1496599
</td>
<td style="text-align:right;">
216.0
</td>
<td style="text-align:right;">
735
</td>
<td style="text-align:right;">
625
</td>
</tr>
<tr>
<td style="text-align:left;">
la-505
</td>
<td style="text-align:left;">
monroe/northeast louisiana coc
</td>
<td style="text-align:right;">
-0.1500000
</td>
<td style="text-align:right;">
217.0
</td>
<td style="text-align:right;">
220
</td>
<td style="text-align:right;">
187
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-511
</td>
<td style="text-align:left;">
lenawee county coc
</td>
<td style="text-align:right;">
-0.1521739
</td>
<td style="text-align:right;">
218.0
</td>
<td style="text-align:right;">
138
</td>
<td style="text-align:right;">
117
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-624
</td>
<td style="text-align:left;">
wichita falls/wise, palo pinto, wichita, archer counties coc
</td>
<td style="text-align:right;">
-0.1530249
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
281
</td>
<td style="text-align:right;">
238
</td>
</tr>
<tr>
<td style="text-align:left;">
va-603
</td>
<td style="text-align:left;">
alexandria coc
</td>
<td style="text-align:right;">
-0.1535581
</td>
<td style="text-align:right;">
220.0
</td>
<td style="text-align:right;">
267
</td>
<td style="text-align:right;">
226
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-600
</td>
<td style="text-align:left;">
miami-dade county coc
</td>
<td style="text-align:right;">
-0.1539942
</td>
<td style="text-align:right;">
221.0
</td>
<td style="text-align:right;">
4156
</td>
<td style="text-align:right;">
3516
</td>
</tr>
<tr>
<td style="text-align:left;">
wy-500
</td>
<td style="text-align:left;">
wyoming statewide coc
</td>
<td style="text-align:right;">
-0.1558785
</td>
<td style="text-align:right;">
222.0
</td>
<td style="text-align:right;">
757
</td>
<td style="text-align:right;">
639
</td>
</tr>
<tr>
<td style="text-align:left;">
va-507
</td>
<td style="text-align:left;">
portsmouth coc
</td>
<td style="text-align:right;">
-0.1562500
</td>
<td style="text-align:right;">
223.0
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
135
</td>
</tr>
<tr>
<td style="text-align:left;">
va-604
</td>
<td style="text-align:left;">
prince william county coc
</td>
<td style="text-align:right;">
-0.1595506
</td>
<td style="text-align:right;">
224.0
</td>
<td style="text-align:right;">
445
</td>
<td style="text-align:right;">
374
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-507
</td>
<td style="text-align:left;">
raleigh/wake county coc
</td>
<td style="text-align:right;">
-0.1598291
</td>
<td style="text-align:right;">
225.0
</td>
<td style="text-align:right;">
1170
</td>
<td style="text-align:right;">
983
</td>
</tr>
<tr>
<td style="text-align:left;">
ut-500
</td>
<td style="text-align:left;">
salt lake city & county coc
</td>
<td style="text-align:right;">
-0.1609302
</td>
<td style="text-align:right;">
226.0
</td>
<td style="text-align:right;">
2150
</td>
<td style="text-align:right;">
1804
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-601
</td>
<td style="text-align:left;">
ft lauderdale/broward county coc
</td>
<td style="text-align:right;">
-0.1619667
</td>
<td style="text-align:right;">
227.0
</td>
<td style="text-align:right;">
2766
</td>
<td style="text-align:right;">
2318
</td>
</tr>
<tr>
<td style="text-align:left;">
va-505
</td>
<td style="text-align:left;">
newport news, hampton/virginia peninsula coc
</td>
<td style="text-align:right;">
-0.1638095
</td>
<td style="text-align:right;">
228.0
</td>
<td style="text-align:right;">
525
</td>
<td style="text-align:right;">
439
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-603
</td>
<td style="text-align:left;">
ft myers, cape coral/lee county coc
</td>
<td style="text-align:right;">
-0.1641791
</td>
<td style="text-align:right;">
229.0
</td>
<td style="text-align:right;">
871
</td>
<td style="text-align:right;">
728
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-507
</td>
<td style="text-align:left;">
portage, kalamazoo city & county coc
</td>
<td style="text-align:right;">
-0.1674009
</td>
<td style="text-align:right;">
230.0
</td>
<td style="text-align:right;">
681
</td>
<td style="text-align:right;">
567
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-514
</td>
<td style="text-align:left;">
battle creek/calhoun county coc
</td>
<td style="text-align:right;">
-0.1690141
</td>
<td style="text-align:right;">
231.0
</td>
<td style="text-align:right;">
284
</td>
<td style="text-align:right;">
236
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-601
</td>
<td style="text-align:left;">
fort worth, arlington/tarrant county coc
</td>
<td style="text-align:right;">
-0.1690722
</td>
<td style="text-align:right;">
232.0
</td>
<td style="text-align:right;">
2425
</td>
<td style="text-align:right;">
2015
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-503
</td>
<td style="text-align:left;">
myrtle beach, sumter city & county coc
</td>
<td style="text-align:right;">
-0.1708428
</td>
<td style="text-align:right;">
233.0
</td>
<td style="text-align:right;">
1317
</td>
<td style="text-align:right;">
1092
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-505
</td>
<td style="text-align:left;">
charlotte/mecklenberg coc
</td>
<td style="text-align:right;">
-0.1717974
</td>
<td style="text-align:right;">
234.0
</td>
<td style="text-align:right;">
2014
</td>
<td style="text-align:right;">
1668
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-514
</td>
<td style="text-align:left;">
fresno city & county/madera county coc
</td>
<td style="text-align:right;">
-0.1728395
</td>
<td style="text-align:right;">
235.0
</td>
<td style="text-align:right;">
2592
</td>
<td style="text-align:right;">
2144
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-512
</td>
<td style="text-align:left;">
troy/rensselaer county coc
</td>
<td style="text-align:right;">
-0.1759259
</td>
<td style="text-align:right;">
236.0
</td>
<td style="text-align:right;">
216
</td>
<td style="text-align:right;">
178
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-502
</td>
<td style="text-align:left;">
burlington county coc
</td>
<td style="text-align:right;">
-0.1764706
</td>
<td style="text-align:right;">
237.5
</td>
<td style="text-align:right;">
1020
</td>
<td style="text-align:right;">
840
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-605
</td>
<td style="text-align:left;">
erie city & county coc
</td>
<td style="text-align:right;">
-0.1764706
</td>
<td style="text-align:right;">
237.5
</td>
<td style="text-align:right;">
408
</td>
<td style="text-align:right;">
336
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-507
</td>
<td style="text-align:left;">
ohio balance of state coc
</td>
<td style="text-align:right;">
-0.1768261
</td>
<td style="text-align:right;">
239.0
</td>
<td style="text-align:right;">
3806
</td>
<td style="text-align:right;">
3133
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-605
</td>
<td style="text-align:left;">
west palm beach/palm beach county coc
</td>
<td style="text-align:right;">
-0.1798246
</td>
<td style="text-align:right;">
240.0
</td>
<td style="text-align:right;">
1596
</td>
<td style="text-align:right;">
1309
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-604
</td>
<td style="text-align:left;">
kansas city, independence, lee’s summit/jackson, wyandotte counties, mo
& ks
</td>
<td style="text-align:right;">
-0.1801186
</td>
<td style="text-align:right;">
241.0
</td>
<td style="text-align:right;">
2193
</td>
<td style="text-align:right;">
1798
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-501
</td>
<td style="text-align:left;">
toledo/lucas county coc
</td>
<td style="text-align:right;">
-0.1817058
</td>
<td style="text-align:right;">
242.0
</td>
<td style="text-align:right;">
809
</td>
<td style="text-align:right;">
662
</td>
</tr>
<tr>
<td style="text-align:left;">
nv-500
</td>
<td style="text-align:left;">
las vegas/clark county coc
</td>
<td style="text-align:right;">
-0.1827220
</td>
<td style="text-align:right;">
243.0
</td>
<td style="text-align:right;">
7443
</td>
<td style="text-align:right;">
6083
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-510
</td>
<td style="text-align:left;">
lancaster city & county coc
</td>
<td style="text-align:right;">
-0.1847390
</td>
<td style="text-align:right;">
244.0
</td>
<td style="text-align:right;">
498
</td>
<td style="text-align:right;">
406
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-502
</td>
<td style="text-align:left;">
upper darby, chester, haverford/delaware county coc
</td>
<td style="text-align:right;">
-0.1866405
</td>
<td style="text-align:right;">
245.0
</td>
<td style="text-align:right;">
509
</td>
<td style="text-align:right;">
414
</td>
</tr>
<tr>
<td style="text-align:left;">
ms-503
</td>
<td style="text-align:left;">
gulf port/gulf coast regional coc
</td>
<td style="text-align:right;">
-0.1877934
</td>
<td style="text-align:right;">
246.0
</td>
<td style="text-align:right;">
426
</td>
<td style="text-align:right;">
346
</td>
</tr>
<tr>
<td style="text-align:left;">
nm-501
</td>
<td style="text-align:left;">
new mexico balance of state coc
</td>
<td style="text-align:right;">
-0.1883378
</td>
<td style="text-align:right;">
247.0
</td>
<td style="text-align:right;">
1492
</td>
<td style="text-align:right;">
1211
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-500
</td>
<td style="text-align:left;">
minneapolis/hennepin county coc
</td>
<td style="text-align:right;">
-0.1924417
</td>
<td style="text-align:right;">
248.0
</td>
<td style="text-align:right;">
3731
</td>
<td style="text-align:right;">
3013
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-511
</td>
<td style="text-align:left;">
bristol, bensalem/bucks county coc
</td>
<td style="text-align:right;">
-0.1930894
</td>
<td style="text-align:right;">
249.0
</td>
<td style="text-align:right;">
492
</td>
<td style="text-align:right;">
397
</td>
</tr>
<tr>
<td style="text-align:left;">
va-601
</td>
<td style="text-align:left;">
fairfax county coc
</td>
<td style="text-align:right;">
-0.1942857
</td>
<td style="text-align:right;">
250.0
</td>
<td style="text-align:right;">
1225
</td>
<td style="text-align:right;">
987
</td>
</tr>
<tr>
<td style="text-align:left;">
mt-500
</td>
<td style="text-align:left;">
montana statewide coc
</td>
<td style="text-align:right;">
-0.1948424
</td>
<td style="text-align:right;">
251.0
</td>
<td style="text-align:right;">
1745
</td>
<td style="text-align:right;">
1405
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-500
</td>
<td style="text-align:left;">
atlantic city & county coc
</td>
<td style="text-align:right;">
-0.1966912
</td>
<td style="text-align:right;">
252.0
</td>
<td style="text-align:right;">
544
</td>
<td style="text-align:right;">
437
</td>
</tr>
<tr>
<td style="text-align:left;">
co-503
</td>
<td style="text-align:left;">
metropolitan denver coc
</td>
<td style="text-align:right;">
-0.1969491
</td>
<td style="text-align:right;">
253.0
</td>
<td style="text-align:right;">
6621
</td>
<td style="text-align:right;">
5317
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-506
</td>
<td style="text-align:left;">
southwest oklahoma regional coc
</td>
<td style="text-align:right;">
-0.2008368
</td>
<td style="text-align:right;">
254.0
</td>
<td style="text-align:right;">
239
</td>
<td style="text-align:right;">
191
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-502
</td>
<td style="text-align:left;">
oklahoma city coc
</td>
<td style="text-align:right;">
-0.2012154
</td>
<td style="text-align:right;">
255.0
</td>
<td style="text-align:right;">
1481
</td>
<td style="text-align:right;">
1183
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-519
</td>
<td style="text-align:left;">
pasco county coc
</td>
<td style="text-align:right;">
-0.2050060
</td>
<td style="text-align:right;">
256.0
</td>
<td style="text-align:right;">
3356
</td>
<td style="text-align:right;">
2668
</td>
</tr>
<tr>
<td style="text-align:left;">
al-503
</td>
<td style="text-align:left;">
huntsville/north alabama coc
</td>
<td style="text-align:right;">
-0.2089552
</td>
<td style="text-align:right;">
257.0
</td>
<td style="text-align:right;">
536
</td>
<td style="text-align:right;">
424
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-503
</td>
<td style="text-align:left;">
madison/dane county coc
</td>
<td style="text-align:right;">
-0.2097812
</td>
<td style="text-align:right;">
258.0
</td>
<td style="text-align:right;">
777
</td>
<td style="text-align:right;">
614
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-503
</td>
<td style="text-align:left;">
oklahoma balance of state coc
</td>
<td style="text-align:right;">
-0.2101695
</td>
<td style="text-align:right;">
259.0
</td>
<td style="text-align:right;">
295
</td>
<td style="text-align:right;">
233
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-511
</td>
<td style="text-align:left;">
binghamton, union town/broome, otsego, chenango, delaware, cortland,
tioga count
</td>
<td style="text-align:right;">
-0.2103560
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
309
</td>
<td style="text-align:right;">
244
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-503
</td>
<td style="text-align:left;">
st. clair shores, warren/macomb county coc
</td>
<td style="text-align:right;">
-0.2128280
</td>
<td style="text-align:right;">
261.0
</td>
<td style="text-align:right;">
343
</td>
<td style="text-align:right;">
270
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-608
</td>
<td style="text-align:left;">
riverside city & county coc
</td>
<td style="text-align:right;">
-0.2135823
</td>
<td style="text-align:right;">
262.0
</td>
<td style="text-align:right;">
2945
</td>
<td style="text-align:right;">
2316
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-509
</td>
<td style="text-align:left;">
gastonia/cleveland, gaston, lincoln counties coc
</td>
<td style="text-align:right;">
-0.2174941
</td>
<td style="text-align:right;">
263.0
</td>
<td style="text-align:right;">
423
</td>
<td style="text-align:right;">
331
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-700
</td>
<td style="text-align:left;">
houston, pasadena, conroe/harris, ft. bend, montgomery, counties coc
</td>
<td style="text-align:right;">
-0.2194800
</td>
<td style="text-align:right;">
264.0
</td>
<td style="text-align:right;">
5308
</td>
<td style="text-align:right;">
4143
</td>
</tr>
<tr>
<td style="text-align:left;">
il-515
</td>
<td style="text-align:left;">
south central illinois coc
</td>
<td style="text-align:right;">
-0.2203390
</td>
<td style="text-align:right;">
265.0
</td>
<td style="text-align:right;">
118
</td>
<td style="text-align:right;">
92
</td>
</tr>
<tr>
<td style="text-align:left;">
la-500
</td>
<td style="text-align:left;">
lafayette/acadiana coc
</td>
<td style="text-align:right;">
-0.2292994
</td>
<td style="text-align:right;">
266.0
</td>
<td style="text-align:right;">
471
</td>
<td style="text-align:right;">
363
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-502
</td>
<td style="text-align:left;">
st. petersburg, clearwater, largo/pinellas county coc
</td>
<td style="text-align:right;">
-0.2297257
</td>
<td style="text-align:right;">
267.0
</td>
<td style="text-align:right;">
3391
</td>
<td style="text-align:right;">
2612
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-607
</td>
<td style="text-align:left;">
texas balance of state coc
</td>
<td style="text-align:right;">
-0.2318214
</td>
<td style="text-align:right;">
268.0
</td>
<td style="text-align:right;">
9943
</td>
<td style="text-align:right;">
7638
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-507
</td>
<td style="text-align:left;">
savannah/chatham county coc
</td>
<td style="text-align:right;">
-0.2326996
</td>
<td style="text-align:right;">
269.0
</td>
<td style="text-align:right;">
1315
</td>
<td style="text-align:right;">
1009
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-604
</td>
<td style="text-align:left;">
waco/mclennan county coc
</td>
<td style="text-align:right;">
-0.2357724
</td>
<td style="text-align:right;">
270.0
</td>
<td style="text-align:right;">
246
</td>
<td style="text-align:right;">
188
</td>
</tr>
<tr>
<td style="text-align:left;">
va-600
</td>
<td style="text-align:left;">
arlington county coc
</td>
<td style="text-align:right;">
-0.2405498
</td>
<td style="text-align:right;">
271.0
</td>
<td style="text-align:right;">
291
</td>
<td style="text-align:right;">
221
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-502
</td>
<td style="text-align:left;">
columbia/midlands coc
</td>
<td style="text-align:right;">
-0.2411839
</td>
<td style="text-align:right;">
272.0
</td>
<td style="text-align:right;">
1588
</td>
<td style="text-align:right;">
1205
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-514
</td>
<td style="text-align:left;">
trenton/mercer county coc
</td>
<td style="text-align:right;">
-0.2420886
</td>
<td style="text-align:right;">
273.0
</td>
<td style="text-align:right;">
632
</td>
<td style="text-align:right;">
479
</td>
</tr>
<tr>
<td style="text-align:left;">
va-602
</td>
<td style="text-align:left;">
loudoun county coc
</td>
<td style="text-align:right;">
-0.2429379
</td>
<td style="text-align:right;">
274.0
</td>
<td style="text-align:right;">
177
</td>
<td style="text-align:right;">
134
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-506
</td>
<td style="text-align:left;">
upper cumberland coc
</td>
<td style="text-align:right;">
-0.2456140
</td>
<td style="text-align:right;">
275.0
</td>
<td style="text-align:right;">
342
</td>
<td style="text-align:right;">
258
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-522
</td>
<td style="text-align:left;">
humboldt county coc
</td>
<td style="text-align:right;">
-0.2457082
</td>
<td style="text-align:right;">
276.0
</td>
<td style="text-align:right;">
932
</td>
<td style="text-align:right;">
703
</td>
</tr>
<tr>
<td style="text-align:left;">
al-504
</td>
<td style="text-align:left;">
montgomery city & county coc
</td>
<td style="text-align:right;">
-0.2469388
</td>
<td style="text-align:right;">
277.0
</td>
<td style="text-align:right;">
490
</td>
<td style="text-align:right;">
369
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-511
</td>
<td style="text-align:left;">
pensacola/escambia, santa rosa counties coc
</td>
<td style="text-align:right;">
-0.2502966
</td>
<td style="text-align:right;">
278.0
</td>
<td style="text-align:right;">
843
</td>
<td style="text-align:right;">
632
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-507
</td>
<td style="text-align:left;">
new brunswick/middlesex county coc
</td>
<td style="text-align:right;">
-0.2556110
</td>
<td style="text-align:right;">
279.0
</td>
<td style="text-align:right;">
802
</td>
<td style="text-align:right;">
597
</td>
</tr>
<tr>
<td style="text-align:left;">
la-506
</td>
<td style="text-align:left;">
slidell/southeast louisiana coc
</td>
<td style="text-align:right;">
-0.2595420
</td>
<td style="text-align:right;">
280.0
</td>
<td style="text-align:right;">
262
</td>
<td style="text-align:right;">
194
</td>
</tr>
<tr>
<td style="text-align:left;">
il-511
</td>
<td style="text-align:left;">
cook county coc
</td>
<td style="text-align:right;">
-0.2614213
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
1182
</td>
<td style="text-align:right;">
873
</td>
</tr>
<tr>
<td style="text-align:left;">
il-508
</td>
<td style="text-align:left;">
east st. louis, belleville/st. clair county coc
</td>
<td style="text-align:right;">
-0.2625369
</td>
<td style="text-align:right;">
282.0
</td>
<td style="text-align:right;">
339
</td>
<td style="text-align:right;">
250
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-506
</td>
<td style="text-align:left;">
marietta/cobb county coc
</td>
<td style="text-align:right;">
-0.2657744
</td>
<td style="text-align:right;">
283.0
</td>
<td style="text-align:right;">
523
</td>
<td style="text-align:right;">
384
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-504
</td>
<td style="text-align:left;">
greensboro, high point coc
</td>
<td style="text-align:right;">
-0.2675585
</td>
<td style="text-align:right;">
284.0
</td>
<td style="text-align:right;">
897
</td>
<td style="text-align:right;">
657
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-501
</td>
<td style="text-align:left;">
memphis/shelby county coc
</td>
<td style="text-align:right;">
-0.2680597
</td>
<td style="text-align:right;">
285.0
</td>
<td style="text-align:right;">
1675
</td>
<td style="text-align:right;">
1226
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-600
</td>
<td style="text-align:left;">
springfield/greene, christian, webster counties coc
</td>
<td style="text-align:right;">
-0.2698171
</td>
<td style="text-align:right;">
286.0
</td>
<td style="text-align:right;">
656
</td>
<td style="text-align:right;">
479
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-503
</td>
<td style="text-align:left;">
arkansas balance of state coc
</td>
<td style="text-align:right;">
-0.2727273
</td>
<td style="text-align:right;">
287.0
</td>
<td style="text-align:right;">
1056
</td>
<td style="text-align:right;">
768
</td>
</tr>
<tr>
<td style="text-align:left;">
nv-502
</td>
<td style="text-align:left;">
nevada balance of state coc
</td>
<td style="text-align:right;">
-0.2729730
</td>
<td style="text-align:right;">
288.0
</td>
<td style="text-align:right;">
370
</td>
<td style="text-align:right;">
269
</td>
</tr>
<tr>
<td style="text-align:left;">
md-600
</td>
<td style="text-align:left;">
prince george’s county coc
</td>
<td style="text-align:right;">
-0.2746586
</td>
<td style="text-align:right;">
289.0
</td>
<td style="text-align:right;">
659
</td>
<td style="text-align:right;">
478
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-501
</td>
<td style="text-align:left;">
greenville, anderson, spartanburg/upstate coc
</td>
<td style="text-align:right;">
-0.2756724
</td>
<td style="text-align:right;">
290.0
</td>
<td style="text-align:right;">
1636
</td>
<td style="text-align:right;">
1185
</td>
</tr>
<tr>
<td style="text-align:left;">
va-502
</td>
<td style="text-align:left;">
roanoke city & county, salem coc
</td>
<td style="text-align:right;">
-0.2795455
</td>
<td style="text-align:right;">
291.0
</td>
<td style="text-align:right;">
440
</td>
<td style="text-align:right;">
317
</td>
</tr>
<tr>
<td style="text-align:left;">
va-500
</td>
<td style="text-align:left;">
richmond/henrico, chesterfield, hanover counties coc
</td>
<td style="text-align:right;">
-0.2801418
</td>
<td style="text-align:right;">
292.0
</td>
<td style="text-align:right;">
846
</td>
<td style="text-align:right;">
609
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-603
</td>
<td style="text-align:left;">
el paso city & county coc
</td>
<td style="text-align:right;">
-0.2920635
</td>
<td style="text-align:right;">
293.0
</td>
<td style="text-align:right;">
1260
</td>
<td style="text-align:right;">
892
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-505
</td>
<td style="text-align:left;">
syracuse, auburn/onondaga, oswego, cayuga counties coc
</td>
<td style="text-align:right;">
-0.2949219
</td>
<td style="text-align:right;">
294.0
</td>
<td style="text-align:right;">
1024
</td>
<td style="text-align:right;">
722
</td>
</tr>
<tr>
<td style="text-align:left;">
ky-501
</td>
<td style="text-align:left;">
louisville-jefferson county coc
</td>
<td style="text-align:right;">
-0.2963526
</td>
<td style="text-align:right;">
295.0
</td>
<td style="text-align:right;">
1316
</td>
<td style="text-align:right;">
926
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-504
</td>
<td style="text-align:left;">
youngstown/mahoning county coc
</td>
<td style="text-align:right;">
-0.2968750
</td>
<td style="text-align:right;">
296.0
</td>
<td style="text-align:right;">
256
</td>
<td style="text-align:right;">
180
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-507
</td>
<td style="text-align:left;">
kansas balance of state coc
</td>
<td style="text-align:right;">
-0.2976282
</td>
<td style="text-align:right;">
297.0
</td>
<td style="text-align:right;">
1307
</td>
<td style="text-align:right;">
918
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-504
</td>
<td style="text-align:left;">
santa rosa, petaluma/sonoma county coc
</td>
<td style="text-align:right;">
-0.2977028
</td>
<td style="text-align:right;">
298.0
</td>
<td style="text-align:right;">
4266
</td>
<td style="text-align:right;">
2996
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-501
</td>
<td style="text-align:left;">
st.louis city coc
</td>
<td style="text-align:right;">
-0.2991137
</td>
<td style="text-align:right;">
299.0
</td>
<td style="text-align:right;">
1354
</td>
<td style="text-align:right;">
949
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-505
</td>
<td style="text-align:left;">
flint/genesee county coc
</td>
<td style="text-align:right;">
-0.3102362
</td>
<td style="text-align:right;">
300.0
</td>
<td style="text-align:right;">
635
</td>
<td style="text-align:right;">
438
</td>
</tr>
<tr>
<td style="text-align:left;">
ct-503
</td>
<td style="text-align:left;">
bridgeport, stamford, norwalk/fairfield county coc
</td>
<td style="text-align:right;">
-0.3157895
</td>
<td style="text-align:right;">
301.0
</td>
<td style="text-align:right;">
1083
</td>
<td style="text-align:right;">
741
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-606
</td>
<td style="text-align:left;">
long beach coc
</td>
<td style="text-align:right;">
-0.3159240
</td>
<td style="text-align:right;">
302.0
</td>
<td style="text-align:right;">
2738
</td>
<td style="text-align:right;">
1873
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-601
</td>
<td style="text-align:left;">
western pennsylvania coc
</td>
<td style="text-align:right;">
-0.3206176
</td>
<td style="text-align:right;">
303.0
</td>
<td style="text-align:right;">
1101
</td>
<td style="text-align:right;">
748
</td>
</tr>
<tr>
<td style="text-align:left;">
al-500
</td>
<td style="text-align:left;">
birmingham/jefferson, st. clair, shelby counties coc
</td>
<td style="text-align:right;">
-0.3220467
</td>
<td style="text-align:right;">
304.0
</td>
<td style="text-align:right;">
1329
</td>
<td style="text-align:right;">
901
</td>
</tr>
<tr>
<td style="text-align:left;">
il-502
</td>
<td style="text-align:left;">
waukegan, north chicago/lake county coc
</td>
<td style="text-align:right;">
-0.3227384
</td>
<td style="text-align:right;">
305.0
</td>
<td style="text-align:right;">
409
</td>
<td style="text-align:right;">
277
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-513
</td>
<td style="text-align:left;">
somerset county coc
</td>
<td style="text-align:right;">
-0.3250774
</td>
<td style="text-align:right;">
306.0
</td>
<td style="text-align:right;">
323
</td>
<td style="text-align:right;">
218
</td>
</tr>
<tr>
<td style="text-align:left;">
vt-501
</td>
<td style="text-align:left;">
burlington/chittenden county coc
</td>
<td style="text-align:right;">
-0.3251880
</td>
<td style="text-align:right;">
307.0
</td>
<td style="text-align:right;">
532
</td>
<td style="text-align:right;">
359
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-506
</td>
<td style="text-align:left;">
akron, barberton/summit county coc
</td>
<td style="text-align:right;">
-0.3252874
</td>
<td style="text-align:right;">
308.0
</td>
<td style="text-align:right;">
870
</td>
<td style="text-align:right;">
587
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-520
</td>
<td style="text-align:left;">
merced city & county coc
</td>
<td style="text-align:right;">
-0.3307292
</td>
<td style="text-align:right;">
309.0
</td>
<td style="text-align:right;">
768
</td>
<td style="text-align:right;">
514
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-518
</td>
<td style="text-align:left;">
livingston county coc
</td>
<td style="text-align:right;">
-0.3333333
</td>
<td style="text-align:right;">
310.0
</td>
<td style="text-align:right;">
135
</td>
<td style="text-align:right;">
90
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-504
</td>
<td style="text-align:left;">
lower merion, norristown, abington/montgomery county coc
</td>
<td style="text-align:right;">
-0.3356164
</td>
<td style="text-align:right;">
311.0
</td>
<td style="text-align:right;">
438
</td>
<td style="text-align:right;">
291
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-511
</td>
<td style="text-align:left;">
quincy, brockton, weymouth, plymouth city and county coc
</td>
<td style="text-align:right;">
-0.3365794
</td>
<td style="text-align:right;">
312.0
</td>
<td style="text-align:right;">
1643
</td>
<td style="text-align:right;">
1090
</td>
</tr>
<tr>
<td style="text-align:left;">
md-507
</td>
<td style="text-align:left;">
cecil county coc
</td>
<td style="text-align:right;">
-0.3384615
</td>
<td style="text-align:right;">
313.0
</td>
<td style="text-align:right;">
195
</td>
<td style="text-align:right;">
129
</td>
</tr>
<tr>
<td style="text-align:left;">
md-500
</td>
<td style="text-align:left;">
cumberland/allegany county coc
</td>
<td style="text-align:right;">
-0.3416667
</td>
<td style="text-align:right;">
314.0
</td>
<td style="text-align:right;">
120
</td>
<td style="text-align:right;">
79
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-508
</td>
<td style="text-align:left;">
watsonville/santa cruz city & county coc
</td>
<td style="text-align:right;">
-0.3425900
</td>
<td style="text-align:right;">
315.0
</td>
<td style="text-align:right;">
3529
</td>
<td style="text-align:right;">
2320
</td>
</tr>
<tr>
<td style="text-align:left;">
la-509
</td>
<td style="text-align:left;">
louisiana balance of state coc
</td>
<td style="text-align:right;">
-0.3436073
</td>
<td style="text-align:right;">
316.0
</td>
<td style="text-align:right;">
876
</td>
<td style="text-align:right;">
575
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-522
</td>
<td style="text-align:left;">
jefferson, lewis, st. lawrence counties coc
</td>
<td style="text-align:right;">
-0.3557047
</td>
<td style="text-align:right;">
317.0
</td>
<td style="text-align:right;">
149
</td>
<td style="text-align:right;">
96
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-501
</td>
<td style="text-align:left;">
detroit coc
</td>
<td style="text-align:right;">
-0.3578947
</td>
<td style="text-align:right;">
318.0
</td>
<td style="text-align:right;">
2755
</td>
<td style="text-align:right;">
1769
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-500
</td>
<td style="text-align:left;">
atlanta coc
</td>
<td style="text-align:right;">
-0.3587659
</td>
<td style="text-align:right;">
319.0
</td>
<td style="text-align:right;">
4797
</td>
<td style="text-align:right;">
3076
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-507
</td>
<td style="text-align:left;">
jackson/west tennessee coc
</td>
<td style="text-align:right;">
-0.3591505
</td>
<td style="text-align:right;">
320.0
</td>
<td style="text-align:right;">
1601
</td>
<td style="text-align:right;">
1026
</td>
</tr>
<tr>
<td style="text-align:left;">
az-501
</td>
<td style="text-align:left;">
tucson/pima county coc
</td>
<td style="text-align:right;">
-0.3666820
</td>
<td style="text-align:right;">
321.0
</td>
<td style="text-align:right;">
2179
</td>
<td style="text-align:right;">
1380
</td>
</tr>
<tr>
<td style="text-align:left;">
il-516
</td>
<td style="text-align:left;">
decatur/macon county coc
</td>
<td style="text-align:right;">
-0.3710938
</td>
<td style="text-align:right;">
322.0
</td>
<td style="text-align:right;">
256
</td>
<td style="text-align:right;">
161
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-509
</td>
<td style="text-align:left;">
mendocino county coc
</td>
<td style="text-align:right;">
-0.3732194
</td>
<td style="text-align:right;">
323.0
</td>
<td style="text-align:right;">
1404
</td>
<td style="text-align:right;">
880
</td>
</tr>
<tr>
<td style="text-align:left;">
il-501
</td>
<td style="text-align:left;">
rockford/winnebago, boone counties coc
</td>
<td style="text-align:right;">
-0.3756098
</td>
<td style="text-align:right;">
324.0
</td>
<td style="text-align:right;">
410
</td>
<td style="text-align:right;">
256
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-514
</td>
<td style="text-align:left;">
ocala/marion county coc
</td>
<td style="text-align:right;">
-0.3769063
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
918
</td>
<td style="text-align:right;">
572
</td>
</tr>
<tr>
<td style="text-align:left;">
or-507
</td>
<td style="text-align:left;">
clackamas county coc
</td>
<td style="text-align:right;">
-0.3802589
</td>
<td style="text-align:right;">
326.0
</td>
<td style="text-align:right;">
618
</td>
<td style="text-align:right;">
383
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-512
</td>
<td style="text-align:left;">
daly/san mateo county coc
</td>
<td style="text-align:right;">
-0.3883399
</td>
<td style="text-align:right;">
327.0
</td>
<td style="text-align:right;">
2024
</td>
<td style="text-align:right;">
1238
</td>
</tr>
<tr>
<td style="text-align:left;">
il-504
</td>
<td style="text-align:left;">
madison county coc
</td>
<td style="text-align:right;">
-0.3916667
</td>
<td style="text-align:right;">
328.0
</td>
<td style="text-align:right;">
240
</td>
<td style="text-align:right;">
146
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-509
</td>
<td style="text-align:left;">
appalachian regional coc
</td>
<td style="text-align:right;">
-0.3979933
</td>
<td style="text-align:right;">
329.0
</td>
<td style="text-align:right;">
598
</td>
<td style="text-align:right;">
360
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-508
</td>
<td style="text-align:left;">
gainesville/alachua, putnam counties coc
</td>
<td style="text-align:right;">
-0.3980892
</td>
<td style="text-align:right;">
330.0
</td>
<td style="text-align:right;">
1256
</td>
<td style="text-align:right;">
756
</td>
</tr>
<tr>
<td style="text-align:left;">
la-503
</td>
<td style="text-align:left;">
new orleans/jefferson parish coc
</td>
<td style="text-align:right;">
-0.4003029
</td>
<td style="text-align:right;">
331.0
</td>
<td style="text-align:right;">
1981
</td>
<td style="text-align:right;">
1188
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-500
</td>
<td style="text-align:left;">
michigan balance of state coc
</td>
<td style="text-align:right;">
-0.4039059
</td>
<td style="text-align:right;">
332.0
</td>
<td style="text-align:right;">
2253
</td>
<td style="text-align:right;">
1343
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-509
</td>
<td style="text-align:left;">
fort pierce/st. lucie, indian river, martin counties coc
</td>
<td style="text-align:right;">
-0.4048630
</td>
<td style="text-align:right;">
333.0
</td>
<td style="text-align:right;">
2591
</td>
<td style="text-align:right;">
1542
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-503
</td>
<td style="text-align:left;">
st. charles city & county, lincoln, warren counties coc
</td>
<td style="text-align:right;">
-0.4062500
</td>
<td style="text-align:right;">
334.0
</td>
<td style="text-align:right;">
896
</td>
<td style="text-align:right;">
532
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-512
</td>
<td style="text-align:left;">
grand traverse, antrim, leelanau counties coc
</td>
<td style="text-align:right;">
-0.4065657
</td>
<td style="text-align:right;">
335.0
</td>
<td style="text-align:right;">
396
</td>
<td style="text-align:right;">
235
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-503
</td>
<td style="text-align:left;">
camden city & county/gloucester, cape may, cumberland counties coc
</td>
<td style="text-align:right;">
-0.4106195
</td>
<td style="text-align:right;">
336.0
</td>
<td style="text-align:right;">
1695
</td>
<td style="text-align:right;">
999
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-516
</td>
<td style="text-align:left;">
massachusetts balance of state coc
</td>
<td style="text-align:right;">
-0.4112821
</td>
<td style="text-align:right;">
337.0
</td>
<td style="text-align:right;">
3900
</td>
<td style="text-align:right;">
2296
</td>
</tr>
<tr>
<td style="text-align:left;">
ms-501
</td>
<td style="text-align:left;">
mississippi balance of state coc
</td>
<td style="text-align:right;">
-0.4129979
</td>
<td style="text-align:right;">
338.0
</td>
<td style="text-align:right;">
954
</td>
<td style="text-align:right;">
560
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-519
</td>
<td style="text-align:left;">
holland/ottawa county coc
</td>
<td style="text-align:right;">
-0.4160207
</td>
<td style="text-align:right;">
339.0
</td>
<td style="text-align:right;">
387
</td>
<td style="text-align:right;">
226
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-501
</td>
<td style="text-align:left;">
milwaukee city & county coc
</td>
<td style="text-align:right;">
-0.4189460
</td>
<td style="text-align:right;">
340.0
</td>
<td style="text-align:right;">
1499
</td>
<td style="text-align:right;">
871
</td>
</tr>
<tr>
<td style="text-align:left;">
il-512
</td>
<td style="text-align:left;">
bloomington/central illinois coc
</td>
<td style="text-align:right;">
-0.4215247
</td>
<td style="text-align:right;">
341.0
</td>
<td style="text-align:right;">
669
</td>
<td style="text-align:right;">
387
</td>
</tr>
<tr>
<td style="text-align:left;">
la-502
</td>
<td style="text-align:left;">
shreveport, bossier/northwest louisiana coc
</td>
<td style="text-align:right;">
-0.4274809
</td>
<td style="text-align:right;">
342.0
</td>
<td style="text-align:right;">
655
</td>
<td style="text-align:right;">
375
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-504
</td>
<td style="text-align:left;">
augusta-richmond county coc
</td>
<td style="text-align:right;">
-0.4300847
</td>
<td style="text-align:right;">
343.0
</td>
<td style="text-align:right;">
472
</td>
<td style="text-align:right;">
269
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-508
</td>
<td style="text-align:left;">
monmouth county coc
</td>
<td style="text-align:right;">
-0.4302721
</td>
<td style="text-align:right;">
344.0
</td>
<td style="text-align:right;">
588
</td>
<td style="text-align:right;">
335
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-511
</td>
<td style="text-align:left;">
fayetteville/cumberland county coc
</td>
<td style="text-align:right;">
-0.4303216
</td>
<td style="text-align:right;">
345.0
</td>
<td style="text-align:right;">
653
</td>
<td style="text-align:right;">
372
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-510
</td>
<td style="text-align:left;">
lakewood township/ocean county coc
</td>
<td style="text-align:right;">
-0.4354067
</td>
<td style="text-align:right;">
346.0
</td>
<td style="text-align:right;">
627
</td>
<td style="text-align:right;">
354
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-508
</td>
<td style="text-align:left;">
scranton/lackawanna county coc
</td>
<td style="text-align:right;">
-0.4459930
</td>
<td style="text-align:right;">
347.0
</td>
<td style="text-align:right;">
287
</td>
<td style="text-align:right;">
159
</td>
</tr>
<tr>
<td style="text-align:left;">
va-503
</td>
<td style="text-align:left;">
virginia beach coc
</td>
<td style="text-align:right;">
-0.4477273
</td>
<td style="text-align:right;">
348.0
</td>
<td style="text-align:right;">
440
</td>
<td style="text-align:right;">
243
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-507
</td>
<td style="text-align:left;">
southeastern oklahoma regional coc
</td>
<td style="text-align:right;">
-0.4479638
</td>
<td style="text-align:right;">
349.0
</td>
<td style="text-align:right;">
442
</td>
<td style="text-align:right;">
244
</td>
</tr>
<tr>
<td style="text-align:left;">
ne-502
</td>
<td style="text-align:left;">
lincoln coc
</td>
<td style="text-align:right;">
-0.4605263
</td>
<td style="text-align:right;">
350.0
</td>
<td style="text-align:right;">
836
</td>
<td style="text-align:right;">
451
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-520
</td>
<td style="text-align:left;">
franklin, essex counties coc
</td>
<td style="text-align:right;">
-0.4615385
</td>
<td style="text-align:right;">
351.0
</td>
<td style="text-align:right;">
78
</td>
<td style="text-align:right;">
42
</td>
</tr>
<tr>
<td style="text-align:left;">
ms-500
</td>
<td style="text-align:left;">
jackson/rankin, madison counties coc
</td>
<td style="text-align:right;">
-0.4728132
</td>
<td style="text-align:right;">
352.0
</td>
<td style="text-align:right;">
846
</td>
<td style="text-align:right;">
446
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-516
</td>
<td style="text-align:left;">
northwest north carolina coc
</td>
<td style="text-align:right;">
-0.4742389
</td>
<td style="text-align:right;">
353.0
</td>
<td style="text-align:right;">
854
</td>
<td style="text-align:right;">
449
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-508
</td>
<td style="text-align:left;">
canton, massillon, alliance/stark county coc
</td>
<td style="text-align:right;">
-0.4764595
</td>
<td style="text-align:right;">
354.0
</td>
<td style="text-align:right;">
531
</td>
<td style="text-align:right;">
278
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-509
</td>
<td style="text-align:left;">
washtenaw county coc
</td>
<td style="text-align:right;">
-0.4825688
</td>
<td style="text-align:right;">
355.0
</td>
<td style="text-align:right;">
545
</td>
<td style="text-align:right;">
282
</td>
</tr>
<tr>
<td style="text-align:left;">
va-508
</td>
<td style="text-align:left;">
lynchburg coc
</td>
<td style="text-align:right;">
-0.4909091
</td>
<td style="text-align:right;">
356.0
</td>
<td style="text-align:right;">
220
</td>
<td style="text-align:right;">
112
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-600
</td>
<td style="text-align:left;">
pittsburgh, mckeesport, penn hills/allegheny county coc
</td>
<td style="text-align:right;">
-0.5022250
</td>
<td style="text-align:right;">
357.0
</td>
<td style="text-align:right;">
1573
</td>
<td style="text-align:right;">
783
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-513
</td>
<td style="text-align:left;">
palm bay, melbourne/brevard county coc
</td>
<td style="text-align:right;">
-0.5030467
</td>
<td style="text-align:right;">
358.0
</td>
<td style="text-align:right;">
1477
</td>
<td style="text-align:right;">
734
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-501
</td>
<td style="text-align:left;">
georgia balance of state coc
</td>
<td style="text-align:right;">
-0.5077207
</td>
<td style="text-align:right;">
359.0
</td>
<td style="text-align:right;">
7577
</td>
<td style="text-align:right;">
3730
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-510
</td>
<td style="text-align:left;">
gloucester, haverhill, salem/essex county coc
</td>
<td style="text-align:right;">
-0.5077337
</td>
<td style="text-align:right;">
360.0
</td>
<td style="text-align:right;">
1487
</td>
<td style="text-align:right;">
732
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-523
</td>
<td style="text-align:left;">
colusa, glenn, trinity counties coc
</td>
<td style="text-align:right;">
-0.5273369
</td>
<td style="text-align:right;">
361.0
</td>
<td style="text-align:right;">
567
</td>
<td style="text-align:right;">
268
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-508
</td>
<td style="text-align:left;">
west virginia balance of state coc
</td>
<td style="text-align:right;">
-0.5306428
</td>
<td style="text-align:right;">
362.0
</td>
<td style="text-align:right;">
1338
</td>
<td style="text-align:right;">
628
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-614
</td>
<td style="text-align:left;">
san luis obispo county coc
</td>
<td style="text-align:right;">
-0.5371936
</td>
<td style="text-align:right;">
363.0
</td>
<td style="text-align:right;">
2366
</td>
<td style="text-align:right;">
1095
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-502
</td>
<td style="text-align:left;">
dearborn, dearborn heights, westland/wayne county coc
</td>
<td style="text-align:right;">
-0.5372807
</td>
<td style="text-align:right;">
364.0
</td>
<td style="text-align:right;">
456
</td>
<td style="text-align:right;">
211
</td>
</tr>
<tr>
<td style="text-align:left;">
il-519
</td>
<td style="text-align:left;">
west central illinois coc
</td>
<td style="text-align:right;">
-0.5379310
</td>
<td style="text-align:right;">
365.0
</td>
<td style="text-align:right;">
145
</td>
<td style="text-align:right;">
67
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-518
</td>
<td style="text-align:left;">
columbia, hamilton, lafayette, suwannee counties coc
</td>
<td style="text-align:right;">
-0.5392523
</td>
<td style="text-align:right;">
366.0
</td>
<td style="text-align:right;">
1070
</td>
<td style="text-align:right;">
493
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-501
</td>
<td style="text-align:left;">
elmira/steuben, allegany, livingston, chemung, schuyler counties coc
</td>
<td style="text-align:right;">
-0.5449219
</td>
<td style="text-align:right;">
367.0
</td>
<td style="text-align:right;">
512
</td>
<td style="text-align:right;">
233
</td>
</tr>
<tr>
<td style="text-align:left;">
il-514
</td>
<td style="text-align:left;">
dupage county coc
</td>
<td style="text-align:right;">
-0.5489297
</td>
<td style="text-align:right;">
368.0
</td>
<td style="text-align:right;">
654
</td>
<td style="text-align:right;">
295
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-504
</td>
<td style="text-align:left;">
northeast minnesota coc
</td>
<td style="text-align:right;">
-0.5500000
</td>
<td style="text-align:right;">
369.0
</td>
<td style="text-align:right;">
200
</td>
<td style="text-align:right;">
90
</td>
</tr>
<tr>
<td style="text-align:left;">
ky-502
</td>
<td style="text-align:left;">
lexington-fayette county coc
</td>
<td style="text-align:right;">
-0.5563472
</td>
<td style="text-align:right;">
370.0
</td>
<td style="text-align:right;">
1544
</td>
<td style="text-align:right;">
685
</td>
</tr>
<tr>
<td style="text-align:left;">
md-508
</td>
<td style="text-align:left;">
charles, calvert, st.mary’s counties coc
</td>
<td style="text-align:right;">
-0.5687993
</td>
<td style="text-align:right;">
371.0
</td>
<td style="text-align:right;">
1141
</td>
<td style="text-align:right;">
492
</td>
</tr>
<tr>
<td style="text-align:left;">
nd-500
</td>
<td style="text-align:left;">
north dakota statewide coc
</td>
<td style="text-align:right;">
-0.5691574
</td>
<td style="text-align:right;">
372.0
</td>
<td style="text-align:right;">
1258
</td>
<td style="text-align:right;">
542
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-504
</td>
<td style="text-align:left;">
daytona beach, daytona/volusia, flagler counties coc
</td>
<td style="text-align:right;">
-0.5817514
</td>
<td style="text-align:right;">
373.0
</td>
<td style="text-align:right;">
1633
</td>
<td style="text-align:right;">
683
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-502
</td>
<td style="text-align:left;">
durham city & county coc
</td>
<td style="text-align:right;">
-0.5832306
</td>
<td style="text-align:right;">
374.0
</td>
<td style="text-align:right;">
811
</td>
<td style="text-align:right;">
338
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-511
</td>
<td style="text-align:left;">
southwest minnesota coc
</td>
<td style="text-align:right;">
-0.6388889
</td>
<td style="text-align:right;">
375.0
</td>
<td style="text-align:right;">
180
</td>
<td style="text-align:right;">
65
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-517
</td>
<td style="text-align:left;">
jackson city & county coc
</td>
<td style="text-align:right;">
-0.6625000
</td>
<td style="text-align:right;">
376.0
</td>
<td style="text-align:right;">
240
</td>
<td style="text-align:right;">
81
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-517
</td>
<td style="text-align:left;">
hendry, hardee, highlands counties coc
</td>
<td style="text-align:right;">
-0.6634473
</td>
<td style="text-align:right;">
377.0
</td>
<td style="text-align:right;">
1346
</td>
<td style="text-align:right;">
453
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-602
</td>
<td style="text-align:left;">
punta gorda/charlotte county coc
</td>
<td style="text-align:right;">
-0.6790607
</td>
<td style="text-align:right;">
378.0
</td>
<td style="text-align:right;">
511
</td>
<td style="text-align:right;">
164
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-505
</td>
<td style="text-align:left;">
fort walton beach/okaloosa, walton counties coc
</td>
<td style="text-align:right;">
-0.6861129
</td>
<td style="text-align:right;">
379.0
</td>
<td style="text-align:right;">
1577
</td>
<td style="text-align:right;">
495
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-515
</td>
<td style="text-align:left;">
elizabeth/union county coc
</td>
<td style="text-align:right;">
-0.7153067
</td>
<td style="text-align:right;">
380.0
</td>
<td style="text-align:right;">
1679
</td>
<td style="text-align:right;">
478
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-516
</td>
<td style="text-align:left;">
norton shores, muskegon city & county coc
</td>
<td style="text-align:right;">
-0.7277397
</td>
<td style="text-align:right;">
381.0
</td>
<td style="text-align:right;">
584
</td>
<td style="text-align:right;">
159
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-512
</td>
<td style="text-align:left;">
st. johns county coc
</td>
<td style="text-align:right;">
-0.7558887
</td>
<td style="text-align:right;">
382.0
</td>
<td style="text-align:right;">
1401
</td>
<td style="text-align:right;">
342
</td>
</tr>
<tr>
<td style="text-align:left;">
al-506
</td>
<td style="text-align:left;">
tuscaloosa city & county coc
</td>
<td style="text-align:right;">
-0.7673469
</td>
<td style="text-align:right;">
383.0
</td>
<td style="text-align:right;">
245
</td>
<td style="text-align:right;">
57
</td>
</tr>
</tbody>
</table>
</div>
### Fact: Change in real homeless count

*Note that this does not consider factors such as total population and
is therefore of limited use.*

The CoC with the greatest increase in overall homelessness count was the
Los Angeles City and County CoC, followed by New York City and
Seattle/King County in Washington State.

The CoC with the greatest decresse in overall homelessness count, not
including aggregate “balance of states,” was Atlanta, Georgia, followed
by the Las Vegas/Clark County CoC the and Metropolitan Denver CoC in
Colorado.

``` r
# Order by overall (real) change
wk %>%
  arrange(rank_overall_change_2014_2018, coc_code) %>%
  select(coc_code, coc_name, 
         overall_change_2014_2018, rank_overall_change_2014_2018,
         overall_homeless_2014, overall_homeless_2018) %>%
  # Write to CSV
  write_csv(paste0(save_path, "counts-of-homelessness-by-coc.csv")) %>%
  # Styling
  kable(caption = "Ordered by the real overall change in homeless count from 2014 to 2018") %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<caption>
Ordered by the real overall change in homeless count from 2014 to 2018
</caption>
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_code
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_name
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
overall\_change\_2014\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
rank\_overall\_change\_2014\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
overall\_homeless\_2014
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
overall\_homeless\_2018
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ca-600
</td>
<td style="text-align:left;">
los angeles city & county coc
</td>
<td style="text-align:right;">
15562
</td>
<td style="text-align:right;">
1.0
</td>
<td style="text-align:right;">
34393
</td>
<td style="text-align:right;">
49955
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-600
</td>
<td style="text-align:left;">
new york city coc
</td>
<td style="text-align:right;">
10866
</td>
<td style="text-align:right;">
2.0
</td>
<td style="text-align:right;">
67810
</td>
<td style="text-align:right;">
78676
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-500
</td>
<td style="text-align:left;">
seattle/king county coc
</td>
<td style="text-align:right;">
3163
</td>
<td style="text-align:right;">
3.0
</td>
<td style="text-align:right;">
8949
</td>
<td style="text-align:right;">
12112
</td>
</tr>
<tr>
<td style="text-align:left;">
or-505
</td>
<td style="text-align:left;">
oregon balance of state coc
</td>
<td style="text-align:right;">
2270
</td>
<td style="text-align:right;">
4.0
</td>
<td style="text-align:right;">
4122
</td>
<td style="text-align:right;">
6392
</td>
</tr>
<tr>
<td style="text-align:left;">
co-500
</td>
<td style="text-align:left;">
colorado balance of state coc
</td>
<td style="text-align:right;">
1801
</td>
<td style="text-align:right;">
5.0
</td>
<td style="text-align:right;">
2188
</td>
<td style="text-align:right;">
3989
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-502
</td>
<td style="text-align:left;">
oakland, berkeley/alameda county coc
</td>
<td style="text-align:right;">
1224
</td>
<td style="text-align:right;">
6.0
</td>
<td style="text-align:right;">
4272
</td>
<td style="text-align:right;">
5496
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-613
</td>
<td style="text-align:left;">
imperial county coc
</td>
<td style="text-align:right;">
1195
</td>
<td style="text-align:right;">
7.0
</td>
<td style="text-align:right;">
298
</td>
<td style="text-align:right;">
1493
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-503
</td>
<td style="text-align:left;">
sacramento city & county coc
</td>
<td style="text-align:right;">
1172
</td>
<td style="text-align:right;">
8.0
</td>
<td style="text-align:right;">
2449
</td>
<td style="text-align:right;">
3621
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-602
</td>
<td style="text-align:left;">
santa ana, anaheim/orange county coc
</td>
<td style="text-align:right;">
1122
</td>
<td style="text-align:right;">
9.0
</td>
<td style="text-align:right;">
3833
</td>
<td style="text-align:right;">
4955
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-504
</td>
<td style="text-align:left;">
newark/essex county coc
</td>
<td style="text-align:right;">
745
</td>
<td style="text-align:right;">
10.0
</td>
<td style="text-align:right;">
1483
</td>
<td style="text-align:right;">
2228
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-502
</td>
<td style="text-align:left;">
lynn coc
</td>
<td style="text-align:right;">
679
</td>
<td style="text-align:right;">
11.0
</td>
<td style="text-align:right;">
382
</td>
<td style="text-align:right;">
1061
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-504
</td>
<td style="text-align:left;">
springfield/hampden county coc
</td>
<td style="text-align:right;">
678
</td>
<td style="text-align:right;">
12.0
</td>
<td style="text-align:right;">
2690
</td>
<td style="text-align:right;">
3368
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-603
</td>
<td style="text-align:left;">
nassau, suffolk counties coc
</td>
<td style="text-align:right;">
661
</td>
<td style="text-align:right;">
13.0
</td>
<td style="text-align:right;">
3207
</td>
<td style="text-align:right;">
3868
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-600
</td>
<td style="text-align:left;">
dallas city & county, irving coc
</td>
<td style="text-align:right;">
607
</td>
<td style="text-align:right;">
14.0
</td>
<td style="text-align:right;">
3514
</td>
<td style="text-align:right;">
4121
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-516
</td>
<td style="text-align:left;">
redding/shasta, siskiyou, lassen, plumas, del norte, modoc, sierra
counties coc
</td>
<td style="text-align:right;">
519
</td>
<td style="text-align:right;">
15.0
</td>
<td style="text-align:right;">
630
</td>
<td style="text-align:right;">
1149
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-525
</td>
<td style="text-align:left;">
el dorado county coc
</td>
<td style="text-align:right;">
450
</td>
<td style="text-align:right;">
16.0
</td>
<td style="text-align:right;">
195
</td>
<td style="text-align:right;">
645
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-501
</td>
<td style="text-align:left;">
san francisco coc
</td>
<td style="text-align:right;">
449
</td>
<td style="text-align:right;">
17.0
</td>
<td style="text-align:right;">
6408
</td>
<td style="text-align:right;">
6857
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-501
</td>
<td style="text-align:left;">
washington balance of state coc
</td>
<td style="text-align:right;">
430
</td>
<td style="text-align:right;">
18.0
</td>
<td style="text-align:right;">
5236
</td>
<td style="text-align:right;">
5666
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-519
</td>
<td style="text-align:left;">
chico, paradise/butte county coc
</td>
<td style="text-align:right;">
429
</td>
<td style="text-align:right;">
19.0
</td>
<td style="text-align:right;">
696
</td>
<td style="text-align:right;">
1125
</td>
</tr>
<tr>
<td style="text-align:left;">
nv-501
</td>
<td style="text-align:left;">
reno, sparks/washoe county coc
</td>
<td style="text-align:right;">
423
</td>
<td style="text-align:right;">
20.0
</td>
<td style="text-align:right;">
769
</td>
<td style="text-align:right;">
1192
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-507
</td>
<td style="text-align:left;">
marin county coc
</td>
<td style="text-align:right;">
416
</td>
<td style="text-align:right;">
21.0
</td>
<td style="text-align:right;">
679
</td>
<td style="text-align:right;">
1095
</td>
</tr>
<tr>
<td style="text-align:left;">
az-502
</td>
<td style="text-align:left;">
phoenix, mesa/maricopa county coc
</td>
<td style="text-align:right;">
380
</td>
<td style="text-align:right;">
22.0
</td>
<td style="text-align:right;">
5918
</td>
<td style="text-align:right;">
6298
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-506
</td>
<td style="text-align:left;">
salinas/monterey, san benito counties coc
</td>
<td style="text-align:right;">
337
</td>
<td style="text-align:right;">
23.0
</td>
<td style="text-align:right;">
2962
</td>
<td style="text-align:right;">
3299
</td>
</tr>
<tr>
<td style="text-align:left;">
co-504
</td>
<td style="text-align:left;">
colorado springs/el paso county coc
</td>
<td style="text-align:right;">
332
</td>
<td style="text-align:right;">
24.0
</td>
<td style="text-align:right;">
1219
</td>
<td style="text-align:right;">
1551
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-604
</td>
<td style="text-align:left;">
monroe county coc
</td>
<td style="text-align:right;">
295
</td>
<td style="text-align:right;">
25.0
</td>
<td style="text-align:right;">
678
</td>
<td style="text-align:right;">
973
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-606
</td>
<td style="text-align:left;">
naples/collier county coc
</td>
<td style="text-align:right;">
292
</td>
<td style="text-align:right;">
26.0
</td>
<td style="text-align:right;">
361
</td>
<td style="text-align:right;">
653
</td>
</tr>
<tr>
<td style="text-align:left;">
sd-500
</td>
<td style="text-align:left;">
south dakota statewide coc
</td>
<td style="text-align:right;">
274
</td>
<td style="text-align:right;">
27.0
</td>
<td style="text-align:right;">
885
</td>
<td style="text-align:right;">
1159
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-505
</td>
<td style="text-align:left;">
richmond/contra costa county coc
</td>
<td style="text-align:right;">
225
</td>
<td style="text-align:right;">
28.0
</td>
<td style="text-align:right;">
2009
</td>
<td style="text-align:right;">
2234
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-504
</td>
<td style="text-align:left;">
norman/cleveland county coc
</td>
<td style="text-align:right;">
224
</td>
<td style="text-align:right;">
29.0
</td>
<td style="text-align:right;">
140
</td>
<td style="text-align:right;">
364
</td>
</tr>
<tr>
<td style="text-align:left;">
or-503
</td>
<td style="text-align:left;">
central oregon coc
</td>
<td style="text-align:right;">
219
</td>
<td style="text-align:right;">
30.0
</td>
<td style="text-align:right;">
568
</td>
<td style="text-align:right;">
787
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-611
</td>
<td style="text-align:left;">
amarillo coc
</td>
<td style="text-align:right;">
214
</td>
<td style="text-align:right;">
31.0
</td>
<td style="text-align:right;">
451
</td>
<td style="text-align:right;">
665
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-513
</td>
<td style="text-align:left;">
visalia/kings, tulare counties coc
</td>
<td style="text-align:right;">
204
</td>
<td style="text-align:right;">
32.0
</td>
<td style="text-align:right;">
763
</td>
<td style="text-align:right;">
967
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-500
</td>
<td style="text-align:left;">
boston coc
</td>
<td style="text-align:right;">
201
</td>
<td style="text-align:right;">
33.0
</td>
<td style="text-align:right;">
5987
</td>
<td style="text-align:right;">
6188
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-510
</td>
<td style="text-align:left;">
turlock, modesto/stanislaus county coc
</td>
<td style="text-align:right;">
200
</td>
<td style="text-align:right;">
34.5
</td>
<td style="text-align:right;">
1156
</td>
<td style="text-align:right;">
1356
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-520
</td>
<td style="text-align:left;">
citrus, hernando, lake, sumter counties coc
</td>
<td style="text-align:right;">
200
</td>
<td style="text-align:right;">
34.5
</td>
<td style="text-align:right;">
511
</td>
<td style="text-align:right;">
711
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-508
</td>
<td style="text-align:left;">
lowell coc
</td>
<td style="text-align:right;">
195
</td>
<td style="text-align:right;">
36.0
</td>
<td style="text-align:right;">
588
</td>
<td style="text-align:right;">
783
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-503
</td>
<td style="text-align:left;">
columbus/franklin county coc
</td>
<td style="text-align:right;">
193
</td>
<td style="text-align:right;">
37.0
</td>
<td style="text-align:right;">
1614
</td>
<td style="text-align:right;">
1807
</td>
</tr>
<tr>
<td style="text-align:left;">
md-505
</td>
<td style="text-align:left;">
baltimore county coc
</td>
<td style="text-align:right;">
189
</td>
<td style="text-align:right;">
38.0
</td>
<td style="text-align:right;">
569
</td>
<td style="text-align:right;">
758
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-515
</td>
<td style="text-align:left;">
roseville, rocklin/placer, nevada counties coc
</td>
<td style="text-align:right;">
188
</td>
<td style="text-align:right;">
39.0
</td>
<td style="text-align:right;">
762
</td>
<td style="text-align:right;">
950
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-503
</td>
<td style="text-align:left;">
albany city & county coc
</td>
<td style="text-align:right;">
185
</td>
<td style="text-align:right;">
40.0
</td>
<td style="text-align:right;">
650
</td>
<td style="text-align:right;">
835
</td>
</tr>
<tr>
<td style="text-align:left;">
de-500
</td>
<td style="text-align:left;">
delaware statewide coc
</td>
<td style="text-align:right;">
181
</td>
<td style="text-align:right;">
41.0
</td>
<td style="text-align:right;">
901
</td>
<td style="text-align:right;">
1082
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-500
</td>
<td style="text-align:left;">
san antonio/bexar county coc
</td>
<td style="text-align:right;">
174
</td>
<td style="text-align:right;">
42.0
</td>
<td style="text-align:right;">
2892
</td>
<td style="text-align:right;">
3066
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-503
</td>
<td style="text-align:left;">
tacoma, lakewood/pierce county coc
</td>
<td style="text-align:right;">
164
</td>
<td style="text-align:right;">
43.0
</td>
<td style="text-align:right;">
1464
</td>
<td style="text-align:right;">
1628
</td>
</tr>
<tr>
<td style="text-align:left;">
ak-501
</td>
<td style="text-align:left;">
alaska balance of state coc
</td>
<td style="text-align:right;">
161
</td>
<td style="text-align:right;">
44.0
</td>
<td style="text-align:right;">
761
</td>
<td style="text-align:right;">
922
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-503
</td>
<td style="text-align:left;">
austin/travis county coc
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
45.0
</td>
<td style="text-align:right;">
1987
</td>
<td style="text-align:right;">
2147
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-507
</td>
<td style="text-align:left;">
schenectady city & county coc
</td>
<td style="text-align:right;">
150
</td>
<td style="text-align:right;">
46.0
</td>
<td style="text-align:right;">
243
</td>
<td style="text-align:right;">
393
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-608
</td>
<td style="text-align:left;">
kingston/ulster county coc
</td>
<td style="text-align:right;">
123
</td>
<td style="text-align:right;">
47.0
</td>
<td style="text-align:right;">
341
</td>
<td style="text-align:right;">
464
</td>
</tr>
<tr>
<td style="text-align:left;">
ut-503
</td>
<td style="text-align:left;">
utah balance of state coc
</td>
<td style="text-align:right;">
117
</td>
<td style="text-align:right;">
48.0
</td>
<td style="text-align:right;">
782
</td>
<td style="text-align:right;">
899
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-515
</td>
<td style="text-align:left;">
panama city/bay, jackson counties coc
</td>
<td style="text-align:right;">
113
</td>
<td style="text-align:right;">
49.0
</td>
<td style="text-align:right;">
268
</td>
<td style="text-align:right;">
381
</td>
</tr>
<tr>
<td style="text-align:left;">
or-502
</td>
<td style="text-align:left;">
medford, ashland/jackson county coc
</td>
<td style="text-align:right;">
107
</td>
<td style="text-align:right;">
50.0
</td>
<td style="text-align:right;">
625
</td>
<td style="text-align:right;">
732
</td>
</tr>
<tr>
<td style="text-align:left;">
va-501
</td>
<td style="text-align:left;">
norfolk/chesapeake, suffolk, isle of wight, southampton counties coc
</td>
<td style="text-align:right;">
105
</td>
<td style="text-align:right;">
51.0
</td>
<td style="text-align:right;">
668
</td>
<td style="text-align:right;">
773
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-506
</td>
<td style="text-align:left;">
tallahassee/leon county coc
</td>
<td style="text-align:right;">
104
</td>
<td style="text-align:right;">
52.0
</td>
<td style="text-align:right;">
805
</td>
<td style="text-align:right;">
909
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-508
</td>
<td style="text-align:left;">
vancouver/clark county coc
</td>
<td style="text-align:right;">
100
</td>
<td style="text-align:right;">
53.0
</td>
<td style="text-align:right;">
695
</td>
<td style="text-align:right;">
795
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-511
</td>
<td style="text-align:left;">
stockton/san joaquin county coc
</td>
<td style="text-align:right;">
97
</td>
<td style="text-align:right;">
54.0
</td>
<td style="text-align:right;">
1588
</td>
<td style="text-align:right;">
1685
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-502
</td>
<td style="text-align:left;">
spokane city & county coc
</td>
<td style="text-align:right;">
96
</td>
<td style="text-align:right;">
55.0
</td>
<td style="text-align:right;">
1149
</td>
<td style="text-align:right;">
1245
</td>
</tr>
<tr>
<td style="text-align:left;">
md-512
</td>
<td style="text-align:left;">
hagerstown/washington county coc
</td>
<td style="text-align:right;">
92
</td>
<td style="text-align:right;">
57.0
</td>
<td style="text-align:right;">
107
</td>
<td style="text-align:right;">
199
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-514
</td>
<td style="text-align:left;">
jamestown, dunkirk/chautauqua county coc
</td>
<td style="text-align:right;">
92
</td>
<td style="text-align:right;">
57.0
</td>
<td style="text-align:right;">
53
</td>
<td style="text-align:right;">
145
</td>
</tr>
<tr>
<td style="text-align:left;">
or-501
</td>
<td style="text-align:left;">
portland, gresham/multnomah county coc
</td>
<td style="text-align:right;">
92
</td>
<td style="text-align:right;">
57.0
</td>
<td style="text-align:right;">
3927
</td>
<td style="text-align:right;">
4019
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-513
</td>
<td style="text-align:left;">
wayne, ontario, seneca, yates counties coc
</td>
<td style="text-align:right;">
90
</td>
<td style="text-align:right;">
59.0
</td>
<td style="text-align:right;">
92
</td>
<td style="text-align:right;">
182
</td>
</tr>
<tr>
<td style="text-align:left;">
nm-500
</td>
<td style="text-align:left;">
albuquerque coc
</td>
<td style="text-align:right;">
86
</td>
<td style="text-align:right;">
60.0
</td>
<td style="text-align:right;">
1254
</td>
<td style="text-align:right;">
1340
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-501
</td>
<td style="text-align:left;">
tulsa city & county coc
</td>
<td style="text-align:right;">
73
</td>
<td style="text-align:right;">
61.0
</td>
<td style="text-align:right;">
1010
</td>
<td style="text-align:right;">
1083
</td>
</tr>
<tr>
<td style="text-align:left;">
ak-500
</td>
<td style="text-align:left;">
anchorage coc
</td>
<td style="text-align:right;">
71
</td>
<td style="text-align:right;">
62.5
</td>
<td style="text-align:right;">
1023
</td>
<td style="text-align:right;">
1094
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-500
</td>
<td style="text-align:left;">
cincinnati/hamilton county coc
</td>
<td style="text-align:right;">
71
</td>
<td style="text-align:right;">
62.5
</td>
<td style="text-align:right;">
1043
</td>
<td style="text-align:right;">
1114
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-601
</td>
<td style="text-align:left;">
san diego city and county coc
</td>
<td style="text-align:right;">
70
</td>
<td style="text-align:right;">
64.5
</td>
<td style="text-align:right;">
8506
</td>
<td style="text-align:right;">
8576
</td>
</tr>
<tr>
<td style="text-align:left;">
md-509
</td>
<td style="text-align:left;">
frederick city & county coc
</td>
<td style="text-align:right;">
70
</td>
<td style="text-align:right;">
64.5
</td>
<td style="text-align:right;">
246
</td>
<td style="text-align:right;">
316
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-519
</td>
<td style="text-align:left;">
columbia, greene counties coc
</td>
<td style="text-align:right;">
68
</td>
<td style="text-align:right;">
66.0
</td>
<td style="text-align:right;">
128
</td>
<td style="text-align:right;">
196
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-502
</td>
<td style="text-align:left;">
racine city & county coc
</td>
<td style="text-align:right;">
65
</td>
<td style="text-align:right;">
67.0
</td>
<td style="text-align:right;">
210
</td>
<td style="text-align:right;">
275
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-516
</td>
<td style="text-align:left;">
clinton county coc
</td>
<td style="text-align:right;">
64
</td>
<td style="text-align:right;">
68.5
</td>
<td style="text-align:right;">
133
</td>
<td style="text-align:right;">
197
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-504
</td>
<td style="text-align:left;">
nashville-davidson county coc
</td>
<td style="text-align:right;">
64
</td>
<td style="text-align:right;">
68.5
</td>
<td style="text-align:right;">
2234
</td>
<td style="text-align:right;">
2298
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-505
</td>
<td style="text-align:left;">
new bedford coc
</td>
<td style="text-align:right;">
60
</td>
<td style="text-align:right;">
70.0
</td>
<td style="text-align:right;">
349
</td>
<td style="text-align:right;">
409
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-516
</td>
<td style="text-align:left;">
warren, sussex, hunterdon counties coc
</td>
<td style="text-align:right;">
59
</td>
<td style="text-align:right;">
71.5
</td>
<td style="text-align:right;">
279
</td>
<td style="text-align:right;">
338
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-602
</td>
<td style="text-align:left;">
newburgh, middletown/orange county coc
</td>
<td style="text-align:right;">
59
</td>
<td style="text-align:right;">
71.5
</td>
<td style="text-align:right;">
421
</td>
<td style="text-align:right;">
480
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-511
</td>
<td style="text-align:left;">
paterson/passaic county coc
</td>
<td style="text-align:right;">
58
</td>
<td style="text-align:right;">
73.5
</td>
<td style="text-align:right;">
376
</td>
<td style="text-align:right;">
434
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-607
</td>
<td style="text-align:left;">
sullivan county coc
</td>
<td style="text-align:right;">
58
</td>
<td style="text-align:right;">
73.5
</td>
<td style="text-align:right;">
131
</td>
<td style="text-align:right;">
189
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-506
</td>
<td style="text-align:left;">
worcester city & county coc
</td>
<td style="text-align:right;">
56
</td>
<td style="text-align:right;">
75.5
</td>
<td style="text-align:right;">
1796
</td>
<td style="text-align:right;">
1852
</td>
</tr>
<tr>
<td style="text-align:left;">
va-521
</td>
<td style="text-align:left;">
virginia balance of state coc
</td>
<td style="text-align:right;">
56
</td>
<td style="text-align:right;">
75.5
</td>
<td style="text-align:right;">
662
</td>
<td style="text-align:right;">
718
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-606
</td>
<td style="text-align:left;">
rockland county coc
</td>
<td style="text-align:right;">
55
</td>
<td style="text-align:right;">
77.5
</td>
<td style="text-align:right;">
125
</td>
<td style="text-align:right;">
180
</td>
</tr>
<tr>
<td style="text-align:left;">
va-513
</td>
<td style="text-align:left;">
harrisburg, winchester/western virginia coc
</td>
<td style="text-align:right;">
55
</td>
<td style="text-align:right;">
77.5
</td>
<td style="text-align:right;">
249
</td>
<td style="text-align:right;">
304
</td>
</tr>
<tr>
<td style="text-align:left;">
nh-500
</td>
<td style="text-align:left;">
new hampshire balance of state coc
</td>
<td style="text-align:right;">
53
</td>
<td style="text-align:right;">
79.0
</td>
<td style="text-align:right;">
689
</td>
<td style="text-align:right;">
742
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-500
</td>
<td style="text-align:left;">
philadelphia coc
</td>
<td style="text-align:right;">
50
</td>
<td style="text-align:right;">
80.0
</td>
<td style="text-align:right;">
5738
</td>
<td style="text-align:right;">
5788
</td>
</tr>
<tr>
<td style="text-align:left;">
md-506
</td>
<td style="text-align:left;">
carroll county coc
</td>
<td style="text-align:right;">
49
</td>
<td style="text-align:right;">
81.5
</td>
<td style="text-align:right;">
124
</td>
<td style="text-align:right;">
173
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-501
</td>
<td style="text-align:left;">
harrisburg/dauphin county coc
</td>
<td style="text-align:right;">
49
</td>
<td style="text-align:right;">
81.5
</td>
<td style="text-align:right;">
396
</td>
<td style="text-align:right;">
445
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-500
</td>
<td style="text-align:left;">
st. louis county coc
</td>
<td style="text-align:right;">
48
</td>
<td style="text-align:right;">
83.0
</td>
<td style="text-align:right;">
402
</td>
<td style="text-align:right;">
450
</td>
</tr>
<tr>
<td style="text-align:left;">
al-502
</td>
<td style="text-align:left;">
florence/northwest alabama coc
</td>
<td style="text-align:right;">
47
</td>
<td style="text-align:right;">
84.0
</td>
<td style="text-align:right;">
209
</td>
<td style="text-align:right;">
256
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-513
</td>
<td style="text-align:left;">
chapel hill/orange county coc
</td>
<td style="text-align:right;">
44
</td>
<td style="text-align:right;">
85.5
</td>
<td style="text-align:right;">
108
</td>
<td style="text-align:right;">
152
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-510
</td>
<td style="text-align:left;">
ithaca/tompkins county coc
</td>
<td style="text-align:right;">
44
</td>
<td style="text-align:right;">
85.5
</td>
<td style="text-align:right;">
47
</td>
<td style="text-align:right;">
91
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-524
</td>
<td style="text-align:left;">
yuba city & county/sutter county coc
</td>
<td style="text-align:right;">
39
</td>
<td style="text-align:right;">
87.5
</td>
<td style="text-align:right;">
726
</td>
<td style="text-align:right;">
765
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-506
</td>
<td style="text-align:left;">
jersey city, bayonne/hudson county coc
</td>
<td style="text-align:right;">
39
</td>
<td style="text-align:right;">
87.5
</td>
<td style="text-align:right;">
821
</td>
<td style="text-align:right;">
860
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-517
</td>
<td style="text-align:left;">
napa city & county coc
</td>
<td style="text-align:right;">
37
</td>
<td style="text-align:right;">
89.0
</td>
<td style="text-align:right;">
285
</td>
<td style="text-align:right;">
322
</td>
</tr>
<tr>
<td style="text-align:left;">
la-507
</td>
<td style="text-align:left;">
alexandria/central louisiana coc
</td>
<td style="text-align:right;">
36
</td>
<td style="text-align:right;">
90.0
</td>
<td style="text-align:right;">
141
</td>
<td style="text-align:right;">
177
</td>
</tr>
<tr>
<td style="text-align:left;">
il-506
</td>
<td style="text-align:left;">
joliet, bolingbrook/will county coc
</td>
<td style="text-align:right;">
32
</td>
<td style="text-align:right;">
92.0
</td>
<td style="text-align:right;">
309
</td>
<td style="text-align:right;">
341
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-510
</td>
<td style="text-align:left;">
saginaw city & county coc
</td>
<td style="text-align:right;">
32
</td>
<td style="text-align:right;">
92.0
</td>
<td style="text-align:right;">
325
</td>
<td style="text-align:right;">
357
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-508
</td>
<td style="text-align:left;">
moorhead/west central minnesota coc
</td>
<td style="text-align:right;">
32
</td>
<td style="text-align:right;">
92.0
</td>
<td style="text-align:right;">
214
</td>
<td style="text-align:right;">
246
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-505
</td>
<td style="text-align:left;">
southeast arkansas coc
</td>
<td style="text-align:right;">
31
</td>
<td style="text-align:right;">
94.0
</td>
<td style="text-align:right;">
70
</td>
<td style="text-align:right;">
101
</td>
</tr>
<tr>
<td style="text-align:left;">
md-511
</td>
<td style="text-align:left;">
mid-shore regional coc
</td>
<td style="text-align:right;">
30
</td>
<td style="text-align:right;">
95.0
</td>
<td style="text-align:right;">
111
</td>
<td style="text-align:right;">
141
</td>
</tr>
<tr>
<td style="text-align:left;">
il-517
</td>
<td style="text-align:left;">
aurora, elgin/kane county coc
</td>
<td style="text-align:right;">
25
</td>
<td style="text-align:right;">
96.5
</td>
<td style="text-align:right;">
405
</td>
<td style="text-align:right;">
430
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-510
</td>
<td style="text-align:left;">
murfreesboro/rutherford county coc
</td>
<td style="text-align:right;">
25
</td>
<td style="text-align:right;">
96.5
</td>
<td style="text-align:right;">
258
</td>
<td style="text-align:right;">
283
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-515
</td>
<td style="text-align:left;">
monroe city & county coc
</td>
<td style="text-align:right;">
24
</td>
<td style="text-align:right;">
99.0
</td>
<td style="text-align:right;">
185
</td>
<td style="text-align:right;">
209
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-501
</td>
<td style="text-align:left;">
asheville/buncombe county coc
</td>
<td style="text-align:right;">
24
</td>
<td style="text-align:right;">
99.0
</td>
<td style="text-align:right;">
530
</td>
<td style="text-align:right;">
554
</td>
</tr>
<tr>
<td style="text-align:left;">
ut-504
</td>
<td style="text-align:left;">
provo/mountainland coc
</td>
<td style="text-align:right;">
24
</td>
<td style="text-align:right;">
99.0
</td>
<td style="text-align:right;">
149
</td>
<td style="text-align:right;">
173
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-515
</td>
<td style="text-align:left;">
fall river coc
</td>
<td style="text-align:right;">
23
</td>
<td style="text-align:right;">
101.0
</td>
<td style="text-align:right;">
354
</td>
<td style="text-align:right;">
377
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-512
</td>
<td style="text-align:left;">
york city & county coc
</td>
<td style="text-align:right;">
22
</td>
<td style="text-align:right;">
102.5
</td>
<td style="text-align:right;">
302
</td>
<td style="text-align:right;">
324
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-603
</td>
<td style="text-align:left;">
beaver county coc
</td>
<td style="text-align:right;">
22
</td>
<td style="text-align:right;">
102.5
</td>
<td style="text-align:right;">
95
</td>
<td style="text-align:right;">
117
</td>
</tr>
<tr>
<td style="text-align:left;">
nh-501
</td>
<td style="text-align:left;">
manchester coc
</td>
<td style="text-align:right;">
20
</td>
<td style="text-align:right;">
104.0
</td>
<td style="text-align:right;">
407
</td>
<td style="text-align:right;">
427
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-518
</td>
<td style="text-align:left;">
utica, rome/oneida, madison counties coc
</td>
<td style="text-align:right;">
19
</td>
<td style="text-align:right;">
105.0
</td>
<td style="text-align:right;">
159
</td>
<td style="text-align:right;">
178
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-526
</td>
<td style="text-align:left;">
amador, calaveras, mariposa, tuolumne counties coc
</td>
<td style="text-align:right;">
16
</td>
<td style="text-align:right;">
106.5
</td>
<td style="text-align:right;">
382
</td>
<td style="text-align:right;">
398
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-503
</td>
<td style="text-align:left;">
lakeland, winterhaven/polk county coc
</td>
<td style="text-align:right;">
16
</td>
<td style="text-align:right;">
106.5
</td>
<td style="text-align:right;">
536
</td>
<td style="text-align:right;">
552
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-502
</td>
<td style="text-align:left;">
rochester/southeast minnesota coc
</td>
<td style="text-align:right;">
15
</td>
<td style="text-align:right;">
108.0
</td>
<td style="text-align:right;">
482
</td>
<td style="text-align:right;">
497
</td>
</tr>
<tr>
<td style="text-align:left;">
al-507
</td>
<td style="text-align:left;">
alabama balance of state coc
</td>
<td style="text-align:right;">
14
</td>
<td style="text-align:right;">
109.0
</td>
<td style="text-align:right;">
716
</td>
<td style="text-align:right;">
730
</td>
</tr>
<tr>
<td style="text-align:left;">
il-500
</td>
<td style="text-align:left;">
mchenry county coc
</td>
<td style="text-align:right;">
13
</td>
<td style="text-align:right;">
110.0
</td>
<td style="text-align:right;">
166
</td>
<td style="text-align:right;">
179
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-506
</td>
<td style="text-align:left;">
wilmington/brunswick, new hanover, pender counties coc
</td>
<td style="text-align:right;">
12
</td>
<td style="text-align:right;">
111.0
</td>
<td style="text-align:right;">
321
</td>
<td style="text-align:right;">
333
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-607
</td>
<td style="text-align:left;">
pasadena coc
</td>
<td style="text-align:right;">
11
</td>
<td style="text-align:right;">
112.5
</td>
<td style="text-align:right;">
666
</td>
<td style="text-align:right;">
677
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-500
</td>
<td style="text-align:left;">
wheeling, weirton area coc
</td>
<td style="text-align:right;">
11
</td>
<td style="text-align:right;">
112.5
</td>
<td style="text-align:right;">
97
</td>
<td style="text-align:right;">
108
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-509
</td>
<td style="text-align:left;">
cambridge coc
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
114.0
</td>
<td style="text-align:right;">
551
</td>
<td style="text-align:right;">
561
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-509
</td>
<td style="text-align:left;">
morris county coc
</td>
<td style="text-align:right;">
9
</td>
<td style="text-align:right;">
116.0
</td>
<td style="text-align:right;">
389
</td>
<td style="text-align:right;">
398
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-505
</td>
<td style="text-align:left;">
northeast oklahoma coc
</td>
<td style="text-align:right;">
9
</td>
<td style="text-align:right;">
116.0
</td>
<td style="text-align:right;">
383
</td>
<td style="text-align:right;">
392
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-701
</td>
<td style="text-align:left;">
bryan, college station/brazos valley coc
</td>
<td style="text-align:right;">
9
</td>
<td style="text-align:right;">
116.0
</td>
<td style="text-align:right;">
188
</td>
<td style="text-align:right;">
197
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-500
</td>
<td style="text-align:left;">
little rock/central arkansas coc
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:right;">
118.0
</td>
<td style="text-align:right;">
1074
</td>
<td style="text-align:right;">
1081
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-521
</td>
<td style="text-align:left;">
davis, woodland/yolo county coc
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
119.0
</td>
<td style="text-align:right;">
442
</td>
<td style="text-align:right;">
448
</td>
</tr>
<tr>
<td style="text-align:left;">
il-509
</td>
<td style="text-align:left;">
dekalb city & county coc
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
120.5
</td>
<td style="text-align:right;">
96
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-603
</td>
<td style="text-align:left;">
st. joseph/andrew, buchanan, dekalb counties coc
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
120.5
</td>
<td style="text-align:right;">
200
</td>
<td style="text-align:right;">
204
</td>
</tr>
<tr>
<td style="text-align:left;">
id-500
</td>
<td style="text-align:left;">
boise/ada county coc
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
122.0
</td>
<td style="text-align:right;">
753
</td>
<td style="text-align:right;">
756
</td>
</tr>
<tr>
<td style="text-align:left;">
il-513
</td>
<td style="text-align:left;">
springfield/sangamon county coc
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
123.5
</td>
<td style="text-align:right;">
269
</td>
<td style="text-align:right;">
271
</td>
</tr>
<tr>
<td style="text-align:left;">
md-510
</td>
<td style="text-align:left;">
garrett county coc
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
123.5
</td>
<td style="text-align:right;">
13
</td>
<td style="text-align:right;">
15
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-505
</td>
<td style="text-align:left;">
overland park, shawnee/johnson county coc
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
125.5
</td>
<td style="text-align:right;">
167
</td>
<td style="text-align:right;">
168
</td>
</tr>
<tr>
<td style="text-align:left;">
nh-502
</td>
<td style="text-align:left;">
nashua/hillsborough county coc
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
125.5
</td>
<td style="text-align:right;">
280
</td>
<td style="text-align:right;">
281
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-504
</td>
<td style="text-align:left;">
cattaragus county coc
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
127.0
</td>
<td style="text-align:right;">
33
</td>
<td style="text-align:right;">
33
</td>
</tr>
<tr>
<td style="text-align:left;">
ne-500
</td>
<td style="text-align:left;">
nebraska balance of state coc
</td>
<td style="text-align:right;">
-1
</td>
<td style="text-align:right;">
128.5
</td>
<td style="text-align:right;">
560
</td>
<td style="text-align:right;">
559
</td>
</tr>
<tr>
<td style="text-align:left;">
va-514
</td>
<td style="text-align:left;">
fredericksburg/spotsylvania, stafford counties coc
</td>
<td style="text-align:right;">
-1
</td>
<td style="text-align:right;">
128.5
</td>
<td style="text-align:right;">
201
</td>
<td style="text-align:right;">
200
</td>
</tr>
<tr>
<td style="text-align:left;">
md-504
</td>
<td style="text-align:left;">
howard county coc
</td>
<td style="text-align:right;">
-2
</td>
<td style="text-align:right;">
130.0
</td>
<td style="text-align:right;">
170
</td>
<td style="text-align:right;">
168
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-500
</td>
<td style="text-align:left;">
rochester, irondequoit, greece/monroe county coc
</td>
<td style="text-align:right;">
-3
</td>
<td style="text-align:right;">
131.0
</td>
<td style="text-align:right;">
838
</td>
<td style="text-align:right;">
835
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-523
</td>
<td style="text-align:left;">
eaton county coc
</td>
<td style="text-align:right;">
-4
</td>
<td style="text-align:right;">
133.5
</td>
<td style="text-align:right;">
126
</td>
<td style="text-align:right;">
122
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-509
</td>
<td style="text-align:left;">
duluth/st.louis county coc
</td>
<td style="text-align:right;">
-4
</td>
<td style="text-align:right;">
133.5
</td>
<td style="text-align:right;">
429
</td>
<td style="text-align:right;">
425
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-601
</td>
<td style="text-align:left;">
poughkeepsie/dutchess county coc
</td>
<td style="text-align:right;">
-4
</td>
<td style="text-align:right;">
133.5
</td>
<td style="text-align:right;">
403
</td>
<td style="text-align:right;">
399
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-500
</td>
<td style="text-align:left;">
chattanooga/southeast tennessee coc
</td>
<td style="text-align:right;">
-4
</td>
<td style="text-align:right;">
133.5
</td>
<td style="text-align:right;">
627
</td>
<td style="text-align:right;">
623
</td>
</tr>
<tr>
<td style="text-align:left;">
il-507
</td>
<td style="text-align:left;">
peoria, pekin/fulton, tazewell, peoria, woodford counties coc
</td>
<td style="text-align:right;">
-5
</td>
<td style="text-align:right;">
136.5
</td>
<td style="text-align:right;">
405
</td>
<td style="text-align:right;">
400
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-523
</td>
<td style="text-align:left;">
glens falls, saratoga springs/saratoga, washington, warren, hamilton
counties co
</td>
<td style="text-align:right;">
-5
</td>
<td style="text-align:right;">
136.5
</td>
<td style="text-align:right;">
262
</td>
<td style="text-align:right;">
257
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-503
</td>
<td style="text-align:left;">
topeka/shawnee county coc
</td>
<td style="text-align:right;">
-8
</td>
<td style="text-align:right;">
138.0
</td>
<td style="text-align:right;">
416
</td>
<td style="text-align:right;">
408
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-508
</td>
<td style="text-align:left;">
lansing, east lansing/ingham county coc
</td>
<td style="text-align:right;">
-10
</td>
<td style="text-align:right;">
139.5
</td>
<td style="text-align:right;">
429
</td>
<td style="text-align:right;">
419
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-513
</td>
<td style="text-align:left;">
marquette, alger counties coc
</td>
<td style="text-align:right;">
-10
</td>
<td style="text-align:right;">
139.5
</td>
<td style="text-align:right;">
80
</td>
<td style="text-align:right;">
70
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-519
</td>
<td style="text-align:left;">
attleboro, taunton/bristol county coc
</td>
<td style="text-align:right;">
-14
</td>
<td style="text-align:right;">
141.0
</td>
<td style="text-align:right;">
222
</td>
<td style="text-align:right;">
208
</td>
</tr>
<tr>
<td style="text-align:left;">
or-506
</td>
<td style="text-align:left;">
hillsboro, beaverton/washington county coc
</td>
<td style="text-align:right;">
-15
</td>
<td style="text-align:right;">
142.0
</td>
<td style="text-align:right;">
537
</td>
<td style="text-align:right;">
522
</td>
</tr>
<tr>
<td style="text-align:left;">
il-503
</td>
<td style="text-align:left;">
champaign, urbana, rantoul/champaign county coc
</td>
<td style="text-align:right;">
-17
</td>
<td style="text-align:right;">
143.5
</td>
<td style="text-align:right;">
205
</td>
<td style="text-align:right;">
188
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-501
</td>
<td style="text-align:left;">
bergen county coc
</td>
<td style="text-align:right;">
-17
</td>
<td style="text-align:right;">
143.5
</td>
<td style="text-align:right;">
371
</td>
<td style="text-align:right;">
354
</td>
</tr>
<tr>
<td style="text-align:left;">
md-503
</td>
<td style="text-align:left;">
annapolis/anne arundel county coc
</td>
<td style="text-align:right;">
-18
</td>
<td style="text-align:right;">
145.5
</td>
<td style="text-align:right;">
384
</td>
<td style="text-align:right;">
366
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-503
</td>
<td style="text-align:left;">
central tennessee coc
</td>
<td style="text-align:right;">
-18
</td>
<td style="text-align:right;">
145.5
</td>
<td style="text-align:right;">
286
</td>
<td style="text-align:right;">
268
</td>
</tr>
<tr>
<td style="text-align:left;">
il-518
</td>
<td style="text-align:left;">
rock island, moline/northwestern illinois coc
</td>
<td style="text-align:right;">
-20
</td>
<td style="text-align:right;">
148.0
</td>
<td style="text-align:right;">
218
</td>
<td style="text-align:right;">
198
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-517
</td>
<td style="text-align:left;">
somerville coc
</td>
<td style="text-align:right;">
-20
</td>
<td style="text-align:right;">
148.0
</td>
<td style="text-align:right;">
154
</td>
<td style="text-align:right;">
134
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-500
</td>
<td style="text-align:left;">
north central oklahoma coc
</td>
<td style="text-align:right;">
-20
</td>
<td style="text-align:right;">
148.0
</td>
<td style="text-align:right;">
201
</td>
<td style="text-align:right;">
181
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-511
</td>
<td style="text-align:left;">
lenawee county coc
</td>
<td style="text-align:right;">
-21
</td>
<td style="text-align:right;">
150.5
</td>
<td style="text-align:right;">
138
</td>
<td style="text-align:right;">
117
</td>
</tr>
<tr>
<td style="text-align:left;">
va-504
</td>
<td style="text-align:left;">
charlottesville coc
</td>
<td style="text-align:right;">
-21
</td>
<td style="text-align:right;">
150.5
</td>
<td style="text-align:right;">
204
</td>
<td style="text-align:right;">
183
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-503
</td>
<td style="text-align:left;">
cape cod islands coc
</td>
<td style="text-align:right;">
-23
</td>
<td style="text-align:right;">
153.0
</td>
<td style="text-align:right;">
381
</td>
<td style="text-align:right;">
358
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-505
</td>
<td style="text-align:left;">
st. cloud/central minnesota coc
</td>
<td style="text-align:right;">
-23
</td>
<td style="text-align:right;">
153.0
</td>
<td style="text-align:right;">
607
</td>
<td style="text-align:right;">
584
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-509
</td>
<td style="text-align:left;">
eastern pennsylvania coc
</td>
<td style="text-align:right;">
-23
</td>
<td style="text-align:right;">
153.0
</td>
<td style="text-align:right;">
2021
</td>
<td style="text-align:right;">
1998
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-506
</td>
<td style="text-align:left;">
northwest minnesota coc
</td>
<td style="text-align:right;">
-25
</td>
<td style="text-align:right;">
155.5
</td>
<td style="text-align:right;">
299
</td>
<td style="text-align:right;">
274
</td>
</tr>
<tr>
<td style="text-align:left;">
va-507
</td>
<td style="text-align:left;">
portsmouth coc
</td>
<td style="text-align:right;">
-25
</td>
<td style="text-align:right;">
155.5
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
135
</td>
</tr>
<tr>
<td style="text-align:left;">
il-515
</td>
<td style="text-align:left;">
south central illinois coc
</td>
<td style="text-align:right;">
-26
</td>
<td style="text-align:right;">
157.0
</td>
<td style="text-align:right;">
118
</td>
<td style="text-align:right;">
92
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-503
</td>
<td style="text-align:left;">
wilkes-barre, hazleton/luzerne county coc
</td>
<td style="text-align:right;">
-27
</td>
<td style="text-align:right;">
158.0
</td>
<td style="text-align:right;">
192
</td>
<td style="text-align:right;">
165
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-501
</td>
<td style="text-align:left;">
huntington/cabell, wayne counties coc
</td>
<td style="text-align:right;">
-28
</td>
<td style="text-align:right;">
159.0
</td>
<td style="text-align:right;">
218
</td>
<td style="text-align:right;">
190
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-504
</td>
<td style="text-align:left;">
pontiac, royal oak/oakland county coc
</td>
<td style="text-align:right;">
-30
</td>
<td style="text-align:right;">
160.0
</td>
<td style="text-align:right;">
457
</td>
<td style="text-align:right;">
427
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-612
</td>
<td style="text-align:left;">
glendale coc
</td>
<td style="text-align:right;">
-32
</td>
<td style="text-align:right;">
161.0
</td>
<td style="text-align:right;">
292
</td>
<td style="text-align:right;">
260
</td>
</tr>
<tr>
<td style="text-align:left;">
ia-500
</td>
<td style="text-align:left;">
sioux city/dakota, woodbury counties coc
</td>
<td style="text-align:right;">
-33
</td>
<td style="text-align:right;">
163.0
</td>
<td style="text-align:right;">
297
</td>
<td style="text-align:right;">
264
</td>
</tr>
<tr>
<td style="text-align:left;">
la-505
</td>
<td style="text-align:left;">
monroe/northeast louisiana coc
</td>
<td style="text-align:right;">
-33
</td>
<td style="text-align:right;">
163.0
</td>
<td style="text-align:right;">
220
</td>
<td style="text-align:right;">
187
</td>
</tr>
<tr>
<td style="text-align:left;">
md-502
</td>
<td style="text-align:left;">
harford county coc
</td>
<td style="text-align:right;">
-33
</td>
<td style="text-align:right;">
163.0
</td>
<td style="text-align:right;">
223
</td>
<td style="text-align:right;">
190
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-503
</td>
<td style="text-align:left;">
athens-clarke county coc
</td>
<td style="text-align:right;">
-35
</td>
<td style="text-align:right;">
165.0
</td>
<td style="text-align:right;">
247
</td>
<td style="text-align:right;">
212
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-505
</td>
<td style="text-align:left;">
columbus-muscogee/russell county coc
</td>
<td style="text-align:right;">
-36
</td>
<td style="text-align:right;">
166.5
</td>
<td style="text-align:right;">
312
</td>
<td style="text-align:right;">
276
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-520
</td>
<td style="text-align:left;">
franklin, essex counties coc
</td>
<td style="text-align:right;">
-36
</td>
<td style="text-align:right;">
166.5
</td>
<td style="text-align:right;">
78
</td>
<td style="text-align:right;">
42
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-512
</td>
<td style="text-align:left;">
troy/rensselaer county coc
</td>
<td style="text-align:right;">
-38
</td>
<td style="text-align:right;">
168.0
</td>
<td style="text-align:right;">
216
</td>
<td style="text-align:right;">
178
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-602
</td>
<td style="text-align:left;">
joplin/jasper, newton counties coc
</td>
<td style="text-align:right;">
-40
</td>
<td style="text-align:right;">
169.0
</td>
<td style="text-align:right;">
315
</td>
<td style="text-align:right;">
275
</td>
</tr>
<tr>
<td style="text-align:left;">
md-500
</td>
<td style="text-align:left;">
cumberland/allegany county coc
</td>
<td style="text-align:right;">
-41
</td>
<td style="text-align:right;">
170.5
</td>
<td style="text-align:right;">
120
</td>
<td style="text-align:right;">
79
</td>
</tr>
<tr>
<td style="text-align:left;">
va-603
</td>
<td style="text-align:left;">
alexandria coc
</td>
<td style="text-align:right;">
-41
</td>
<td style="text-align:right;">
170.5
</td>
<td style="text-align:right;">
267
</td>
<td style="text-align:right;">
226
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-506
</td>
<td style="text-align:left;">
reading/berks county coc
</td>
<td style="text-align:right;">
-42
</td>
<td style="text-align:right;">
172.0
</td>
<td style="text-align:right;">
604
</td>
<td style="text-align:right;">
562
</td>
</tr>
<tr>
<td style="text-align:left;">
il-520
</td>
<td style="text-align:left;">
southern illinois coc
</td>
<td style="text-align:right;">
-43
</td>
<td style="text-align:right;">
174.5
</td>
<td style="text-align:right;">
325
</td>
<td style="text-align:right;">
282
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-624
</td>
<td style="text-align:left;">
wichita falls/wise, palo pinto, wichita, archer counties coc
</td>
<td style="text-align:right;">
-43
</td>
<td style="text-align:right;">
174.5
</td>
<td style="text-align:right;">
281
</td>
<td style="text-align:right;">
238
</td>
</tr>
<tr>
<td style="text-align:left;">
va-602
</td>
<td style="text-align:left;">
loudoun county coc
</td>
<td style="text-align:right;">
-43
</td>
<td style="text-align:right;">
174.5
</td>
<td style="text-align:right;">
177
</td>
<td style="text-align:right;">
134
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-503
</td>
<td style="text-align:left;">
charleston/kanawha, putnam, boone, clay counties coc
</td>
<td style="text-align:right;">
-43
</td>
<td style="text-align:right;">
174.5
</td>
<td style="text-align:right;">
360
</td>
<td style="text-align:right;">
317
</td>
</tr>
<tr>
<td style="text-align:left;">
md-513
</td>
<td style="text-align:left;">
wicomico, somerset, worcester counties coc
</td>
<td style="text-align:right;">
-44
</td>
<td style="text-align:right;">
177.0
</td>
<td style="text-align:right;">
336
</td>
<td style="text-align:right;">
292
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-518
</td>
<td style="text-align:left;">
livingston county coc
</td>
<td style="text-align:right;">
-45
</td>
<td style="text-align:right;">
178.0
</td>
<td style="text-align:right;">
135
</td>
<td style="text-align:right;">
90
</td>
</tr>
<tr>
<td style="text-align:left;">
al-501
</td>
<td style="text-align:left;">
mobile city & county/baldwin county coc
</td>
<td style="text-align:right;">
-47
</td>
<td style="text-align:right;">
179.0
</td>
<td style="text-align:right;">
598
</td>
<td style="text-align:right;">
551
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-514
</td>
<td style="text-align:left;">
battle creek/calhoun county coc
</td>
<td style="text-align:right;">
-48
</td>
<td style="text-align:right;">
180.5
</td>
<td style="text-align:right;">
284
</td>
<td style="text-align:right;">
236
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-506
</td>
<td style="text-align:left;">
southwest oklahoma regional coc
</td>
<td style="text-align:right;">
-48
</td>
<td style="text-align:right;">
180.5
</td>
<td style="text-align:right;">
239
</td>
<td style="text-align:right;">
191
</td>
</tr>
<tr>
<td style="text-align:left;">
md-601
</td>
<td style="text-align:left;">
montgomery county coc
</td>
<td style="text-align:right;">
-51
</td>
<td style="text-align:right;">
182.0
</td>
<td style="text-align:right;">
891
</td>
<td style="text-align:right;">
840
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-522
</td>
<td style="text-align:left;">
jefferson, lewis, st. lawrence counties coc
</td>
<td style="text-align:right;">
-53
</td>
<td style="text-align:right;">
183.0
</td>
<td style="text-align:right;">
149
</td>
<td style="text-align:right;">
96
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-502
</td>
<td style="text-align:left;">
wichita/sedgwick county coc
</td>
<td style="text-align:right;">
-58
</td>
<td style="text-align:right;">
184.5
</td>
<td style="text-align:right;">
631
</td>
<td style="text-align:right;">
573
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-604
</td>
<td style="text-align:left;">
waco/mclennan county coc
</td>
<td style="text-align:right;">
-58
</td>
<td style="text-align:right;">
184.5
</td>
<td style="text-align:right;">
246
</td>
<td style="text-align:right;">
188
</td>
</tr>
<tr>
<td style="text-align:left;">
md-501
</td>
<td style="text-align:left;">
baltimore coc
</td>
<td style="text-align:right;">
-59
</td>
<td style="text-align:right;">
186.0
</td>
<td style="text-align:right;">
2567
</td>
<td style="text-align:right;">
2508
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-503
</td>
<td style="text-align:left;">
oklahoma balance of state coc
</td>
<td style="text-align:right;">
-62
</td>
<td style="text-align:right;">
187.0
</td>
<td style="text-align:right;">
295
</td>
<td style="text-align:right;">
233
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-511
</td>
<td style="text-align:left;">
binghamton, union town/broome, otsego, chenango, delaware, cortland,
tioga count
</td>
<td style="text-align:right;">
-65
</td>
<td style="text-align:right;">
188.5
</td>
<td style="text-align:right;">
309
</td>
<td style="text-align:right;">
244
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-500
</td>
<td style="text-align:left;">
charleston/low country coc
</td>
<td style="text-align:right;">
-65
</td>
<td style="text-align:right;">
188.5
</td>
<td style="text-align:right;">
516
</td>
<td style="text-align:right;">
451
</td>
</tr>
<tr>
<td style="text-align:left;">
md-507
</td>
<td style="text-align:left;">
cecil county coc
</td>
<td style="text-align:right;">
-66
</td>
<td style="text-align:right;">
190.0
</td>
<td style="text-align:right;">
195
</td>
<td style="text-align:right;">
129
</td>
</tr>
<tr>
<td style="text-align:left;">
la-506
</td>
<td style="text-align:left;">
slidell/southeast louisiana coc
</td>
<td style="text-align:right;">
-68
</td>
<td style="text-align:right;">
191.0
</td>
<td style="text-align:right;">
262
</td>
<td style="text-align:right;">
194
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-506
</td>
<td style="text-align:left;">
grand rapids, wyoming/kent county coc
</td>
<td style="text-align:right;">
-70
</td>
<td style="text-align:right;">
192.5
</td>
<td style="text-align:right;">
793
</td>
<td style="text-align:right;">
723
</td>
</tr>
<tr>
<td style="text-align:left;">
va-600
</td>
<td style="text-align:left;">
arlington county coc
</td>
<td style="text-align:right;">
-70
</td>
<td style="text-align:right;">
192.5
</td>
<td style="text-align:right;">
291
</td>
<td style="text-align:right;">
221
</td>
</tr>
<tr>
<td style="text-align:left;">
va-604
</td>
<td style="text-align:left;">
prince william county coc
</td>
<td style="text-align:right;">
-71
</td>
<td style="text-align:right;">
194.0
</td>
<td style="text-align:right;">
445
</td>
<td style="text-align:right;">
374
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-605
</td>
<td style="text-align:left;">
erie city & county coc
</td>
<td style="text-align:right;">
-72
</td>
<td style="text-align:right;">
195.0
</td>
<td style="text-align:right;">
408
</td>
<td style="text-align:right;">
336
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-503
</td>
<td style="text-align:left;">
st. clair shores, warren/macomb county coc
</td>
<td style="text-align:right;">
-73
</td>
<td style="text-align:right;">
196.0
</td>
<td style="text-align:right;">
343
</td>
<td style="text-align:right;">
270
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-500
</td>
<td style="text-align:left;">
winston-salem/forsyth county coc
</td>
<td style="text-align:right;">
-75
</td>
<td style="text-align:right;">
197.0
</td>
<td style="text-align:right;">
515
</td>
<td style="text-align:right;">
440
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-501
</td>
<td style="text-align:left;">
saint paul/ramsey county coc
</td>
<td style="text-align:right;">
-76
</td>
<td style="text-align:right;">
198.5
</td>
<td style="text-align:right;">
1500
</td>
<td style="text-align:right;">
1424
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-504
</td>
<td style="text-align:left;">
youngstown/mahoning county coc
</td>
<td style="text-align:right;">
-76
</td>
<td style="text-align:right;">
198.5
</td>
<td style="text-align:right;">
256
</td>
<td style="text-align:right;">
180
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-501
</td>
<td style="text-align:left;">
fayetteville/northwest arkansas coc
</td>
<td style="text-align:right;">
-77
</td>
<td style="text-align:right;">
200.0
</td>
<td style="text-align:right;">
551
</td>
<td style="text-align:right;">
474
</td>
</tr>
<tr>
<td style="text-align:left;">
il-519
</td>
<td style="text-align:left;">
west central illinois coc
</td>
<td style="text-align:right;">
-78
</td>
<td style="text-align:right;">
201.0
</td>
<td style="text-align:right;">
145
</td>
<td style="text-align:right;">
67
</td>
</tr>
<tr>
<td style="text-align:left;">
ms-503
</td>
<td style="text-align:left;">
gulf port/gulf coast regional coc
</td>
<td style="text-align:right;">
-80
</td>
<td style="text-align:right;">
202.0
</td>
<td style="text-align:right;">
426
</td>
<td style="text-align:right;">
346
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-506
</td>
<td style="text-align:left;">
upper cumberland coc
</td>
<td style="text-align:right;">
-84
</td>
<td style="text-align:right;">
203.0
</td>
<td style="text-align:right;">
342
</td>
<td style="text-align:right;">
258
</td>
</tr>
<tr>
<td style="text-align:left;">
va-505
</td>
<td style="text-align:left;">
newport news, hampton/virginia peninsula coc
</td>
<td style="text-align:right;">
-86
</td>
<td style="text-align:right;">
204.0
</td>
<td style="text-align:right;">
525
</td>
<td style="text-align:right;">
439
</td>
</tr>
<tr>
<td style="text-align:left;">
il-508
</td>
<td style="text-align:left;">
east st. louis, belleville/st. clair county coc
</td>
<td style="text-align:right;">
-89
</td>
<td style="text-align:right;">
205.5
</td>
<td style="text-align:right;">
339
</td>
<td style="text-align:right;">
250
</td>
</tr>
<tr>
<td style="text-align:left;">
ri-500
</td>
<td style="text-align:left;">
rhode island statewide coc
</td>
<td style="text-align:right;">
-89
</td>
<td style="text-align:right;">
205.5
</td>
<td style="text-align:right;">
1190
</td>
<td style="text-align:right;">
1101
</td>
</tr>
<tr>
<td style="text-align:left;">
wa-504
</td>
<td style="text-align:left;">
everett/snohomish county coc
</td>
<td style="text-align:right;">
-91
</td>
<td style="text-align:right;">
207.0
</td>
<td style="text-align:right;">
949
</td>
<td style="text-align:right;">
858
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-509
</td>
<td style="text-align:left;">
gastonia/cleveland, gaston, lincoln counties coc
</td>
<td style="text-align:right;">
-92
</td>
<td style="text-align:right;">
208.5
</td>
<td style="text-align:right;">
423
</td>
<td style="text-align:right;">
331
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-510
</td>
<td style="text-align:left;">
lancaster city & county coc
</td>
<td style="text-align:right;">
-92
</td>
<td style="text-align:right;">
208.5
</td>
<td style="text-align:right;">
498
</td>
<td style="text-align:right;">
406
</td>
</tr>
<tr>
<td style="text-align:left;">
il-504
</td>
<td style="text-align:left;">
madison county coc
</td>
<td style="text-align:right;">
-94
</td>
<td style="text-align:right;">
210.0
</td>
<td style="text-align:right;">
240
</td>
<td style="text-align:right;">
146
</td>
</tr>
<tr>
<td style="text-align:left;">
id-501
</td>
<td style="text-align:left;">
idaho balance of state coc
</td>
<td style="text-align:right;">
-95
</td>
<td style="text-align:right;">
213.0
</td>
<td style="text-align:right;">
1351
</td>
<td style="text-align:right;">
1256
</td>
</tr>
<tr>
<td style="text-align:left;">
il-516
</td>
<td style="text-align:left;">
decatur/macon county coc
</td>
<td style="text-align:right;">
-95
</td>
<td style="text-align:right;">
213.0
</td>
<td style="text-align:right;">
256
</td>
<td style="text-align:right;">
161
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-502
</td>
<td style="text-align:left;">
upper darby, chester, haverford/delaware county coc
</td>
<td style="text-align:right;">
-95
</td>
<td style="text-align:right;">
213.0
</td>
<td style="text-align:right;">
509
</td>
<td style="text-align:right;">
414
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-511
</td>
<td style="text-align:left;">
bristol, bensalem/bucks county coc
</td>
<td style="text-align:right;">
-95
</td>
<td style="text-align:right;">
213.0
</td>
<td style="text-align:right;">
492
</td>
<td style="text-align:right;">
397
</td>
</tr>
<tr>
<td style="text-align:left;">
vt-500
</td>
<td style="text-align:left;">
vermont balance of state coc
</td>
<td style="text-align:right;">
-95
</td>
<td style="text-align:right;">
213.0
</td>
<td style="text-align:right;">
1027
</td>
<td style="text-align:right;">
932
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-505
</td>
<td style="text-align:left;">
chester county coc
</td>
<td style="text-align:right;">
-100
</td>
<td style="text-align:right;">
216.0
</td>
<td style="text-align:right;">
679
</td>
<td style="text-align:right;">
579
</td>
</tr>
<tr>
<td style="text-align:left;">
nv-502
</td>
<td style="text-align:left;">
nevada balance of state coc
</td>
<td style="text-align:right;">
-101
</td>
<td style="text-align:right;">
217.0
</td>
<td style="text-align:right;">
370
</td>
<td style="text-align:right;">
269
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-507
</td>
<td style="text-align:left;">
pittsfield/berkshire, franklin, hampshire counties coc
</td>
<td style="text-align:right;">
-102
</td>
<td style="text-align:right;">
218.0
</td>
<td style="text-align:right;">
753
</td>
<td style="text-align:right;">
651
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-513
</td>
<td style="text-align:left;">
somerset county coc
</td>
<td style="text-align:right;">
-105
</td>
<td style="text-align:right;">
219.0
</td>
<td style="text-align:right;">
323
</td>
<td style="text-align:right;">
218
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-604
</td>
<td style="text-align:left;">
bakersfield/kern county coc
</td>
<td style="text-align:right;">
-107
</td>
<td style="text-align:right;">
220.5
</td>
<td style="text-align:right;">
992
</td>
<td style="text-align:right;">
885
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-500
</td>
<td style="text-align:left;">
atlantic city & county coc
</td>
<td style="text-align:right;">
-107
</td>
<td style="text-align:right;">
220.5
</td>
<td style="text-align:right;">
544
</td>
<td style="text-align:right;">
437
</td>
</tr>
<tr>
<td style="text-align:left;">
la-500
</td>
<td style="text-align:left;">
lafayette/acadiana coc
</td>
<td style="text-align:right;">
-108
</td>
<td style="text-align:right;">
222.5
</td>
<td style="text-align:right;">
471
</td>
<td style="text-align:right;">
363
</td>
</tr>
<tr>
<td style="text-align:left;">
va-508
</td>
<td style="text-align:left;">
lynchburg coc
</td>
<td style="text-align:right;">
-108
</td>
<td style="text-align:right;">
222.5
</td>
<td style="text-align:right;">
220
</td>
<td style="text-align:right;">
112
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-503
</td>
<td style="text-align:left;">
dakota, anoka, washington, scott, carver counties
</td>
<td style="text-align:right;">
-110
</td>
<td style="text-align:right;">
224.5
</td>
<td style="text-align:right;">
735
</td>
<td style="text-align:right;">
625
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-504
</td>
<td style="text-align:left;">
northeast minnesota coc
</td>
<td style="text-align:right;">
-110
</td>
<td style="text-align:right;">
224.5
</td>
<td style="text-align:right;">
200
</td>
<td style="text-align:right;">
90
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-505
</td>
<td style="text-align:left;">
dayton, kettering/montgomery county coc
</td>
<td style="text-align:right;">
-111
</td>
<td style="text-align:right;">
226.0
</td>
<td style="text-align:right;">
791
</td>
<td style="text-align:right;">
680
</td>
</tr>
<tr>
<td style="text-align:left;">
al-503
</td>
<td style="text-align:left;">
huntsville/north alabama coc
</td>
<td style="text-align:right;">
-112
</td>
<td style="text-align:right;">
227.0
</td>
<td style="text-align:right;">
536
</td>
<td style="text-align:right;">
424
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-507
</td>
<td style="text-align:left;">
portage, kalamazoo city & county coc
</td>
<td style="text-align:right;">
-114
</td>
<td style="text-align:right;">
228.0
</td>
<td style="text-align:right;">
681
</td>
<td style="text-align:right;">
567
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-511
</td>
<td style="text-align:left;">
southwest minnesota coc
</td>
<td style="text-align:right;">
-115
</td>
<td style="text-align:right;">
229.0
</td>
<td style="text-align:right;">
180
</td>
<td style="text-align:right;">
65
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-502
</td>
<td style="text-align:left;">
knoxville/knox county coc
</td>
<td style="text-align:right;">
-118
</td>
<td style="text-align:right;">
230.5
</td>
<td style="text-align:right;">
861
</td>
<td style="text-align:right;">
743
</td>
</tr>
<tr>
<td style="text-align:left;">
wy-500
</td>
<td style="text-align:left;">
wyoming statewide coc
</td>
<td style="text-align:right;">
-118
</td>
<td style="text-align:right;">
230.5
</td>
<td style="text-align:right;">
757
</td>
<td style="text-align:right;">
639
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-611
</td>
<td style="text-align:left;">
oxnard, san buenaventura/ventura county coc
</td>
<td style="text-align:right;">
-120
</td>
<td style="text-align:right;">
232.0
</td>
<td style="text-align:right;">
1428
</td>
<td style="text-align:right;">
1308
</td>
</tr>
<tr>
<td style="text-align:left;">
al-504
</td>
<td style="text-align:left;">
montgomery city & county coc
</td>
<td style="text-align:right;">
-121
</td>
<td style="text-align:right;">
233.0
</td>
<td style="text-align:right;">
490
</td>
<td style="text-align:right;">
369
</td>
</tr>
<tr>
<td style="text-align:left;">
ia-502
</td>
<td style="text-align:left;">
des moines/polk county coc
</td>
<td style="text-align:right;">
-122
</td>
<td style="text-align:right;">
234.0
</td>
<td style="text-align:right;">
886
</td>
<td style="text-align:right;">
764
</td>
</tr>
<tr>
<td style="text-align:left;">
va-502
</td>
<td style="text-align:left;">
roanoke city & county, salem coc
</td>
<td style="text-align:right;">
-123
</td>
<td style="text-align:right;">
235.0
</td>
<td style="text-align:right;">
440
</td>
<td style="text-align:right;">
317
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-603
</td>
<td style="text-align:left;">
santa maria/santa barbara county coc
</td>
<td style="text-align:right;">
-126
</td>
<td style="text-align:right;">
236.5
</td>
<td style="text-align:right;">
1832
</td>
<td style="text-align:right;">
1706
</td>
</tr>
<tr>
<td style="text-align:left;">
or-500
</td>
<td style="text-align:left;">
eugene, springfield/lane county coc
</td>
<td style="text-align:right;">
-126
</td>
<td style="text-align:right;">
236.5
</td>
<td style="text-align:right;">
1767
</td>
<td style="text-align:right;">
1641
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-508
</td>
<td style="text-align:left;">
scranton/lackawanna county coc
</td>
<td style="text-align:right;">
-128
</td>
<td style="text-align:right;">
238.0
</td>
<td style="text-align:right;">
287
</td>
<td style="text-align:right;">
159
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-508
</td>
<td style="text-align:left;">
buffalo, niagara falls/erie, niagara, orleans, genesee, wyoming counties
coc
</td>
<td style="text-align:right;">
-131
</td>
<td style="text-align:right;">
239.0
</td>
<td style="text-align:right;">
1088
</td>
<td style="text-align:right;">
957
</td>
</tr>
<tr>
<td style="text-align:left;">
ct-505
</td>
<td style="text-align:left;">
connecticut balance of state coc
</td>
<td style="text-align:right;">
-132
</td>
<td style="text-align:right;">
240.5
</td>
<td style="text-align:right;">
3367
</td>
<td style="text-align:right;">
3235
</td>
</tr>
<tr>
<td style="text-align:left;">
il-502
</td>
<td style="text-align:left;">
waukegan, north chicago/lake county coc
</td>
<td style="text-align:right;">
-132
</td>
<td style="text-align:right;">
240.5
</td>
<td style="text-align:right;">
409
</td>
<td style="text-align:right;">
277
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-512
</td>
<td style="text-align:left;">
morristown/blount, sevier, campbell, cocke counties coc
</td>
<td style="text-align:right;">
-135
</td>
<td style="text-align:right;">
242.0
</td>
<td style="text-align:right;">
933
</td>
<td style="text-align:right;">
798
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-506
</td>
<td style="text-align:left;">
marietta/cobb county coc
</td>
<td style="text-align:right;">
-139
</td>
<td style="text-align:right;">
243.0
</td>
<td style="text-align:right;">
523
</td>
<td style="text-align:right;">
384
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-603
</td>
<td style="text-align:left;">
ft myers, cape coral/lee county coc
</td>
<td style="text-align:right;">
-143
</td>
<td style="text-align:right;">
244.0
</td>
<td style="text-align:right;">
871
</td>
<td style="text-align:right;">
728
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-501
</td>
<td style="text-align:left;">
toledo/lucas county coc
</td>
<td style="text-align:right;">
-147
</td>
<td style="text-align:right;">
245.5
</td>
<td style="text-align:right;">
809
</td>
<td style="text-align:right;">
662
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-504
</td>
<td style="text-align:left;">
lower merion, norristown, abington/montgomery county coc
</td>
<td style="text-align:right;">
-147
</td>
<td style="text-align:right;">
245.5
</td>
<td style="text-align:right;">
438
</td>
<td style="text-align:right;">
291
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-501
</td>
<td style="text-align:left;">
tampa/hillsborough county coc
</td>
<td style="text-align:right;">
-149
</td>
<td style="text-align:right;">
247.0
</td>
<td style="text-align:right;">
1944
</td>
<td style="text-align:right;">
1795
</td>
</tr>
<tr>
<td style="text-align:left;">
ky-500
</td>
<td style="text-align:left;">
kentucky balance of state coc
</td>
<td style="text-align:right;">
-152
</td>
<td style="text-align:right;">
248.0
</td>
<td style="text-align:right;">
2229
</td>
<td style="text-align:right;">
2077
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-514
</td>
<td style="text-align:left;">
trenton/mercer county coc
</td>
<td style="text-align:right;">
-153
</td>
<td style="text-align:right;">
249.0
</td>
<td style="text-align:right;">
632
</td>
<td style="text-align:right;">
479
</td>
</tr>
<tr>
<td style="text-align:left;">
il-501
</td>
<td style="text-align:left;">
rockford/winnebago, boone counties coc
</td>
<td style="text-align:right;">
-154
</td>
<td style="text-align:right;">
250.0
</td>
<td style="text-align:right;">
410
</td>
<td style="text-align:right;">
256
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-517
</td>
<td style="text-align:left;">
jackson city & county coc
</td>
<td style="text-align:right;">
-159
</td>
<td style="text-align:right;">
251.0
</td>
<td style="text-align:right;">
240
</td>
<td style="text-align:right;">
81
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-512
</td>
<td style="text-align:left;">
grand traverse, antrim, leelanau counties coc
</td>
<td style="text-align:right;">
-161
</td>
<td style="text-align:right;">
252.5
</td>
<td style="text-align:right;">
396
</td>
<td style="text-align:right;">
235
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-519
</td>
<td style="text-align:left;">
holland/ottawa county coc
</td>
<td style="text-align:right;">
-161
</td>
<td style="text-align:right;">
252.5
</td>
<td style="text-align:right;">
387
</td>
<td style="text-align:right;">
226
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-503
</td>
<td style="text-align:left;">
madison/dane county coc
</td>
<td style="text-align:right;">
-163
</td>
<td style="text-align:right;">
254.0
</td>
<td style="text-align:right;">
777
</td>
<td style="text-align:right;">
614
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-518
</td>
<td style="text-align:left;">
vallejo/solano county coc
</td>
<td style="text-align:right;">
-166
</td>
<td style="text-align:right;">
255.0
</td>
<td style="text-align:right;">
1295
</td>
<td style="text-align:right;">
1129
</td>
</tr>
<tr>
<td style="text-align:left;">
hi-500
</td>
<td style="text-align:left;">
hawaii balance of state coc
</td>
<td style="text-align:right;">
-171
</td>
<td style="text-align:right;">
256.0
</td>
<td style="text-align:right;">
2206
</td>
<td style="text-align:right;">
2035
</td>
</tr>
<tr>
<td style="text-align:left;">
vt-501
</td>
<td style="text-align:left;">
burlington/chittenden county coc
</td>
<td style="text-align:right;">
-173
</td>
<td style="text-align:right;">
257.0
</td>
<td style="text-align:right;">
532
</td>
<td style="text-align:right;">
359
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-600
</td>
<td style="text-align:left;">
springfield/greene, christian, webster counties coc
</td>
<td style="text-align:right;">
-177
</td>
<td style="text-align:right;">
258.0
</td>
<td style="text-align:right;">
656
</td>
<td style="text-align:right;">
479
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-502
</td>
<td style="text-align:left;">
burlington county coc
</td>
<td style="text-align:right;">
-180
</td>
<td style="text-align:right;">
259.0
</td>
<td style="text-align:right;">
1020
</td>
<td style="text-align:right;">
840
</td>
</tr>
<tr>
<td style="text-align:left;">
md-600
</td>
<td style="text-align:left;">
prince george’s county coc
</td>
<td style="text-align:right;">
-181
</td>
<td style="text-align:right;">
260.0
</td>
<td style="text-align:right;">
659
</td>
<td style="text-align:right;">
478
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-606
</td>
<td style="text-align:left;">
missouri balance of state coc
</td>
<td style="text-align:right;">
-183
</td>
<td style="text-align:right;">
261.0
</td>
<td style="text-align:right;">
1528
</td>
<td style="text-align:right;">
1345
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-500
</td>
<td style="text-align:left;">
sarasota, bradenton/manatee, sarasota counties coc
</td>
<td style="text-align:right;">
-185
</td>
<td style="text-align:right;">
262.0
</td>
<td style="text-align:right;">
1377
</td>
<td style="text-align:right;">
1192
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-507
</td>
<td style="text-align:left;">
raleigh/wake county coc
</td>
<td style="text-align:right;">
-187
</td>
<td style="text-align:right;">
263.0
</td>
<td style="text-align:right;">
1170
</td>
<td style="text-align:right;">
983
</td>
</tr>
<tr>
<td style="text-align:left;">
al-506
</td>
<td style="text-align:left;">
tuscaloosa city & county coc
</td>
<td style="text-align:right;">
-188
</td>
<td style="text-align:right;">
264.0
</td>
<td style="text-align:right;">
245
</td>
<td style="text-align:right;">
57
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-609
</td>
<td style="text-align:left;">
san bernardino city & county coc
</td>
<td style="text-align:right;">
-197
</td>
<td style="text-align:right;">
266.0
</td>
<td style="text-align:right;">
2315
</td>
<td style="text-align:right;">
2118
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-505
</td>
<td style="text-align:left;">
flint/genesee county coc
</td>
<td style="text-align:right;">
-197
</td>
<td style="text-align:right;">
266.0
</td>
<td style="text-align:right;">
635
</td>
<td style="text-align:right;">
438
</td>
</tr>
<tr>
<td style="text-align:left;">
va-503
</td>
<td style="text-align:left;">
virginia beach coc
</td>
<td style="text-align:right;">
-197
</td>
<td style="text-align:right;">
266.0
</td>
<td style="text-align:right;">
440
</td>
<td style="text-align:right;">
243
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-507
</td>
<td style="text-align:left;">
southeastern oklahoma regional coc
</td>
<td style="text-align:right;">
-198
</td>
<td style="text-align:right;">
268.0
</td>
<td style="text-align:right;">
442
</td>
<td style="text-align:right;">
244
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-507
</td>
<td style="text-align:left;">
orlando/orange, osceola, seminole counties coc
</td>
<td style="text-align:right;">
-201
</td>
<td style="text-align:right;">
269.0
</td>
<td style="text-align:right;">
2254
</td>
<td style="text-align:right;">
2053
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-504
</td>
<td style="text-align:left;">
augusta-richmond county coc
</td>
<td style="text-align:right;">
-203
</td>
<td style="text-align:right;">
270.0
</td>
<td style="text-align:right;">
472
</td>
<td style="text-align:right;">
269
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-503
</td>
<td style="text-align:left;">
north carolina balance of state coc
</td>
<td style="text-align:right;">
-204
</td>
<td style="text-align:right;">
271.0
</td>
<td style="text-align:right;">
3195
</td>
<td style="text-align:right;">
2991
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-507
</td>
<td style="text-align:left;">
new brunswick/middlesex county coc
</td>
<td style="text-align:right;">
-205
</td>
<td style="text-align:right;">
272.0
</td>
<td style="text-align:right;">
802
</td>
<td style="text-align:right;">
597
</td>
</tr>
<tr>
<td style="text-align:left;">
in-503
</td>
<td style="text-align:left;">
indianapolis coc
</td>
<td style="text-align:right;">
-208
</td>
<td style="text-align:right;">
273.0
</td>
<td style="text-align:right;">
1890
</td>
<td style="text-align:right;">
1682
</td>
</tr>
<tr>
<td style="text-align:left;">
me-500
</td>
<td style="text-align:left;">
maine statewide coc
</td>
<td style="text-align:right;">
-210
</td>
<td style="text-align:right;">
274.0
</td>
<td style="text-align:right;">
2726
</td>
<td style="text-align:right;">
2516
</td>
</tr>
<tr>
<td style="text-align:left;">
az-500
</td>
<td style="text-align:left;">
arizona balance of state coc
</td>
<td style="text-align:right;">
-211
</td>
<td style="text-align:right;">
275.5
</td>
<td style="text-align:right;">
2398
</td>
<td style="text-align:right;">
2187
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-511
</td>
<td style="text-align:left;">
pensacola/escambia, santa rosa counties coc
</td>
<td style="text-align:right;">
-211
</td>
<td style="text-align:right;">
275.5
</td>
<td style="text-align:right;">
843
</td>
<td style="text-align:right;">
632
</td>
</tr>
<tr>
<td style="text-align:left;">
hi-501
</td>
<td style="text-align:left;">
honolulu city and county coc
</td>
<td style="text-align:right;">
-217
</td>
<td style="text-align:right;">
277.0
</td>
<td style="text-align:right;">
4712
</td>
<td style="text-align:right;">
4495
</td>
</tr>
<tr>
<td style="text-align:left;">
ia-501
</td>
<td style="text-align:left;">
iowa balance of state coc
</td>
<td style="text-align:right;">
-218
</td>
<td style="text-align:right;">
278.0
</td>
<td style="text-align:right;">
1939
</td>
<td style="text-align:right;">
1721
</td>
</tr>
<tr>
<td style="text-align:left;">
ne-501
</td>
<td style="text-align:left;">
omaha, council bluffs coc
</td>
<td style="text-align:right;">
-219
</td>
<td style="text-align:right;">
279.0
</td>
<td style="text-align:right;">
1630
</td>
<td style="text-align:right;">
1411
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-503
</td>
<td style="text-align:left;">
myrtle beach, sumter city & county coc
</td>
<td style="text-align:right;">
-225
</td>
<td style="text-align:right;">
280.0
</td>
<td style="text-align:right;">
1317
</td>
<td style="text-align:right;">
1092
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-522
</td>
<td style="text-align:left;">
humboldt county coc
</td>
<td style="text-align:right;">
-229
</td>
<td style="text-align:right;">
281.0
</td>
<td style="text-align:right;">
932
</td>
<td style="text-align:right;">
703
</td>
</tr>
<tr>
<td style="text-align:left;">
or-507
</td>
<td style="text-align:left;">
clackamas county coc
</td>
<td style="text-align:right;">
-235
</td>
<td style="text-align:right;">
282.0
</td>
<td style="text-align:right;">
618
</td>
<td style="text-align:right;">
383
</td>
</tr>
<tr>
<td style="text-align:left;">
va-500
</td>
<td style="text-align:left;">
richmond/henrico, chesterfield, hanover counties coc
</td>
<td style="text-align:right;">
-237
</td>
<td style="text-align:right;">
283.0
</td>
<td style="text-align:right;">
846
</td>
<td style="text-align:right;">
609
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-509
</td>
<td style="text-align:left;">
appalachian regional coc
</td>
<td style="text-align:right;">
-238
</td>
<td style="text-align:right;">
284.5
</td>
<td style="text-align:right;">
598
</td>
<td style="text-align:right;">
360
</td>
</tr>
<tr>
<td style="text-align:left;">
va-601
</td>
<td style="text-align:left;">
fairfax county coc
</td>
<td style="text-align:right;">
-238
</td>
<td style="text-align:right;">
284.5
</td>
<td style="text-align:right;">
1225
</td>
<td style="text-align:right;">
987
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-504
</td>
<td style="text-align:left;">
greensboro, high point coc
</td>
<td style="text-align:right;">
-240
</td>
<td style="text-align:right;">
286.0
</td>
<td style="text-align:right;">
897
</td>
<td style="text-align:right;">
657
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-502
</td>
<td style="text-align:left;">
dearborn, dearborn heights, westland/wayne county coc
</td>
<td style="text-align:right;">
-245
</td>
<td style="text-align:right;">
287.0
</td>
<td style="text-align:right;">
456
</td>
<td style="text-align:right;">
211
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-508
</td>
<td style="text-align:left;">
monmouth county coc
</td>
<td style="text-align:right;">
-253
</td>
<td style="text-align:right;">
288.5
</td>
<td style="text-align:right;">
588
</td>
<td style="text-align:right;">
335
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-508
</td>
<td style="text-align:left;">
canton, massillon, alliance/stark county coc
</td>
<td style="text-align:right;">
-253
</td>
<td style="text-align:right;">
288.5
</td>
<td style="text-align:right;">
531
</td>
<td style="text-align:right;">
278
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-520
</td>
<td style="text-align:left;">
merced city & county coc
</td>
<td style="text-align:right;">
-254
</td>
<td style="text-align:right;">
290.0
</td>
<td style="text-align:right;">
768
</td>
<td style="text-align:right;">
514
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-510
</td>
<td style="text-align:left;">
jacksonville-duval, clay counties coc
</td>
<td style="text-align:right;">
-255
</td>
<td style="text-align:right;">
291.0
</td>
<td style="text-align:right;">
2049
</td>
<td style="text-align:right;">
1794
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-509
</td>
<td style="text-align:left;">
washtenaw county coc
</td>
<td style="text-align:right;">
-263
</td>
<td style="text-align:right;">
292.0
</td>
<td style="text-align:right;">
545
</td>
<td style="text-align:right;">
282
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-510
</td>
<td style="text-align:left;">
lakewood township/ocean county coc
</td>
<td style="text-align:right;">
-273
</td>
<td style="text-align:right;">
293.0
</td>
<td style="text-align:right;">
627
</td>
<td style="text-align:right;">
354
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-501
</td>
<td style="text-align:left;">
elmira/steuben, allegany, livingston, chemung, schuyler counties coc
</td>
<td style="text-align:right;">
-279
</td>
<td style="text-align:right;">
294.0
</td>
<td style="text-align:right;">
512
</td>
<td style="text-align:right;">
233
</td>
</tr>
<tr>
<td style="text-align:left;">
la-502
</td>
<td style="text-align:left;">
shreveport, bossier/northwest louisiana coc
</td>
<td style="text-align:right;">
-280
</td>
<td style="text-align:right;">
295.0
</td>
<td style="text-align:right;">
655
</td>
<td style="text-align:right;">
375
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-511
</td>
<td style="text-align:left;">
fayetteville/cumberland county coc
</td>
<td style="text-align:right;">
-281
</td>
<td style="text-align:right;">
296.5
</td>
<td style="text-align:right;">
653
</td>
<td style="text-align:right;">
372
</td>
</tr>
<tr>
<td style="text-align:left;">
nm-501
</td>
<td style="text-align:left;">
new mexico balance of state coc
</td>
<td style="text-align:right;">
-281
</td>
<td style="text-align:right;">
296.5
</td>
<td style="text-align:right;">
1492
</td>
<td style="text-align:right;">
1211
</td>
</tr>
<tr>
<td style="text-align:left;">
il-512
</td>
<td style="text-align:left;">
bloomington/central illinois coc
</td>
<td style="text-align:right;">
-282
</td>
<td style="text-align:right;">
298.0
</td>
<td style="text-align:right;">
669
</td>
<td style="text-align:right;">
387
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-506
</td>
<td style="text-align:left;">
akron, barberton/summit county coc
</td>
<td style="text-align:right;">
-283
</td>
<td style="text-align:right;">
299.0
</td>
<td style="text-align:right;">
870
</td>
<td style="text-align:right;">
587
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-605
</td>
<td style="text-align:left;">
west palm beach/palm beach county coc
</td>
<td style="text-align:right;">
-287
</td>
<td style="text-align:right;">
300.0
</td>
<td style="text-align:right;">
1596
</td>
<td style="text-align:right;">
1309
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-503
</td>
<td style="text-align:left;">
arkansas balance of state coc
</td>
<td style="text-align:right;">
-288
</td>
<td style="text-align:right;">
301.0
</td>
<td style="text-align:right;">
1056
</td>
<td style="text-align:right;">
768
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-502
</td>
<td style="text-align:left;">
cleveland/cuyahoga county coc
</td>
<td style="text-align:right;">
-295
</td>
<td style="text-align:right;">
302.0
</td>
<td style="text-align:right;">
2103
</td>
<td style="text-align:right;">
1808
</td>
</tr>
<tr>
<td style="text-align:left;">
ok-502
</td>
<td style="text-align:left;">
oklahoma city coc
</td>
<td style="text-align:right;">
-298
</td>
<td style="text-align:right;">
303.0
</td>
<td style="text-align:right;">
1481
</td>
<td style="text-align:right;">
1183
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-523
</td>
<td style="text-align:left;">
colusa, glenn, trinity counties coc
</td>
<td style="text-align:right;">
-299
</td>
<td style="text-align:right;">
304.0
</td>
<td style="text-align:right;">
567
</td>
<td style="text-align:right;">
268
</td>
</tr>
<tr>
<td style="text-align:left;">
la-509
</td>
<td style="text-align:left;">
louisiana balance of state coc
</td>
<td style="text-align:right;">
-301
</td>
<td style="text-align:right;">
305.0
</td>
<td style="text-align:right;">
876
</td>
<td style="text-align:right;">
575
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-505
</td>
<td style="text-align:left;">
syracuse, auburn/onondaga, oswego, cayuga counties coc
</td>
<td style="text-align:right;">
-302
</td>
<td style="text-align:right;">
306.0
</td>
<td style="text-align:right;">
1024
</td>
<td style="text-align:right;">
722
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-507
</td>
<td style="text-align:left;">
savannah/chatham county coc
</td>
<td style="text-align:right;">
-306
</td>
<td style="text-align:right;">
307.0
</td>
<td style="text-align:right;">
1315
</td>
<td style="text-align:right;">
1009
</td>
</tr>
<tr>
<td style="text-align:left;">
il-511
</td>
<td style="text-align:left;">
cook county coc
</td>
<td style="text-align:right;">
-309
</td>
<td style="text-align:right;">
308.0
</td>
<td style="text-align:right;">
1182
</td>
<td style="text-align:right;">
873
</td>
</tr>
<tr>
<td style="text-align:left;">
ny-604
</td>
<td style="text-align:left;">
yonkers, mount vernon/westchester county coc
</td>
<td style="text-align:right;">
-311
</td>
<td style="text-align:right;">
309.0
</td>
<td style="text-align:right;">
2138
</td>
<td style="text-align:right;">
1827
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-500
</td>
<td style="text-align:left;">
san jose/santa clara city & county coc
</td>
<td style="text-align:right;">
-313
</td>
<td style="text-align:right;">
310.0
</td>
<td style="text-align:right;">
7567
</td>
<td style="text-align:right;">
7254
</td>
</tr>
<tr>
<td style="text-align:left;">
mt-500
</td>
<td style="text-align:left;">
montana statewide coc
</td>
<td style="text-align:right;">
-340
</td>
<td style="text-align:right;">
311.0
</td>
<td style="text-align:right;">
1745
</td>
<td style="text-align:right;">
1405
</td>
</tr>
<tr>
<td style="text-align:left;">
ct-503
</td>
<td style="text-align:left;">
bridgeport, stamford, norwalk/fairfield county coc
</td>
<td style="text-align:right;">
-342
</td>
<td style="text-align:right;">
312.0
</td>
<td style="text-align:right;">
1083
</td>
<td style="text-align:right;">
741
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-514
</td>
<td style="text-align:left;">
ocala/marion county coc
</td>
<td style="text-align:right;">
-346
</td>
<td style="text-align:right;">
314.0
</td>
<td style="text-align:right;">
918
</td>
<td style="text-align:right;">
572
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-505
</td>
<td style="text-align:left;">
charlotte/mecklenberg coc
</td>
<td style="text-align:right;">
-346
</td>
<td style="text-align:right;">
314.0
</td>
<td style="text-align:right;">
2014
</td>
<td style="text-align:right;">
1668
</td>
</tr>
<tr>
<td style="text-align:left;">
ut-500
</td>
<td style="text-align:left;">
salt lake city & county coc
</td>
<td style="text-align:right;">
-346
</td>
<td style="text-align:right;">
314.0
</td>
<td style="text-align:right;">
2150
</td>
<td style="text-align:right;">
1804
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-602
</td>
<td style="text-align:left;">
punta gorda/charlotte county coc
</td>
<td style="text-align:right;">
-347
</td>
<td style="text-align:right;">
316.0
</td>
<td style="text-align:right;">
511
</td>
<td style="text-align:right;">
164
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-601
</td>
<td style="text-align:left;">
western pennsylvania coc
</td>
<td style="text-align:right;">
-353
</td>
<td style="text-align:right;">
317.0
</td>
<td style="text-align:right;">
1101
</td>
<td style="text-align:right;">
748
</td>
</tr>
<tr>
<td style="text-align:left;">
il-514
</td>
<td style="text-align:left;">
dupage county coc
</td>
<td style="text-align:right;">
-359
</td>
<td style="text-align:right;">
318.0
</td>
<td style="text-align:right;">
654
</td>
<td style="text-align:right;">
295
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-503
</td>
<td style="text-align:left;">
st. charles city & county, lincoln, warren counties coc
</td>
<td style="text-align:right;">
-364
</td>
<td style="text-align:right;">
319.0
</td>
<td style="text-align:right;">
896
</td>
<td style="text-align:right;">
532
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-603
</td>
<td style="text-align:left;">
el paso city & county coc
</td>
<td style="text-align:right;">
-368
</td>
<td style="text-align:right;">
320.0
</td>
<td style="text-align:right;">
1260
</td>
<td style="text-align:right;">
892
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-502
</td>
<td style="text-align:left;">
columbia/midlands coc
</td>
<td style="text-align:right;">
-383
</td>
<td style="text-align:right;">
321.0
</td>
<td style="text-align:right;">
1588
</td>
<td style="text-align:right;">
1205
</td>
</tr>
<tr>
<td style="text-align:left;">
ne-502
</td>
<td style="text-align:left;">
lincoln coc
</td>
<td style="text-align:right;">
-385
</td>
<td style="text-align:right;">
322.0
</td>
<td style="text-align:right;">
836
</td>
<td style="text-align:right;">
451
</td>
</tr>
<tr>
<td style="text-align:left;">
ks-507
</td>
<td style="text-align:left;">
kansas balance of state coc
</td>
<td style="text-align:right;">
-389
</td>
<td style="text-align:right;">
323.0
</td>
<td style="text-align:right;">
1307
</td>
<td style="text-align:right;">
918
</td>
</tr>
<tr>
<td style="text-align:left;">
ky-501
</td>
<td style="text-align:left;">
louisville-jefferson county coc
</td>
<td style="text-align:right;">
-390
</td>
<td style="text-align:right;">
324.0
</td>
<td style="text-align:right;">
1316
</td>
<td style="text-align:right;">
926
</td>
</tr>
<tr>
<td style="text-align:left;">
ms-501
</td>
<td style="text-align:left;">
mississippi balance of state coc
</td>
<td style="text-align:right;">
-394
</td>
<td style="text-align:right;">
325.0
</td>
<td style="text-align:right;">
954
</td>
<td style="text-align:right;">
560
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-604
</td>
<td style="text-align:left;">
kansas city, independence, lee’s summit/jackson, wyandotte counties, mo
& ks
</td>
<td style="text-align:right;">
-395
</td>
<td style="text-align:right;">
326.0
</td>
<td style="text-align:right;">
2193
</td>
<td style="text-align:right;">
1798
</td>
</tr>
<tr>
<td style="text-align:left;">
ms-500
</td>
<td style="text-align:left;">
jackson/rankin, madison counties coc
</td>
<td style="text-align:right;">
-400
</td>
<td style="text-align:right;">
327.0
</td>
<td style="text-align:right;">
846
</td>
<td style="text-align:right;">
446
</td>
</tr>
<tr>
<td style="text-align:left;">
mo-501
</td>
<td style="text-align:left;">
st.louis city coc
</td>
<td style="text-align:right;">
-405
</td>
<td style="text-align:right;">
328.5
</td>
<td style="text-align:right;">
1354
</td>
<td style="text-align:right;">
949
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-516
</td>
<td style="text-align:left;">
northwest north carolina coc
</td>
<td style="text-align:right;">
-405
</td>
<td style="text-align:right;">
328.5
</td>
<td style="text-align:right;">
854
</td>
<td style="text-align:right;">
449
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-601
</td>
<td style="text-align:left;">
fort worth, arlington/tarrant county coc
</td>
<td style="text-align:right;">
-410
</td>
<td style="text-align:right;">
330.0
</td>
<td style="text-align:right;">
2425
</td>
<td style="text-align:right;">
2015
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-500
</td>
<td style="text-align:left;">
wisconsin balance of state coc
</td>
<td style="text-align:right;">
-422
</td>
<td style="text-align:right;">
331.0
</td>
<td style="text-align:right;">
3569
</td>
<td style="text-align:right;">
3147
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-516
</td>
<td style="text-align:left;">
norton shores, muskegon city & county coc
</td>
<td style="text-align:right;">
-425
</td>
<td style="text-align:right;">
332.0
</td>
<td style="text-align:right;">
584
</td>
<td style="text-align:right;">
159
</td>
</tr>
<tr>
<td style="text-align:left;">
al-500
</td>
<td style="text-align:left;">
birmingham/jefferson, st. clair, shelby counties coc
</td>
<td style="text-align:right;">
-428
</td>
<td style="text-align:right;">
333.0
</td>
<td style="text-align:right;">
1329
</td>
<td style="text-align:right;">
901
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-514
</td>
<td style="text-align:left;">
fresno city & county/madera county coc
</td>
<td style="text-align:right;">
-448
</td>
<td style="text-align:right;">
334.5
</td>
<td style="text-align:right;">
2592
</td>
<td style="text-align:right;">
2144
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-601
</td>
<td style="text-align:left;">
ft lauderdale/broward county coc
</td>
<td style="text-align:right;">
-448
</td>
<td style="text-align:right;">
334.5
</td>
<td style="text-align:right;">
2766
</td>
<td style="text-align:right;">
2318
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-501
</td>
<td style="text-align:left;">
memphis/shelby county coc
</td>
<td style="text-align:right;">
-449
</td>
<td style="text-align:right;">
336.0
</td>
<td style="text-align:right;">
1675
</td>
<td style="text-align:right;">
1226
</td>
</tr>
<tr>
<td style="text-align:left;">
sc-501
</td>
<td style="text-align:left;">
greenville, anderson, spartanburg/upstate coc
</td>
<td style="text-align:right;">
-451
</td>
<td style="text-align:right;">
337.0
</td>
<td style="text-align:right;">
1636
</td>
<td style="text-align:right;">
1185
</td>
</tr>
<tr>
<td style="text-align:left;">
nc-502
</td>
<td style="text-align:left;">
durham city & county coc
</td>
<td style="text-align:right;">
-473
</td>
<td style="text-align:right;">
338.0
</td>
<td style="text-align:right;">
811
</td>
<td style="text-align:right;">
338
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-508
</td>
<td style="text-align:left;">
gainesville/alachua, putnam counties coc
</td>
<td style="text-align:right;">
-500
</td>
<td style="text-align:right;">
339.0
</td>
<td style="text-align:right;">
1256
</td>
<td style="text-align:right;">
756
</td>
</tr>
<tr>
<td style="text-align:left;">
in-502
</td>
<td style="text-align:left;">
indiana balance of state coc
</td>
<td style="text-align:right;">
-505
</td>
<td style="text-align:right;">
340.0
</td>
<td style="text-align:right;">
4081
</td>
<td style="text-align:right;">
3576
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-509
</td>
<td style="text-align:left;">
mendocino county coc
</td>
<td style="text-align:right;">
-524
</td>
<td style="text-align:right;">
341.0
</td>
<td style="text-align:right;">
1404
</td>
<td style="text-align:right;">
880
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-511
</td>
<td style="text-align:left;">
quincy, brockton, weymouth, plymouth city and county coc
</td>
<td style="text-align:right;">
-553
</td>
<td style="text-align:right;">
342.0
</td>
<td style="text-align:right;">
1643
</td>
<td style="text-align:right;">
1090
</td>
</tr>
<tr>
<td style="text-align:left;">
tn-507
</td>
<td style="text-align:left;">
jackson/west tennessee coc
</td>
<td style="text-align:right;">
-575
</td>
<td style="text-align:right;">
343.0
</td>
<td style="text-align:right;">
1601
</td>
<td style="text-align:right;">
1026
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-518
</td>
<td style="text-align:left;">
columbia, hamilton, lafayette, suwannee counties coc
</td>
<td style="text-align:right;">
-577
</td>
<td style="text-align:right;">
344.0
</td>
<td style="text-align:right;">
1070
</td>
<td style="text-align:right;">
493
</td>
</tr>
<tr>
<td style="text-align:left;">
wi-501
</td>
<td style="text-align:left;">
milwaukee city & county coc
</td>
<td style="text-align:right;">
-628
</td>
<td style="text-align:right;">
345.0
</td>
<td style="text-align:right;">
1499
</td>
<td style="text-align:right;">
871
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-608
</td>
<td style="text-align:left;">
riverside city & county coc
</td>
<td style="text-align:right;">
-629
</td>
<td style="text-align:right;">
346.0
</td>
<td style="text-align:right;">
2945
</td>
<td style="text-align:right;">
2316
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-600
</td>
<td style="text-align:left;">
miami-dade county coc
</td>
<td style="text-align:right;">
-640
</td>
<td style="text-align:right;">
347.0
</td>
<td style="text-align:right;">
4156
</td>
<td style="text-align:right;">
3516
</td>
</tr>
<tr>
<td style="text-align:left;">
md-508
</td>
<td style="text-align:left;">
charles, calvert, st.mary’s counties coc
</td>
<td style="text-align:right;">
-649
</td>
<td style="text-align:right;">
348.0
</td>
<td style="text-align:right;">
1141
</td>
<td style="text-align:right;">
492
</td>
</tr>
<tr>
<td style="text-align:left;">
oh-507
</td>
<td style="text-align:left;">
ohio balance of state coc
</td>
<td style="text-align:right;">
-673
</td>
<td style="text-align:right;">
349.0
</td>
<td style="text-align:right;">
3806
</td>
<td style="text-align:right;">
3133
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-519
</td>
<td style="text-align:left;">
pasco county coc
</td>
<td style="text-align:right;">
-688
</td>
<td style="text-align:right;">
350.0
</td>
<td style="text-align:right;">
3356
</td>
<td style="text-align:right;">
2668
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-503
</td>
<td style="text-align:left;">
camden city & county/gloucester, cape may, cumberland counties coc
</td>
<td style="text-align:right;">
-696
</td>
<td style="text-align:right;">
351.0
</td>
<td style="text-align:right;">
1695
</td>
<td style="text-align:right;">
999
</td>
</tr>
<tr>
<td style="text-align:left;">
wv-508
</td>
<td style="text-align:left;">
west virginia balance of state coc
</td>
<td style="text-align:right;">
-710
</td>
<td style="text-align:right;">
352.0
</td>
<td style="text-align:right;">
1338
</td>
<td style="text-align:right;">
628
</td>
</tr>
<tr>
<td style="text-align:left;">
nd-500
</td>
<td style="text-align:left;">
north dakota statewide coc
</td>
<td style="text-align:right;">
-716
</td>
<td style="text-align:right;">
353.0
</td>
<td style="text-align:right;">
1258
</td>
<td style="text-align:right;">
542
</td>
</tr>
<tr>
<td style="text-align:left;">
mn-500
</td>
<td style="text-align:left;">
minneapolis/hennepin county coc
</td>
<td style="text-align:right;">
-718
</td>
<td style="text-align:right;">
354.0
</td>
<td style="text-align:right;">
3731
</td>
<td style="text-align:right;">
3013
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-513
</td>
<td style="text-align:left;">
palm bay, melbourne/brevard county coc
</td>
<td style="text-align:right;">
-743
</td>
<td style="text-align:right;">
355.0
</td>
<td style="text-align:right;">
1477
</td>
<td style="text-align:right;">
734
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-510
</td>
<td style="text-align:left;">
gloucester, haverhill, salem/essex county coc
</td>
<td style="text-align:right;">
-755
</td>
<td style="text-align:right;">
356.0
</td>
<td style="text-align:right;">
1487
</td>
<td style="text-align:right;">
732
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-502
</td>
<td style="text-align:left;">
st. petersburg, clearwater, largo/pinellas county coc
</td>
<td style="text-align:right;">
-779
</td>
<td style="text-align:right;">
357.0
</td>
<td style="text-align:right;">
3391
</td>
<td style="text-align:right;">
2612
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-512
</td>
<td style="text-align:left;">
daly/san mateo county coc
</td>
<td style="text-align:right;">
-786
</td>
<td style="text-align:right;">
358.0
</td>
<td style="text-align:right;">
2024
</td>
<td style="text-align:right;">
1238
</td>
</tr>
<tr>
<td style="text-align:left;">
pa-600
</td>
<td style="text-align:left;">
pittsburgh, mckeesport, penn hills/allegheny county coc
</td>
<td style="text-align:right;">
-790
</td>
<td style="text-align:right;">
359.0
</td>
<td style="text-align:right;">
1573
</td>
<td style="text-align:right;">
783
</td>
</tr>
<tr>
<td style="text-align:left;">
la-503
</td>
<td style="text-align:left;">
new orleans/jefferson parish coc
</td>
<td style="text-align:right;">
-793
</td>
<td style="text-align:right;">
360.0
</td>
<td style="text-align:right;">
1981
</td>
<td style="text-align:right;">
1188
</td>
</tr>
<tr>
<td style="text-align:left;">
az-501
</td>
<td style="text-align:left;">
tucson/pima county coc
</td>
<td style="text-align:right;">
-799
</td>
<td style="text-align:right;">
361.0
</td>
<td style="text-align:right;">
2179
</td>
<td style="text-align:right;">
1380
</td>
</tr>
<tr>
<td style="text-align:left;">
il-510
</td>
<td style="text-align:left;">
chicago coc
</td>
<td style="text-align:right;">
-837
</td>
<td style="text-align:right;">
362.0
</td>
<td style="text-align:right;">
6287
</td>
<td style="text-align:right;">
5450
</td>
</tr>
<tr>
<td style="text-align:left;">
dc-500
</td>
<td style="text-align:left;">
district of columbia coc
</td>
<td style="text-align:right;">
-844
</td>
<td style="text-align:right;">
363.0
</td>
<td style="text-align:right;">
7748
</td>
<td style="text-align:right;">
6904
</td>
</tr>
<tr>
<td style="text-align:left;">
ky-502
</td>
<td style="text-align:left;">
lexington-fayette county coc
</td>
<td style="text-align:right;">
-859
</td>
<td style="text-align:right;">
364.0
</td>
<td style="text-align:right;">
1544
</td>
<td style="text-align:right;">
685
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-606
</td>
<td style="text-align:left;">
long beach coc
</td>
<td style="text-align:right;">
-865
</td>
<td style="text-align:right;">
365.0
</td>
<td style="text-align:right;">
2738
</td>
<td style="text-align:right;">
1873
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-517
</td>
<td style="text-align:left;">
hendry, hardee, highlands counties coc
</td>
<td style="text-align:right;">
-893
</td>
<td style="text-align:right;">
366.0
</td>
<td style="text-align:right;">
1346
</td>
<td style="text-align:right;">
453
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-500
</td>
<td style="text-align:left;">
michigan balance of state coc
</td>
<td style="text-align:right;">
-910
</td>
<td style="text-align:right;">
367.0
</td>
<td style="text-align:right;">
2253
</td>
<td style="text-align:right;">
1343
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-504
</td>
<td style="text-align:left;">
daytona beach, daytona/volusia, flagler counties coc
</td>
<td style="text-align:right;">
-950
</td>
<td style="text-align:right;">
368.0
</td>
<td style="text-align:right;">
1633
</td>
<td style="text-align:right;">
683
</td>
</tr>
<tr>
<td style="text-align:left;">
mi-501
</td>
<td style="text-align:left;">
detroit coc
</td>
<td style="text-align:right;">
-986
</td>
<td style="text-align:right;">
369.0
</td>
<td style="text-align:right;">
2755
</td>
<td style="text-align:right;">
1769
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-509
</td>
<td style="text-align:left;">
fort pierce/st. lucie, indian river, martin counties coc
</td>
<td style="text-align:right;">
-1049
</td>
<td style="text-align:right;">
370.0
</td>
<td style="text-align:right;">
2591
</td>
<td style="text-align:right;">
1542
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-512
</td>
<td style="text-align:left;">
st. johns county coc
</td>
<td style="text-align:right;">
-1059
</td>
<td style="text-align:right;">
371.0
</td>
<td style="text-align:right;">
1401
</td>
<td style="text-align:right;">
342
</td>
</tr>
<tr>
<td style="text-align:left;">
fl-505
</td>
<td style="text-align:left;">
fort walton beach/okaloosa, walton counties coc
</td>
<td style="text-align:right;">
-1082
</td>
<td style="text-align:right;">
372.0
</td>
<td style="text-align:right;">
1577
</td>
<td style="text-align:right;">
495
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-700
</td>
<td style="text-align:left;">
houston, pasadena, conroe/harris, ft. bend, montgomery, counties coc
</td>
<td style="text-align:right;">
-1165
</td>
<td style="text-align:right;">
373.0
</td>
<td style="text-align:right;">
5308
</td>
<td style="text-align:right;">
4143
</td>
</tr>
<tr>
<td style="text-align:left;">
nj-515
</td>
<td style="text-align:left;">
elizabeth/union county coc
</td>
<td style="text-align:right;">
-1201
</td>
<td style="text-align:right;">
374.0
</td>
<td style="text-align:right;">
1679
</td>
<td style="text-align:right;">
478
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-508
</td>
<td style="text-align:left;">
watsonville/santa cruz city & county coc
</td>
<td style="text-align:right;">
-1209
</td>
<td style="text-align:right;">
375.0
</td>
<td style="text-align:right;">
3529
</td>
<td style="text-align:right;">
2320
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-504
</td>
<td style="text-align:left;">
santa rosa, petaluma/sonoma county coc
</td>
<td style="text-align:right;">
-1270
</td>
<td style="text-align:right;">
376.0
</td>
<td style="text-align:right;">
4266
</td>
<td style="text-align:right;">
2996
</td>
</tr>
<tr>
<td style="text-align:left;">
ca-614
</td>
<td style="text-align:left;">
san luis obispo county coc
</td>
<td style="text-align:right;">
-1271
</td>
<td style="text-align:right;">
377.0
</td>
<td style="text-align:right;">
2366
</td>
<td style="text-align:right;">
1095
</td>
</tr>
<tr>
<td style="text-align:left;">
co-503
</td>
<td style="text-align:left;">
metropolitan denver coc
</td>
<td style="text-align:right;">
-1304
</td>
<td style="text-align:right;">
378.0
</td>
<td style="text-align:right;">
6621
</td>
<td style="text-align:right;">
5317
</td>
</tr>
<tr>
<td style="text-align:left;">
nv-500
</td>
<td style="text-align:left;">
las vegas/clark county coc
</td>
<td style="text-align:right;">
-1360
</td>
<td style="text-align:right;">
379.0
</td>
<td style="text-align:right;">
7443
</td>
<td style="text-align:right;">
6083
</td>
</tr>
<tr>
<td style="text-align:left;">
ma-516
</td>
<td style="text-align:left;">
massachusetts balance of state coc
</td>
<td style="text-align:right;">
-1604
</td>
<td style="text-align:right;">
380.0
</td>
<td style="text-align:right;">
3900
</td>
<td style="text-align:right;">
2296
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-500
</td>
<td style="text-align:left;">
atlanta coc
</td>
<td style="text-align:right;">
-1721
</td>
<td style="text-align:right;">
381.0
</td>
<td style="text-align:right;">
4797
</td>
<td style="text-align:right;">
3076
</td>
</tr>
<tr>
<td style="text-align:left;">
tx-607
</td>
<td style="text-align:left;">
texas balance of state coc
</td>
<td style="text-align:right;">
-2305
</td>
<td style="text-align:right;">
382.0
</td>
<td style="text-align:right;">
9943
</td>
<td style="text-align:right;">
7638
</td>
</tr>
<tr>
<td style="text-align:left;">
ga-501
</td>
<td style="text-align:left;">
georgia balance of state coc
</td>
<td style="text-align:right;">
-3847
</td>
<td style="text-align:right;">
383.0
</td>
<td style="text-align:right;">
7577
</td>
<td style="text-align:right;">
3730
</td>
</tr>
</tbody>
</table>
</div>
