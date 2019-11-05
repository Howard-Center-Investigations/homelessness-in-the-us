Introduction
------------

### Purpose of this memo

This memo includes code and results from a preliminary exploration of
the data for use by field reporters in narrowing their initial
reporting. Accompanying this memo are four .csv files for use by the
reporters. They can be found
[here](https://github.com/shardsofblue/homelessness-project-fall2019/tree/master/documentation/memos/output-csvs)
(Click the file, right-click “Raw”, choose “Save Link As”, and change
the file extention from “.txt” to “.csv”).

### Definitions

-   **Continuum of Care**: “A Continuum of Care (CoC) is a regional or
    local planning body that coordinates housing and services funding
    for homeless families and individuals,” (The 2018 Annual Homeless
    Assessment Report to Congress p. 2). CoCs are not consistent in
    size, shape or population.

### Important caveats

**Findings herein are preliminary estimates and should not be
published.** Please bear the following caveats in mind when reviewing
this memo:

1.  Methods of counting the population of people experiencing
    homelessness may have changed over the years, which may have caused
    flucutations in counts that do not reflect actual changes.
2.  Because we do not have estimates for the total population of CoCs
    for 2014 and 2018 yet, we used an available 2017 population estimate
    to calculate rates of change in the homeless population at 2014
    and 2018. These rates are therefore only rough estimations, to be
    perfected when we have more accurate overall population data.
3.  D.C. is a consistent outlier in statewide groupings because, unlike
    most other state groups, it includes only one city, and cities
    generally have higher rates of homelessness that rural areas.
4.  Some Continuums of Care have changed over the years, merging
    together or into new CoCs. The following CoCs have known issues
    during the period covered here, having merged with other CoCs:
    CT-502, CT-506, CT-503, CT-508, CT-512, CT-505, FL-516, FL-503,
    MA-513, MA-516, MA-520, MA-511, NJ-518, NJ-503, NY-509, NY-502,
    NY-505, NY-517, NY-508, PA-507, PA-509, PA-602, PA-601, TX-703,
    TX-607, IN-500, IN-502, LA-504, LA-509, MA-518, MA-516, ME-502,
    ME-500, AR-512, AR-503, LA-508, LA-509, WA-507, WA-501.

Findings
--------

### Fact: Highest rates of homelessness by Continuum of Care 2017

To find the rate of homelessness for an area, we divided the count of
people experiencing homelessness for a given year by the total
population in 2017 (the only year for which we have this data at the CoC
level).

In 2017, Mendocino County’s CoC had the nation’s highest rate of
homelessness, at 2 percent, followed by Washington, D.C. (1.2 percent).

Five of the top 10 were in California (Mendocino County, Santa Cruz
area, San Francisco, Monterey area, Imperial County). Other areas with
high rates: Boston, New York City, Atlanta and the Florida Keys (Monroe
County).

#### Supporting code and output

**Rates of Homelessness by CoC, Highest to Lowest**

``` r
# CoCs by estimated homeless percent 2017, highest to lowest
zillow_cluster %>%
  select(state_code, coc_code, estimated_homeless_rate_percent_cluster_2017, coc_total_population_cluster_2017, coc_name) %>%
  arrange(desc(estimated_homeless_rate_percent_cluster_2017)) %>%
  mutate(rank_rate = rank(desc(estimated_homeless_rate_percent_cluster_2017), ties.method= "first")) %>%
  write_csv(paste0(save_path, "rates-of-homelessness-by-coc.csv")) %>%
  kable(caption = "Rates of Homelessness by CoC, Highest to Lowest") %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<caption>
Rates of Homelessness by CoC, Highest to Lowest
</caption>
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
state\_code
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_code
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
estimated\_homeless\_rate\_percent\_cluster\_2017
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_total\_population\_cluster\_2017
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_name
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
rank\_rate
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-509
</td>
<td style="text-align:right;">
2.13
</td>
<td style="text-align:right;">
87274
</td>
<td style="text-align:left;">
mendocino county coc
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
dc
</td>
<td style="text-align:left;">
dc-500
</td>
<td style="text-align:right;">
1.20
</td>
<td style="text-align:right;">
670534
</td>
<td style="text-align:left;">
district of columbia coc
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-508
</td>
<td style="text-align:right;">
1.16
</td>
<td style="text-align:right;">
272584
</td>
<td style="text-align:left;">
watsonville/santa cruz city & county coc
</td>
<td style="text-align:right;">
3
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-604
</td>
<td style="text-align:right;">
1.15
</td>
<td style="text-align:right;">
78399
</td>
<td style="text-align:left;">
monroe county coc
</td>
<td style="text-align:right;">
4
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-501
</td>
<td style="text-align:right;">
1.03
</td>
<td style="text-align:right;">
859801
</td>
<td style="text-align:left;">
san francisco coc
</td>
<td style="text-align:right;">
5
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-500
</td>
<td style="text-align:right;">
0.99
</td>
<td style="text-align:right;">
666277
</td>
<td style="text-align:left;">
boston coc
</td>
<td style="text-align:right;">
6
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-600
</td>
<td style="text-align:right;">
0.96
</td>
<td style="text-align:right;">
8497179
</td>
<td style="text-align:left;">
new york city coc
</td>
<td style="text-align:right;">
7
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-506
</td>
<td style="text-align:right;">
0.95
</td>
<td style="text-align:right;">
490506
</td>
<td style="text-align:left;">
salinas/monterey, san benito counties coc
</td>
<td style="text-align:right;">
8
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-500
</td>
<td style="text-align:right;">
0.93
</td>
<td style="text-align:right;">
460412
</td>
<td style="text-align:left;">
atlanta continuum of care
</td>
<td style="text-align:right;">
9
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-613
</td>
<td style="text-align:right;">
0.89
</td>
<td style="text-align:right;">
179408
</td>
<td style="text-align:left;">
imperial county coc
</td>
<td style="text-align:right;">
10
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-522
</td>
<td style="text-align:right;">
0.83
</td>
<td style="text-align:right;">
135330
</td>
<td style="text-align:left;">
humboldt county coc
</td>
<td style="text-align:right;">
11
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-504
</td>
<td style="text-align:right;">
0.80
</td>
<td style="text-align:right;">
500474
</td>
<td style="text-align:left;">
santa rosa/petaluma/sonoma county coc
</td>
<td style="text-align:right;">
12
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-600
</td>
<td style="text-align:right;">
0.79
</td>
<td style="text-align:right;">
9264635
</td>
<td style="text-align:left;">
los angeles city & county coc
</td>
<td style="text-align:right;">
13
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-519
</td>
<td style="text-align:right;">
0.72
</td>
<td style="text-align:right;">
497332
</td>
<td style="text-align:left;">
pasco county coc
</td>
<td style="text-align:right;">
14
</td>
</tr>
<tr>
<td style="text-align:left;">
hi
</td>
<td style="text-align:left;">
hi-500
</td>
<td style="text-align:right;">
0.70
</td>
<td style="text-align:right;">
431130
</td>
<td style="text-align:left;">
hawaii balance of state coc
</td>
<td style="text-align:right;">
15
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-519
</td>
<td style="text-align:right;">
0.68
</td>
<td style="text-align:right;">
225190
</td>
<td style="text-align:left;">
chico/paradise/butte county coc
</td>
<td style="text-align:right;">
16
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-614
</td>
<td style="text-align:right;">
0.67
</td>
<td style="text-align:right;">
280843
</td>
<td style="text-align:left;">
san luis obispo county coc
</td>
<td style="text-align:right;">
17
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-502
</td>
<td style="text-align:right;">
0.67
</td>
<td style="text-align:right;">
92522
</td>
<td style="text-align:left;">
lynn coc
</td>
<td style="text-align:right;">
18
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-508
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
110393
</td>
<td style="text-align:left;">
lowell coc
</td>
<td style="text-align:right;">
19
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-501
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
787968
</td>
<td style="text-align:left;">
portland-gresham-multnomah county coc
</td>
<td style="text-align:right;">
20
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-500
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
2119230
</td>
<td style="text-align:left;">
seattle/king county coc
</td>
<td style="text-align:right;">
21
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-603
</td>
<td style="text-align:right;">
0.60
</td>
<td style="text-align:right;">
442940
</td>
<td style="text-align:left;">
santa maria/santa barbara county coc
</td>
<td style="text-align:right;">
22
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-518
</td>
<td style="text-align:right;">
0.60
</td>
<td style="text-align:right;">
135313
</td>
<td style="text-align:left;">
columbia, hamilton, lafayette, suwannee counties coc
</td>
<td style="text-align:right;">
23
</td>
</tr>
<tr>
<td style="text-align:left;">
hi
</td>
<td style="text-align:left;">
hi-501
</td>
<td style="text-align:right;">
0.60
</td>
<td style="text-align:right;">
989820
</td>
<td style="text-align:left;">
honolulu coc
</td>
<td style="text-align:right;">
24
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-607
</td>
<td style="text-align:right;">
0.57
</td>
<td style="text-align:right;">
137876
</td>
<td style="text-align:left;">
pasadena coc
</td>
<td style="text-align:right;">
25
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-500
</td>
<td style="text-align:right;">
0.57
</td>
<td style="text-align:right;">
363486
</td>
<td style="text-align:left;">
eugene/springfield/lane county coc
</td>
<td style="text-align:right;">
26
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-505
</td>
<td style="text-align:right;">
0.57
</td>
<td style="text-align:right;">
1468651
</td>
<td style="text-align:left;">
oregon balance of state coc
</td>
<td style="text-align:right;">
27
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-500
</td>
<td style="text-align:right;">
0.53
</td>
<td style="text-align:right;">
1901963
</td>
<td style="text-align:left;">
san jose/santa clara city & county coc
</td>
<td style="text-align:right;">
28
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-507
</td>
<td style="text-align:right;">
0.53
</td>
<td style="text-align:right;">
260367
</td>
<td style="text-align:left;">
marin county coc
</td>
<td style="text-align:right;">
29
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-509
</td>
<td style="text-align:right;">
0.53
</td>
<td style="text-align:right;">
109598
</td>
<td style="text-align:left;">
cambridge coc
</td>
<td style="text-align:right;">
30
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-524
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
169922
</td>
<td style="text-align:left;">
yuba city & county/sutter county coc
</td>
<td style="text-align:right;">
31
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-504
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
468103
</td>
<td style="text-align:left;">
springfield coc
</td>
<td style="text-align:right;">
32
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-501
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
619546
</td>
<td style="text-align:left;">
baltimore city coc
</td>
<td style="text-align:right;">
33
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-606
</td>
<td style="text-align:right;">
0.51
</td>
<td style="text-align:right;">
474605
</td>
<td style="text-align:left;">
long beach coc
</td>
<td style="text-align:right;">
34
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-509
</td>
<td style="text-align:right;">
0.47
</td>
<td style="text-align:right;">
601682
</td>
<td style="text-align:left;">
fort pierce/st. lucie, indian river, martin counties coc
</td>
<td style="text-align:right;">
35
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-501
</td>
<td style="text-align:right;">
0.47
</td>
<td style="text-align:right;">
314210
</td>
<td style="text-align:left;">
st.louis city coc
</td>
<td style="text-align:right;">
36
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-503
</td>
<td style="text-align:right;">
0.46
</td>
<td style="text-align:right;">
219265
</td>
<td style="text-align:left;">
central oregon coc
</td>
<td style="text-align:right;">
37
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-502
</td>
<td style="text-align:right;">
0.43
</td>
<td style="text-align:right;">
1625451
</td>
<td style="text-align:left;">
oakland/alameda county coc
</td>
<td style="text-align:right;">
38
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-525
</td>
<td style="text-align:right;">
0.42
</td>
<td style="text-align:right;">
183907
</td>
<td style="text-align:left;">
el dorado county coc
</td>
<td style="text-align:right;">
39
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-507
</td>
<td style="text-align:right;">
0.42
</td>
<td style="text-align:right;">
285936
</td>
<td style="text-align:left;">
savannah/chatham county coc
</td>
<td style="text-align:right;">
40
</td>
</tr>
<tr>
<td style="text-align:left;">
ak
</td>
<td style="text-align:left;">
ak-500
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
299535
</td>
<td style="text-align:left;">
anchorage coc
</td>
<td style="text-align:right;">
41
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-510
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
533755
</td>
<td style="text-align:left;">
turlock/modesto/stanislaus county coc
</td>
<td style="text-align:right;">
42
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-502
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
947619
</td>
<td style="text-align:left;">
st. petersburg/clearwater/largo/pinellas county coc
</td>
<td style="text-align:right;">
43
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-517
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
253385
</td>
<td style="text-align:left;">
hendry, hardee, highlands counties coc
</td>
<td style="text-align:right;">
44
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-505
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
95067
</td>
<td style="text-align:left;">
new bedford coc
</td>
<td style="text-align:right;">
45
</td>
</tr>
<tr>
<td style="text-align:left;">
nh
</td>
<td style="text-align:left;">
nh-501
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
110323
</td>
<td style="text-align:left;">
manchester coc
</td>
<td style="text-align:right;">
46
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-502
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
213469
</td>
<td style="text-align:left;">
medford/ashland/jackson county coc
</td>
<td style="text-align:right;">
47
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-500
</td>
<td style="text-align:right;">
0.40
</td>
<td style="text-align:right;">
1564804
</td>
<td style="text-align:left;">
philadelphia coc
</td>
<td style="text-align:right;">
48
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-523
</td>
<td style="text-align:right;">
0.39
</td>
<td style="text-align:right;">
62236
</td>
<td style="text-align:left;">
colusa, glenn, trinity counties coc
</td>
<td style="text-align:right;">
49
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-504
</td>
<td style="text-align:right;">
0.38
</td>
<td style="text-align:right;">
677264
</td>
<td style="text-align:left;">
nashville/davidson county coc
</td>
<td style="text-align:right;">
50
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-518
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
433439
</td>
<td style="text-align:left;">
vallejo/solano county coc
</td>
<td style="text-align:right;">
51
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-526
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
152888
</td>
<td style="text-align:left;">
amador, calaveras, tuolumne and mariposa counties coc
</td>
<td style="text-align:right;">
52
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-601
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
3283616
</td>
<td style="text-align:left;">
san diego city and county coc
</td>
<td style="text-align:right;">
53
</td>
</tr>
<tr>
<td style="text-align:left;">
ky
</td>
<td style="text-align:left;">
ky-502
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
314752
</td>
<td style="text-align:left;">
lexington/fayette county coc
</td>
<td style="text-align:right;">
54
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-516
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
311933
</td>
<td style="text-align:left;">
redding/shasta, siskiyou, lassen, plumas, del norte, modoc, sierra
counties coc
</td>
<td style="text-align:right;">
55
</td>
</tr>
<tr>
<td style="text-align:left;">
co
</td>
<td style="text-align:left;">
co-500
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
1702773
</td>
<td style="text-align:left;">
colorado balance of state coc
</td>
<td style="text-align:right;">
56
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-515
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
89077
</td>
<td style="text-align:left;">
fall river coc
</td>
<td style="text-align:right;">
57
</td>
</tr>
<tr>
<td style="text-align:left;">
nv
</td>
<td style="text-align:left;">
nv-500
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
2104734
</td>
<td style="text-align:left;">
las vegas/clark county coc
</td>
<td style="text-align:right;">
58
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-501
</td>
<td style="text-align:right;">
0.34
</td>
<td style="text-align:right;">
676812
</td>
<td style="text-align:left;">
detroit coc
</td>
<td style="text-align:right;">
59
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-516
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
210136
</td>
<td style="text-align:left;">
northwest north carolina coc
</td>
<td style="text-align:right;">
60
</td>
</tr>
<tr>
<td style="text-align:left;">
nm
</td>
<td style="text-align:left;">
nm-500
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
526332
</td>
<td style="text-align:left;">
albuquerque coc
</td>
<td style="text-align:right;">
61
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-512
</td>
<td style="text-align:right;">
0.31
</td>
<td style="text-align:right;">
226229
</td>
<td style="text-align:left;">
saint johns county coc
</td>
<td style="text-align:right;">
62
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-503
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
1492768
</td>
<td style="text-align:left;">
sacramento city & county coc
</td>
<td style="text-align:right;">
63
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-521
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
212022
</td>
<td style="text-align:left;">
davis/woodland/yolo county coc
</td>
<td style="text-align:right;">
64
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-611
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
189080
</td>
<td style="text-align:left;">
amarillo coc
</td>
<td style="text-align:right;">
65
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-508
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
414138
</td>
<td style="text-align:left;">
gainesville/alachua, putnam counties coc
</td>
<td style="text-align:right;">
66
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-501
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
535645
</td>
<td style="text-align:left;">
saint paul/ramsey county coc
</td>
<td style="text-align:right;">
67
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-509
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
200200
</td>
<td style="text-align:left;">
duluth/st.louis county coc
</td>
<td style="text-align:right;">
68
</td>
</tr>
<tr>
<td style="text-align:left;">
nv
</td>
<td style="text-align:left;">
nv-501
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
444809
</td>
<td style="text-align:left;">
reno/sparks/washoe county coc
</td>
<td style="text-align:right;">
69
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-500
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
767077
</td>
<td style="text-align:left;">
sarasota/bradenton/manatee, sarasota counties coc
</td>
<td style="text-align:right;">
70
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-504
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
793563
</td>
<td style="text-align:left;">
newark/essex county coc
</td>
<td style="text-align:right;">
71
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-503
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
308319
</td>
<td style="text-align:left;">
albany city & county coc
</td>
<td style="text-align:right;">
72
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-517
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
141351
</td>
<td style="text-align:left;">
napa city & county coc
</td>
<td style="text-align:right;">
73
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-506
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
438911
</td>
<td style="text-align:left;">
tallahassee/leon county coc
</td>
<td style="text-align:right;">
74
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-500
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
1220754
</td>
<td style="text-align:left;">
minneapolis/hennepin county coc
</td>
<td style="text-align:right;">
75
</td>
</tr>
<tr>
<td style="text-align:left;">
ne
</td>
<td style="text-align:left;">
ne-502
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
253363
</td>
<td style="text-align:left;">
lincoln coc
</td>
<td style="text-align:right;">
76
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-608
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
179710
</td>
<td style="text-align:left;">
kingston/ulster county coc
</td>
<td style="text-align:right;">
77
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-515
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
473570
</td>
<td style="text-align:left;">
roseville/rocklin/placer, nevada counties coc
</td>
<td style="text-align:right;">
78
</td>
</tr>
<tr>
<td style="text-align:left;">
co
</td>
<td style="text-align:left;">
co-504
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
675318
</td>
<td style="text-align:left;">
colorado springs/el paso county coc
</td>
<td style="text-align:right;">
79
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-514
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
343871
</td>
<td style="text-align:left;">
ocala/marion county coc
</td>
<td style="text-align:right;">
80
</td>
</tr>
<tr>
<td style="text-align:left;">
ia
</td>
<td style="text-align:left;">
ia-500
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
122918
</td>
<td style="text-align:left;">
sioux city/dakota, woodbury counties coc
</td>
<td style="text-align:right;">
81
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-502
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
629187
</td>
<td style="text-align:left;">
oklahoma city coc
</td>
<td style="text-align:right;">
82
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-501
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
2228592
</td>
<td style="text-align:left;">
washington balance of state coc
</td>
<td style="text-align:right;">
83
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-502
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
490886
</td>
<td style="text-align:left;">
spokane city & county coc
</td>
<td style="text-align:right;">
84
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-507
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
247954
</td>
<td style="text-align:left;">
yakima city & county coc
</td>
<td style="text-align:right;">
85
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-514
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
1123116
</td>
<td style="text-align:left;">
fresno/madera county coc
</td>
<td style="text-align:right;">
86
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-520
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
266117
</td>
<td style="text-align:left;">
merced city & county coc
</td>
<td style="text-align:right;">
87
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-503
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
123169
</td>
<td style="text-align:left;">
athens/clarke county coc
</td>
<td style="text-align:right;">
88
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-503
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
824422
</td>
<td style="text-align:left;">
new orleans/jefferson parish coc
</td>
<td style="text-align:right;">
89
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-501
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
252888
</td>
<td style="text-align:left;">
asheville/buncombe county coc
</td>
<td style="text-align:right;">
90
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-607
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
75306
</td>
<td style="text-align:left;">
sullivan county coc
</td>
<td style="text-align:right;">
91
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-507
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
668662
</td>
<td style="text-align:left;">
jackson/west tennessee coc
</td>
<td style="text-align:right;">
92
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-511
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
721166
</td>
<td style="text-align:left;">
stockton/san joaquin county coc
</td>
<td style="text-align:right;">
93
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-505
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
262928
</td>
<td style="text-align:left;">
fort walton beach/okaloosa, walton counties coc
</td>
<td style="text-align:right;">
94
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-510
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
2712975
</td>
<td style="text-align:left;">
chicago coc
</td>
<td style="text-align:right;">
95
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-512
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
760765
</td>
<td style="text-align:left;">
daly/san mateo county coc
</td>
<td style="text-align:right;">
96
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-602
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
3148353
</td>
<td style="text-align:left;">
santa ana/anaheim/orange county coc
</td>
<td style="text-align:right;">
97
</td>
</tr>
<tr>
<td style="text-align:left;">
ks
</td>
<td style="text-align:left;">
ks-503
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
178342
</td>
<td style="text-align:left;">
topeka/shawnee county coc
</td>
<td style="text-align:right;">
98
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-510
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
193923
</td>
<td style="text-align:left;">
saginaw city & county coc
</td>
<td style="text-align:right;">
99
</td>
</tr>
<tr>
<td style="text-align:left;">
vt
</td>
<td style="text-align:left;">
vt-500
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
464585
</td>
<td style="text-align:left;">
vermont balance of state coc
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-505
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
1119782
</td>
<td style="text-align:left;">
richmond/contra costa county coc
</td>
<td style="text-align:right;">
101
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-511
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
479606
</td>
<td style="text-align:left;">
pensacola/escambia/santa rosa county coc
</td>
<td style="text-align:right;">
102
</td>
</tr>
<tr>
<td style="text-align:left;">
id
</td>
<td style="text-align:left;">
id-500
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
434095
</td>
<td style="text-align:left;">
boise/ada county coc
</td>
<td style="text-align:right;">
103
</td>
</tr>
<tr>
<td style="text-align:left;">
in
</td>
<td style="text-align:left;">
in-503
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
937949
</td>
<td style="text-align:left;">
indianapolis coc
</td>
<td style="text-align:right;">
104
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-516
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
1076446
</td>
<td style="text-align:left;">
massachusetts balance of state
</td>
<td style="text-align:right;">
105
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-507
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
102390
</td>
<td style="text-align:left;">
cecil county coc
</td>
<td style="text-align:right;">
106
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-506
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
170369
</td>
<td style="text-align:left;">
northwest minnesota coc
</td>
<td style="text-align:right;">
107
</td>
</tr>
<tr>
<td style="text-align:left;">
vt
</td>
<td style="text-align:left;">
vt-501
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
161309
</td>
<td style="text-align:left;">
burlington/chittenden county coc
</td>
<td style="text-align:right;">
108
</td>
</tr>
<tr>
<td style="text-align:left;">
ar
</td>
<td style="text-align:left;">
ar-500
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
590603
</td>
<td style="text-align:left;">
little rock/central arkansas coc
</td>
<td style="text-align:right;">
109
</td>
</tr>
<tr>
<td style="text-align:left;">
az
</td>
<td style="text-align:left;">
az-501
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
1008139
</td>
<td style="text-align:left;">
tucson/pima county coc
</td>
<td style="text-align:right;">
110
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-611
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
845387
</td>
<td style="text-align:left;">
oxnard/san buenaventura/ventura county coc
</td>
<td style="text-align:right;">
111
</td>
</tr>
<tr>
<td style="text-align:left;">
co
</td>
<td style="text-align:left;">
co-503
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
3049220
</td>
<td style="text-align:left;">
metropolitan denver homeless initiative
</td>
<td style="text-align:right;">
112
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-506
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
816243
</td>
<td style="text-align:left;">
worcester city & county coc
</td>
<td style="text-align:right;">
113
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-507
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
260458
</td>
<td style="text-align:left;">
portage/kalamazoo city & county coc
</td>
<td style="text-align:right;">
114
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-511
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
327079
</td>
<td style="text-align:left;">
fayetteville/cumberland county coc
</td>
<td style="text-align:right;">
115
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-604
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
974393
</td>
<td style="text-align:left;">
yonkers/mount vernon/new rochelle/westchester coc
</td>
<td style="text-align:right;">
116
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-507
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
400496
</td>
<td style="text-align:left;">
clackamas county coc
</td>
<td style="text-align:right;">
117
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-502
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
451980
</td>
<td style="text-align:left;">
knoxville/knox county coc
</td>
<td style="text-align:right;">
118
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-503
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
1250891
</td>
<td style="text-align:left;">
austin/travis county coc
</td>
<td style="text-align:right;">
119
</td>
</tr>
<tr>
<td style="text-align:left;">
ut
</td>
<td style="text-align:left;">
ut-500
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
1111517
</td>
<td style="text-align:left;">
salt lake city & county coc
</td>
<td style="text-align:right;">
120
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-513
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
607029
</td>
<td style="text-align:left;">
visalia, kings, tulare counties coc
</td>
<td style="text-align:right;">
121
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-510
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
1192876
</td>
<td style="text-align:left;">
jacksonville-duval, clay counties coc
</td>
<td style="text-align:right;">
122
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-606
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
355381
</td>
<td style="text-align:left;">
naples/collier county coc
</td>
<td style="text-align:right;">
123
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-603
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
119265
</td>
<td style="text-align:left;">
st. joseph/andrew, buchanan, dekalb counties coc
</td>
<td style="text-align:right;">
124
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-507
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
154894
</td>
<td style="text-align:left;">
schenectady city & county coc
</td>
<td style="text-align:right;">
125
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-501
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
272830
</td>
<td style="text-align:left;">
harrisburg/dauphin county coc
</td>
<td style="text-align:right;">
126
</td>
</tr>
<tr>
<td style="text-align:left;">
ak
</td>
<td style="text-align:left;">
ak-501
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
440800
</td>
<td style="text-align:left;">
alaska balance of state coc
</td>
<td style="text-align:right;">
127
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-501
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
1343234
</td>
<td style="text-align:left;">
tampa/hillsborough county coc
</td>
<td style="text-align:right;">
128
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-507
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
359837
</td>
<td style="text-align:left;">
pittsfield/berkshire county coc
</td>
<td style="text-align:right;">
129
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-511
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
659052
</td>
<td style="text-align:left;">
quincy/brockton/weymouth/plymouth city and county coc
</td>
<td style="text-align:right;">
130
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-500
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
72571
</td>
<td style="text-align:left;">
cumberland/allegany county coc
</td>
<td style="text-align:right;">
131
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-508
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
358636
</td>
<td style="text-align:left;">
charles, calvert, st.mary’s counties coc
</td>
<td style="text-align:right;">
132
</td>
</tr>
<tr>
<td style="text-align:left;">
me
</td>
<td style="text-align:left;">
me-500
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
1330746
</td>
<td style="text-align:left;">
maine balance of state coc
</td>
<td style="text-align:right;">
133
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-508
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
287438
</td>
<td style="text-align:left;">
lansing/east lansing/ingham county coc
</td>
<td style="text-align:right;">
134
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-514
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
134592
</td>
<td style="text-align:left;">
battle creek/calhoun county coc
</td>
<td style="text-align:right;">
135
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-604
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
1007389
</td>
<td style="text-align:left;">
kansas city, independence, lees summit/jackson, wyandotte counties, mo
& ks
</td>
<td style="text-align:right;">
136
</td>
</tr>
<tr>
<td style="text-align:left;">
ne
</td>
<td style="text-align:left;">
ne-501
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
817762
</td>
<td style="text-align:left;">
omaha/council bluffs coc
</td>
<td style="text-align:right;">
137
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-500
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
272676
</td>
<td style="text-align:left;">
atlantic city & county coc
</td>
<td style="text-align:right;">
138
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-500
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
1919847
</td>
<td style="text-align:left;">
san antonio/bexar county coc
</td>
<td style="text-align:right;">
139
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-507
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
96007
</td>
<td style="text-align:left;">
portsmouth coc
</td>
<td style="text-align:right;">
140
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-508
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
465567
</td>
<td style="text-align:left;">
vancouver/clark county coc
</td>
<td style="text-align:right;">
141
</td>
</tr>
<tr>
<td style="text-align:left;">
az
</td>
<td style="text-align:left;">
az-502
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
4163953
</td>
<td style="text-align:left;">
phoenix/mesa/maricopa county regional coc
</td>
<td style="text-align:right;">
142
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-504
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
622944
</td>
<td style="text-align:left;">
daytona beach/daytona/volusia, flagler counties coc
</td>
<td style="text-align:right;">
143
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-513
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
567775
</td>
<td style="text-align:left;">
palm bay/melbourne/brevard county coc
</td>
<td style="text-align:right;">
144
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-602
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
173501
</td>
<td style="text-align:left;">
punta gorda/charlotte county coc
</td>
<td style="text-align:right;">
145
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-503
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
242698
</td>
<td style="text-align:left;">
cape cod/islands coc
</td>
<td style="text-align:right;">
146
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-513
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
179053
</td>
<td style="text-align:left;">
wicomico/somerset/worcester county coc
</td>
<td style="text-align:right;">
147
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-602
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
176273
</td>
<td style="text-align:left;">
joplin/jasper, newton counties coc
</td>
<td style="text-align:right;">
148
</td>
</tr>
<tr>
<td style="text-align:left;">
mt
</td>
<td style="text-align:left;">
mt-500
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
1032083
</td>
<td style="text-align:left;">
montana statewide coc
</td>
<td style="text-align:right;">
149
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-505
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
1033260
</td>
<td style="text-align:left;">
charlotte/mecklenberg coc
</td>
<td style="text-align:right;">
150
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-516
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
81325
</td>
<td style="text-align:left;">
clinton county coc
</td>
<td style="text-align:right;">
151
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-501
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
690290
</td>
<td style="text-align:left;">
tulsa city & county/broken arrow coc
</td>
<td style="text-align:right;">
152
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-501
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
936230
</td>
<td style="text-align:left;">
memphis/shelby county coc
</td>
<td style="text-align:right;">
153
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-603
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
836089
</td>
<td style="text-align:left;">
el paso city & county coc
</td>
<td style="text-align:right;">
154
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-503
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
837954
</td>
<td style="text-align:left;">
tacoma/lakewood/pierce county coc
</td>
<td style="text-align:right;">
155
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-504
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
770645
</td>
<td style="text-align:left;">
everett/snohomish county coc
</td>
<td style="text-align:right;">
156
</td>
</tr>
<tr>
<td style="text-align:left;">
wv
</td>
<td style="text-align:left;">
wv-501
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
137397
</td>
<td style="text-align:left;">
huntington/cabell, wayne counties coc
</td>
<td style="text-align:right;">
157
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-600
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
2689794
</td>
<td style="text-align:left;">
miami/dade county coc
</td>
<td style="text-align:right;">
158
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-605
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
1418708
</td>
<td style="text-align:left;">
west palm beach/palm beach county coc
</td>
<td style="text-align:right;">
159
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-505
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
259291
</td>
<td style="text-align:left;">
columbus-muscogee/russell county coc
</td>
<td style="text-align:right;">
160
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-512
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
149872
</td>
<td style="text-align:left;">
hagerstown/washington county coc
</td>
<td style="text-align:right;">
161
</td>
</tr>
<tr>
<td style="text-align:left;">
nd
</td>
<td style="text-align:left;">
nd-500
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
750684
</td>
<td style="text-align:left;">
north dakota statewide coc
</td>
<td style="text-align:right;">
162
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-603
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
153631
</td>
<td style="text-align:left;">
city of alexandria coc
</td>
<td style="text-align:right;">
163
</td>
</tr>
<tr>
<td style="text-align:left;">
wy
</td>
<td style="text-align:left;">
wy-500
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
586379
</td>
<td style="text-align:left;">
wyoming statewide coc
</td>
<td style="text-align:right;">
164
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-500
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
954826
</td>
<td style="text-align:left;">
birmingham/jefferson, st. clair, shelby counties coc
</td>
<td style="text-align:right;">
165
</td>
</tr>
<tr>
<td style="text-align:left;">
az
</td>
<td style="text-align:left;">
az-500
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
1643134
</td>
<td style="text-align:left;">
arizona balance of state coc
</td>
<td style="text-align:right;">
166
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-601
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
1884408
</td>
<td style="text-align:left;">
ft lauderdale/broward county coc
</td>
<td style="text-align:right;">
167
</td>
</tr>
<tr>
<td style="text-align:left;">
ia
</td>
<td style="text-align:left;">
ia-502
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
481896
</td>
<td style="text-align:left;">
des moines/polk county coc
</td>
<td style="text-align:right;">
168
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-508
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
271982
</td>
<td style="text-align:left;">
east saint louis/belleville/saint clair county coc
</td>
<td style="text-align:right;">
169
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-516
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
107615
</td>
<td style="text-align:left;">
decatur/macon county coc
</td>
<td style="text-align:right;">
170
</td>
</tr>
<tr>
<td style="text-align:left;">
ky
</td>
<td style="text-align:left;">
ky-501
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
763639
</td>
<td style="text-align:left;">
louisville/jefferson county coc
</td>
<td style="text-align:right;">
171
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-506
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
636114
</td>
<td style="text-align:left;">
grand rapids/wyoming/kent county coc
</td>
<td style="text-align:right;">
172
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-512
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171217
</td>
<td style="text-align:left;">
grand traverse, antrim, leelanau counties coc
</td>
<td style="text-align:right;">
173
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-503
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
473166
</td>
<td style="text-align:left;">
st. charles, lincoln, warren counties coc
</td>
<td style="text-align:right;">
174
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-502
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
449916
</td>
<td style="text-align:left;">
burlington county coc
</td>
<td style="text-align:right;">
175
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-514
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
371990
</td>
<td style="text-align:left;">
trenton/mercer county coc
</td>
<td style="text-align:right;">
176
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-603
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
2853877
</td>
<td style="text-align:left;">
nassau, suffolk counties/babylon/islip/ huntington coc
</td>
<td style="text-align:right;">
177
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-500
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
811574
</td>
<td style="text-align:left;">
cincinnati/hamilton county coc
</td>
<td style="text-align:right;">
178
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-502
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
1254231
</td>
<td style="text-align:left;">
cleveland/cuyahoga county coc
</td>
<td style="text-align:right;">
179
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-605
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
278408
</td>
<td style="text-align:left;">
erie city & county coc
</td>
<td style="text-align:right;">
180
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-608
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
2349752
</td>
<td style="text-align:left;">
riverside city & county coc
</td>
<td style="text-align:right;">
181
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-504
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
201545
</td>
<td style="text-align:left;">
augusta coc
</td>
<td style="text-align:right;">
182
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-510
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
602483
</td>
<td style="text-align:left;">
gloucester/haverhill/salem/essex county coc
</td>
<td style="text-align:right;">
183
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-509
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
245557
</td>
<td style="text-align:left;">
frederick city & county coc
</td>
<td style="text-align:right;">
184
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-511
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
98444
</td>
<td style="text-align:left;">
lenawee county coc
</td>
<td style="text-align:right;">
185
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-500
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
367698
</td>
<td style="text-align:left;">
winston salem/forsyth county coc
</td>
<td style="text-align:right;">
186
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-512
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
160018
</td>
<td style="text-align:left;">
troy/rensselaer county coc
</td>
<td style="text-align:right;">
187
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-519
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
109351
</td>
<td style="text-align:left;">
columbia/greene county coc
</td>
<td style="text-align:right;">
188
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-601
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
294882
</td>
<td style="text-align:left;">
poughkeepsie/dutchess county coc
</td>
<td style="text-align:right;">
189
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-503
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
1289308
</td>
<td style="text-align:left;">
columbus/franklin county coc
</td>
<td style="text-align:right;">
190
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-506
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
571966
</td>
<td style="text-align:left;">
hillsboro/beaverton/washington county coc
</td>
<td style="text-align:right;">
191
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-506
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
414229
</td>
<td style="text-align:left;">
reading/berks county coc
</td>
<td style="text-align:right;">
192
</td>
</tr>
<tr>
<td style="text-align:left;">
sc
</td>
<td style="text-align:left;">
sc-503
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
905529
</td>
<td style="text-align:left;">
myrtle beach/sumter city & county coc
</td>
<td style="text-align:right;">
193
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-604
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
876938
</td>
<td style="text-align:left;">
bakersfield/kern county coc
</td>
<td style="text-align:right;">
194
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-507
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
2054589
</td>
<td style="text-align:left;">
orlando/orange, osceola, seminole counties coc
</td>
<td style="text-align:right;">
195
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-515
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
304441
</td>
<td style="text-align:left;">
panama city/bay, jackson counties coc
</td>
<td style="text-align:right;">
196
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-515
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
149454
</td>
<td style="text-align:left;">
monroe city & county coc
</td>
<td style="text-align:right;">
197
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-505
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
730221
</td>
<td style="text-align:left;">
st. cloud/central minnesota coc
</td>
<td style="text-align:right;">
198
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-600
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
408354
</td>
<td style="text-align:left;">
springfield/greene, christian, webster counties coc
</td>
<td style="text-align:right;">
199
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-502
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
300419
</td>
<td style="text-align:left;">
durham city & county coc
</td>
<td style="text-align:right;">
200
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-504
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
516867
</td>
<td style="text-align:left;">
greensboro/high point coc
</td>
<td style="text-align:right;">
201
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-506
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
674433
</td>
<td style="text-align:left;">
jersey city/bayonne/hudson county coc
</td>
<td style="text-align:right;">
202
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-505
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
666032
</td>
<td style="text-align:left;">
syracuse, auburn/onondaga, oswego, cayuga counties coc
</td>
<td style="text-align:right;">
203
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-513
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
260993
</td>
<td style="text-align:left;">
wayne, ontario, seneca, yates counties coc
</td>
<td style="text-align:right;">
204
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-501
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
433339
</td>
<td style="text-align:left;">
toledo/lucas county coc
</td>
<td style="text-align:right;">
205
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-505
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
536021
</td>
<td style="text-align:left;">
dayton/kettering/montgomery county coc
</td>
<td style="text-align:right;">
206
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-510
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
298020
</td>
<td style="text-align:left;">
murfreesboro/rutherford county coc
</td>
<td style="text-align:right;">
207
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-512
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
663735
</td>
<td style="text-align:left;">
morristown/blount, sevier, campbell, cocke counties coc
</td>
<td style="text-align:right;">
208
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-501
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
632576
</td>
<td style="text-align:left;">
norfolk/chesapeake/suffolk/isle of wright, southampton counties coc
</td>
<td style="text-align:right;">
209
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-600
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
228239
</td>
<td style="text-align:left;">
arlington county coc
</td>
<td style="text-align:right;">
210
</td>
</tr>
<tr>
<td style="text-align:left;">
wv
</td>
<td style="text-align:left;">
wv-503
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
277596
</td>
<td style="text-align:left;">
charleston/kanawha, putnam, boone, clay counties coc
</td>
<td style="text-align:right;">
211
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-501
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
618230
</td>
<td style="text-align:left;">
mobile city & county/baldwin county coc
</td>
<td style="text-align:right;">
212
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-504
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
383488
</td>
<td style="text-align:left;">
montgomery city & county coc
</td>
<td style="text-align:right;">
213
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-609
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
2118739
</td>
<td style="text-align:left;">
san bernardino city & county coc
</td>
<td style="text-align:right;">
214
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-520
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
763325
</td>
<td style="text-align:left;">
citrus, hernando, lake, sumter counties coc
</td>
<td style="text-align:right;">
215
</td>
</tr>
<tr>
<td style="text-align:left;">
id
</td>
<td style="text-align:left;">
id-501
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
1220324
</td>
<td style="text-align:left;">
idaho balance of state
</td>
<td style="text-align:right;">
216
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-513
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
198262
</td>
<td style="text-align:left;">
springfield/sangamon county coc
</td>
<td style="text-align:right;">
217
</td>
</tr>
<tr>
<td style="text-align:left;">
ks
</td>
<td style="text-align:left;">
ks-502
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
509913
</td>
<td style="text-align:left;">
wichita/sedgwick county coc
</td>
<td style="text-align:right;">
218
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-517
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
125107
</td>
<td style="text-align:left;">
somerville coc
</td>
<td style="text-align:right;">
219
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-505
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
410306
</td>
<td style="text-align:left;">
flint/genesee county coc
</td>
<td style="text-align:right;">
220
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-513
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
76570
</td>
<td style="text-align:left;">
marquette, alger counties coc
</td>
<td style="text-align:right;">
221
</td>
</tr>
<tr>
<td style="text-align:left;">
ms
</td>
<td style="text-align:left;">
ms-500
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
572084
</td>
<td style="text-align:left;">
jackson/rankin, madison counties coc
</td>
<td style="text-align:right;">
222
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-504
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
231480
</td>
<td style="text-align:left;">
youngstown/mahoning county coc
</td>
<td style="text-align:right;">
223
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-504
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
202712
</td>
<td style="text-align:left;">
norman/cleveland county coc
</td>
<td style="text-align:right;">
224
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-505
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
514259
</td>
<td style="text-align:left;">
chester county coc
</td>
<td style="text-align:right;">
225
</td>
</tr>
<tr>
<td style="text-align:left;">
ri
</td>
<td style="text-align:left;">
ri-500
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
1055321
</td>
<td style="text-align:left;">
rhode island statewide coc
</td>
<td style="text-align:right;">
226
</td>
</tr>
<tr>
<td style="text-align:left;">
sd
</td>
<td style="text-align:left;">
sd-500
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
858926
</td>
<td style="text-align:left;">
south dakota statewide coc
</td>
<td style="text-align:right;">
227
</td>
</tr>
<tr>
<td style="text-align:left;">
wi
</td>
<td style="text-align:left;">
wi-503
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
523438
</td>
<td style="text-align:left;">
madison/dane county coc
</td>
<td style="text-align:right;">
228
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-506
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
204484
</td>
<td style="text-align:left;">
tuscaloosa city & county coc
</td>
<td style="text-align:right;">
229
</td>
</tr>
<tr>
<td style="text-align:left;">
ar
</td>
<td style="text-align:left;">
ar-503
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
859633
</td>
<td style="text-align:left;">
arkansas balance of state coc
</td>
<td style="text-align:right;">
230
</td>
</tr>
<tr>
<td style="text-align:left;">
ct
</td>
<td style="text-align:left;">
ct-505
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
2730533
</td>
<td style="text-align:left;">
connecticut balance of state coc
</td>
<td style="text-align:right;">
231
</td>
</tr>
<tr>
<td style="text-align:left;">
de
</td>
<td style="text-align:left;">
de-500
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
942936
</td>
<td style="text-align:left;">
delaware statewide coc
</td>
<td style="text-align:right;">
232
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-509
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
104571
</td>
<td style="text-align:left;">
dekalb city & county coc
</td>
<td style="text-align:right;">
233
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-516
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
172813
</td>
<td style="text-align:left;">
norton shores/muskegon city & county coc
</td>
<td style="text-align:right;">
234
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-523
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
108747
</td>
<td style="text-align:left;">
eaton county coc
</td>
<td style="text-align:right;">
235
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-504
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
125218
</td>
<td style="text-align:left;">
northeast minnesota coc
</td>
<td style="text-align:right;">
236
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-508
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
240746
</td>
<td style="text-align:left;">
moorhead/west central minnesota coc
</td>
<td style="text-align:right;">
237
</td>
</tr>
<tr>
<td style="text-align:left;">
nh
</td>
<td style="text-align:left;">
nh-502
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
295601
</td>
<td style="text-align:left;">
nashua/hillsborough county coc
</td>
<td style="text-align:right;">
238
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-500
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
749116
</td>
<td style="text-align:left;">
rochester/irondequoit/greece/monroe county coc
</td>
<td style="text-align:right;">
239
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-602
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
377100
</td>
<td style="text-align:left;">
newburgh/middletown/orange county coc
</td>
<td style="text-align:right;">
240
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-506
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
540897
</td>
<td style="text-align:left;">
akron/barberton/summit county coc
</td>
<td style="text-align:right;">
241
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-505
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
441778
</td>
<td style="text-align:left;">
northeast oklahoma coc
</td>
<td style="text-align:right;">
242
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-508
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
212553
</td>
<td style="text-align:left;">
scranton/lackawanna county coc
</td>
<td style="text-align:right;">
243
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-500
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
684710
</td>
<td style="text-align:left;">
chattanooga/southeast tennessee coc
</td>
<td style="text-align:right;">
244
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-600
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
3684054
</td>
<td style="text-align:left;">
dallas city & county/irving coc
</td>
<td style="text-align:right;">
245
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-502
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
278757
</td>
<td style="text-align:left;">
roanoke city & county/salem coc
</td>
<td style="text-align:right;">
246
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-505
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
486161
</td>
<td style="text-align:left;">
newport news/hampton/virginia peninsula coc
</td>
<td style="text-align:right;">
247
</td>
</tr>
<tr>
<td style="text-align:left;">
wi
</td>
<td style="text-align:left;">
wi-501
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
954673
</td>
<td style="text-align:left;">
milwaukee city & county coc
</td>
<td style="text-align:right;">
248
</td>
</tr>
<tr>
<td style="text-align:left;">
wi
</td>
<td style="text-align:left;">
wi-502
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
194851
</td>
<td style="text-align:left;">
racine city & county coc
</td>
<td style="text-align:right;">
249
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-612
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
198806
</td>
<td style="text-align:left;">
glendale coc
</td>
<td style="text-align:right;">
250
</td>
</tr>
<tr>
<td style="text-align:left;">
ct
</td>
<td style="text-align:left;">
ct-503
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
858949
</td>
<td style="text-align:left;">
bridgeport/norwalk /stamford/fairfield county coc
</td>
<td style="text-align:right;">
251
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-503
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
648706
</td>
<td style="text-align:left;">
lakeland/winter haven/polk county coc
</td>
<td style="text-align:right;">
252
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-501
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
340814
</td>
<td style="text-align:left;">
rockford/winnebago, boone counties coc
</td>
<td style="text-align:right;">
253
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-512
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
530800
</td>
<td style="text-align:left;">
bloomington/central illinois coc
</td>
<td style="text-align:right;">
254
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-506
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
167626
</td>
<td style="text-align:left;">
carroll county coc
</td>
<td style="text-align:right;">
255
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-511
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
171089
</td>
<td style="text-align:left;">
mid-shore regional coc
</td>
<td style="text-align:right;">
256
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-601
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
1034883
</td>
<td style="text-align:left;">
montgomery county coc
</td>
<td style="text-align:right;">
257
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-517
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
159207
</td>
<td style="text-align:left;">
jackson city & county coc
</td>
<td style="text-align:right;">
258
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-519
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
287039
</td>
<td style="text-align:left;">
holland/ottawa county coc
</td>
<td style="text-align:right;">
259
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-507
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
1021133
</td>
<td style="text-align:left;">
raleigh/wake county coc
</td>
<td style="text-align:right;">
260
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-513
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
140970
</td>
<td style="text-align:left;">
chapel hill/orange county coc
</td>
<td style="text-align:right;">
261
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-503
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
1052022
</td>
<td style="text-align:left;">
camden city/camden, cumberland, gloucester, cape may counties coc
</td>
<td style="text-align:right;">
262
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-511
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
506834
</td>
<td style="text-align:left;">
paterson/passaic county coc
</td>
<td style="text-align:right;">
263
</td>
</tr>
<tr>
<td style="text-align:left;">
nv
</td>
<td style="text-align:left;">
nv-502
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
330165
</td>
<td style="text-align:left;">
nevada balance of state coc
</td>
<td style="text-align:right;">
264
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-508
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
374545
</td>
<td style="text-align:left;">
canton/massillon/alliance/stark county coc
</td>
<td style="text-align:right;">
265
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-507
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
540654
</td>
<td style="text-align:left;">
southeastern oklahoma regional coc
</td>
<td style="text-align:right;">
266
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-600
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
1229575
</td>
<td style="text-align:left;">
pittsburgh/mckeesport/penn hills/allegheny county coc
</td>
<td style="text-align:right;">
267
</td>
</tr>
<tr>
<td style="text-align:left;">
sc
</td>
<td style="text-align:left;">
sc-501
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
1480081
</td>
<td style="text-align:left;">
greenville/anderson/spartanburg upstate coc
</td>
<td style="text-align:right;">
268
</td>
</tr>
<tr>
<td style="text-align:left;">
sc
</td>
<td style="text-align:left;">
sc-502
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
1496796
</td>
<td style="text-align:left;">
columbia/midlands coc
</td>
<td style="text-align:right;">
269
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-509
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
506973
</td>
<td style="text-align:left;">
appalachian regional coc
</td>
<td style="text-align:right;">
270
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-601
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
2090799
</td>
<td style="text-align:left;">
fort worth/arlington/tarrant county coc
</td>
<td style="text-align:right;">
271
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-607
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
10634996
</td>
<td style="text-align:left;">
texas balance of state (bos) coc
</td>
<td style="text-align:right;">
272
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-503
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
564541
</td>
<td style="text-align:left;">
huntsville/north alabama coc
</td>
<td style="text-align:right;">
273
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-507
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
396538
</td>
<td style="text-align:left;">
peoria/perkin/fulton, peoria, tazewell, woodford coc
</td>
<td style="text-align:right;">
274
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-502
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
250586
</td>
<td style="text-align:left;">
harford county coc
</td>
<td style="text-align:right;">
275
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-505
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
828373
</td>
<td style="text-align:left;">
baltimore county coc
</td>
<td style="text-align:right;">
276
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-509
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
362072
</td>
<td style="text-align:left;">
ann arbor/washtenaw county coc
</td>
<td style="text-align:right;">
277
</td>
</tr>
<tr>
<td style="text-align:left;">
ms
</td>
<td style="text-align:left;">
ms-503
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
484997
</td>
<td style="text-align:left;">
gulf port/gulf coast regional coc
</td>
<td style="text-align:right;">
278
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-506
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
399727
</td>
<td style="text-align:left;">
wilmington/brunswick, new hanover, pender counties coc
</td>
<td style="text-align:right;">
279
</td>
</tr>
<tr>
<td style="text-align:left;">
nh
</td>
<td style="text-align:left;">
nh-500
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
924881
</td>
<td style="text-align:left;">
new hampshire balance of state coc
</td>
<td style="text-align:right;">
280
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-509
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
498238
</td>
<td style="text-align:left;">
morris county coc
</td>
<td style="text-align:right;">
281
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-515
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
552128
</td>
<td style="text-align:left;">
elizabeth/union county coc
</td>
<td style="text-align:right;">
282
</td>
</tr>
<tr>
<td style="text-align:left;">
nm
</td>
<td style="text-align:left;">
nm-501
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
1554889
</td>
<td style="text-align:left;">
new mexico balance of state coc
</td>
<td style="text-align:right;">
283
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-502
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
562949
</td>
<td style="text-align:left;">
upper darby/chester/haverford/delaware county coc
</td>
<td style="text-align:right;">
284
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-511
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
625857
</td>
<td style="text-align:left;">
bristol/bensalem/bucks county coc
</td>
<td style="text-align:right;">
285
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-503
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
451176
</td>
<td style="text-align:left;">
virginia beach coc
</td>
<td style="text-align:right;">
286
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-513
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
362584
</td>
<td style="text-align:left;">
harrisburg, winchester/western virginia coc
</td>
<td style="text-align:right;">
287
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-601
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
1174776
</td>
<td style="text-align:left;">
fairfax county coc
</td>
<td style="text-align:right;">
288
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-604
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
507573
</td>
<td style="text-align:left;">
prince william county coc
</td>
<td style="text-align:right;">
289
</td>
</tr>
<tr>
<td style="text-align:left;">
wi
</td>
<td style="text-align:left;">
wi-500
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
4094517
</td>
<td style="text-align:left;">
wisconsin balance of state coc
</td>
<td style="text-align:right;">
290
</td>
</tr>
<tr>
<td style="text-align:left;">
wv
</td>
<td style="text-align:left;">
wv-500
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
143954
</td>
<td style="text-align:left;">
wheeling/weirton area coc
</td>
<td style="text-align:right;">
291
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-603
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
698265
</td>
<td style="text-align:left;">
ft myers/cape coral/lee county coc
</td>
<td style="text-align:right;">
292
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-501
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
6905893
</td>
<td style="text-align:left;">
georgia balance of state coc
</td>
<td style="text-align:right;">
293
</td>
</tr>
<tr>
<td style="text-align:left;">
ia
</td>
<td style="text-align:left;">
ia-501
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
2442251
</td>
<td style="text-align:left;">
iowa balance of state coc
</td>
<td style="text-align:right;">
294
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-503
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
207074
</td>
<td style="text-align:left;">
champaign/urbana/rantoul/champaign county coc
</td>
<td style="text-align:right;">
295
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-504
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
266162
</td>
<td style="text-align:left;">
madison county coc
</td>
<td style="text-align:right;">
296
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-520
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
576910
</td>
<td style="text-align:left;">
southern illinois coc
</td>
<td style="text-align:right;">
297
</td>
</tr>
<tr>
<td style="text-align:left;">
ks
</td>
<td style="text-align:left;">
ks-507
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
1474552
</td>
<td style="text-align:left;">
kansas balance of state coc
</td>
<td style="text-align:right;">
298
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-502
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
483539
</td>
<td style="text-align:left;">
shreveport/bossier/northwest coc
</td>
<td style="text-align:right;">
299
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-503
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
564194
</td>
<td style="text-align:left;">
annapolis/anne arundel county coc
</td>
<td style="text-align:right;">
300
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-500
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
2358534
</td>
<td style="text-align:left;">
michigan balance of state coc
</td>
<td style="text-align:right;">
301
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-502
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
717982
</td>
<td style="text-align:left;">
rochester/southeast minnesota coc
</td>
<td style="text-align:right;">
302
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-509
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
390735
</td>
<td style="text-align:left;">
gastonia/cleveland, gaston, lincoln counties coc
</td>
<td style="text-align:right;">
303
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-513
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
332768
</td>
<td style="text-align:left;">
somerset county coc
</td>
<td style="text-align:right;">
304
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-516
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
375588
</td>
<td style="text-align:left;">
warren, sussex, hunterdon counties coc
</td>
<td style="text-align:right;">
305
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-501
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
314889
</td>
<td style="text-align:left;">
elmira/steuben, allegany, livingston, chemung, schuyler counties coc
</td>
<td style="text-align:right;">
306
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-508
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
1272364
</td>
<td style="text-align:left;">
buffalo, niagara falls/erie, niagara, orleans, genesee, wyoming counties
coc
</td>
<td style="text-align:right;">
307
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-510
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
104681
</td>
<td style="text-align:left;">
ithaca/tompkins county coc
</td>
<td style="text-align:right;">
308
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-523
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
357590
</td>
<td style="text-align:left;">
glens falls/saratoga springs/saratoga, washington, warren, hamilton
counties coc
</td>
<td style="text-align:right;">
309
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-509
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
3104937
</td>
<td style="text-align:left;">
eastern pennsylvania coc
</td>
<td style="text-align:right;">
310
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-624
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
330725
</td>
<td style="text-align:left;">
wichita falls/wise, palo pinto, wichita, archer counties coc
</td>
<td style="text-align:right;">
311
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-700
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
5748292
</td>
<td style="text-align:left;">
houston, pasadena, conroe/harris, ft. bend, montgomery, counties coc
</td>
<td style="text-align:right;">
312
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-514
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
356451
</td>
<td style="text-align:left;">
fredericksburg/spotsylvania, stafford counties coc
</td>
<td style="text-align:right;">
313
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-502
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
265634
</td>
<td style="text-align:left;">
florence/northwest alabama coc
</td>
<td style="text-align:right;">
314
</td>
</tr>
<tr>
<td style="text-align:left;">
ar
</td>
<td style="text-align:left;">
ar-501
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
524887
</td>
<td style="text-align:left;">
fayetteville/northwest arkansas coc
</td>
<td style="text-align:right;">
315
</td>
</tr>
<tr>
<td style="text-align:left;">
ar
</td>
<td style="text-align:left;">
ar-512
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
102593
</td>
<td style="text-align:left;">
boone, baxter, marion, newton counties coc
</td>
<td style="text-align:right;">
316
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-517
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
589685
</td>
<td style="text-align:left;">
aurora/elgin/kane county coc
</td>
<td style="text-align:right;">
317
</td>
</tr>
<tr>
<td style="text-align:left;">
in
</td>
<td style="text-align:left;">
in-502
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
5672562
</td>
<td style="text-align:left;">
indiana balance of state coc
</td>
<td style="text-align:right;">
318
</td>
</tr>
<tr>
<td style="text-align:left;">
ky
</td>
<td style="text-align:left;">
ky-500
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
3348234
</td>
<td style="text-align:left;">
kentucky balance of state coc
</td>
<td style="text-align:right;">
319
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-500
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
658150
</td>
<td style="text-align:left;">
lafayette/acadiana coc
</td>
<td style="text-align:right;">
320
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-509
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
1111992
</td>
<td style="text-align:left;">
louisiana balance of state (bos)
</td>
<td style="text-align:right;">
321
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-519
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
372829
</td>
<td style="text-align:left;">
attleboro/taunton/bristol county coc
</td>
<td style="text-align:right;">
322
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-504
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
312779
</td>
<td style="text-align:left;">
howard county coc
</td>
<td style="text-align:right;">
323
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-600
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
902570
</td>
<td style="text-align:left;">
prince george\`s county/maryland coc
</td>
<td style="text-align:right;">
324
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-503
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
5075411
</td>
<td style="text-align:left;">
north carolina balance of state coc
</td>
<td style="text-align:right;">
325
</td>
</tr>
<tr>
<td style="text-align:left;">
ne
</td>
<td style="text-align:left;">
ne-500
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
894615
</td>
<td style="text-align:left;">
nebraska balance of state coc
</td>
<td style="text-align:right;">
326
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-507
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
833404
</td>
<td style="text-align:left;">
new brunswick/middlesex county coc
</td>
<td style="text-align:right;">
327
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-511
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
449792
</td>
<td style="text-align:left;">
binghamton, union/broome, otsego, chenango, delaware, cortland, tioga
counties c
</td>
<td style="text-align:right;">
328
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-514
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
130850
</td>
<td style="text-align:left;">
jamestown/dunkirk/chautauqua county coc
</td>
<td style="text-align:right;">
329
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-522
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
255122
</td>
<td style="text-align:left;">
jefferson/lewis/st. lawrence counties coc
</td>
<td style="text-align:right;">
330
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-500
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
314750
</td>
<td style="text-align:left;">
north central oklahoma coc
</td>
<td style="text-align:right;">
331
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-503
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
669481
</td>
<td style="text-align:left;">
oklahoma balance of state coc
</td>
<td style="text-align:right;">
332
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-510
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
536004
</td>
<td style="text-align:left;">
lancaster city & county coc
</td>
<td style="text-align:right;">
333
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-512
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
441548
</td>
<td style="text-align:left;">
york city & county coc
</td>
<td style="text-align:right;">
334
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-506
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
567870
</td>
<td style="text-align:left;">
oak ridge/upper cumberland coc
</td>
<td style="text-align:right;">
335
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-604
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
358285
</td>
<td style="text-align:left;">
waco/mclennan county coc
</td>
<td style="text-align:right;">
336
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-500
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
1061547
</td>
<td style="text-align:left;">
richmond/henrico, chesterfield, hanover counties coc
</td>
<td style="text-align:right;">
337
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-504
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
246286
</td>
<td style="text-align:left;">
charlottesville coc
</td>
<td style="text-align:right;">
338
</td>
</tr>
<tr>
<td style="text-align:left;">
wv
</td>
<td style="text-align:left;">
wv-508
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
1281817
</td>
<td style="text-align:left;">
west virginia balance of state coc
</td>
<td style="text-align:right;">
339
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-507
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
1522513
</td>
<td style="text-align:left;">
alabama balance of state coc
</td>
<td style="text-align:right;">
340
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-506
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
737643
</td>
<td style="text-align:left;">
marietta/cobb county coc
</td>
<td style="text-align:right;">
341
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-500
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
300660
</td>
<td style="text-align:left;">
mchenry county coc
</td>
<td style="text-align:right;">
342
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-505
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
355418
</td>
<td style="text-align:left;">
monroe/northeast louisiana coc
</td>
<td style="text-align:right;">
343
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-506
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
573011
</td>
<td style="text-align:left;">
slidell/southeast louisiana coc
</td>
<td style="text-align:right;">
344
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-507
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
307404
</td>
<td style="text-align:left;">
alexandria/central louisiana coc
</td>
<td style="text-align:right;">
345
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-510
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
29541
</td>
<td style="text-align:left;">
garrett county coc
</td>
<td style="text-align:right;">
346
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-503
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
864717
</td>
<td style="text-align:left;">
st. clair shores/warren/macomb county coc
</td>
<td style="text-align:right;">
347
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-518
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
187091
</td>
<td style="text-align:left;">
livingston county coc
</td>
<td style="text-align:right;">
348
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-500
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
999793
</td>
<td style="text-align:left;">
st. louis county coc
</td>
<td style="text-align:right;">
349
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-606
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
2738152
</td>
<td style="text-align:left;">
missouri balance of state coc
</td>
<td style="text-align:right;">
350
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-504
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
78050
</td>
<td style="text-align:left;">
cattaragus county coc
</td>
<td style="text-align:right;">
351
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-518
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
306907
</td>
<td style="text-align:left;">
utica/rome/oneida, madison counties coc
</td>
<td style="text-align:right;">
352
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-606
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
324596
</td>
<td style="text-align:left;">
rockland county coc
</td>
<td style="text-align:right;">
353
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-507
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
6126510
</td>
<td style="text-align:left;">
ohio balance of state coc
</td>
<td style="text-align:right;">
354
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-506
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
407894
</td>
<td style="text-align:left;">
southwest oklahoma regional coc
</td>
<td style="text-align:right;">
355
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-503
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
317739
</td>
<td style="text-align:left;">
wilkes-barre/hazleton/luzerne county coc
</td>
<td style="text-align:right;">
356
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-603
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
168625
</td>
<td style="text-align:left;">
beaver county coc
</td>
<td style="text-align:right;">
357
</td>
</tr>
<tr>
<td style="text-align:left;">
ut
</td>
<td style="text-align:left;">
ut-503
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
1242374
</td>
<td style="text-align:left;">
utah balance of state coc
</td>
<td style="text-align:right;">
358
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-508
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
259135
</td>
<td style="text-align:left;">
lynchburg coc
</td>
<td style="text-align:right;">
359
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-503
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
1264398
</td>
<td style="text-align:left;">
dakota, anoka, washington, scott, carver counties
</td>
<td style="text-align:right;">
360
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-511
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
277032
</td>
<td style="text-align:left;">
southwest minnesota coc
</td>
<td style="text-align:right;">
361
</td>
</tr>
<tr>
<td style="text-align:left;">
ms
</td>
<td style="text-align:left;">
ms-501
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
1933222
</td>
<td style="text-align:left;">
mississippi balance of state coc
</td>
<td style="text-align:right;">
362
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-508
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
625879
</td>
<td style="text-align:left;">
monmouth county coc
</td>
<td style="text-align:right;">
363
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-601
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
1725296
</td>
<td style="text-align:left;">
western pennsylvania coc
</td>
<td style="text-align:right;">
364
</td>
</tr>
<tr>
<td style="text-align:left;">
sc
</td>
<td style="text-align:left;">
sc-500
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
1009228
</td>
<td style="text-align:left;">
charleston/low country coc
</td>
<td style="text-align:right;">
365
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-521
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
1695332
</td>
<td style="text-align:left;">
virginia balance of state (bos) coc
</td>
<td style="text-align:right;">
366
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-502
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
729261
</td>
<td style="text-align:left;">
waukegan/north chicago/lake county coc
</td>
<td style="text-align:right;">
367
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-506
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
803325
</td>
<td style="text-align:left;">
joliet/bolingbrook/will county coc
</td>
<td style="text-align:right;">
368
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-511
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
2494027
</td>
<td style="text-align:left;">
cook county coc
</td>
<td style="text-align:right;">
369
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-514
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
917503
</td>
<td style="text-align:left;">
dupage county coc
</td>
<td style="text-align:right;">
370
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-518
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
656316
</td>
<td style="text-align:left;">
rock island/moline/northwestern illinois coc
</td>
<td style="text-align:right;">
371
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-519
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
223572
</td>
<td style="text-align:left;">
west central illinois coc
</td>
<td style="text-align:right;">
372
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-508
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
352151
</td>
<td style="text-align:left;">
houma-terrebonne/thibodaux coc
</td>
<td style="text-align:right;">
373
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-504
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
1240927
</td>
<td style="text-align:left;">
pontiac/royal oak/oakland county coc
</td>
<td style="text-align:right;">
374
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-501
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
934290
</td>
<td style="text-align:left;">
bergen county coc
</td>
<td style="text-align:right;">
375
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-510
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
588882
</td>
<td style="text-align:left;">
lakewood township/ocean county coc
</td>
<td style="text-align:right;">
376
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-520
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
89018
</td>
<td style="text-align:left;">
franklin county coc
</td>
<td style="text-align:right;">
377
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-504
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
818782
</td>
<td style="text-align:left;">
lower marion/norristown/abington/montgomery county coc
</td>
<td style="text-align:right;">
378
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-701
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
331198
</td>
<td style="text-align:left;">
bryan/college station/brazos valley coc
</td>
<td style="text-align:right;">
379
</td>
</tr>
<tr>
<td style="text-align:left;">
ut
</td>
<td style="text-align:left;">
ut-504
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
639584
</td>
<td style="text-align:left;">
provo/mountainland coc
</td>
<td style="text-align:right;">
380
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-602
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
373741
</td>
<td style="text-align:left;">
loudoun county coc
</td>
<td style="text-align:right;">
381
</td>
</tr>
<tr>
<td style="text-align:left;">
ar
</td>
<td style="text-align:left;">
ar-505
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
304531
</td>
<td style="text-align:left;">
southeast arkansas
</td>
<td style="text-align:right;">
382
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-515
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
401555
</td>
<td style="text-align:left;">
south central illinois coc
</td>
<td style="text-align:right;">
383
</td>
</tr>
<tr>
<td style="text-align:left;">
ks
</td>
<td style="text-align:left;">
ks-505
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
578042
</td>
<td style="text-align:left;">
overland park/shawnee/johnson county coc
</td>
<td style="text-align:right;">
384
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-503
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
1140959
</td>
<td style="text-align:left;">
central tennessee coc
</td>
<td style="text-align:right;">
385
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-502
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
1079405
</td>
<td style="text-align:left;">
dearborn/dearborn heights/westland/wayne county coc
</td>
<td style="text-align:right;">
386
</td>
</tr>
</tbody>
</table>
</div>
**Rates of Homelessness by CoC, Lowest to Highest**

``` r
# CoCs by estimated homeless percent 2017, lowest to highest
zillow_cluster %>%
  select(state_code, coc_code, estimated_homeless_rate_percent_cluster_2017, coc_total_population_cluster_2017, coc_name) %>%
  arrange(estimated_homeless_rate_percent_cluster_2017) %>%
  mutate(rank_rate = rank(desc(estimated_homeless_rate_percent_cluster_2017), ties.method= "first")) %>%
  kable() %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
state\_code
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_code
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
estimated\_homeless\_rate\_percent\_cluster\_2017
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_total\_population\_cluster\_2017
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_name
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
rank\_rate
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-502
</td>
<td style="text-align:right;">
0.02
</td>
<td style="text-align:right;">
1079405
</td>
<td style="text-align:left;">
dearborn/dearborn heights/westland/wayne county coc
</td>
<td style="text-align:right;">
386
</td>
</tr>
<tr>
<td style="text-align:left;">
ar
</td>
<td style="text-align:left;">
ar-505
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
304531
</td>
<td style="text-align:left;">
southeast arkansas
</td>
<td style="text-align:right;">
382
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-515
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
401555
</td>
<td style="text-align:left;">
south central illinois coc
</td>
<td style="text-align:right;">
383
</td>
</tr>
<tr>
<td style="text-align:left;">
ks
</td>
<td style="text-align:left;">
ks-505
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
578042
</td>
<td style="text-align:left;">
overland park/shawnee/johnson county coc
</td>
<td style="text-align:right;">
384
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-503
</td>
<td style="text-align:right;">
0.03
</td>
<td style="text-align:right;">
1140959
</td>
<td style="text-align:left;">
central tennessee coc
</td>
<td style="text-align:right;">
385
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-502
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
729261
</td>
<td style="text-align:left;">
waukegan/north chicago/lake county coc
</td>
<td style="text-align:right;">
367
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-506
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
803325
</td>
<td style="text-align:left;">
joliet/bolingbrook/will county coc
</td>
<td style="text-align:right;">
368
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-511
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
2494027
</td>
<td style="text-align:left;">
cook county coc
</td>
<td style="text-align:right;">
369
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-514
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
917503
</td>
<td style="text-align:left;">
dupage county coc
</td>
<td style="text-align:right;">
370
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-518
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
656316
</td>
<td style="text-align:left;">
rock island/moline/northwestern illinois coc
</td>
<td style="text-align:right;">
371
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-519
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
223572
</td>
<td style="text-align:left;">
west central illinois coc
</td>
<td style="text-align:right;">
372
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-508
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
352151
</td>
<td style="text-align:left;">
houma-terrebonne/thibodaux coc
</td>
<td style="text-align:right;">
373
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-504
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
1240927
</td>
<td style="text-align:left;">
pontiac/royal oak/oakland county coc
</td>
<td style="text-align:right;">
374
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-501
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
934290
</td>
<td style="text-align:left;">
bergen county coc
</td>
<td style="text-align:right;">
375
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-510
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
588882
</td>
<td style="text-align:left;">
lakewood township/ocean county coc
</td>
<td style="text-align:right;">
376
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-520
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
89018
</td>
<td style="text-align:left;">
franklin county coc
</td>
<td style="text-align:right;">
377
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-504
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
818782
</td>
<td style="text-align:left;">
lower marion/norristown/abington/montgomery county coc
</td>
<td style="text-align:right;">
378
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-701
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
331198
</td>
<td style="text-align:left;">
bryan/college station/brazos valley coc
</td>
<td style="text-align:right;">
379
</td>
</tr>
<tr>
<td style="text-align:left;">
ut
</td>
<td style="text-align:left;">
ut-504
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
639584
</td>
<td style="text-align:left;">
provo/mountainland coc
</td>
<td style="text-align:right;">
380
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-602
</td>
<td style="text-align:right;">
0.04
</td>
<td style="text-align:right;">
373741
</td>
<td style="text-align:left;">
loudoun county coc
</td>
<td style="text-align:right;">
381
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-503
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
1264398
</td>
<td style="text-align:left;">
dakota, anoka, washington, scott, carver counties
</td>
<td style="text-align:right;">
360
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-511
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
277032
</td>
<td style="text-align:left;">
southwest minnesota coc
</td>
<td style="text-align:right;">
361
</td>
</tr>
<tr>
<td style="text-align:left;">
ms
</td>
<td style="text-align:left;">
ms-501
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
1933222
</td>
<td style="text-align:left;">
mississippi balance of state coc
</td>
<td style="text-align:right;">
362
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-508
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
625879
</td>
<td style="text-align:left;">
monmouth county coc
</td>
<td style="text-align:right;">
363
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-601
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
1725296
</td>
<td style="text-align:left;">
western pennsylvania coc
</td>
<td style="text-align:right;">
364
</td>
</tr>
<tr>
<td style="text-align:left;">
sc
</td>
<td style="text-align:left;">
sc-500
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
1009228
</td>
<td style="text-align:left;">
charleston/low country coc
</td>
<td style="text-align:right;">
365
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-521
</td>
<td style="text-align:right;">
0.05
</td>
<td style="text-align:right;">
1695332
</td>
<td style="text-align:left;">
virginia balance of state (bos) coc
</td>
<td style="text-align:right;">
366
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-507
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
1522513
</td>
<td style="text-align:left;">
alabama balance of state coc
</td>
<td style="text-align:right;">
340
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-506
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
737643
</td>
<td style="text-align:left;">
marietta/cobb county coc
</td>
<td style="text-align:right;">
341
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-500
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
300660
</td>
<td style="text-align:left;">
mchenry county coc
</td>
<td style="text-align:right;">
342
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-505
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
355418
</td>
<td style="text-align:left;">
monroe/northeast louisiana coc
</td>
<td style="text-align:right;">
343
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-506
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
573011
</td>
<td style="text-align:left;">
slidell/southeast louisiana coc
</td>
<td style="text-align:right;">
344
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-507
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
307404
</td>
<td style="text-align:left;">
alexandria/central louisiana coc
</td>
<td style="text-align:right;">
345
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-510
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
29541
</td>
<td style="text-align:left;">
garrett county coc
</td>
<td style="text-align:right;">
346
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-503
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
864717
</td>
<td style="text-align:left;">
st. clair shores/warren/macomb county coc
</td>
<td style="text-align:right;">
347
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-518
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
187091
</td>
<td style="text-align:left;">
livingston county coc
</td>
<td style="text-align:right;">
348
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-500
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
999793
</td>
<td style="text-align:left;">
st. louis county coc
</td>
<td style="text-align:right;">
349
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-606
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
2738152
</td>
<td style="text-align:left;">
missouri balance of state coc
</td>
<td style="text-align:right;">
350
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-504
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
78050
</td>
<td style="text-align:left;">
cattaragus county coc
</td>
<td style="text-align:right;">
351
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-518
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
306907
</td>
<td style="text-align:left;">
utica/rome/oneida, madison counties coc
</td>
<td style="text-align:right;">
352
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-606
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
324596
</td>
<td style="text-align:left;">
rockland county coc
</td>
<td style="text-align:right;">
353
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-507
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
6126510
</td>
<td style="text-align:left;">
ohio balance of state coc
</td>
<td style="text-align:right;">
354
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-506
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
407894
</td>
<td style="text-align:left;">
southwest oklahoma regional coc
</td>
<td style="text-align:right;">
355
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-503
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
317739
</td>
<td style="text-align:left;">
wilkes-barre/hazleton/luzerne county coc
</td>
<td style="text-align:right;">
356
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-603
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
168625
</td>
<td style="text-align:left;">
beaver county coc
</td>
<td style="text-align:right;">
357
</td>
</tr>
<tr>
<td style="text-align:left;">
ut
</td>
<td style="text-align:left;">
ut-503
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
1242374
</td>
<td style="text-align:left;">
utah balance of state coc
</td>
<td style="text-align:right;">
358
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-508
</td>
<td style="text-align:right;">
0.06
</td>
<td style="text-align:right;">
259135
</td>
<td style="text-align:left;">
lynchburg coc
</td>
<td style="text-align:right;">
359
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-502
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
265634
</td>
<td style="text-align:left;">
florence/northwest alabama coc
</td>
<td style="text-align:right;">
314
</td>
</tr>
<tr>
<td style="text-align:left;">
ar
</td>
<td style="text-align:left;">
ar-501
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
524887
</td>
<td style="text-align:left;">
fayetteville/northwest arkansas coc
</td>
<td style="text-align:right;">
315
</td>
</tr>
<tr>
<td style="text-align:left;">
ar
</td>
<td style="text-align:left;">
ar-512
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
102593
</td>
<td style="text-align:left;">
boone, baxter, marion, newton counties coc
</td>
<td style="text-align:right;">
316
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-517
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
589685
</td>
<td style="text-align:left;">
aurora/elgin/kane county coc
</td>
<td style="text-align:right;">
317
</td>
</tr>
<tr>
<td style="text-align:left;">
in
</td>
<td style="text-align:left;">
in-502
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
5672562
</td>
<td style="text-align:left;">
indiana balance of state coc
</td>
<td style="text-align:right;">
318
</td>
</tr>
<tr>
<td style="text-align:left;">
ky
</td>
<td style="text-align:left;">
ky-500
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
3348234
</td>
<td style="text-align:left;">
kentucky balance of state coc
</td>
<td style="text-align:right;">
319
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-500
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
658150
</td>
<td style="text-align:left;">
lafayette/acadiana coc
</td>
<td style="text-align:right;">
320
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-509
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
1111992
</td>
<td style="text-align:left;">
louisiana balance of state (bos)
</td>
<td style="text-align:right;">
321
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-519
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
372829
</td>
<td style="text-align:left;">
attleboro/taunton/bristol county coc
</td>
<td style="text-align:right;">
322
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-504
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
312779
</td>
<td style="text-align:left;">
howard county coc
</td>
<td style="text-align:right;">
323
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-600
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
902570
</td>
<td style="text-align:left;">
prince george\`s county/maryland coc
</td>
<td style="text-align:right;">
324
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-503
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
5075411
</td>
<td style="text-align:left;">
north carolina balance of state coc
</td>
<td style="text-align:right;">
325
</td>
</tr>
<tr>
<td style="text-align:left;">
ne
</td>
<td style="text-align:left;">
ne-500
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
894615
</td>
<td style="text-align:left;">
nebraska balance of state coc
</td>
<td style="text-align:right;">
326
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-507
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
833404
</td>
<td style="text-align:left;">
new brunswick/middlesex county coc
</td>
<td style="text-align:right;">
327
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-511
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
449792
</td>
<td style="text-align:left;">
binghamton, union/broome, otsego, chenango, delaware, cortland, tioga
counties c
</td>
<td style="text-align:right;">
328
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-514
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
130850
</td>
<td style="text-align:left;">
jamestown/dunkirk/chautauqua county coc
</td>
<td style="text-align:right;">
329
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-522
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
255122
</td>
<td style="text-align:left;">
jefferson/lewis/st. lawrence counties coc
</td>
<td style="text-align:right;">
330
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-500
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
314750
</td>
<td style="text-align:left;">
north central oklahoma coc
</td>
<td style="text-align:right;">
331
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-503
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
669481
</td>
<td style="text-align:left;">
oklahoma balance of state coc
</td>
<td style="text-align:right;">
332
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-510
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
536004
</td>
<td style="text-align:left;">
lancaster city & county coc
</td>
<td style="text-align:right;">
333
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-512
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
441548
</td>
<td style="text-align:left;">
york city & county coc
</td>
<td style="text-align:right;">
334
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-506
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
567870
</td>
<td style="text-align:left;">
oak ridge/upper cumberland coc
</td>
<td style="text-align:right;">
335
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-604
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
358285
</td>
<td style="text-align:left;">
waco/mclennan county coc
</td>
<td style="text-align:right;">
336
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-500
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
1061547
</td>
<td style="text-align:left;">
richmond/henrico, chesterfield, hanover counties coc
</td>
<td style="text-align:right;">
337
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-504
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
246286
</td>
<td style="text-align:left;">
charlottesville coc
</td>
<td style="text-align:right;">
338
</td>
</tr>
<tr>
<td style="text-align:left;">
wv
</td>
<td style="text-align:left;">
wv-508
</td>
<td style="text-align:right;">
0.07
</td>
<td style="text-align:right;">
1281817
</td>
<td style="text-align:left;">
west virginia balance of state coc
</td>
<td style="text-align:right;">
339
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-603
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
698265
</td>
<td style="text-align:left;">
ft myers/cape coral/lee county coc
</td>
<td style="text-align:right;">
292
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-501
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
6905893
</td>
<td style="text-align:left;">
georgia balance of state coc
</td>
<td style="text-align:right;">
293
</td>
</tr>
<tr>
<td style="text-align:left;">
ia
</td>
<td style="text-align:left;">
ia-501
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
2442251
</td>
<td style="text-align:left;">
iowa balance of state coc
</td>
<td style="text-align:right;">
294
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-503
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
207074
</td>
<td style="text-align:left;">
champaign/urbana/rantoul/champaign county coc
</td>
<td style="text-align:right;">
295
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-504
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
266162
</td>
<td style="text-align:left;">
madison county coc
</td>
<td style="text-align:right;">
296
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-520
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
576910
</td>
<td style="text-align:left;">
southern illinois coc
</td>
<td style="text-align:right;">
297
</td>
</tr>
<tr>
<td style="text-align:left;">
ks
</td>
<td style="text-align:left;">
ks-507
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
1474552
</td>
<td style="text-align:left;">
kansas balance of state coc
</td>
<td style="text-align:right;">
298
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-502
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
483539
</td>
<td style="text-align:left;">
shreveport/bossier/northwest coc
</td>
<td style="text-align:right;">
299
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-503
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
564194
</td>
<td style="text-align:left;">
annapolis/anne arundel county coc
</td>
<td style="text-align:right;">
300
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-500
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
2358534
</td>
<td style="text-align:left;">
michigan balance of state coc
</td>
<td style="text-align:right;">
301
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-502
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
717982
</td>
<td style="text-align:left;">
rochester/southeast minnesota coc
</td>
<td style="text-align:right;">
302
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-509
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
390735
</td>
<td style="text-align:left;">
gastonia/cleveland, gaston, lincoln counties coc
</td>
<td style="text-align:right;">
303
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-513
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
332768
</td>
<td style="text-align:left;">
somerset county coc
</td>
<td style="text-align:right;">
304
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-516
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
375588
</td>
<td style="text-align:left;">
warren, sussex, hunterdon counties coc
</td>
<td style="text-align:right;">
305
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-501
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
314889
</td>
<td style="text-align:left;">
elmira/steuben, allegany, livingston, chemung, schuyler counties coc
</td>
<td style="text-align:right;">
306
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-508
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
1272364
</td>
<td style="text-align:left;">
buffalo, niagara falls/erie, niagara, orleans, genesee, wyoming counties
coc
</td>
<td style="text-align:right;">
307
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-510
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
104681
</td>
<td style="text-align:left;">
ithaca/tompkins county coc
</td>
<td style="text-align:right;">
308
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-523
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
357590
</td>
<td style="text-align:left;">
glens falls/saratoga springs/saratoga, washington, warren, hamilton
counties coc
</td>
<td style="text-align:right;">
309
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-509
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
3104937
</td>
<td style="text-align:left;">
eastern pennsylvania coc
</td>
<td style="text-align:right;">
310
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-624
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
330725
</td>
<td style="text-align:left;">
wichita falls/wise, palo pinto, wichita, archer counties coc
</td>
<td style="text-align:right;">
311
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-700
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
5748292
</td>
<td style="text-align:left;">
houston, pasadena, conroe/harris, ft. bend, montgomery, counties coc
</td>
<td style="text-align:right;">
312
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-514
</td>
<td style="text-align:right;">
0.08
</td>
<td style="text-align:right;">
356451
</td>
<td style="text-align:left;">
fredericksburg/spotsylvania, stafford counties coc
</td>
<td style="text-align:right;">
313
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-503
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
564541
</td>
<td style="text-align:left;">
huntsville/north alabama coc
</td>
<td style="text-align:right;">
273
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-507
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
396538
</td>
<td style="text-align:left;">
peoria/perkin/fulton, peoria, tazewell, woodford coc
</td>
<td style="text-align:right;">
274
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-502
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
250586
</td>
<td style="text-align:left;">
harford county coc
</td>
<td style="text-align:right;">
275
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-505
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
828373
</td>
<td style="text-align:left;">
baltimore county coc
</td>
<td style="text-align:right;">
276
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-509
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
362072
</td>
<td style="text-align:left;">
ann arbor/washtenaw county coc
</td>
<td style="text-align:right;">
277
</td>
</tr>
<tr>
<td style="text-align:left;">
ms
</td>
<td style="text-align:left;">
ms-503
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
484997
</td>
<td style="text-align:left;">
gulf port/gulf coast regional coc
</td>
<td style="text-align:right;">
278
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-506
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
399727
</td>
<td style="text-align:left;">
wilmington/brunswick, new hanover, pender counties coc
</td>
<td style="text-align:right;">
279
</td>
</tr>
<tr>
<td style="text-align:left;">
nh
</td>
<td style="text-align:left;">
nh-500
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
924881
</td>
<td style="text-align:left;">
new hampshire balance of state coc
</td>
<td style="text-align:right;">
280
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-509
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
498238
</td>
<td style="text-align:left;">
morris county coc
</td>
<td style="text-align:right;">
281
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-515
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
552128
</td>
<td style="text-align:left;">
elizabeth/union county coc
</td>
<td style="text-align:right;">
282
</td>
</tr>
<tr>
<td style="text-align:left;">
nm
</td>
<td style="text-align:left;">
nm-501
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
1554889
</td>
<td style="text-align:left;">
new mexico balance of state coc
</td>
<td style="text-align:right;">
283
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-502
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
562949
</td>
<td style="text-align:left;">
upper darby/chester/haverford/delaware county coc
</td>
<td style="text-align:right;">
284
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-511
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
625857
</td>
<td style="text-align:left;">
bristol/bensalem/bucks county coc
</td>
<td style="text-align:right;">
285
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-503
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
451176
</td>
<td style="text-align:left;">
virginia beach coc
</td>
<td style="text-align:right;">
286
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-513
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
362584
</td>
<td style="text-align:left;">
harrisburg, winchester/western virginia coc
</td>
<td style="text-align:right;">
287
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-601
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
1174776
</td>
<td style="text-align:left;">
fairfax county coc
</td>
<td style="text-align:right;">
288
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-604
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
507573
</td>
<td style="text-align:left;">
prince william county coc
</td>
<td style="text-align:right;">
289
</td>
</tr>
<tr>
<td style="text-align:left;">
wi
</td>
<td style="text-align:left;">
wi-500
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
4094517
</td>
<td style="text-align:left;">
wisconsin balance of state coc
</td>
<td style="text-align:right;">
290
</td>
</tr>
<tr>
<td style="text-align:left;">
wv
</td>
<td style="text-align:left;">
wv-500
</td>
<td style="text-align:right;">
0.09
</td>
<td style="text-align:right;">
143954
</td>
<td style="text-align:left;">
wheeling/weirton area coc
</td>
<td style="text-align:right;">
291
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-612
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
198806
</td>
<td style="text-align:left;">
glendale coc
</td>
<td style="text-align:right;">
250
</td>
</tr>
<tr>
<td style="text-align:left;">
ct
</td>
<td style="text-align:left;">
ct-503
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
858949
</td>
<td style="text-align:left;">
bridgeport/norwalk /stamford/fairfield county coc
</td>
<td style="text-align:right;">
251
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-503
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
648706
</td>
<td style="text-align:left;">
lakeland/winter haven/polk county coc
</td>
<td style="text-align:right;">
252
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-501
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
340814
</td>
<td style="text-align:left;">
rockford/winnebago, boone counties coc
</td>
<td style="text-align:right;">
253
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-512
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
530800
</td>
<td style="text-align:left;">
bloomington/central illinois coc
</td>
<td style="text-align:right;">
254
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-506
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
167626
</td>
<td style="text-align:left;">
carroll county coc
</td>
<td style="text-align:right;">
255
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-511
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
171089
</td>
<td style="text-align:left;">
mid-shore regional coc
</td>
<td style="text-align:right;">
256
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-601
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
1034883
</td>
<td style="text-align:left;">
montgomery county coc
</td>
<td style="text-align:right;">
257
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-517
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
159207
</td>
<td style="text-align:left;">
jackson city & county coc
</td>
<td style="text-align:right;">
258
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-519
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
287039
</td>
<td style="text-align:left;">
holland/ottawa county coc
</td>
<td style="text-align:right;">
259
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-507
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
1021133
</td>
<td style="text-align:left;">
raleigh/wake county coc
</td>
<td style="text-align:right;">
260
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-513
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
140970
</td>
<td style="text-align:left;">
chapel hill/orange county coc
</td>
<td style="text-align:right;">
261
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-503
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
1052022
</td>
<td style="text-align:left;">
camden city/camden, cumberland, gloucester, cape may counties coc
</td>
<td style="text-align:right;">
262
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-511
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
506834
</td>
<td style="text-align:left;">
paterson/passaic county coc
</td>
<td style="text-align:right;">
263
</td>
</tr>
<tr>
<td style="text-align:left;">
nv
</td>
<td style="text-align:left;">
nv-502
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
330165
</td>
<td style="text-align:left;">
nevada balance of state coc
</td>
<td style="text-align:right;">
264
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-508
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
374545
</td>
<td style="text-align:left;">
canton/massillon/alliance/stark county coc
</td>
<td style="text-align:right;">
265
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-507
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
540654
</td>
<td style="text-align:left;">
southeastern oklahoma regional coc
</td>
<td style="text-align:right;">
266
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-600
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
1229575
</td>
<td style="text-align:left;">
pittsburgh/mckeesport/penn hills/allegheny county coc
</td>
<td style="text-align:right;">
267
</td>
</tr>
<tr>
<td style="text-align:left;">
sc
</td>
<td style="text-align:left;">
sc-501
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
1480081
</td>
<td style="text-align:left;">
greenville/anderson/spartanburg upstate coc
</td>
<td style="text-align:right;">
268
</td>
</tr>
<tr>
<td style="text-align:left;">
sc
</td>
<td style="text-align:left;">
sc-502
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
1496796
</td>
<td style="text-align:left;">
columbia/midlands coc
</td>
<td style="text-align:right;">
269
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-509
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
506973
</td>
<td style="text-align:left;">
appalachian regional coc
</td>
<td style="text-align:right;">
270
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-601
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
2090799
</td>
<td style="text-align:left;">
fort worth/arlington/tarrant county coc
</td>
<td style="text-align:right;">
271
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-607
</td>
<td style="text-align:right;">
0.10
</td>
<td style="text-align:right;">
10634996
</td>
<td style="text-align:left;">
texas balance of state (bos) coc
</td>
<td style="text-align:right;">
272
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-506
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
204484
</td>
<td style="text-align:left;">
tuscaloosa city & county coc
</td>
<td style="text-align:right;">
229
</td>
</tr>
<tr>
<td style="text-align:left;">
ar
</td>
<td style="text-align:left;">
ar-503
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
859633
</td>
<td style="text-align:left;">
arkansas balance of state coc
</td>
<td style="text-align:right;">
230
</td>
</tr>
<tr>
<td style="text-align:left;">
ct
</td>
<td style="text-align:left;">
ct-505
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
2730533
</td>
<td style="text-align:left;">
connecticut balance of state coc
</td>
<td style="text-align:right;">
231
</td>
</tr>
<tr>
<td style="text-align:left;">
de
</td>
<td style="text-align:left;">
de-500
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
942936
</td>
<td style="text-align:left;">
delaware statewide coc
</td>
<td style="text-align:right;">
232
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-509
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
104571
</td>
<td style="text-align:left;">
dekalb city & county coc
</td>
<td style="text-align:right;">
233
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-516
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
172813
</td>
<td style="text-align:left;">
norton shores/muskegon city & county coc
</td>
<td style="text-align:right;">
234
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-523
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
108747
</td>
<td style="text-align:left;">
eaton county coc
</td>
<td style="text-align:right;">
235
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-504
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
125218
</td>
<td style="text-align:left;">
northeast minnesota coc
</td>
<td style="text-align:right;">
236
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-508
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
240746
</td>
<td style="text-align:left;">
moorhead/west central minnesota coc
</td>
<td style="text-align:right;">
237
</td>
</tr>
<tr>
<td style="text-align:left;">
nh
</td>
<td style="text-align:left;">
nh-502
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
295601
</td>
<td style="text-align:left;">
nashua/hillsborough county coc
</td>
<td style="text-align:right;">
238
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-500
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
749116
</td>
<td style="text-align:left;">
rochester/irondequoit/greece/monroe county coc
</td>
<td style="text-align:right;">
239
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-602
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
377100
</td>
<td style="text-align:left;">
newburgh/middletown/orange county coc
</td>
<td style="text-align:right;">
240
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-506
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
540897
</td>
<td style="text-align:left;">
akron/barberton/summit county coc
</td>
<td style="text-align:right;">
241
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-505
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
441778
</td>
<td style="text-align:left;">
northeast oklahoma coc
</td>
<td style="text-align:right;">
242
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-508
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
212553
</td>
<td style="text-align:left;">
scranton/lackawanna county coc
</td>
<td style="text-align:right;">
243
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-500
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
684710
</td>
<td style="text-align:left;">
chattanooga/southeast tennessee coc
</td>
<td style="text-align:right;">
244
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-600
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
3684054
</td>
<td style="text-align:left;">
dallas city & county/irving coc
</td>
<td style="text-align:right;">
245
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-502
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
278757
</td>
<td style="text-align:left;">
roanoke city & county/salem coc
</td>
<td style="text-align:right;">
246
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-505
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
486161
</td>
<td style="text-align:left;">
newport news/hampton/virginia peninsula coc
</td>
<td style="text-align:right;">
247
</td>
</tr>
<tr>
<td style="text-align:left;">
wi
</td>
<td style="text-align:left;">
wi-501
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
954673
</td>
<td style="text-align:left;">
milwaukee city & county coc
</td>
<td style="text-align:right;">
248
</td>
</tr>
<tr>
<td style="text-align:left;">
wi
</td>
<td style="text-align:left;">
wi-502
</td>
<td style="text-align:right;">
0.11
</td>
<td style="text-align:right;">
194851
</td>
<td style="text-align:left;">
racine city & county coc
</td>
<td style="text-align:right;">
249
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-501
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
618230
</td>
<td style="text-align:left;">
mobile city & county/baldwin county coc
</td>
<td style="text-align:right;">
212
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-504
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
383488
</td>
<td style="text-align:left;">
montgomery city & county coc
</td>
<td style="text-align:right;">
213
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-609
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
2118739
</td>
<td style="text-align:left;">
san bernardino city & county coc
</td>
<td style="text-align:right;">
214
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-520
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
763325
</td>
<td style="text-align:left;">
citrus, hernando, lake, sumter counties coc
</td>
<td style="text-align:right;">
215
</td>
</tr>
<tr>
<td style="text-align:left;">
id
</td>
<td style="text-align:left;">
id-501
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
1220324
</td>
<td style="text-align:left;">
idaho balance of state
</td>
<td style="text-align:right;">
216
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-513
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
198262
</td>
<td style="text-align:left;">
springfield/sangamon county coc
</td>
<td style="text-align:right;">
217
</td>
</tr>
<tr>
<td style="text-align:left;">
ks
</td>
<td style="text-align:left;">
ks-502
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
509913
</td>
<td style="text-align:left;">
wichita/sedgwick county coc
</td>
<td style="text-align:right;">
218
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-517
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
125107
</td>
<td style="text-align:left;">
somerville coc
</td>
<td style="text-align:right;">
219
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-505
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
410306
</td>
<td style="text-align:left;">
flint/genesee county coc
</td>
<td style="text-align:right;">
220
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-513
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
76570
</td>
<td style="text-align:left;">
marquette, alger counties coc
</td>
<td style="text-align:right;">
221
</td>
</tr>
<tr>
<td style="text-align:left;">
ms
</td>
<td style="text-align:left;">
ms-500
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
572084
</td>
<td style="text-align:left;">
jackson/rankin, madison counties coc
</td>
<td style="text-align:right;">
222
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-504
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
231480
</td>
<td style="text-align:left;">
youngstown/mahoning county coc
</td>
<td style="text-align:right;">
223
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-504
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
202712
</td>
<td style="text-align:left;">
norman/cleveland county coc
</td>
<td style="text-align:right;">
224
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-505
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
514259
</td>
<td style="text-align:left;">
chester county coc
</td>
<td style="text-align:right;">
225
</td>
</tr>
<tr>
<td style="text-align:left;">
ri
</td>
<td style="text-align:left;">
ri-500
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
1055321
</td>
<td style="text-align:left;">
rhode island statewide coc
</td>
<td style="text-align:right;">
226
</td>
</tr>
<tr>
<td style="text-align:left;">
sd
</td>
<td style="text-align:left;">
sd-500
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
858926
</td>
<td style="text-align:left;">
south dakota statewide coc
</td>
<td style="text-align:right;">
227
</td>
</tr>
<tr>
<td style="text-align:left;">
wi
</td>
<td style="text-align:left;">
wi-503
</td>
<td style="text-align:right;">
0.12
</td>
<td style="text-align:right;">
523438
</td>
<td style="text-align:left;">
madison/dane county coc
</td>
<td style="text-align:right;">
228
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-604
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
876938
</td>
<td style="text-align:left;">
bakersfield/kern county coc
</td>
<td style="text-align:right;">
194
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-507
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
2054589
</td>
<td style="text-align:left;">
orlando/orange, osceola, seminole counties coc
</td>
<td style="text-align:right;">
195
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-515
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
304441
</td>
<td style="text-align:left;">
panama city/bay, jackson counties coc
</td>
<td style="text-align:right;">
196
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-515
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
149454
</td>
<td style="text-align:left;">
monroe city & county coc
</td>
<td style="text-align:right;">
197
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-505
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
730221
</td>
<td style="text-align:left;">
st. cloud/central minnesota coc
</td>
<td style="text-align:right;">
198
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-600
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
408354
</td>
<td style="text-align:left;">
springfield/greene, christian, webster counties coc
</td>
<td style="text-align:right;">
199
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-502
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
300419
</td>
<td style="text-align:left;">
durham city & county coc
</td>
<td style="text-align:right;">
200
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-504
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
516867
</td>
<td style="text-align:left;">
greensboro/high point coc
</td>
<td style="text-align:right;">
201
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-506
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
674433
</td>
<td style="text-align:left;">
jersey city/bayonne/hudson county coc
</td>
<td style="text-align:right;">
202
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-505
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
666032
</td>
<td style="text-align:left;">
syracuse, auburn/onondaga, oswego, cayuga counties coc
</td>
<td style="text-align:right;">
203
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-513
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
260993
</td>
<td style="text-align:left;">
wayne, ontario, seneca, yates counties coc
</td>
<td style="text-align:right;">
204
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-501
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
433339
</td>
<td style="text-align:left;">
toledo/lucas county coc
</td>
<td style="text-align:right;">
205
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-505
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
536021
</td>
<td style="text-align:left;">
dayton/kettering/montgomery county coc
</td>
<td style="text-align:right;">
206
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-510
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
298020
</td>
<td style="text-align:left;">
murfreesboro/rutherford county coc
</td>
<td style="text-align:right;">
207
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-512
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
663735
</td>
<td style="text-align:left;">
morristown/blount, sevier, campbell, cocke counties coc
</td>
<td style="text-align:right;">
208
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-501
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
632576
</td>
<td style="text-align:left;">
norfolk/chesapeake/suffolk/isle of wright, southampton counties coc
</td>
<td style="text-align:right;">
209
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-600
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
228239
</td>
<td style="text-align:left;">
arlington county coc
</td>
<td style="text-align:right;">
210
</td>
</tr>
<tr>
<td style="text-align:left;">
wv
</td>
<td style="text-align:left;">
wv-503
</td>
<td style="text-align:right;">
0.13
</td>
<td style="text-align:right;">
277596
</td>
<td style="text-align:left;">
charleston/kanawha, putnam, boone, clay counties coc
</td>
<td style="text-align:right;">
211
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-608
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
2349752
</td>
<td style="text-align:left;">
riverside city & county coc
</td>
<td style="text-align:right;">
181
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-504
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
201545
</td>
<td style="text-align:left;">
augusta coc
</td>
<td style="text-align:right;">
182
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-510
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
602483
</td>
<td style="text-align:left;">
gloucester/haverhill/salem/essex county coc
</td>
<td style="text-align:right;">
183
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-509
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
245557
</td>
<td style="text-align:left;">
frederick city & county coc
</td>
<td style="text-align:right;">
184
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-511
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
98444
</td>
<td style="text-align:left;">
lenawee county coc
</td>
<td style="text-align:right;">
185
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-500
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
367698
</td>
<td style="text-align:left;">
winston salem/forsyth county coc
</td>
<td style="text-align:right;">
186
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-512
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
160018
</td>
<td style="text-align:left;">
troy/rensselaer county coc
</td>
<td style="text-align:right;">
187
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-519
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
109351
</td>
<td style="text-align:left;">
columbia/greene county coc
</td>
<td style="text-align:right;">
188
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-601
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
294882
</td>
<td style="text-align:left;">
poughkeepsie/dutchess county coc
</td>
<td style="text-align:right;">
189
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-503
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
1289308
</td>
<td style="text-align:left;">
columbus/franklin county coc
</td>
<td style="text-align:right;">
190
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-506
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
571966
</td>
<td style="text-align:left;">
hillsboro/beaverton/washington county coc
</td>
<td style="text-align:right;">
191
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-506
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
414229
</td>
<td style="text-align:left;">
reading/berks county coc
</td>
<td style="text-align:right;">
192
</td>
</tr>
<tr>
<td style="text-align:left;">
sc
</td>
<td style="text-align:left;">
sc-503
</td>
<td style="text-align:right;">
0.14
</td>
<td style="text-align:right;">
905529
</td>
<td style="text-align:left;">
myrtle beach/sumter city & county coc
</td>
<td style="text-align:right;">
193
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:left;">
al-500
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
954826
</td>
<td style="text-align:left;">
birmingham/jefferson, st. clair, shelby counties coc
</td>
<td style="text-align:right;">
165
</td>
</tr>
<tr>
<td style="text-align:left;">
az
</td>
<td style="text-align:left;">
az-500
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
1643134
</td>
<td style="text-align:left;">
arizona balance of state coc
</td>
<td style="text-align:right;">
166
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-601
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
1884408
</td>
<td style="text-align:left;">
ft lauderdale/broward county coc
</td>
<td style="text-align:right;">
167
</td>
</tr>
<tr>
<td style="text-align:left;">
ia
</td>
<td style="text-align:left;">
ia-502
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
481896
</td>
<td style="text-align:left;">
des moines/polk county coc
</td>
<td style="text-align:right;">
168
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-508
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
271982
</td>
<td style="text-align:left;">
east saint louis/belleville/saint clair county coc
</td>
<td style="text-align:right;">
169
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-516
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
107615
</td>
<td style="text-align:left;">
decatur/macon county coc
</td>
<td style="text-align:right;">
170
</td>
</tr>
<tr>
<td style="text-align:left;">
ky
</td>
<td style="text-align:left;">
ky-501
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
763639
</td>
<td style="text-align:left;">
louisville/jefferson county coc
</td>
<td style="text-align:right;">
171
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-506
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
636114
</td>
<td style="text-align:left;">
grand rapids/wyoming/kent county coc
</td>
<td style="text-align:right;">
172
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-512
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
171217
</td>
<td style="text-align:left;">
grand traverse, antrim, leelanau counties coc
</td>
<td style="text-align:right;">
173
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-503
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
473166
</td>
<td style="text-align:left;">
st. charles, lincoln, warren counties coc
</td>
<td style="text-align:right;">
174
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-502
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
449916
</td>
<td style="text-align:left;">
burlington county coc
</td>
<td style="text-align:right;">
175
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-514
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
371990
</td>
<td style="text-align:left;">
trenton/mercer county coc
</td>
<td style="text-align:right;">
176
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-603
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
2853877
</td>
<td style="text-align:left;">
nassau, suffolk counties/babylon/islip/ huntington coc
</td>
<td style="text-align:right;">
177
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-500
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
811574
</td>
<td style="text-align:left;">
cincinnati/hamilton county coc
</td>
<td style="text-align:right;">
178
</td>
</tr>
<tr>
<td style="text-align:left;">
oh
</td>
<td style="text-align:left;">
oh-502
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
1254231
</td>
<td style="text-align:left;">
cleveland/cuyahoga county coc
</td>
<td style="text-align:right;">
179
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-605
</td>
<td style="text-align:right;">
0.15
</td>
<td style="text-align:right;">
278408
</td>
<td style="text-align:left;">
erie city & county coc
</td>
<td style="text-align:right;">
180
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-600
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
2689794
</td>
<td style="text-align:left;">
miami/dade county coc
</td>
<td style="text-align:right;">
158
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-605
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
1418708
</td>
<td style="text-align:left;">
west palm beach/palm beach county coc
</td>
<td style="text-align:right;">
159
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-505
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
259291
</td>
<td style="text-align:left;">
columbus-muscogee/russell county coc
</td>
<td style="text-align:right;">
160
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-512
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
149872
</td>
<td style="text-align:left;">
hagerstown/washington county coc
</td>
<td style="text-align:right;">
161
</td>
</tr>
<tr>
<td style="text-align:left;">
nd
</td>
<td style="text-align:left;">
nd-500
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
750684
</td>
<td style="text-align:left;">
north dakota statewide coc
</td>
<td style="text-align:right;">
162
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-603
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
153631
</td>
<td style="text-align:left;">
city of alexandria coc
</td>
<td style="text-align:right;">
163
</td>
</tr>
<tr>
<td style="text-align:left;">
wy
</td>
<td style="text-align:left;">
wy-500
</td>
<td style="text-align:right;">
0.16
</td>
<td style="text-align:right;">
586379
</td>
<td style="text-align:left;">
wyoming statewide coc
</td>
<td style="text-align:right;">
164
</td>
</tr>
<tr>
<td style="text-align:left;">
az
</td>
<td style="text-align:left;">
az-502
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
4163953
</td>
<td style="text-align:left;">
phoenix/mesa/maricopa county regional coc
</td>
<td style="text-align:right;">
142
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-504
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
622944
</td>
<td style="text-align:left;">
daytona beach/daytona/volusia, flagler counties coc
</td>
<td style="text-align:right;">
143
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-513
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
567775
</td>
<td style="text-align:left;">
palm bay/melbourne/brevard county coc
</td>
<td style="text-align:right;">
144
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-602
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
173501
</td>
<td style="text-align:left;">
punta gorda/charlotte county coc
</td>
<td style="text-align:right;">
145
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-503
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
242698
</td>
<td style="text-align:left;">
cape cod/islands coc
</td>
<td style="text-align:right;">
146
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-513
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
179053
</td>
<td style="text-align:left;">
wicomico/somerset/worcester county coc
</td>
<td style="text-align:right;">
147
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-602
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
176273
</td>
<td style="text-align:left;">
joplin/jasper, newton counties coc
</td>
<td style="text-align:right;">
148
</td>
</tr>
<tr>
<td style="text-align:left;">
mt
</td>
<td style="text-align:left;">
mt-500
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
1032083
</td>
<td style="text-align:left;">
montana statewide coc
</td>
<td style="text-align:right;">
149
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-505
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
1033260
</td>
<td style="text-align:left;">
charlotte/mecklenberg coc
</td>
<td style="text-align:right;">
150
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-516
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
81325
</td>
<td style="text-align:left;">
clinton county coc
</td>
<td style="text-align:right;">
151
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-501
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
690290
</td>
<td style="text-align:left;">
tulsa city & county/broken arrow coc
</td>
<td style="text-align:right;">
152
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-501
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
936230
</td>
<td style="text-align:left;">
memphis/shelby county coc
</td>
<td style="text-align:right;">
153
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-603
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
836089
</td>
<td style="text-align:left;">
el paso city & county coc
</td>
<td style="text-align:right;">
154
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-503
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
837954
</td>
<td style="text-align:left;">
tacoma/lakewood/pierce county coc
</td>
<td style="text-align:right;">
155
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-504
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
770645
</td>
<td style="text-align:left;">
everett/snohomish county coc
</td>
<td style="text-align:right;">
156
</td>
</tr>
<tr>
<td style="text-align:left;">
wv
</td>
<td style="text-align:left;">
wv-501
</td>
<td style="text-align:right;">
0.17
</td>
<td style="text-align:right;">
137397
</td>
<td style="text-align:left;">
huntington/cabell, wayne counties coc
</td>
<td style="text-align:right;">
157
</td>
</tr>
<tr>
<td style="text-align:left;">
ak
</td>
<td style="text-align:left;">
ak-501
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
440800
</td>
<td style="text-align:left;">
alaska balance of state coc
</td>
<td style="text-align:right;">
127
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-501
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
1343234
</td>
<td style="text-align:left;">
tampa/hillsborough county coc
</td>
<td style="text-align:right;">
128
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-507
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
359837
</td>
<td style="text-align:left;">
pittsfield/berkshire county coc
</td>
<td style="text-align:right;">
129
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-511
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
659052
</td>
<td style="text-align:left;">
quincy/brockton/weymouth/plymouth city and county coc
</td>
<td style="text-align:right;">
130
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-500
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
72571
</td>
<td style="text-align:left;">
cumberland/allegany county coc
</td>
<td style="text-align:right;">
131
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-508
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
358636
</td>
<td style="text-align:left;">
charles, calvert, st.mary’s counties coc
</td>
<td style="text-align:right;">
132
</td>
</tr>
<tr>
<td style="text-align:left;">
me
</td>
<td style="text-align:left;">
me-500
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
1330746
</td>
<td style="text-align:left;">
maine balance of state coc
</td>
<td style="text-align:right;">
133
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-508
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
287438
</td>
<td style="text-align:left;">
lansing/east lansing/ingham county coc
</td>
<td style="text-align:right;">
134
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-514
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
134592
</td>
<td style="text-align:left;">
battle creek/calhoun county coc
</td>
<td style="text-align:right;">
135
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-604
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
1007389
</td>
<td style="text-align:left;">
kansas city, independence, lees summit/jackson, wyandotte counties, mo
& ks
</td>
<td style="text-align:right;">
136
</td>
</tr>
<tr>
<td style="text-align:left;">
ne
</td>
<td style="text-align:left;">
ne-501
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
817762
</td>
<td style="text-align:left;">
omaha/council bluffs coc
</td>
<td style="text-align:right;">
137
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-500
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
272676
</td>
<td style="text-align:left;">
atlantic city & county coc
</td>
<td style="text-align:right;">
138
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-500
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
1919847
</td>
<td style="text-align:left;">
san antonio/bexar county coc
</td>
<td style="text-align:right;">
139
</td>
</tr>
<tr>
<td style="text-align:left;">
va
</td>
<td style="text-align:left;">
va-507
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
96007
</td>
<td style="text-align:left;">
portsmouth coc
</td>
<td style="text-align:right;">
140
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-508
</td>
<td style="text-align:right;">
0.18
</td>
<td style="text-align:right;">
465567
</td>
<td style="text-align:left;">
vancouver/clark county coc
</td>
<td style="text-align:right;">
141
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-513
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
607029
</td>
<td style="text-align:left;">
visalia, kings, tulare counties coc
</td>
<td style="text-align:right;">
121
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-510
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
1192876
</td>
<td style="text-align:left;">
jacksonville-duval, clay counties coc
</td>
<td style="text-align:right;">
122
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-606
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
355381
</td>
<td style="text-align:left;">
naples/collier county coc
</td>
<td style="text-align:right;">
123
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-603
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
119265
</td>
<td style="text-align:left;">
st. joseph/andrew, buchanan, dekalb counties coc
</td>
<td style="text-align:right;">
124
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-507
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
154894
</td>
<td style="text-align:left;">
schenectady city & county coc
</td>
<td style="text-align:right;">
125
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-501
</td>
<td style="text-align:right;">
0.19
</td>
<td style="text-align:right;">
272830
</td>
<td style="text-align:left;">
harrisburg/dauphin county coc
</td>
<td style="text-align:right;">
126
</td>
</tr>
<tr>
<td style="text-align:left;">
ar
</td>
<td style="text-align:left;">
ar-500
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
590603
</td>
<td style="text-align:left;">
little rock/central arkansas coc
</td>
<td style="text-align:right;">
109
</td>
</tr>
<tr>
<td style="text-align:left;">
az
</td>
<td style="text-align:left;">
az-501
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
1008139
</td>
<td style="text-align:left;">
tucson/pima county coc
</td>
<td style="text-align:right;">
110
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-611
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
845387
</td>
<td style="text-align:left;">
oxnard/san buenaventura/ventura county coc
</td>
<td style="text-align:right;">
111
</td>
</tr>
<tr>
<td style="text-align:left;">
co
</td>
<td style="text-align:left;">
co-503
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
3049220
</td>
<td style="text-align:left;">
metropolitan denver homeless initiative
</td>
<td style="text-align:right;">
112
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-506
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
816243
</td>
<td style="text-align:left;">
worcester city & county coc
</td>
<td style="text-align:right;">
113
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-507
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
260458
</td>
<td style="text-align:left;">
portage/kalamazoo city & county coc
</td>
<td style="text-align:right;">
114
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-511
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
327079
</td>
<td style="text-align:left;">
fayetteville/cumberland county coc
</td>
<td style="text-align:right;">
115
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-604
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
974393
</td>
<td style="text-align:left;">
yonkers/mount vernon/new rochelle/westchester coc
</td>
<td style="text-align:right;">
116
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-507
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
400496
</td>
<td style="text-align:left;">
clackamas county coc
</td>
<td style="text-align:right;">
117
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-502
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
451980
</td>
<td style="text-align:left;">
knoxville/knox county coc
</td>
<td style="text-align:right;">
118
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-503
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
1250891
</td>
<td style="text-align:left;">
austin/travis county coc
</td>
<td style="text-align:right;">
119
</td>
</tr>
<tr>
<td style="text-align:left;">
ut
</td>
<td style="text-align:left;">
ut-500
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
1111517
</td>
<td style="text-align:left;">
salt lake city & county coc
</td>
<td style="text-align:right;">
120
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-505
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
1119782
</td>
<td style="text-align:left;">
richmond/contra costa county coc
</td>
<td style="text-align:right;">
101
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-511
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
479606
</td>
<td style="text-align:left;">
pensacola/escambia/santa rosa county coc
</td>
<td style="text-align:right;">
102
</td>
</tr>
<tr>
<td style="text-align:left;">
id
</td>
<td style="text-align:left;">
id-500
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
434095
</td>
<td style="text-align:left;">
boise/ada county coc
</td>
<td style="text-align:right;">
103
</td>
</tr>
<tr>
<td style="text-align:left;">
in
</td>
<td style="text-align:left;">
in-503
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
937949
</td>
<td style="text-align:left;">
indianapolis coc
</td>
<td style="text-align:right;">
104
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-516
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
1076446
</td>
<td style="text-align:left;">
massachusetts balance of state
</td>
<td style="text-align:right;">
105
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-507
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
102390
</td>
<td style="text-align:left;">
cecil county coc
</td>
<td style="text-align:right;">
106
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-506
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
170369
</td>
<td style="text-align:left;">
northwest minnesota coc
</td>
<td style="text-align:right;">
107
</td>
</tr>
<tr>
<td style="text-align:left;">
vt
</td>
<td style="text-align:left;">
vt-501
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
161309
</td>
<td style="text-align:left;">
burlington/chittenden county coc
</td>
<td style="text-align:right;">
108
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-512
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
760765
</td>
<td style="text-align:left;">
daly/san mateo county coc
</td>
<td style="text-align:right;">
96
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-602
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
3148353
</td>
<td style="text-align:left;">
santa ana/anaheim/orange county coc
</td>
<td style="text-align:right;">
97
</td>
</tr>
<tr>
<td style="text-align:left;">
ks
</td>
<td style="text-align:left;">
ks-503
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
178342
</td>
<td style="text-align:left;">
topeka/shawnee county coc
</td>
<td style="text-align:right;">
98
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-510
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
193923
</td>
<td style="text-align:left;">
saginaw city & county coc
</td>
<td style="text-align:right;">
99
</td>
</tr>
<tr>
<td style="text-align:left;">
vt
</td>
<td style="text-align:left;">
vt-500
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
464585
</td>
<td style="text-align:left;">
vermont balance of state coc
</td>
<td style="text-align:right;">
100
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-511
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
721166
</td>
<td style="text-align:left;">
stockton/san joaquin county coc
</td>
<td style="text-align:right;">
93
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-505
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
262928
</td>
<td style="text-align:left;">
fort walton beach/okaloosa, walton counties coc
</td>
<td style="text-align:right;">
94
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
<td style="text-align:left;">
il-510
</td>
<td style="text-align:right;">
0.23
</td>
<td style="text-align:right;">
2712975
</td>
<td style="text-align:left;">
chicago coc
</td>
<td style="text-align:right;">
95
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-514
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
1123116
</td>
<td style="text-align:left;">
fresno/madera county coc
</td>
<td style="text-align:right;">
86
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-520
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
266117
</td>
<td style="text-align:left;">
merced city & county coc
</td>
<td style="text-align:right;">
87
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-503
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
123169
</td>
<td style="text-align:left;">
athens/clarke county coc
</td>
<td style="text-align:right;">
88
</td>
</tr>
<tr>
<td style="text-align:left;">
la
</td>
<td style="text-align:left;">
la-503
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
824422
</td>
<td style="text-align:left;">
new orleans/jefferson parish coc
</td>
<td style="text-align:right;">
89
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-501
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
252888
</td>
<td style="text-align:left;">
asheville/buncombe county coc
</td>
<td style="text-align:right;">
90
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-607
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
75306
</td>
<td style="text-align:left;">
sullivan county coc
</td>
<td style="text-align:right;">
91
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-507
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
668662
</td>
<td style="text-align:left;">
jackson/west tennessee coc
</td>
<td style="text-align:right;">
92
</td>
</tr>
<tr>
<td style="text-align:left;">
ia
</td>
<td style="text-align:left;">
ia-500
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
122918
</td>
<td style="text-align:left;">
sioux city/dakota, woodbury counties coc
</td>
<td style="text-align:right;">
81
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:left;">
ok-502
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
629187
</td>
<td style="text-align:left;">
oklahoma city coc
</td>
<td style="text-align:right;">
82
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-501
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
2228592
</td>
<td style="text-align:left;">
washington balance of state coc
</td>
<td style="text-align:right;">
83
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-502
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
490886
</td>
<td style="text-align:left;">
spokane city & county coc
</td>
<td style="text-align:right;">
84
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-507
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
247954
</td>
<td style="text-align:left;">
yakima city & county coc
</td>
<td style="text-align:right;">
85
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-515
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
473570
</td>
<td style="text-align:left;">
roseville/rocklin/placer, nevada counties coc
</td>
<td style="text-align:right;">
78
</td>
</tr>
<tr>
<td style="text-align:left;">
co
</td>
<td style="text-align:left;">
co-504
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
675318
</td>
<td style="text-align:left;">
colorado springs/el paso county coc
</td>
<td style="text-align:right;">
79
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-514
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
343871
</td>
<td style="text-align:left;">
ocala/marion county coc
</td>
<td style="text-align:right;">
80
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-517
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
141351
</td>
<td style="text-align:left;">
napa city & county coc
</td>
<td style="text-align:right;">
73
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-506
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
438911
</td>
<td style="text-align:left;">
tallahassee/leon county coc
</td>
<td style="text-align:right;">
74
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-500
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
1220754
</td>
<td style="text-align:left;">
minneapolis/hennepin county coc
</td>
<td style="text-align:right;">
75
</td>
</tr>
<tr>
<td style="text-align:left;">
ne
</td>
<td style="text-align:left;">
ne-502
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
253363
</td>
<td style="text-align:left;">
lincoln coc
</td>
<td style="text-align:right;">
76
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-608
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
179710
</td>
<td style="text-align:left;">
kingston/ulster county coc
</td>
<td style="text-align:right;">
77
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-500
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
767077
</td>
<td style="text-align:left;">
sarasota/bradenton/manatee, sarasota counties coc
</td>
<td style="text-align:right;">
70
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:left;">
nj-504
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
793563
</td>
<td style="text-align:left;">
newark/essex county coc
</td>
<td style="text-align:right;">
71
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-503
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
308319
</td>
<td style="text-align:left;">
albany city & county coc
</td>
<td style="text-align:right;">
72
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-508
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
414138
</td>
<td style="text-align:left;">
gainesville/alachua, putnam counties coc
</td>
<td style="text-align:right;">
66
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-501
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
535645
</td>
<td style="text-align:left;">
saint paul/ramsey county coc
</td>
<td style="text-align:right;">
67
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:left;">
mn-509
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
200200
</td>
<td style="text-align:left;">
duluth/st.louis county coc
</td>
<td style="text-align:right;">
68
</td>
</tr>
<tr>
<td style="text-align:left;">
nv
</td>
<td style="text-align:left;">
nv-501
</td>
<td style="text-align:right;">
0.29
</td>
<td style="text-align:right;">
444809
</td>
<td style="text-align:left;">
reno/sparks/washoe county coc
</td>
<td style="text-align:right;">
69
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-503
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
1492768
</td>
<td style="text-align:left;">
sacramento city & county coc
</td>
<td style="text-align:right;">
63
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-521
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
212022
</td>
<td style="text-align:left;">
davis/woodland/yolo county coc
</td>
<td style="text-align:right;">
64
</td>
</tr>
<tr>
<td style="text-align:left;">
tx
</td>
<td style="text-align:left;">
tx-611
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
189080
</td>
<td style="text-align:left;">
amarillo coc
</td>
<td style="text-align:right;">
65
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-512
</td>
<td style="text-align:right;">
0.31
</td>
<td style="text-align:right;">
226229
</td>
<td style="text-align:left;">
saint johns county coc
</td>
<td style="text-align:right;">
62
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:left;">
nc-516
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
210136
</td>
<td style="text-align:left;">
northwest north carolina coc
</td>
<td style="text-align:right;">
60
</td>
</tr>
<tr>
<td style="text-align:left;">
nm
</td>
<td style="text-align:left;">
nm-500
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
526332
</td>
<td style="text-align:left;">
albuquerque coc
</td>
<td style="text-align:right;">
61
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:left;">
mi-501
</td>
<td style="text-align:right;">
0.34
</td>
<td style="text-align:right;">
676812
</td>
<td style="text-align:left;">
detroit coc
</td>
<td style="text-align:right;">
59
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-516
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
311933
</td>
<td style="text-align:left;">
redding/shasta, siskiyou, lassen, plumas, del norte, modoc, sierra
counties coc
</td>
<td style="text-align:right;">
55
</td>
</tr>
<tr>
<td style="text-align:left;">
co
</td>
<td style="text-align:left;">
co-500
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
1702773
</td>
<td style="text-align:left;">
colorado balance of state coc
</td>
<td style="text-align:right;">
56
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-515
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
89077
</td>
<td style="text-align:left;">
fall river coc
</td>
<td style="text-align:right;">
57
</td>
</tr>
<tr>
<td style="text-align:left;">
nv
</td>
<td style="text-align:left;">
nv-500
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
2104734
</td>
<td style="text-align:left;">
las vegas/clark county coc
</td>
<td style="text-align:right;">
58
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-518
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
433439
</td>
<td style="text-align:left;">
vallejo/solano county coc
</td>
<td style="text-align:right;">
51
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-526
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
152888
</td>
<td style="text-align:left;">
amador, calaveras, tuolumne and mariposa counties coc
</td>
<td style="text-align:right;">
52
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-601
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
3283616
</td>
<td style="text-align:left;">
san diego city and county coc
</td>
<td style="text-align:right;">
53
</td>
</tr>
<tr>
<td style="text-align:left;">
ky
</td>
<td style="text-align:left;">
ky-502
</td>
<td style="text-align:right;">
0.37
</td>
<td style="text-align:right;">
314752
</td>
<td style="text-align:left;">
lexington/fayette county coc
</td>
<td style="text-align:right;">
54
</td>
</tr>
<tr>
<td style="text-align:left;">
tn
</td>
<td style="text-align:left;">
tn-504
</td>
<td style="text-align:right;">
0.38
</td>
<td style="text-align:right;">
677264
</td>
<td style="text-align:left;">
nashville/davidson county coc
</td>
<td style="text-align:right;">
50
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-523
</td>
<td style="text-align:right;">
0.39
</td>
<td style="text-align:right;">
62236
</td>
<td style="text-align:left;">
colusa, glenn, trinity counties coc
</td>
<td style="text-align:right;">
49
</td>
</tr>
<tr>
<td style="text-align:left;">
pa
</td>
<td style="text-align:left;">
pa-500
</td>
<td style="text-align:right;">
0.40
</td>
<td style="text-align:right;">
1564804
</td>
<td style="text-align:left;">
philadelphia coc
</td>
<td style="text-align:right;">
48
</td>
</tr>
<tr>
<td style="text-align:left;">
ak
</td>
<td style="text-align:left;">
ak-500
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
299535
</td>
<td style="text-align:left;">
anchorage coc
</td>
<td style="text-align:right;">
41
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-510
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
533755
</td>
<td style="text-align:left;">
turlock/modesto/stanislaus county coc
</td>
<td style="text-align:right;">
42
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-502
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
947619
</td>
<td style="text-align:left;">
st. petersburg/clearwater/largo/pinellas county coc
</td>
<td style="text-align:right;">
43
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-517
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
253385
</td>
<td style="text-align:left;">
hendry, hardee, highlands counties coc
</td>
<td style="text-align:right;">
44
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-505
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
95067
</td>
<td style="text-align:left;">
new bedford coc
</td>
<td style="text-align:right;">
45
</td>
</tr>
<tr>
<td style="text-align:left;">
nh
</td>
<td style="text-align:left;">
nh-501
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
110323
</td>
<td style="text-align:left;">
manchester coc
</td>
<td style="text-align:right;">
46
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-502
</td>
<td style="text-align:right;">
0.41
</td>
<td style="text-align:right;">
213469
</td>
<td style="text-align:left;">
medford/ashland/jackson county coc
</td>
<td style="text-align:right;">
47
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-525
</td>
<td style="text-align:right;">
0.42
</td>
<td style="text-align:right;">
183907
</td>
<td style="text-align:left;">
el dorado county coc
</td>
<td style="text-align:right;">
39
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-507
</td>
<td style="text-align:right;">
0.42
</td>
<td style="text-align:right;">
285936
</td>
<td style="text-align:left;">
savannah/chatham county coc
</td>
<td style="text-align:right;">
40
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-502
</td>
<td style="text-align:right;">
0.43
</td>
<td style="text-align:right;">
1625451
</td>
<td style="text-align:left;">
oakland/alameda county coc
</td>
<td style="text-align:right;">
38
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-503
</td>
<td style="text-align:right;">
0.46
</td>
<td style="text-align:right;">
219265
</td>
<td style="text-align:left;">
central oregon coc
</td>
<td style="text-align:right;">
37
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-509
</td>
<td style="text-align:right;">
0.47
</td>
<td style="text-align:right;">
601682
</td>
<td style="text-align:left;">
fort pierce/st. lucie, indian river, martin counties coc
</td>
<td style="text-align:right;">
35
</td>
</tr>
<tr>
<td style="text-align:left;">
mo
</td>
<td style="text-align:left;">
mo-501
</td>
<td style="text-align:right;">
0.47
</td>
<td style="text-align:right;">
314210
</td>
<td style="text-align:left;">
st.louis city coc
</td>
<td style="text-align:right;">
36
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-606
</td>
<td style="text-align:right;">
0.51
</td>
<td style="text-align:right;">
474605
</td>
<td style="text-align:left;">
long beach coc
</td>
<td style="text-align:right;">
34
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-524
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
169922
</td>
<td style="text-align:left;">
yuba city & county/sutter county coc
</td>
<td style="text-align:right;">
31
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-504
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
468103
</td>
<td style="text-align:left;">
springfield coc
</td>
<td style="text-align:right;">
32
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:left;">
md-501
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
619546
</td>
<td style="text-align:left;">
baltimore city coc
</td>
<td style="text-align:right;">
33
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-500
</td>
<td style="text-align:right;">
0.53
</td>
<td style="text-align:right;">
1901963
</td>
<td style="text-align:left;">
san jose/santa clara city & county coc
</td>
<td style="text-align:right;">
28
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-507
</td>
<td style="text-align:right;">
0.53
</td>
<td style="text-align:right;">
260367
</td>
<td style="text-align:left;">
marin county coc
</td>
<td style="text-align:right;">
29
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-509
</td>
<td style="text-align:right;">
0.53
</td>
<td style="text-align:right;">
109598
</td>
<td style="text-align:left;">
cambridge coc
</td>
<td style="text-align:right;">
30
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-607
</td>
<td style="text-align:right;">
0.57
</td>
<td style="text-align:right;">
137876
</td>
<td style="text-align:left;">
pasadena coc
</td>
<td style="text-align:right;">
25
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-500
</td>
<td style="text-align:right;">
0.57
</td>
<td style="text-align:right;">
363486
</td>
<td style="text-align:left;">
eugene/springfield/lane county coc
</td>
<td style="text-align:right;">
26
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-505
</td>
<td style="text-align:right;">
0.57
</td>
<td style="text-align:right;">
1468651
</td>
<td style="text-align:left;">
oregon balance of state coc
</td>
<td style="text-align:right;">
27
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-603
</td>
<td style="text-align:right;">
0.60
</td>
<td style="text-align:right;">
442940
</td>
<td style="text-align:left;">
santa maria/santa barbara county coc
</td>
<td style="text-align:right;">
22
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-518
</td>
<td style="text-align:right;">
0.60
</td>
<td style="text-align:right;">
135313
</td>
<td style="text-align:left;">
columbia, hamilton, lafayette, suwannee counties coc
</td>
<td style="text-align:right;">
23
</td>
</tr>
<tr>
<td style="text-align:left;">
hi
</td>
<td style="text-align:left;">
hi-501
</td>
<td style="text-align:right;">
0.60
</td>
<td style="text-align:right;">
989820
</td>
<td style="text-align:left;">
honolulu coc
</td>
<td style="text-align:right;">
24
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-508
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
110393
</td>
<td style="text-align:left;">
lowell coc
</td>
<td style="text-align:right;">
19
</td>
</tr>
<tr>
<td style="text-align:left;">
or
</td>
<td style="text-align:left;">
or-501
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
787968
</td>
<td style="text-align:left;">
portland-gresham-multnomah county coc
</td>
<td style="text-align:right;">
20
</td>
</tr>
<tr>
<td style="text-align:left;">
wa
</td>
<td style="text-align:left;">
wa-500
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
2119230
</td>
<td style="text-align:left;">
seattle/king county coc
</td>
<td style="text-align:right;">
21
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-614
</td>
<td style="text-align:right;">
0.67
</td>
<td style="text-align:right;">
280843
</td>
<td style="text-align:left;">
san luis obispo county coc
</td>
<td style="text-align:right;">
17
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-502
</td>
<td style="text-align:right;">
0.67
</td>
<td style="text-align:right;">
92522
</td>
<td style="text-align:left;">
lynn coc
</td>
<td style="text-align:right;">
18
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-519
</td>
<td style="text-align:right;">
0.68
</td>
<td style="text-align:right;">
225190
</td>
<td style="text-align:left;">
chico/paradise/butte county coc
</td>
<td style="text-align:right;">
16
</td>
</tr>
<tr>
<td style="text-align:left;">
hi
</td>
<td style="text-align:left;">
hi-500
</td>
<td style="text-align:right;">
0.70
</td>
<td style="text-align:right;">
431130
</td>
<td style="text-align:left;">
hawaii balance of state coc
</td>
<td style="text-align:right;">
15
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-519
</td>
<td style="text-align:right;">
0.72
</td>
<td style="text-align:right;">
497332
</td>
<td style="text-align:left;">
pasco county coc
</td>
<td style="text-align:right;">
14
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-600
</td>
<td style="text-align:right;">
0.79
</td>
<td style="text-align:right;">
9264635
</td>
<td style="text-align:left;">
los angeles city & county coc
</td>
<td style="text-align:right;">
13
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-504
</td>
<td style="text-align:right;">
0.80
</td>
<td style="text-align:right;">
500474
</td>
<td style="text-align:left;">
santa rosa/petaluma/sonoma county coc
</td>
<td style="text-align:right;">
12
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-522
</td>
<td style="text-align:right;">
0.83
</td>
<td style="text-align:right;">
135330
</td>
<td style="text-align:left;">
humboldt county coc
</td>
<td style="text-align:right;">
11
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-613
</td>
<td style="text-align:right;">
0.89
</td>
<td style="text-align:right;">
179408
</td>
<td style="text-align:left;">
imperial county coc
</td>
<td style="text-align:right;">
10
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:left;">
ga-500
</td>
<td style="text-align:right;">
0.93
</td>
<td style="text-align:right;">
460412
</td>
<td style="text-align:left;">
atlanta continuum of care
</td>
<td style="text-align:right;">
9
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-506
</td>
<td style="text-align:right;">
0.95
</td>
<td style="text-align:right;">
490506
</td>
<td style="text-align:left;">
salinas/monterey, san benito counties coc
</td>
<td style="text-align:right;">
8
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:left;">
ny-600
</td>
<td style="text-align:right;">
0.96
</td>
<td style="text-align:right;">
8497179
</td>
<td style="text-align:left;">
new york city coc
</td>
<td style="text-align:right;">
7
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:left;">
ma-500
</td>
<td style="text-align:right;">
0.99
</td>
<td style="text-align:right;">
666277
</td>
<td style="text-align:left;">
boston coc
</td>
<td style="text-align:right;">
6
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-501
</td>
<td style="text-align:right;">
1.03
</td>
<td style="text-align:right;">
859801
</td>
<td style="text-align:left;">
san francisco coc
</td>
<td style="text-align:right;">
5
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:left;">
fl-604
</td>
<td style="text-align:right;">
1.15
</td>
<td style="text-align:right;">
78399
</td>
<td style="text-align:left;">
monroe county coc
</td>
<td style="text-align:right;">
4
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-508
</td>
<td style="text-align:right;">
1.16
</td>
<td style="text-align:right;">
272584
</td>
<td style="text-align:left;">
watsonville/santa cruz city & county coc
</td>
<td style="text-align:right;">
3
</td>
</tr>
<tr>
<td style="text-align:left;">
dc
</td>
<td style="text-align:left;">
dc-500
</td>
<td style="text-align:right;">
1.20
</td>
<td style="text-align:right;">
670534
</td>
<td style="text-align:left;">
district of columbia coc
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:left;">
ca-509
</td>
<td style="text-align:right;">
2.13
</td>
<td style="text-align:right;">
87274
</td>
<td style="text-align:left;">
mendocino county coc
</td>
<td style="text-align:right;">
1
</td>
</tr>
</tbody>
</table>
</div>
**Counts of CoCs in the Top 10**

``` r
# How many of the top 10 were from each state?
zillow_cluster %>%
  select(state_code, coc_code, est_rate_perc_2017 = estimated_homeless_rate_percent_cluster_2017) %>%
  arrange(desc(est_rate_perc_2017)) %>%
  top_n(10) %>%
  select(state_code) %>%
  group_by(state_code) %>%
  summarize(count_coc = n()) %>%
  arrange(desc(count_coc)) %>%
  kable() %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "350px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:350px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
state\_code
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
count\_coc
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:right;">
5
</td>
</tr>
<tr>
<td style="text-align:left;">
dc
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ga
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:right;">
1
</td>
</tr>
</tbody>
</table>
</div>
### Fact: Highest rates of homelessness by state

To generate an overview by state, we averaged homelessness rates in all
CoCs within a state together. *See Caveat \#2 above.*

Washington, D.C., followed by Hawaii, California and Oregon had highest
average rates of homelessness. Illinois, Louisiana and Mississippi had
the lowest.

#### Supporting code and output

**Rates of Homelessness by State, Highest to Lowest**

``` r
# Homelessness rates by state 2017, highest to lowest
zillow_cluster %>%
  select(state_code, coc_name, coc_total_population_cluster_2017, est_rate_perc_2017 = estimated_homeless_rate_percent_cluster_2017) %>%
  na.omit() %>%
  group_by(state_code) %>%
  summarise(mean_homeless_rate = mean(est_rate_perc_2017),
            total_pop_2017 = sum(coc_total_population_cluster_2017)) %>%
  arrange(desc(mean_homeless_rate)) %>%
  mutate(rank_rate = rank(desc(mean_homeless_rate), ties.method= "first")) %>%
  select(rank_rate, everything()) %>%
  write_csv(paste0(save_path, "rates-of-homelessness-by-state.csv")) %>%
  kable() %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
rank\_rate
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
state\_code
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
mean\_homeless\_rate
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
total\_pop\_2017
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
dc
</td>
<td style="text-align:right;">
1.2000000
</td>
<td style="text-align:right;">
670534
</td>
</tr>
<tr>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
hi
</td>
<td style="text-align:right;">
0.6500000
</td>
<td style="text-align:right;">
1420950
</td>
</tr>
<tr>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
ca
</td>
<td style="text-align:right;">
0.4920000
</td>
<td style="text-align:right;">
38726604
</td>
</tr>
<tr>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
or
</td>
<td style="text-align:right;">
0.4285714
</td>
<td style="text-align:right;">
4025301
</td>
</tr>
<tr>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
ma
</td>
<td style="text-align:right;">
0.3600000
</td>
<td style="text-align:right;">
5885732
</td>
</tr>
<tr>
<td style="text-align:right;">
6
</td>
<td style="text-align:left;">
ak
</td>
<td style="text-align:right;">
0.2950000
</td>
<td style="text-align:right;">
740335
</td>
</tr>
<tr>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
ga
</td>
<td style="text-align:right;">
0.2900000
</td>
<td style="text-align:right;">
8973889
</td>
</tr>
<tr>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;">
fl
</td>
<td style="text-align:right;">
0.2855556
</td>
<td style="text-align:right;">
20164437
</td>
</tr>
<tr>
<td style="text-align:right;">
9
</td>
<td style="text-align:left;">
wa
</td>
<td style="text-align:right;">
0.2742857
</td>
<td style="text-align:right;">
7160828
</td>
</tr>
<tr>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;">
co
</td>
<td style="text-align:right;">
0.2733333
</td>
<td style="text-align:right;">
5427311
</td>
</tr>
<tr>
<td style="text-align:right;">
11
</td>
<td style="text-align:left;">
nv
</td>
<td style="text-align:right;">
0.2500000
</td>
<td style="text-align:right;">
2879708
</td>
</tr>
<tr>
<td style="text-align:right;">
12
</td>
<td style="text-align:left;">
vt
</td>
<td style="text-align:right;">
0.2150000
</td>
<td style="text-align:right;">
625894
</td>
</tr>
<tr>
<td style="text-align:right;">
13
</td>
<td style="text-align:left;">
nm
</td>
<td style="text-align:right;">
0.2050000
</td>
<td style="text-align:right;">
2081221
</td>
</tr>
<tr>
<td style="text-align:right;">
14
</td>
<td style="text-align:left;">
nh
</td>
<td style="text-align:right;">
0.2033333
</td>
<td style="text-align:right;">
1330805
</td>
</tr>
<tr>
<td style="text-align:right;">
15
</td>
<td style="text-align:left;">
ky
</td>
<td style="text-align:right;">
0.1966667
</td>
<td style="text-align:right;">
4426625
</td>
</tr>
<tr>
<td style="text-align:right;">
16
</td>
<td style="text-align:left;">
me
</td>
<td style="text-align:right;">
0.1800000
</td>
<td style="text-align:right;">
1330746
</td>
</tr>
<tr>
<td style="text-align:right;">
17
</td>
<td style="text-align:left;">
mo
</td>
<td style="text-align:right;">
0.1762500
</td>
<td style="text-align:right;">
6236602
</td>
</tr>
<tr>
<td style="text-align:right;">
18
</td>
<td style="text-align:left;">
az
</td>
<td style="text-align:right;">
0.1733333
</td>
<td style="text-align:right;">
6815226
</td>
</tr>
<tr>
<td style="text-align:right;">
19
</td>
<td style="text-align:left;">
ne
</td>
<td style="text-align:right;">
0.1733333
</td>
<td style="text-align:right;">
1965740
</td>
</tr>
<tr>
<td style="text-align:right;">
20
</td>
<td style="text-align:left;">
mt
</td>
<td style="text-align:right;">
0.1700000
</td>
<td style="text-align:right;">
1032083
</td>
</tr>
<tr>
<td style="text-align:right;">
21
</td>
<td style="text-align:left;">
id
</td>
<td style="text-align:right;">
0.1650000
</td>
<td style="text-align:right;">
1654419
</td>
</tr>
<tr>
<td style="text-align:right;">
22
</td>
<td style="text-align:left;">
ia
</td>
<td style="text-align:right;">
0.1600000
</td>
<td style="text-align:right;">
3047065
</td>
</tr>
<tr>
<td style="text-align:right;">
23
</td>
<td style="text-align:left;">
nd
</td>
<td style="text-align:right;">
0.1600000
</td>
<td style="text-align:right;">
750684
</td>
</tr>
<tr>
<td style="text-align:right;">
24
</td>
<td style="text-align:left;">
wy
</td>
<td style="text-align:right;">
0.1600000
</td>
<td style="text-align:right;">
586379
</td>
</tr>
<tr>
<td style="text-align:right;">
25
</td>
<td style="text-align:left;">
mn
</td>
<td style="text-align:right;">
0.1590000
</td>
<td style="text-align:right;">
5482565
</td>
</tr>
<tr>
<td style="text-align:right;">
26
</td>
<td style="text-align:left;">
ny
</td>
<td style="text-align:right;">
0.1580769
</td>
<td style="text-align:right;">
19426354
</td>
</tr>
<tr>
<td style="text-align:right;">
27
</td>
<td style="text-align:left;">
tn
</td>
<td style="text-align:right;">
0.1560000
</td>
<td style="text-align:right;">
6596403
</td>
</tr>
<tr>
<td style="text-align:right;">
28
</td>
<td style="text-align:left;">
nc
</td>
<td style="text-align:right;">
0.1475000
</td>
<td style="text-align:right;">
10036323
</td>
</tr>
<tr>
<td style="text-align:right;">
29
</td>
<td style="text-align:left;">
md
</td>
<td style="text-align:right;">
0.1450000
</td>
<td style="text-align:right;">
5989266
</td>
</tr>
<tr>
<td style="text-align:right;">
30
</td>
<td style="text-align:left;">
in
</td>
<td style="text-align:right;">
0.1400000
</td>
<td style="text-align:right;">
6610511
</td>
</tr>
<tr>
<td style="text-align:right;">
31
</td>
<td style="text-align:left;">
tx
</td>
<td style="text-align:right;">
0.1300000
</td>
<td style="text-align:right;">
27374256
</td>
</tr>
<tr>
<td style="text-align:right;">
32
</td>
<td style="text-align:left;">
mi
</td>
<td style="text-align:right;">
0.1285714
</td>
<td style="text-align:right;">
9915880
</td>
</tr>
<tr>
<td style="text-align:right;">
33
</td>
<td style="text-align:left;">
oh
</td>
<td style="text-align:right;">
0.1211111
</td>
<td style="text-align:right;">
11597905
</td>
</tr>
<tr>
<td style="text-align:right;">
34
</td>
<td style="text-align:left;">
ri
</td>
<td style="text-align:right;">
0.1200000
</td>
<td style="text-align:right;">
1055321
</td>
</tr>
<tr>
<td style="text-align:right;">
35
</td>
<td style="text-align:left;">
sd
</td>
<td style="text-align:right;">
0.1200000
</td>
<td style="text-align:right;">
858926
</td>
</tr>
<tr>
<td style="text-align:right;">
36
</td>
<td style="text-align:left;">
ok
</td>
<td style="text-align:right;">
0.1187500
</td>
<td style="text-align:right;">
3896746
</td>
</tr>
<tr>
<td style="text-align:right;">
37
</td>
<td style="text-align:left;">
wv
</td>
<td style="text-align:right;">
0.1150000
</td>
<td style="text-align:right;">
1840764
</td>
</tr>
<tr>
<td style="text-align:right;">
38
</td>
<td style="text-align:left;">
pa
</td>
<td style="text-align:right;">
0.1137500
</td>
<td style="text-align:right;">
12788395
</td>
</tr>
<tr>
<td style="text-align:right;">
39
</td>
<td style="text-align:left;">
ks
</td>
<td style="text-align:right;">
0.1125000
</td>
<td style="text-align:right;">
2740849
</td>
</tr>
<tr>
<td style="text-align:right;">
40
</td>
<td style="text-align:left;">
de
</td>
<td style="text-align:right;">
0.1100000
</td>
<td style="text-align:right;">
942936
</td>
</tr>
<tr>
<td style="text-align:right;">
41
</td>
<td style="text-align:left;">
nj
</td>
<td style="text-align:right;">
0.1086667
</td>
<td style="text-align:right;">
8862611
</td>
</tr>
<tr>
<td style="text-align:right;">
42
</td>
<td style="text-align:left;">
wi
</td>
<td style="text-align:right;">
0.1075000
</td>
<td style="text-align:right;">
5767479
</td>
</tr>
<tr>
<td style="text-align:right;">
43
</td>
<td style="text-align:left;">
ct
</td>
<td style="text-align:right;">
0.1050000
</td>
<td style="text-align:right;">
3589482
</td>
</tr>
<tr>
<td style="text-align:right;">
44
</td>
<td style="text-align:left;">
al
</td>
<td style="text-align:right;">
0.1028571
</td>
<td style="text-align:right;">
4513716
</td>
</tr>
<tr>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;">
ut
</td>
<td style="text-align:right;">
0.1000000
</td>
<td style="text-align:right;">
2993475
</td>
</tr>
<tr>
<td style="text-align:right;">
46
</td>
<td style="text-align:left;">
sc
</td>
<td style="text-align:right;">
0.0975000
</td>
<td style="text-align:right;">
4891634
</td>
</tr>
<tr>
<td style="text-align:right;">
47
</td>
<td style="text-align:left;">
va
</td>
<td style="text-align:right;">
0.0968750
</td>
<td style="text-align:right;">
8363972
</td>
</tr>
<tr>
<td style="text-align:right;">
48
</td>
<td style="text-align:left;">
ar
</td>
<td style="text-align:right;">
0.0960000
</td>
<td style="text-align:right;">
2382247
</td>
</tr>
<tr>
<td style="text-align:right;">
49
</td>
<td style="text-align:left;">
ms
</td>
<td style="text-align:right;">
0.0866667
</td>
<td style="text-align:right;">
2990303
</td>
</tr>
<tr>
<td style="text-align:right;">
50
</td>
<td style="text-align:left;">
la
</td>
<td style="text-align:right;">
0.0850000
</td>
<td style="text-align:right;">
4666087
</td>
</tr>
<tr>
<td style="text-align:right;">
51
</td>
<td style="text-align:left;">
il
</td>
<td style="text-align:right;">
0.0845000
</td>
<td style="text-align:right;">
12829607
</td>
</tr>
</tbody>
</table>
</div>
**Rates of Homelessness by State, Lowest to Highest**

``` r
# Homelessness rates by state 2017, highest to lowest
zillow_cluster %>%
  select(state_code, coc_name, coc_total_population_cluster_2017, est_rate_perc_2017 = estimated_homeless_rate_percent_cluster_2017, coc_total_population_cluster_2017) %>%
  na.omit() %>%
  group_by(state_code) %>%
  summarise(mean_homeless_rate = mean(est_rate_perc_2017),
            total_pop_2017 = sum(coc_total_population_cluster_2017)) %>%
  arrange(mean_homeless_rate) %>%
  mutate(rank_rate = rank(desc(mean_homeless_rate), ties.method= "first")) %>%
  select(rank_rate, everything()) %>%
  kable() %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
rank\_rate
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
state\_code
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
mean\_homeless\_rate
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
total\_pop\_2017
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
51
</td>
<td style="text-align:left;">
il
</td>
<td style="text-align:right;">
0.0845000
</td>
<td style="text-align:right;">
12829607
</td>
</tr>
<tr>
<td style="text-align:right;">
50
</td>
<td style="text-align:left;">
la
</td>
<td style="text-align:right;">
0.0850000
</td>
<td style="text-align:right;">
4666087
</td>
</tr>
<tr>
<td style="text-align:right;">
49
</td>
<td style="text-align:left;">
ms
</td>
<td style="text-align:right;">
0.0866667
</td>
<td style="text-align:right;">
2990303
</td>
</tr>
<tr>
<td style="text-align:right;">
48
</td>
<td style="text-align:left;">
ar
</td>
<td style="text-align:right;">
0.0960000
</td>
<td style="text-align:right;">
2382247
</td>
</tr>
<tr>
<td style="text-align:right;">
47
</td>
<td style="text-align:left;">
va
</td>
<td style="text-align:right;">
0.0968750
</td>
<td style="text-align:right;">
8363972
</td>
</tr>
<tr>
<td style="text-align:right;">
46
</td>
<td style="text-align:left;">
sc
</td>
<td style="text-align:right;">
0.0975000
</td>
<td style="text-align:right;">
4891634
</td>
</tr>
<tr>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;">
ut
</td>
<td style="text-align:right;">
0.1000000
</td>
<td style="text-align:right;">
2993475
</td>
</tr>
<tr>
<td style="text-align:right;">
44
</td>
<td style="text-align:left;">
al
</td>
<td style="text-align:right;">
0.1028571
</td>
<td style="text-align:right;">
4513716
</td>
</tr>
<tr>
<td style="text-align:right;">
43
</td>
<td style="text-align:left;">
ct
</td>
<td style="text-align:right;">
0.1050000
</td>
<td style="text-align:right;">
3589482
</td>
</tr>
<tr>
<td style="text-align:right;">
42
</td>
<td style="text-align:left;">
wi
</td>
<td style="text-align:right;">
0.1075000
</td>
<td style="text-align:right;">
5767479
</td>
</tr>
<tr>
<td style="text-align:right;">
41
</td>
<td style="text-align:left;">
nj
</td>
<td style="text-align:right;">
0.1086667
</td>
<td style="text-align:right;">
8862611
</td>
</tr>
<tr>
<td style="text-align:right;">
40
</td>
<td style="text-align:left;">
de
</td>
<td style="text-align:right;">
0.1100000
</td>
<td style="text-align:right;">
942936
</td>
</tr>
<tr>
<td style="text-align:right;">
39
</td>
<td style="text-align:left;">
ks
</td>
<td style="text-align:right;">
0.1125000
</td>
<td style="text-align:right;">
2740849
</td>
</tr>
<tr>
<td style="text-align:right;">
38
</td>
<td style="text-align:left;">
pa
</td>
<td style="text-align:right;">
0.1137500
</td>
<td style="text-align:right;">
12788395
</td>
</tr>
<tr>
<td style="text-align:right;">
37
</td>
<td style="text-align:left;">
wv
</td>
<td style="text-align:right;">
0.1150000
</td>
<td style="text-align:right;">
1840764
</td>
</tr>
<tr>
<td style="text-align:right;">
36
</td>
<td style="text-align:left;">
ok
</td>
<td style="text-align:right;">
0.1187500
</td>
<td style="text-align:right;">
3896746
</td>
</tr>
<tr>
<td style="text-align:right;">
34
</td>
<td style="text-align:left;">
ri
</td>
<td style="text-align:right;">
0.1200000
</td>
<td style="text-align:right;">
1055321
</td>
</tr>
<tr>
<td style="text-align:right;">
35
</td>
<td style="text-align:left;">
sd
</td>
<td style="text-align:right;">
0.1200000
</td>
<td style="text-align:right;">
858926
</td>
</tr>
<tr>
<td style="text-align:right;">
33
</td>
<td style="text-align:left;">
oh
</td>
<td style="text-align:right;">
0.1211111
</td>
<td style="text-align:right;">
11597905
</td>
</tr>
<tr>
<td style="text-align:right;">
32
</td>
<td style="text-align:left;">
mi
</td>
<td style="text-align:right;">
0.1285714
</td>
<td style="text-align:right;">
9915880
</td>
</tr>
<tr>
<td style="text-align:right;">
31
</td>
<td style="text-align:left;">
tx
</td>
<td style="text-align:right;">
0.1300000
</td>
<td style="text-align:right;">
27374256
</td>
</tr>
<tr>
<td style="text-align:right;">
30
</td>
<td style="text-align:left;">
in
</td>
<td style="text-align:right;">
0.1400000
</td>
<td style="text-align:right;">
6610511
</td>
</tr>
<tr>
<td style="text-align:right;">
29
</td>
<td style="text-align:left;">
md
</td>
<td style="text-align:right;">
0.1450000
</td>
<td style="text-align:right;">
5989266
</td>
</tr>
<tr>
<td style="text-align:right;">
28
</td>
<td style="text-align:left;">
nc
</td>
<td style="text-align:right;">
0.1475000
</td>
<td style="text-align:right;">
10036323
</td>
</tr>
<tr>
<td style="text-align:right;">
27
</td>
<td style="text-align:left;">
tn
</td>
<td style="text-align:right;">
0.1560000
</td>
<td style="text-align:right;">
6596403
</td>
</tr>
<tr>
<td style="text-align:right;">
26
</td>
<td style="text-align:left;">
ny
</td>
<td style="text-align:right;">
0.1580769
</td>
<td style="text-align:right;">
19426354
</td>
</tr>
<tr>
<td style="text-align:right;">
25
</td>
<td style="text-align:left;">
mn
</td>
<td style="text-align:right;">
0.1590000
</td>
<td style="text-align:right;">
5482565
</td>
</tr>
<tr>
<td style="text-align:right;">
22
</td>
<td style="text-align:left;">
ia
</td>
<td style="text-align:right;">
0.1600000
</td>
<td style="text-align:right;">
3047065
</td>
</tr>
<tr>
<td style="text-align:right;">
23
</td>
<td style="text-align:left;">
nd
</td>
<td style="text-align:right;">
0.1600000
</td>
<td style="text-align:right;">
750684
</td>
</tr>
<tr>
<td style="text-align:right;">
24
</td>
<td style="text-align:left;">
wy
</td>
<td style="text-align:right;">
0.1600000
</td>
<td style="text-align:right;">
586379
</td>
</tr>
<tr>
<td style="text-align:right;">
21
</td>
<td style="text-align:left;">
id
</td>
<td style="text-align:right;">
0.1650000
</td>
<td style="text-align:right;">
1654419
</td>
</tr>
<tr>
<td style="text-align:right;">
20
</td>
<td style="text-align:left;">
mt
</td>
<td style="text-align:right;">
0.1700000
</td>
<td style="text-align:right;">
1032083
</td>
</tr>
<tr>
<td style="text-align:right;">
18
</td>
<td style="text-align:left;">
az
</td>
<td style="text-align:right;">
0.1733333
</td>
<td style="text-align:right;">
6815226
</td>
</tr>
<tr>
<td style="text-align:right;">
19
</td>
<td style="text-align:left;">
ne
</td>
<td style="text-align:right;">
0.1733333
</td>
<td style="text-align:right;">
1965740
</td>
</tr>
<tr>
<td style="text-align:right;">
17
</td>
<td style="text-align:left;">
mo
</td>
<td style="text-align:right;">
0.1762500
</td>
<td style="text-align:right;">
6236602
</td>
</tr>
<tr>
<td style="text-align:right;">
16
</td>
<td style="text-align:left;">
me
</td>
<td style="text-align:right;">
0.1800000
</td>
<td style="text-align:right;">
1330746
</td>
</tr>
<tr>
<td style="text-align:right;">
15
</td>
<td style="text-align:left;">
ky
</td>
<td style="text-align:right;">
0.1966667
</td>
<td style="text-align:right;">
4426625
</td>
</tr>
<tr>
<td style="text-align:right;">
14
</td>
<td style="text-align:left;">
nh
</td>
<td style="text-align:right;">
0.2033333
</td>
<td style="text-align:right;">
1330805
</td>
</tr>
<tr>
<td style="text-align:right;">
13
</td>
<td style="text-align:left;">
nm
</td>
<td style="text-align:right;">
0.2050000
</td>
<td style="text-align:right;">
2081221
</td>
</tr>
<tr>
<td style="text-align:right;">
12
</td>
<td style="text-align:left;">
vt
</td>
<td style="text-align:right;">
0.2150000
</td>
<td style="text-align:right;">
625894
</td>
</tr>
<tr>
<td style="text-align:right;">
11
</td>
<td style="text-align:left;">
nv
</td>
<td style="text-align:right;">
0.2500000
</td>
<td style="text-align:right;">
2879708
</td>
</tr>
<tr>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;">
co
</td>
<td style="text-align:right;">
0.2733333
</td>
<td style="text-align:right;">
5427311
</td>
</tr>
<tr>
<td style="text-align:right;">
9
</td>
<td style="text-align:left;">
wa
</td>
<td style="text-align:right;">
0.2742857
</td>
<td style="text-align:right;">
7160828
</td>
</tr>
<tr>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;">
fl
</td>
<td style="text-align:right;">
0.2855556
</td>
<td style="text-align:right;">
20164437
</td>
</tr>
<tr>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
ga
</td>
<td style="text-align:right;">
0.2900000
</td>
<td style="text-align:right;">
8973889
</td>
</tr>
<tr>
<td style="text-align:right;">
6
</td>
<td style="text-align:left;">
ak
</td>
<td style="text-align:right;">
0.2950000
</td>
<td style="text-align:right;">
740335
</td>
</tr>
<tr>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
ma
</td>
<td style="text-align:right;">
0.3600000
</td>
<td style="text-align:right;">
5885732
</td>
</tr>
<tr>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
or
</td>
<td style="text-align:right;">
0.4285714
</td>
<td style="text-align:right;">
4025301
</td>
</tr>
<tr>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
ca
</td>
<td style="text-align:right;">
0.4920000
</td>
<td style="text-align:right;">
38726604
</td>
</tr>
<tr>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
hi
</td>
<td style="text-align:right;">
0.6500000
</td>
<td style="text-align:right;">
1420950
</td>
</tr>
<tr>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
dc
</td>
<td style="text-align:right;">
1.2000000
</td>
<td style="text-align:right;">
670534
</td>
</tr>
</tbody>
</table>
</div>
### Fact: Percent increases/decreases per CoC ROUGH ESTIMATE

*See Caveat \#2 above.*

We calculated the rates of homelessness in 2014 and 2018 for CoCs
compared to total population estimates from 2017. This rough calculation
shows that by percentage, Imperial County, CA; El Dorado County, CA;
Lynn, Massachusetts and Norman/Cleveland County, Oklahoma had the
highest overall increases, while tuscaloosa city & county, AL;
elizabeth/union county, NJ; Fort Walton Beach/Okaloosa, Walton Counties,
FL and Punta Gorda/Charlotte County, FL had the greatest decreases.
*These are only rough estimates for use in preliminary reporting and
should not be used in final stories.*

#### Supporting code and output

**Percent Homeless Increase by CoC, Highest to Lowest**

``` r
# Calculate ROUGH percent change by CoC
hud_pit_14_18 %>%
  left_join(zillow_cluster, by= c("coc_code", "state_code", "coc_number", "coc_name")) %>%
  select(state_code, coc_code, coc_name, overall_homeless_2014, overall_homeless_2018, coc_total_population_cluster_2017, est_rate_perc_2017 = estimated_homeless_rate_percent_cluster_2017) %>%
  mutate(homeless_rate_2014 = overall_homeless_2014/coc_total_population_cluster_2017*100,
         homeless_rate_2018 = overall_homeless_2018/coc_total_population_cluster_2017*100,
         overall_pct_change_2014_2018 = (overall_homeless_2018 -  overall_homeless_2014)/overall_homeless_2014
         ) %>%
  na.omit() %>%
  arrange(desc(overall_pct_change_2014_2018)) %>%
  select(state_code, coc_code, coc_name, overall_pct_change_2014_2018, homeless_rate_2014, homeless_rate_2018, coc_total_population_cluster_2017) %>%
  write_csv(paste0(save_path, "homelessness-increases-by-coc.csv")) %>%
  kable() %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
state\_code
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_code
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_name
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
overall\_pct\_change\_2014\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
homeless\_rate\_2014
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
homeless\_rate\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_total\_population\_cluster\_2017
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ca
</td>
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
ca
</td>
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
ma
</td>
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
ok
</td>
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
ny
</td>
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
ny
</td>
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
md
</td>
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
ca
</td>
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
co
</td>
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
fl
</td>
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
ny
</td>
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
ca
</td>
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
or
</td>
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
nj
</td>
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
ny
</td>
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
ca
</td>
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
tx
</td>
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
ca
</td>
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
ny
</td>
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
ny
</td>
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
fl
</td>
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
fl
</td>
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
nc
</td>
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
md
</td>
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
fl
</td>
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
or
</td>
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
ny
</td>
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
wa
</td>
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
md
</td>
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
ma
</td>
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
sd
</td>
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
wi
</td>
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
ny
</td>
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
md
</td>
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
co
</td>
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
md
</td>
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
la
</td>
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
pa
</td>
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
al
</td>
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
va
</td>
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
ak
</td>
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
nj
</td>
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
de
</td>
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
ma
</td>
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
ut
</td>
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
ny
</td>
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
nj
</td>
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
md
</td>
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
ut
</td>
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
mn
</td>
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
wa
</td>
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
ca
</td>
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
mi
</td>
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
fl
</td>
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
pa
</td>
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
oh
</td>
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
mo
</td>
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
ca
</td>
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
ca
</td>
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
mi
</td>
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
tn
</td>
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
wa
</td>
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
wa
</td>
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
tx
</td>
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
il
</td>
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
nh
</td>
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
pa
</td>
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
ca
</td>
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
ak
</td>
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
nm
</td>
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
oh
</td>
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
ma
</td>
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
ca
</td>
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
tx
</td>
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
ca
</td>
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
nh
</td>
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
nc
</td>
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
il
</td>
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
nc
</td>
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
ma
</td>
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
ma
</td>
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
mn
</td>
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
ok
</td>
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
nj
</td>
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
mo
</td>
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
al
</td>
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
ma
</td>
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
ca
</td>
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
pa
</td>
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
ca
</td>
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
il
</td>
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
ar
</td>
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
id
</td>
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
nh
</td>
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
ny
</td>
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
ne
</td>
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
va
</td>
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
tn
</td>
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
mn
</td>
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
ny
</td>
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
pa
</td>
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
md
</td>
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
ks
</td>
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
mi
</td>
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
mn
</td>
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
ct
</td>
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
ca
</td>
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
nj
</td>
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
md
</td>
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
mn
</td>
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
md
</td>
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
tn
</td>
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
nc
</td>
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
ky
</td>
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
ca
</td>
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
pa
</td>
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
ri
</td>
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
fl
</td>
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
hi
</td>
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
al
</td>
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
mn
</td>
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
ca
</td>
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
az
</td>
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
fl
</td>
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
ks
</td>
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
vt
</td>
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
wa
</td>
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
ok
</td>
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
va
</td>
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
ca
</td>
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
dc
</td>
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
ca
</td>
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
in
</td>
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
ia
</td>
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
ia
</td>
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
ga
</td>
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
wi
</td>
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
wv
</td>
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
mo
</td>
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
ny
</td>
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
in
</td>
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
fl
</td>
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
mi
</td>
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
sc
</td>
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
mo
</td>
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
ca
</td>
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
wv
</td>
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
ma
</td>
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
il
</td>
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
il
</td>
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
tn
</td>
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
ia
</td>
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
ar
</td>
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
oh
</td>
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
tn
</td>
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
pa
</td>
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
md
</td>
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
mn
</td>
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
la
</td>
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
mi
</td>
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
tx
</td>
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
wy
</td>
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
va
</td>
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
va
</td>
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
nc
</td>
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
ut
</td>
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
fl
</td>
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
mi
</td>
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
nc
</td>
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
ny
</td>
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
nj
</td>
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
pa
</td>
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
oh
</td>
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
fl
</td>
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
oh
</td>
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
nv
</td>
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
pa
</td>
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
ms
</td>
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
nm
</td>
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
mn
</td>
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
va
</td>
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
mt
</td>
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
nj
</td>
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
ok
</td>
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
ok
</td>
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
fl
</td>
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
al
</td>
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
wi
</td>
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
ok
</td>
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
ca
</td>
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
nc
</td>
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
tx
</td>
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
il
</td>
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
la
</td>
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
ga
</td>
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
tx
</td>
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
va
</td>
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
sc
</td>
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
nj
</td>
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
va
</td>
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
ca
</td>
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
al
</td>
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
nj
</td>
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
la
</td>
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
il
</td>
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
ga
</td>
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
tn
</td>
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
mo
</td>
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
ar
</td>
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
nv
</td>
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
va
</td>
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
tx
</td>
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
ny
</td>
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
oh
</td>
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
ks
</td>
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
mo
</td>
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
mi
</td>
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
ca
</td>
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
pa
</td>
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
al
</td>
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
nj
</td>
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
vt
</td>
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
ca
</td>
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
mi
</td>
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
md
</td>
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
md
</td>
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
ca
</td>
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
mi
</td>
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
tn
</td>
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
az
</td>
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
il
</td>
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
ca
</td>
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
1.6087265
</td>
<td style="text-align:right;">
1.0083186
</td>
<td style="text-align:right;">
87274
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
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
fl
</td>
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
or
</td>
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
ca
</td>
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
il
</td>
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
tn
</td>
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
fl
</td>
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
la
</td>
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
mi
</td>
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
fl
</td>
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
mi
</td>
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
ms
</td>
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
mi
</td>
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
wi
</td>
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
il
</td>
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
nj
</td>
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
nc
</td>
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
nj
</td>
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
pa
</td>
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
va
</td>
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
ok
</td>
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
ne
</td>
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
ms
</td>
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
nc
</td>
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
va
</td>
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
ga
</td>
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
ca
</td>
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
wv
</td>
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
ca
</td>
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
il
</td>
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
fl
</td>
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
ny
</td>
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
il
</td>
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
mn
</td>
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
md
</td>
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
nd
</td>
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
nc
</td>
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
mn
</td>
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
mi
</td>
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
fl
</td>
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
fl
</td>
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
fl
</td>
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
nj
</td>
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
al
</td>
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
0.1198138
</td>
<td style="text-align:right;">
0.0278750
</td>
<td style="text-align:right;">
204484
</td>
</tr>
</tbody>
</table>
</div>
**Percent Homeless Increase by CoC, Lowest to Highest**

``` r
# Calculate ROUGH percent change by CoC
hud_pit_14_18 %>%
  left_join(zillow_cluster, by= c("coc_code", "state_code", "coc_number", "coc_name")) %>%
  select(state_code, coc_code, coc_name, overall_homeless_2014, overall_homeless_2018, coc_total_population_cluster_2017, est_rate_perc_2017 = estimated_homeless_rate_percent_cluster_2017, coc_total_population_cluster_2017) %>%
  mutate(homeless_rate_2014 = overall_homeless_2014/coc_total_population_cluster_2017*100,
         homeless_rate_2018 = overall_homeless_2018/coc_total_population_cluster_2017*100,
         overall_pct_change_2014_2018 = (overall_homeless_2018 -  overall_homeless_2014)/overall_homeless_2014,
         ) %>%
  na.omit() %>%
  arrange(overall_pct_change_2014_2018) %>%
  select(state_code, coc_code, coc_name, overall_pct_change_2014_2018, homeless_rate_2014, homeless_rate_2018, coc_total_population_cluster_2017) %>%
  kable() %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
state\_code
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_code
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_name
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
overall\_pct\_change\_2014\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
homeless\_rate\_2014
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
homeless\_rate\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
coc\_total\_population\_cluster\_2017
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
al
</td>
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
nj
</td>
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
fl
</td>
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
fl
</td>
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
fl
</td>
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
mi
</td>
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
mn
</td>
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
nc
</td>
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
nd
</td>
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
md
</td>
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
mn
</td>
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
il
</td>
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
ny
</td>
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
fl
</td>
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
il
</td>
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
ca
</td>
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
wv
</td>
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
ca
</td>
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
ga
</td>
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
va
</td>
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
nc
</td>
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
ms
</td>
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
ne
</td>
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
ok
</td>
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
va
</td>
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
pa
</td>
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
nj
</td>
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
nc
</td>
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
nj
</td>
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
il
</td>
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
wi
</td>
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
mi
</td>
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
ms
</td>
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
mi
</td>
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
fl
</td>
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
mi
</td>
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
la
</td>
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
fl
</td>
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
tn
</td>
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
il
</td>
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
ca
</td>
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
or
</td>
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
fl
</td>
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
il
</td>
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
ca
</td>
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
1.6087265
</td>
<td style="text-align:right;">
1.0083186
</td>
<td style="text-align:right;">
87274
</td>
</tr>
<tr>
<td style="text-align:left;">
il
</td>
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
az
</td>
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
tn
</td>
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
mi
</td>
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
ca
</td>
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
md
</td>
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
md
</td>
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
mi
</td>
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
ca
</td>
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
vt
</td>
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
nj
</td>
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
al
</td>
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
pa
</td>
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
ca
</td>
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
mi
</td>
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
mo
</td>
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
ks
</td>
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
oh
</td>
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
ny
</td>
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
tx
</td>
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
va
</td>
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
nv
</td>
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
ar
</td>
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
mo
</td>
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
tn
</td>
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
ga
</td>
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
il
</td>
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
la
</td>
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
nj
</td>
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
al
</td>
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
ca
</td>
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
va
</td>
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
nj
</td>
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
sc
</td>
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
va
</td>
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
tx
</td>
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
ga
</td>
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
la
</td>
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
il
</td>
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
tx
</td>
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
nc
</td>
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
ca
</td>
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
ok
</td>
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
wi
</td>
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
al
</td>
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
fl
</td>
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
ok
</td>
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
ok
</td>
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
nj
</td>
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
mt
</td>
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
va
</td>
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
mn
</td>
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
nm
</td>
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
ms
</td>
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
pa
</td>
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
nv
</td>
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
oh
</td>
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
fl
</td>
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
oh
</td>
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
nj
</td>
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
pa
</td>
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
ny
</td>
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
nc
</td>
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
mi
</td>
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
fl
</td>
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
ut
</td>
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
nc
</td>
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
va
</td>
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
va
</td>
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
wy
</td>
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
tx
</td>
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
mi
</td>
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
la
</td>
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
mn
</td>
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
md
</td>
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
pa
</td>
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
tn
</td>
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
oh
</td>
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
ar
</td>
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
ia
</td>
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
tn
</td>
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
il
</td>
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
il
</td>
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
ma
</td>
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
wv
</td>
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
ca
</td>
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
mo
</td>
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
sc
</td>
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
mi
</td>
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
fl
</td>
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
in
</td>
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
ny
</td>
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
mo
</td>
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
wv
</td>
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
wi
</td>
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
ga
</td>
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
ia
</td>
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
ia
</td>
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
in
</td>
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
ca
</td>
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
dc
</td>
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
ca
</td>
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
va
</td>
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
ok
</td>
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
wa
</td>
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
vt
</td>
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
ks
</td>
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
fl
</td>
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
az
</td>
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
ca
</td>
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
mn
</td>
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
al
</td>
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
hi
</td>
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
fl
</td>
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
ri
</td>
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
pa
</td>
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
ca
</td>
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
ky
</td>
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
nc
</td>
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
tn
</td>
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
md
</td>
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
mn
</td>
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
md
</td>
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
nj
</td>
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
ca
</td>
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
ct
</td>
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
mn
</td>
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
mi
</td>
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
ks
</td>
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
md
</td>
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
pa
</td>
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
ny
</td>
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
mn
</td>
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
tn
</td>
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
va
</td>
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
ne
</td>
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
ny
</td>
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
nh
</td>
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
id
</td>
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
ar
</td>
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
il
</td>
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
ca
</td>
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
pa
</td>
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
ca
</td>
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
ma
</td>
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
al
</td>
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
mo
</td>
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
nj
</td>
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
ok
</td>
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
mn
</td>
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
ma
</td>
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
ma
</td>
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
nc
</td>
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
il
</td>
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
nc
</td>
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
nh
</td>
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
ca
</td>
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
tx
</td>
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
ca
</td>
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
ma
</td>
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
oh
</td>
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
nm
</td>
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
ak
</td>
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
ca
</td>
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
pa
</td>
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
nh
</td>
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
il
</td>
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
tx
</td>
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
wa
</td>
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
wa
</td>
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
tn
</td>
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
mi
</td>
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
ca
</td>
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
ca
</td>
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
mo
</td>
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
oh
</td>
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
pa
</td>
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
fl
</td>
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
mi
</td>
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
ca
</td>
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
wa
</td>
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
mn
</td>
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
ut
</td>
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
md
</td>
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
nj
</td>
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
ny
</td>
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
ut
</td>
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
ma
</td>
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
de
</td>
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
nj
</td>
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
ak
</td>
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
va
</td>
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
al
</td>
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
pa
</td>
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
la
</td>
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
md
</td>
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
co
</td>
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
md
</td>
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
ny
</td>
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
wi
</td>
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
sd
</td>
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
ma
</td>
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
md
</td>
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
wa
</td>
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
ny
</td>
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
or
</td>
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
fl
</td>
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
md
</td>
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
nc
</td>
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
fl
</td>
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
fl
</td>
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
ny
</td>
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
ny
</td>
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
ca
</td>
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
tx
</td>
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
ca
</td>
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
ny
</td>
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
nj
</td>
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
or
</td>
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
ca
</td>
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
ny
</td>
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
fl
</td>
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
co
</td>
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
ca
</td>
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
md
</td>
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
ny
</td>
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
ny
</td>
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
ok
</td>
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
ma
</td>
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
ca
</td>
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
ca
</td>
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
0.1661018
</td>
<td style="text-align:right;">
0.8321814
</td>
<td style="text-align:right;">
179408
</td>
</tr>
</tbody>
</table>
</div>
**Counts of CoCs in the Top 10 Greatest Increases**

``` r
# How many were from each state?
hud_pit_14_18 %>%
  # Top 10
  left_join(zillow_cluster, by= c("coc_code", "state_code", "coc_number", "coc_name")) %>%
  select(state_code, coc_name, overall_homeless_2014, overall_homeless_2018, coc_total_population_cluster_2017, est_rate_perc_2017 = estimated_homeless_rate_percent_cluster_2017) %>%
  # Compare homeless counts at given years to total population in 2017
  mutate(homeless_rate_2014 = overall_homeless_2014/coc_total_population_cluster_2017*100,
         homeless_rate_2018 = overall_homeless_2018/coc_total_population_cluster_2017*100,
          # Change in overall homelessness
         overall_pct_change_2014_2018 = (overall_homeless_2018 - overall_homeless_2014)/overall_homeless_2014
         ) %>%
  na.omit() %>%
  arrange(desc(overall_pct_change_2014_2018)) %>%
  mutate(rank = rank(desc(overall_pct_change_2014_2018))) %>%
  filter(between(rank, 1, 10)) %>%
  group_by(state_code) %>%
  summarize(count_coc_top = n()) %>%
  select(state_code, count_coc_top) %>%
  # Bottom 10
  full_join(
    hud_pit_14_18 %>%
    left_join(zillow_cluster, by= c("coc_code", "state_code", "coc_number", "coc_name")) %>%
    select(state_code, coc_name, overall_homeless_2014, overall_homeless_2018, coc_total_population_cluster_2017, est_rate_perc_2017 = estimated_homeless_rate_percent_cluster_2017) %>%
    mutate(homeless_rate_2014 = overall_homeless_2014/coc_total_population_cluster_2017*100,
           homeless_rate_2018 = overall_homeless_2018/coc_total_population_cluster_2017*100,
           overall_pct_change_2014_2018 = (overall_homeless_2018 - overall_homeless_2014)/overall_homeless_2014
           ) %>%
    na.omit() %>%
    arrange(desc(overall_pct_change_2014_2018)) %>%
    mutate(rank = rank(overall_pct_change_2014_2018)) %>%
    filter(between(rank, 1, 10)) %>%
    group_by(state_code) %>%
    summarize(count_coc_bottom = n()) %>%
    select(state_code, count_coc_bottom) 
  ) %>%
  kable() %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
state\_code
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
count\_coc\_top
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
count\_coc\_bottom
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ca
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
co
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
fl
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
3
</td>
</tr>
<tr>
<td style="text-align:left;">
ma
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
md
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
ny
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
ok
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
NA
</td>
</tr>
<tr>
<td style="text-align:left;">
al
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
mi
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
mn
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
nc
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
nd
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
nj
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
1
</td>
</tr>
</tbody>
</table>
</div>
### Fact: Percent increases/decreases per state ROUGH ESTIMATE

*See Caveat \#2 above.*

We calculated the rates of homelessness in 2014 and 2018 compared to
total population estimates from 2017. This rough calculation shows that
by percentage, South Dakota, Colorado and Delaware had the highest
overall increases, while North Dakota, Mississippi and Kentucky had the
greatest decreases. *These are only rough estimates for use in
preliminary reporting and should not be used in final stories.*

#### Supporting code and output

**Percent Homeless Increase by State, Highest to Lowest**

``` r
# Calculate ROUGH percent change by state
hud_pit_zillow_cluster %>%
  select(state_code, coc_name, 
         overall_homeless_2014, overall_homeless_2018, 
         coc_total_population_cluster_2017, 
         overall_pct_change_2014_2018, 
         est_rate_perc_2017 = estimated_homeless_rate_percent_cluster_2017) %>%
  na.omit() %>%
  # Group by states
  group_by(state_code) %>%
  # Average the changes for statewide average change
  summarize(
    mean_overall_homeless_2014 = mean(overall_homeless_2014),
    mean_overall_homeless_2018 = mean(overall_homeless_2018),
    mean_overall_pct_change_2014_2018 = mean(overall_pct_change_2014_2018),
    total_pop_2017 = sum(coc_total_population_cluster_2017)
  ) %>%
  #mutate(test = (mean_homeless_rate_2018 - mean_homeless_rate_2014) / mean_homeless_rate_2014) %>%
  arrange(desc(mean_overall_pct_change_2014_2018)) %>%
  mutate(rank = rank(desc(mean_overall_pct_change_2014_2018), ties.method= "first")) %>%
  select(rank, state_code, mean_overall_pct_change_2014_2018, mean_overall_homeless_2014, mean_overall_homeless_2018, total_pop_2017) %>%
  write_csv(paste0(save_path, "homelessness-increases-by-state.csv")) %>%
  kable() %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
rank
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
state\_code
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
mean\_overall\_pct\_change\_2014\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
mean\_overall\_homeless\_2014
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
mean\_overall\_homeless\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
total\_pop\_2017
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
sd
</td>
<td style="text-align:right;">
0.3096045
</td>
<td style="text-align:right;">
885.0000
</td>
<td style="text-align:right;">
1159.0000
</td>
<td style="text-align:right;">
858926
</td>
</tr>
<tr>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
co
</td>
<td style="text-align:right;">
0.2995105
</td>
<td style="text-align:right;">
3342.6667
</td>
<td style="text-align:right;">
3619.0000
</td>
<td style="text-align:right;">
5427311
</td>
</tr>
<tr>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
de
</td>
<td style="text-align:right;">
0.2008879
</td>
<td style="text-align:right;">
901.0000
</td>
<td style="text-align:right;">
1082.0000
</td>
<td style="text-align:right;">
942936
</td>
</tr>
<tr>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
ny
</td>
<td style="text-align:right;">
0.1958558
</td>
<td style="text-align:right;">
3099.6154
</td>
<td style="text-align:right;">
3534.5000
</td>
<td style="text-align:right;">
19426354
</td>
</tr>
<tr>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
ca
</td>
<td style="text-align:right;">
0.1704646
</td>
<td style="text-align:right;">
2848.8000
</td>
<td style="text-align:right;">
3226.8750
</td>
<td style="text-align:right;">
38726604
</td>
</tr>
<tr>
<td style="text-align:right;">
6
</td>
<td style="text-align:left;">
ak
</td>
<td style="text-align:right;">
0.1404837
</td>
<td style="text-align:right;">
892.0000
</td>
<td style="text-align:right;">
1008.0000
</td>
<td style="text-align:right;">
740335
</td>
</tr>
<tr>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
wa
</td>
<td style="text-align:right;">
0.1131897
</td>
<td style="text-align:right;">
3073.6667
</td>
<td style="text-align:right;">
3717.3333
</td>
<td style="text-align:right;">
6912874
</td>
</tr>
<tr>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;">
or
</td>
<td style="text-align:right;">
0.0930565
</td>
<td style="text-align:right;">
1737.7143
</td>
<td style="text-align:right;">
2068.0000
</td>
<td style="text-align:right;">
4025301
</td>
</tr>
<tr>
<td style="text-align:right;">
9
</td>
<td style="text-align:left;">
ma
</td>
<td style="text-align:right;">
0.0691069
</td>
<td style="text-align:right;">
1415.8000
</td>
<td style="text-align:right;">
1337.8667
</td>
<td style="text-align:right;">
5885732
</td>
</tr>
<tr>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;">
ok
</td>
<td style="text-align:right;">
0.0670110
</td>
<td style="text-align:right;">
523.8750
</td>
<td style="text-align:right;">
483.8750
</td>
<td style="text-align:right;">
3896746
</td>
</tr>
<tr>
<td style="text-align:right;">
11
</td>
<td style="text-align:left;">
ut
</td>
<td style="text-align:right;">
0.0499200
</td>
<td style="text-align:right;">
1027.0000
</td>
<td style="text-align:right;">
958.6667
</td>
<td style="text-align:right;">
2993475
</td>
</tr>
<tr>
<td style="text-align:right;">
12
</td>
<td style="text-align:left;">
nh
</td>
<td style="text-align:right;">
0.0432115
</td>
<td style="text-align:right;">
458.6667
</td>
<td style="text-align:right;">
483.3333
</td>
<td style="text-align:right;">
1330805
</td>
</tr>
<tr>
<td style="text-align:right;">
13
</td>
<td style="text-align:left;">
nv
</td>
<td style="text-align:right;">
0.0314567
</td>
<td style="text-align:right;">
2860.6667
</td>
<td style="text-align:right;">
2514.6667
</td>
<td style="text-align:right;">
2879708
</td>
</tr>
<tr>
<td style="text-align:right;">
14
</td>
<td style="text-align:left;">
md
</td>
<td style="text-align:right;">
0.0221514
</td>
<td style="text-align:right;">
491.0000
</td>
<td style="text-align:right;">
446.5000
</td>
<td style="text-align:right;">
5989266
</td>
</tr>
<tr>
<td style="text-align:right;">
15
</td>
<td style="text-align:left;">
ar
</td>
<td style="text-align:right;">
0.0092254
</td>
<td style="text-align:right;">
687.7500
</td>
<td style="text-align:right;">
606.0000
</td>
<td style="text-align:right;">
2279654
</td>
</tr>
<tr>
<td style="text-align:right;">
16
</td>
<td style="text-align:left;">
id
</td>
<td style="text-align:right;">
-0.0331671
</td>
<td style="text-align:right;">
1052.0000
</td>
<td style="text-align:right;">
1006.0000
</td>
<td style="text-align:right;">
1654419
</td>
</tr>
<tr>
<td style="text-align:right;">
17
</td>
<td style="text-align:left;">
tx
</td>
<td style="text-align:right;">
-0.0423122
</td>
<td style="text-align:right;">
2590.4545
</td>
<td style="text-align:right;">
2300.9091
</td>
<td style="text-align:right;">
27374256
</td>
</tr>
<tr>
<td style="text-align:right;">
18
</td>
<td style="text-align:left;">
nm
</td>
<td style="text-align:right;">
-0.0598786
</td>
<td style="text-align:right;">
1373.0000
</td>
<td style="text-align:right;">
1275.5000
</td>
<td style="text-align:right;">
2081221
</td>
</tr>
<tr>
<td style="text-align:right;">
19
</td>
<td style="text-align:left;">
hi
</td>
<td style="text-align:right;">
-0.0617842
</td>
<td style="text-align:right;">
3459.0000
</td>
<td style="text-align:right;">
3265.0000
</td>
<td style="text-align:right;">
1420950
</td>
</tr>
<tr>
<td style="text-align:right;">
20
</td>
<td style="text-align:left;">
ri
</td>
<td style="text-align:right;">
-0.0747899
</td>
<td style="text-align:right;">
1190.0000
</td>
<td style="text-align:right;">
1101.0000
</td>
<td style="text-align:right;">
1055321
</td>
</tr>
<tr>
<td style="text-align:right;">
21
</td>
<td style="text-align:left;">
me
</td>
<td style="text-align:right;">
-0.0770360
</td>
<td style="text-align:right;">
2726.0000
</td>
<td style="text-align:right;">
2516.0000
</td>
<td style="text-align:right;">
1330746
</td>
</tr>
<tr>
<td style="text-align:right;">
22
</td>
<td style="text-align:left;">
ks
</td>
<td style="text-align:right;">
-0.1006971
</td>
<td style="text-align:right;">
630.2500
</td>
<td style="text-align:right;">
516.7500
</td>
<td style="text-align:right;">
2740849
</td>
</tr>
<tr>
<td style="text-align:right;">
23
</td>
<td style="text-align:left;">
dc
</td>
<td style="text-align:right;">
-0.1089313
</td>
<td style="text-align:right;">
7748.0000
</td>
<td style="text-align:right;">
6904.0000
</td>
<td style="text-align:right;">
670534
</td>
</tr>
<tr>
<td style="text-align:right;">
24
</td>
<td style="text-align:left;">
wi
</td>
<td style="text-align:right;">
-0.1093609
</td>
<td style="text-align:right;">
1513.7500
</td>
<td style="text-align:right;">
1226.7500
</td>
<td style="text-align:right;">
5767479
</td>
</tr>
<tr>
<td style="text-align:right;">
25
</td>
<td style="text-align:left;">
in
</td>
<td style="text-align:right;">
-0.1168985
</td>
<td style="text-align:right;">
2985.5000
</td>
<td style="text-align:right;">
2629.0000
</td>
<td style="text-align:right;">
6610511
</td>
</tr>
<tr>
<td style="text-align:right;">
26
</td>
<td style="text-align:left;">
ia
</td>
<td style="text-align:right;">
-0.1204126
</td>
<td style="text-align:right;">
1040.6667
</td>
<td style="text-align:right;">
916.3333
</td>
<td style="text-align:right;">
3047065
</td>
</tr>
<tr>
<td style="text-align:right;">
27
</td>
<td style="text-align:left;">
az
</td>
<td style="text-align:right;">
-0.1301537
</td>
<td style="text-align:right;">
3498.3333
</td>
<td style="text-align:right;">
3288.3333
</td>
<td style="text-align:right;">
6815226
</td>
</tr>
<tr>
<td style="text-align:right;">
28
</td>
<td style="text-align:left;">
pa
</td>
<td style="text-align:right;">
-0.1423332
</td>
<td style="text-align:right;">
958.3125
</td>
<td style="text-align:right;">
844.5000
</td>
<td style="text-align:right;">
12788395
</td>
</tr>
<tr>
<td style="text-align:right;">
29
</td>
<td style="text-align:left;">
tn
</td>
<td style="text-align:right;">
-0.1496331
</td>
<td style="text-align:right;">
941.5000
</td>
<td style="text-align:right;">
788.3000
</td>
<td style="text-align:right;">
6596403
</td>
</tr>
<tr>
<td style="text-align:right;">
30
</td>
<td style="text-align:left;">
nj
</td>
<td style="text-align:right;">
-0.1529761
</td>
<td style="text-align:right;">
775.2667
</td>
<td style="text-align:right;">
623.2667
</td>
<td style="text-align:right;">
8862611
</td>
</tr>
<tr>
<td style="text-align:right;">
31
</td>
<td style="text-align:left;">
mn
</td>
<td style="text-align:right;">
-0.1531831
</td>
<td style="text-align:right;">
837.7000
</td>
<td style="text-align:right;">
724.3000
</td>
<td style="text-align:right;">
5482565
</td>
</tr>
<tr>
<td style="text-align:right;">
32
</td>
<td style="text-align:left;">
va
</td>
<td style="text-align:right;">
-0.1534075
</td>
<td style="text-align:right;">
438.7500
</td>
<td style="text-align:right;">
373.4375
</td>
<td style="text-align:right;">
8363972
</td>
</tr>
<tr>
<td style="text-align:right;">
33
</td>
<td style="text-align:left;">
mo
</td>
<td style="text-align:right;">
-0.1546466
</td>
<td style="text-align:right;">
764.4286
</td>
<td style="text-align:right;">
604.8571
</td>
<td style="text-align:right;">
5229213
</td>
</tr>
<tr>
<td style="text-align:right;">
34
</td>
<td style="text-align:left;">
wy
</td>
<td style="text-align:right;">
-0.1558785
</td>
<td style="text-align:right;">
757.0000
</td>
<td style="text-align:right;">
639.0000
</td>
<td style="text-align:right;">
586379
</td>
</tr>
<tr>
<td style="text-align:right;">
35
</td>
<td style="text-align:left;">
wv
</td>
<td style="text-align:right;">
-0.1662814
</td>
<td style="text-align:right;">
503.2500
</td>
<td style="text-align:right;">
310.7500
</td>
<td style="text-align:right;">
1840764
</td>
</tr>
<tr>
<td style="text-align:right;">
36
</td>
<td style="text-align:left;">
nc
</td>
<td style="text-align:right;">
-0.1686564
</td>
<td style="text-align:right;">
957.5833
</td>
<td style="text-align:right;">
772.3333
</td>
<td style="text-align:right;">
10036323
</td>
</tr>
<tr>
<td style="text-align:right;">
37
</td>
<td style="text-align:left;">
oh
</td>
<td style="text-align:right;">
-0.1722341
</td>
<td style="text-align:right;">
1313.6667
</td>
<td style="text-align:right;">
1138.7778
</td>
<td style="text-align:right;">
11597905
</td>
</tr>
<tr>
<td style="text-align:right;">
38
</td>
<td style="text-align:left;">
ct
</td>
<td style="text-align:right;">
-0.1774968
</td>
<td style="text-align:right;">
2225.0000
</td>
<td style="text-align:right;">
1988.0000
</td>
<td style="text-align:right;">
3589482
</td>
</tr>
<tr>
<td style="text-align:right;">
39
</td>
<td style="text-align:left;">
fl
</td>
<td style="text-align:right;">
-0.1904441
</td>
<td style="text-align:right;">
1538.5926
</td>
<td style="text-align:right;">
1149.2593
</td>
<td style="text-align:right;">
20164437
</td>
</tr>
<tr>
<td style="text-align:right;">
40
</td>
<td style="text-align:left;">
il
</td>
<td style="text-align:right;">
-0.1936772
</td>
<td style="text-align:right;">
655.3500
</td>
<td style="text-align:right;">
532.1500
</td>
<td style="text-align:right;">
12829607
</td>
</tr>
<tr>
<td style="text-align:right;">
41
</td>
<td style="text-align:left;">
mt
</td>
<td style="text-align:right;">
-0.1948424
</td>
<td style="text-align:right;">
1745.0000
</td>
<td style="text-align:right;">
1405.0000
</td>
<td style="text-align:right;">
1032083
</td>
</tr>
<tr>
<td style="text-align:right;">
42
</td>
<td style="text-align:left;">
al
</td>
<td style="text-align:right;">
-0.1970642
</td>
<td style="text-align:right;">
589.0000
</td>
<td style="text-align:right;">
469.7143
</td>
<td style="text-align:right;">
4513716
</td>
</tr>
<tr>
<td style="text-align:right;">
43
</td>
<td style="text-align:left;">
ne
</td>
<td style="text-align:right;">
-0.1988893
</td>
<td style="text-align:right;">
1008.6667
</td>
<td style="text-align:right;">
807.0000
</td>
<td style="text-align:right;">
1965740
</td>
</tr>
<tr>
<td style="text-align:right;">
44
</td>
<td style="text-align:left;">
sc
</td>
<td style="text-align:right;">
-0.2034170
</td>
<td style="text-align:right;">
1264.2500
</td>
<td style="text-align:right;">
983.2500
</td>
<td style="text-align:right;">
4891634
</td>
</tr>
<tr>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;">
vt
</td>
<td style="text-align:right;">
-0.2088452
</td>
<td style="text-align:right;">
779.5000
</td>
<td style="text-align:right;">
645.5000
</td>
<td style="text-align:right;">
625894
</td>
</tr>
<tr>
<td style="text-align:right;">
46
</td>
<td style="text-align:left;">
la
</td>
<td style="text-align:right;">
-0.2221305
</td>
<td style="text-align:right;">
658.0000
</td>
<td style="text-align:right;">
437.0000
</td>
<td style="text-align:right;">
4313936
</td>
</tr>
<tr>
<td style="text-align:right;">
47
</td>
<td style="text-align:left;">
mi
</td>
<td style="text-align:right;">
-0.2592974
</td>
<td style="text-align:right;">
582.2381
</td>
<td style="text-align:right;">
397.6667
</td>
<td style="text-align:right;">
9915880
</td>
</tr>
<tr>
<td style="text-align:right;">
48
</td>
<td style="text-align:left;">
ga
</td>
<td style="text-align:right;">
-0.2931615
</td>
<td style="text-align:right;">
2177.5714
</td>
<td style="text-align:right;">
1279.4286
</td>
<td style="text-align:right;">
8973889
</td>
</tr>
<tr>
<td style="text-align:right;">
49
</td>
<td style="text-align:left;">
ky
</td>
<td style="text-align:right;">
-0.3069639
</td>
<td style="text-align:right;">
1696.3333
</td>
<td style="text-align:right;">
1229.3333
</td>
<td style="text-align:right;">
4426625
</td>
</tr>
<tr>
<td style="text-align:right;">
50
</td>
<td style="text-align:left;">
ms
</td>
<td style="text-align:right;">
-0.3578682
</td>
<td style="text-align:right;">
742.0000
</td>
<td style="text-align:right;">
450.6667
</td>
<td style="text-align:right;">
2990303
</td>
</tr>
<tr>
<td style="text-align:right;">
51
</td>
<td style="text-align:left;">
nd
</td>
<td style="text-align:right;">
-0.5691574
</td>
<td style="text-align:right;">
1258.0000
</td>
<td style="text-align:right;">
542.0000
</td>
<td style="text-align:right;">
750684
</td>
</tr>
</tbody>
</table>
</div>
**Percent Homeless Increase by State, Lowest to Highest**

``` r
# Calculate ROUGH percent change by state
hud_pit_zillow_cluster %>%
  select(state_code, coc_name, 
         overall_homeless_2014, overall_homeless_2018, 
         coc_total_population_cluster_2017, 
         overall_pct_change_2014_2018, 
         est_rate_perc_2017 = estimated_homeless_rate_percent_cluster_2017) %>%
  na.omit() %>%
  # Group by states
  group_by(state_code) %>%
  # Average the changes for statewide average change
  summarize(
    mean_overall_homeless_2014 = mean(overall_homeless_2014),
    mean_overall_homeless_2018 = mean(overall_homeless_2018),
    mean_overall_pct_change_2014_2018 = mean(overall_pct_change_2014_2018),
    total_pop_2017 = sum(coc_total_population_cluster_2017)
  ) %>%
  #mutate(test = (mean_homeless_rate_2018 - mean_homeless_rate_2014) / mean_homeless_rate_2014) %>%
  arrange(mean_overall_pct_change_2014_2018) %>%
  mutate(rank = rank(desc(mean_overall_pct_change_2014_2018), ties.method= "first")) %>%
  select(rank, state_code, mean_overall_pct_change_2014_2018, mean_overall_homeless_2014, mean_overall_homeless_2018, total_pop_2017) %>%
  kable() %>%
  kable_styling("striped", fixed_thead = T) %>%
  scroll_box(width = "100%", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:100%; ">
<table class="table table-striped" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
rank
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
state\_code
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
mean\_overall\_pct\_change\_2014\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
mean\_overall\_homeless\_2014
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
mean\_overall\_homeless\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;position: sticky; top:0; background-color: #FFFFFF;">
total\_pop\_2017
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:right;">
51
</td>
<td style="text-align:left;">
nd
</td>
<td style="text-align:right;">
-0.5691574
</td>
<td style="text-align:right;">
1258.0000
</td>
<td style="text-align:right;">
542.0000
</td>
<td style="text-align:right;">
750684
</td>
</tr>
<tr>
<td style="text-align:right;">
50
</td>
<td style="text-align:left;">
ms
</td>
<td style="text-align:right;">
-0.3578682
</td>
<td style="text-align:right;">
742.0000
</td>
<td style="text-align:right;">
450.6667
</td>
<td style="text-align:right;">
2990303
</td>
</tr>
<tr>
<td style="text-align:right;">
49
</td>
<td style="text-align:left;">
ky
</td>
<td style="text-align:right;">
-0.3069639
</td>
<td style="text-align:right;">
1696.3333
</td>
<td style="text-align:right;">
1229.3333
</td>
<td style="text-align:right;">
4426625
</td>
</tr>
<tr>
<td style="text-align:right;">
48
</td>
<td style="text-align:left;">
ga
</td>
<td style="text-align:right;">
-0.2931615
</td>
<td style="text-align:right;">
2177.5714
</td>
<td style="text-align:right;">
1279.4286
</td>
<td style="text-align:right;">
8973889
</td>
</tr>
<tr>
<td style="text-align:right;">
47
</td>
<td style="text-align:left;">
mi
</td>
<td style="text-align:right;">
-0.2592974
</td>
<td style="text-align:right;">
582.2381
</td>
<td style="text-align:right;">
397.6667
</td>
<td style="text-align:right;">
9915880
</td>
</tr>
<tr>
<td style="text-align:right;">
46
</td>
<td style="text-align:left;">
la
</td>
<td style="text-align:right;">
-0.2221305
</td>
<td style="text-align:right;">
658.0000
</td>
<td style="text-align:right;">
437.0000
</td>
<td style="text-align:right;">
4313936
</td>
</tr>
<tr>
<td style="text-align:right;">
45
</td>
<td style="text-align:left;">
vt
</td>
<td style="text-align:right;">
-0.2088452
</td>
<td style="text-align:right;">
779.5000
</td>
<td style="text-align:right;">
645.5000
</td>
<td style="text-align:right;">
625894
</td>
</tr>
<tr>
<td style="text-align:right;">
44
</td>
<td style="text-align:left;">
sc
</td>
<td style="text-align:right;">
-0.2034170
</td>
<td style="text-align:right;">
1264.2500
</td>
<td style="text-align:right;">
983.2500
</td>
<td style="text-align:right;">
4891634
</td>
</tr>
<tr>
<td style="text-align:right;">
43
</td>
<td style="text-align:left;">
ne
</td>
<td style="text-align:right;">
-0.1988893
</td>
<td style="text-align:right;">
1008.6667
</td>
<td style="text-align:right;">
807.0000
</td>
<td style="text-align:right;">
1965740
</td>
</tr>
<tr>
<td style="text-align:right;">
42
</td>
<td style="text-align:left;">
al
</td>
<td style="text-align:right;">
-0.1970642
</td>
<td style="text-align:right;">
589.0000
</td>
<td style="text-align:right;">
469.7143
</td>
<td style="text-align:right;">
4513716
</td>
</tr>
<tr>
<td style="text-align:right;">
41
</td>
<td style="text-align:left;">
mt
</td>
<td style="text-align:right;">
-0.1948424
</td>
<td style="text-align:right;">
1745.0000
</td>
<td style="text-align:right;">
1405.0000
</td>
<td style="text-align:right;">
1032083
</td>
</tr>
<tr>
<td style="text-align:right;">
40
</td>
<td style="text-align:left;">
il
</td>
<td style="text-align:right;">
-0.1936772
</td>
<td style="text-align:right;">
655.3500
</td>
<td style="text-align:right;">
532.1500
</td>
<td style="text-align:right;">
12829607
</td>
</tr>
<tr>
<td style="text-align:right;">
39
</td>
<td style="text-align:left;">
fl
</td>
<td style="text-align:right;">
-0.1904441
</td>
<td style="text-align:right;">
1538.5926
</td>
<td style="text-align:right;">
1149.2593
</td>
<td style="text-align:right;">
20164437
</td>
</tr>
<tr>
<td style="text-align:right;">
38
</td>
<td style="text-align:left;">
ct
</td>
<td style="text-align:right;">
-0.1774968
</td>
<td style="text-align:right;">
2225.0000
</td>
<td style="text-align:right;">
1988.0000
</td>
<td style="text-align:right;">
3589482
</td>
</tr>
<tr>
<td style="text-align:right;">
37
</td>
<td style="text-align:left;">
oh
</td>
<td style="text-align:right;">
-0.1722341
</td>
<td style="text-align:right;">
1313.6667
</td>
<td style="text-align:right;">
1138.7778
</td>
<td style="text-align:right;">
11597905
</td>
</tr>
<tr>
<td style="text-align:right;">
36
</td>
<td style="text-align:left;">
nc
</td>
<td style="text-align:right;">
-0.1686564
</td>
<td style="text-align:right;">
957.5833
</td>
<td style="text-align:right;">
772.3333
</td>
<td style="text-align:right;">
10036323
</td>
</tr>
<tr>
<td style="text-align:right;">
35
</td>
<td style="text-align:left;">
wv
</td>
<td style="text-align:right;">
-0.1662814
</td>
<td style="text-align:right;">
503.2500
</td>
<td style="text-align:right;">
310.7500
</td>
<td style="text-align:right;">
1840764
</td>
</tr>
<tr>
<td style="text-align:right;">
34
</td>
<td style="text-align:left;">
wy
</td>
<td style="text-align:right;">
-0.1558785
</td>
<td style="text-align:right;">
757.0000
</td>
<td style="text-align:right;">
639.0000
</td>
<td style="text-align:right;">
586379
</td>
</tr>
<tr>
<td style="text-align:right;">
33
</td>
<td style="text-align:left;">
mo
</td>
<td style="text-align:right;">
-0.1546466
</td>
<td style="text-align:right;">
764.4286
</td>
<td style="text-align:right;">
604.8571
</td>
<td style="text-align:right;">
5229213
</td>
</tr>
<tr>
<td style="text-align:right;">
32
</td>
<td style="text-align:left;">
va
</td>
<td style="text-align:right;">
-0.1534075
</td>
<td style="text-align:right;">
438.7500
</td>
<td style="text-align:right;">
373.4375
</td>
<td style="text-align:right;">
8363972
</td>
</tr>
<tr>
<td style="text-align:right;">
31
</td>
<td style="text-align:left;">
mn
</td>
<td style="text-align:right;">
-0.1531831
</td>
<td style="text-align:right;">
837.7000
</td>
<td style="text-align:right;">
724.3000
</td>
<td style="text-align:right;">
5482565
</td>
</tr>
<tr>
<td style="text-align:right;">
30
</td>
<td style="text-align:left;">
nj
</td>
<td style="text-align:right;">
-0.1529761
</td>
<td style="text-align:right;">
775.2667
</td>
<td style="text-align:right;">
623.2667
</td>
<td style="text-align:right;">
8862611
</td>
</tr>
<tr>
<td style="text-align:right;">
29
</td>
<td style="text-align:left;">
tn
</td>
<td style="text-align:right;">
-0.1496331
</td>
<td style="text-align:right;">
941.5000
</td>
<td style="text-align:right;">
788.3000
</td>
<td style="text-align:right;">
6596403
</td>
</tr>
<tr>
<td style="text-align:right;">
28
</td>
<td style="text-align:left;">
pa
</td>
<td style="text-align:right;">
-0.1423332
</td>
<td style="text-align:right;">
958.3125
</td>
<td style="text-align:right;">
844.5000
</td>
<td style="text-align:right;">
12788395
</td>
</tr>
<tr>
<td style="text-align:right;">
27
</td>
<td style="text-align:left;">
az
</td>
<td style="text-align:right;">
-0.1301537
</td>
<td style="text-align:right;">
3498.3333
</td>
<td style="text-align:right;">
3288.3333
</td>
<td style="text-align:right;">
6815226
</td>
</tr>
<tr>
<td style="text-align:right;">
26
</td>
<td style="text-align:left;">
ia
</td>
<td style="text-align:right;">
-0.1204126
</td>
<td style="text-align:right;">
1040.6667
</td>
<td style="text-align:right;">
916.3333
</td>
<td style="text-align:right;">
3047065
</td>
</tr>
<tr>
<td style="text-align:right;">
25
</td>
<td style="text-align:left;">
in
</td>
<td style="text-align:right;">
-0.1168985
</td>
<td style="text-align:right;">
2985.5000
</td>
<td style="text-align:right;">
2629.0000
</td>
<td style="text-align:right;">
6610511
</td>
</tr>
<tr>
<td style="text-align:right;">
24
</td>
<td style="text-align:left;">
wi
</td>
<td style="text-align:right;">
-0.1093609
</td>
<td style="text-align:right;">
1513.7500
</td>
<td style="text-align:right;">
1226.7500
</td>
<td style="text-align:right;">
5767479
</td>
</tr>
<tr>
<td style="text-align:right;">
23
</td>
<td style="text-align:left;">
dc
</td>
<td style="text-align:right;">
-0.1089313
</td>
<td style="text-align:right;">
7748.0000
</td>
<td style="text-align:right;">
6904.0000
</td>
<td style="text-align:right;">
670534
</td>
</tr>
<tr>
<td style="text-align:right;">
22
</td>
<td style="text-align:left;">
ks
</td>
<td style="text-align:right;">
-0.1006971
</td>
<td style="text-align:right;">
630.2500
</td>
<td style="text-align:right;">
516.7500
</td>
<td style="text-align:right;">
2740849
</td>
</tr>
<tr>
<td style="text-align:right;">
21
</td>
<td style="text-align:left;">
me
</td>
<td style="text-align:right;">
-0.0770360
</td>
<td style="text-align:right;">
2726.0000
</td>
<td style="text-align:right;">
2516.0000
</td>
<td style="text-align:right;">
1330746
</td>
</tr>
<tr>
<td style="text-align:right;">
20
</td>
<td style="text-align:left;">
ri
</td>
<td style="text-align:right;">
-0.0747899
</td>
<td style="text-align:right;">
1190.0000
</td>
<td style="text-align:right;">
1101.0000
</td>
<td style="text-align:right;">
1055321
</td>
</tr>
<tr>
<td style="text-align:right;">
19
</td>
<td style="text-align:left;">
hi
</td>
<td style="text-align:right;">
-0.0617842
</td>
<td style="text-align:right;">
3459.0000
</td>
<td style="text-align:right;">
3265.0000
</td>
<td style="text-align:right;">
1420950
</td>
</tr>
<tr>
<td style="text-align:right;">
18
</td>
<td style="text-align:left;">
nm
</td>
<td style="text-align:right;">
-0.0598786
</td>
<td style="text-align:right;">
1373.0000
</td>
<td style="text-align:right;">
1275.5000
</td>
<td style="text-align:right;">
2081221
</td>
</tr>
<tr>
<td style="text-align:right;">
17
</td>
<td style="text-align:left;">
tx
</td>
<td style="text-align:right;">
-0.0423122
</td>
<td style="text-align:right;">
2590.4545
</td>
<td style="text-align:right;">
2300.9091
</td>
<td style="text-align:right;">
27374256
</td>
</tr>
<tr>
<td style="text-align:right;">
16
</td>
<td style="text-align:left;">
id
</td>
<td style="text-align:right;">
-0.0331671
</td>
<td style="text-align:right;">
1052.0000
</td>
<td style="text-align:right;">
1006.0000
</td>
<td style="text-align:right;">
1654419
</td>
</tr>
<tr>
<td style="text-align:right;">
15
</td>
<td style="text-align:left;">
ar
</td>
<td style="text-align:right;">
0.0092254
</td>
<td style="text-align:right;">
687.7500
</td>
<td style="text-align:right;">
606.0000
</td>
<td style="text-align:right;">
2279654
</td>
</tr>
<tr>
<td style="text-align:right;">
14
</td>
<td style="text-align:left;">
md
</td>
<td style="text-align:right;">
0.0221514
</td>
<td style="text-align:right;">
491.0000
</td>
<td style="text-align:right;">
446.5000
</td>
<td style="text-align:right;">
5989266
</td>
</tr>
<tr>
<td style="text-align:right;">
13
</td>
<td style="text-align:left;">
nv
</td>
<td style="text-align:right;">
0.0314567
</td>
<td style="text-align:right;">
2860.6667
</td>
<td style="text-align:right;">
2514.6667
</td>
<td style="text-align:right;">
2879708
</td>
</tr>
<tr>
<td style="text-align:right;">
12
</td>
<td style="text-align:left;">
nh
</td>
<td style="text-align:right;">
0.0432115
</td>
<td style="text-align:right;">
458.6667
</td>
<td style="text-align:right;">
483.3333
</td>
<td style="text-align:right;">
1330805
</td>
</tr>
<tr>
<td style="text-align:right;">
11
</td>
<td style="text-align:left;">
ut
</td>
<td style="text-align:right;">
0.0499200
</td>
<td style="text-align:right;">
1027.0000
</td>
<td style="text-align:right;">
958.6667
</td>
<td style="text-align:right;">
2993475
</td>
</tr>
<tr>
<td style="text-align:right;">
10
</td>
<td style="text-align:left;">
ok
</td>
<td style="text-align:right;">
0.0670110
</td>
<td style="text-align:right;">
523.8750
</td>
<td style="text-align:right;">
483.8750
</td>
<td style="text-align:right;">
3896746
</td>
</tr>
<tr>
<td style="text-align:right;">
9
</td>
<td style="text-align:left;">
ma
</td>
<td style="text-align:right;">
0.0691069
</td>
<td style="text-align:right;">
1415.8000
</td>
<td style="text-align:right;">
1337.8667
</td>
<td style="text-align:right;">
5885732
</td>
</tr>
<tr>
<td style="text-align:right;">
8
</td>
<td style="text-align:left;">
or
</td>
<td style="text-align:right;">
0.0930565
</td>
<td style="text-align:right;">
1737.7143
</td>
<td style="text-align:right;">
2068.0000
</td>
<td style="text-align:right;">
4025301
</td>
</tr>
<tr>
<td style="text-align:right;">
7
</td>
<td style="text-align:left;">
wa
</td>
<td style="text-align:right;">
0.1131897
</td>
<td style="text-align:right;">
3073.6667
</td>
<td style="text-align:right;">
3717.3333
</td>
<td style="text-align:right;">
6912874
</td>
</tr>
<tr>
<td style="text-align:right;">
6
</td>
<td style="text-align:left;">
ak
</td>
<td style="text-align:right;">
0.1404837
</td>
<td style="text-align:right;">
892.0000
</td>
<td style="text-align:right;">
1008.0000
</td>
<td style="text-align:right;">
740335
</td>
</tr>
<tr>
<td style="text-align:right;">
5
</td>
<td style="text-align:left;">
ca
</td>
<td style="text-align:right;">
0.1704646
</td>
<td style="text-align:right;">
2848.8000
</td>
<td style="text-align:right;">
3226.8750
</td>
<td style="text-align:right;">
38726604
</td>
</tr>
<tr>
<td style="text-align:right;">
4
</td>
<td style="text-align:left;">
ny
</td>
<td style="text-align:right;">
0.1958558
</td>
<td style="text-align:right;">
3099.6154
</td>
<td style="text-align:right;">
3534.5000
</td>
<td style="text-align:right;">
19426354
</td>
</tr>
<tr>
<td style="text-align:right;">
3
</td>
<td style="text-align:left;">
de
</td>
<td style="text-align:right;">
0.2008879
</td>
<td style="text-align:right;">
901.0000
</td>
<td style="text-align:right;">
1082.0000
</td>
<td style="text-align:right;">
942936
</td>
</tr>
<tr>
<td style="text-align:right;">
2
</td>
<td style="text-align:left;">
co
</td>
<td style="text-align:right;">
0.2995105
</td>
<td style="text-align:right;">
3342.6667
</td>
<td style="text-align:right;">
3619.0000
</td>
<td style="text-align:right;">
5427311
</td>
</tr>
<tr>
<td style="text-align:right;">
1
</td>
<td style="text-align:left;">
sd
</td>
<td style="text-align:right;">
0.3096045
</td>
<td style="text-align:right;">
885.0000
</td>
<td style="text-align:right;">
1159.0000
</td>
<td style="text-align:right;">
858926
</td>
</tr>
</tbody>
</table>
</div>
