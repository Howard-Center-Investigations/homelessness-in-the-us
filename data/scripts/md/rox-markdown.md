``` r
# Display styling
# Use when running calculations, but not when storing a table for future calcs b/c it turns the df into a kable object
# Only for HTML; does not render properly in .md files. "always_allow_html" in header prevents compile failure but does not fix display issues.
# df %>%
#   kable() %>%
#   kable_styling("striped", fixed_thead = T) %>%
#   scroll_box(width = "100%", height = "500px")
```

``` r
#######################
#### Load Packages ####
#######################

library(tidyverse)
library(readxl)
library(knitr)
library(kableExtra)
library(data.table)
```

``` r
#######################
#### Load Data ########
#######################

load_path <- paste0(here::here(), "/data/input-data/clean/")
save_path <- paste0(here::here(), "/data/")

hud_pit_all <- read_csv(paste0(load_path, "hud-pit-all.csv"))

zillow_cluster <- read_csv(paste0(load_path, "zillow-cluster.csv")) %>%
  mutate_at("coc_number", as.character)

hud_zillow_joined <- read_csv(paste0(load_path, "hud-zillow-joined.csv"))
```

``` r
################
## Rates #######
################

# Calculate rates and changes over time data 14-18
## SHOW SEAN THE DISCREPENCY B/W 17 rates we calculated and 17 rates they calcuclated
homeless_rates_14_18 <- hud_zillow_joined %>%
  select(state_code, coc_code, coc_name, 
         overall_homeless_2014,
         overall_homeless_2017,
         overall_homeless_2018,
         total_pop_2017 = coc_total_population_zillow_2017, 
         est_rate_perc_2017 = estimated_homeless_rate_percent_zillow_2017,
         cluster_num = cluster_number_zillow_2017) %>%
  ### Rates of homelessness for 2014 and 2018 based on available 2017 population numbers
  mutate(homeless_rate_2014 = (overall_homeless_2014/total_pop_2017)*100,
         OURShomeless_rate_2017 = (overall_homeless_2017/total_pop_2017)*100,
         homeless_rate_2018 = (overall_homeless_2018/total_pop_2017)*100) %>%
  ### Changes over time between 2014-2018
  # Change in overall homelessness
  mutate(overall_change_2014_2018 = overall_homeless_2014 -  overall_homeless_2018,
         overall_pct_change_2014_2018 = (overall_homeless_2018 - overall_homeless_2014)/overall_homeless_2014) %>%
  # Change in homelessness rates
  mutate(rate_change_2014_2018 = homeless_rate_2018 - homeless_rate_2014)

# Rank by homeless rate and change in homeless rate
homeless_rates_14_18 %>%
  mutate(rank_rate_2018 = rank(homeless_rate_2018),
         rank_rate_change_14_18 = rank(rate_change_2014_2018)) %>%
  select(coc_code, coc_name, 
         rank_rate_2018, homeless_rate_2018,
         rank_rate_change_14_18, rate_change_2014_2018) %>%
  # Styling
  arrange(coc_code, rank_rate_2018) %>%
  kable() %>%
  kable_styling("striped", fixed_thead = T, bootstrap_options = c("condensed", "responsive"))
```

<table class="table table-condensed table-responsive" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">
coc\_code
</th>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">
coc\_name
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
rank\_rate\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
homeless\_rate\_2018
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
rank\_rate\_change\_14\_18
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
rate\_change\_2014\_2018
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
ak-500
</td>
<td style="text-align:left;">
anchorage coc
</td>
<td style="text-align:right;">
344
</td>
<td style="text-align:right;">
0.3652328
</td>
<td style="text-align:right;">
331
</td>
<td style="text-align:right;">
0.0237034
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
298
</td>
<td style="text-align:right;">
0.2091652
</td>
<td style="text-align:right;">
344
</td>
<td style="text-align:right;">
0.0365245
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
146
</td>
<td style="text-align:right;">
0.0943627
</td>
<td style="text-align:right;">
78
</td>
<td style="text-align:right;">
-0.0448249
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
131
</td>
<td style="text-align:right;">
0.0891254
</td>
<td style="text-align:right;">
226
</td>
<td style="text-align:right;">
-0.0076023
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
155
</td>
<td style="text-align:right;">
0.0963732
</td>
<td style="text-align:right;">
318
</td>
<td style="text-align:right;">
0.0176935
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
101
</td>
<td style="text-align:right;">
0.0751053
</td>
<td style="text-align:right;">
166
</td>
<td style="text-align:right;">
-0.0198391
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
153
</td>
<td style="text-align:right;">
0.0962220
</td>
<td style="text-align:right;">
113
</td>
<td style="text-align:right;">
-0.0315525
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
6
</td>
<td style="text-align:right;">
0.0278750
</td>
<td style="text-align:right;">
41
</td>
<td style="text-align:right;">
-0.0919387
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
34
</td>
<td style="text-align:right;">
0.0479470
</td>
<td style="text-align:right;">
261
</td>
<td style="text-align:right;">
0.0009195
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
282
</td>
<td style="text-align:right;">
0.1830333
</td>
<td style="text-align:right;">
263
</td>
<td style="text-align:right;">
0.0011852
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
135
</td>
<td style="text-align:right;">
0.0903052
</td>
<td style="text-align:right;">
188
</td>
<td style="text-align:right;">
-0.0146698
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
132
</td>
<td style="text-align:right;">
0.0893405
</td>
<td style="text-align:right;">
106
</td>
<td style="text-align:right;">
-0.0335027
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
13
</td>
<td style="text-align:right;">
0.0331658
</td>
<td style="text-align:right;">
297
</td>
<td style="text-align:right;">
0.0101796
</td>
</tr>
<tr>
<td style="text-align:left;">
ar-512
</td>
<td style="text-align:left;">
boone, baxter, marion, newton counties coc
</td>
<td style="text-align:right;">
384
</td>
<td style="text-align:right;">
NA
</td>
<td style="text-align:right;">
384
</td>
<td style="text-align:right;">
NA
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
219
</td>
<td style="text-align:right;">
0.1330993
</td>
<td style="text-align:right;">
197
</td>
<td style="text-align:right;">
-0.0128413
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
228
</td>
<td style="text-align:right;">
0.1368859
</td>
<td style="text-align:right;">
49
</td>
<td style="text-align:right;">
-0.0792549
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
245
</td>
<td style="text-align:right;">
0.1512505
</td>
<td style="text-align:right;">
293
</td>
<td style="text-align:right;">
0.0091259
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
347
</td>
<td style="text-align:right;">
0.3813954
</td>
<td style="text-align:right;">
178
</td>
<td style="text-align:right;">
-0.0164567
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
375
</td>
<td style="text-align:right;">
0.7975101
</td>
<td style="text-align:right;">
351
</td>
<td style="text-align:right;">
0.0522214
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
336
</td>
<td style="text-align:right;">
0.3381215
</td>
<td style="text-align:right;">
359
</td>
<td style="text-align:right;">
0.0753022
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
315
</td>
<td style="text-align:right;">
0.2425695
</td>
<td style="text-align:right;">
361
</td>
<td style="text-align:right;">
0.0785119
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
370
</td>
<td style="text-align:right;">
0.5986325
</td>
<td style="text-align:right;">
11
</td>
<td style="text-align:right;">
-0.2537594
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
293
</td>
<td style="text-align:right;">
0.1995031
</td>
<td style="text-align:right;">
325
</td>
<td style="text-align:right;">
0.0200932
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
372
</td>
<td style="text-align:right;">
0.6725708
</td>
<td style="text-align:right;">
357
</td>
<td style="text-align:right;">
0.0687046
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
353
</td>
<td style="text-align:right;">
0.4205602
</td>
<td style="text-align:right;">
375
</td>
<td style="text-align:right;">
0.1597745
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
377
</td>
<td style="text-align:right;">
0.8511138
</td>
<td style="text-align:right;">
5
</td>
<td style="text-align:right;">
-0.4435330
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
380
</td>
<td style="text-align:right;">
1.0083186
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
-0.6004079
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
320
</td>
<td style="text-align:right;">
0.2540491
</td>
<td style="text-align:right;">
346
</td>
<td style="text-align:right;">
0.0374704
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
312
</td>
<td style="text-align:right;">
0.2336494
</td>
<td style="text-align:right;">
306
</td>
<td style="text-align:right;">
0.0134504
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
260
</td>
<td style="text-align:right;">
0.1627309
</td>
<td style="text-align:right;">
33
</td>
<td style="text-align:right;">
-0.1033171
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
254
</td>
<td style="text-align:right;">
0.1593005
</td>
<td style="text-align:right;">
341
</td>
<td style="text-align:right;">
0.0336063
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
290
</td>
<td style="text-align:right;">
0.1908975
</td>
<td style="text-align:right;">
92
</td>
<td style="text-align:right;">
-0.0398890
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
294
</td>
<td style="text-align:right;">
0.2006039
</td>
<td style="text-align:right;">
347
</td>
<td style="text-align:right;">
0.0396985
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
345
</td>
<td style="text-align:right;">
0.3683483
</td>
<td style="text-align:right;">
376
</td>
<td style="text-align:right;">
0.1663819
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
309
</td>
<td style="text-align:right;">
0.2278017
</td>
<td style="text-align:right;">
333
</td>
<td style="text-align:right;">
0.0261760
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
326
</td>
<td style="text-align:right;">
0.2604749
</td>
<td style="text-align:right;">
99
</td>
<td style="text-align:right;">
-0.0382984
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
363
</td>
<td style="text-align:right;">
0.4995781
</td>
<td style="text-align:right;">
379
</td>
<td style="text-align:right;">
0.1905058
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
291
</td>
<td style="text-align:right;">
0.1931481
</td>
<td style="text-align:right;">
38
</td>
<td style="text-align:right;">
-0.0954467
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
299
</td>
<td style="text-align:right;">
0.2112988
</td>
<td style="text-align:right;">
270
</td>
<td style="text-align:right;">
0.0028299
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
366
</td>
<td style="text-align:right;">
0.5194709
</td>
<td style="text-align:right;">
19
</td>
<td style="text-align:right;">
-0.1692160
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
356
</td>
<td style="text-align:right;">
0.4306189
</td>
<td style="text-align:right;">
2
</td>
<td style="text-align:right;">
-0.4804293
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
358
</td>
<td style="text-align:right;">
0.4502066
</td>
<td style="text-align:right;">
328
</td>
<td style="text-align:right;">
0.0229517
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
339
</td>
<td style="text-align:right;">
0.3507207
</td>
<td style="text-align:right;">
380
</td>
<td style="text-align:right;">
0.2446889
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
325
</td>
<td style="text-align:right;">
0.2603213
</td>
<td style="text-align:right;">
298
</td>
<td style="text-align:right;">
0.0104652
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
368
</td>
<td style="text-align:right;">
0.5392010
</td>
<td style="text-align:right;">
377
</td>
<td style="text-align:right;">
0.1679721
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
327
</td>
<td style="text-align:right;">
0.2611755
</td>
<td style="text-align:right;">
267
</td>
<td style="text-align:right;">
0.0021318
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
252
</td>
<td style="text-align:right;">
0.1573839
</td>
<td style="text-align:right;">
343
</td>
<td style="text-align:right;">
0.0356377
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
348
</td>
<td style="text-align:right;">
0.3851537
</td>
<td style="text-align:right;">
120
</td>
<td style="text-align:right;">
-0.0284463
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
162
</td>
<td style="text-align:right;">
0.1009193
</td>
<td style="text-align:right;">
199
</td>
<td style="text-align:right;">
-0.0122015
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
351
</td>
<td style="text-align:right;">
0.3946440
</td>
<td style="text-align:right;">
16
</td>
<td style="text-align:right;">
-0.1822568
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
362
</td>
<td style="text-align:right;">
0.4910209
</td>
<td style="text-align:right;">
288
</td>
<td style="text-align:right;">
0.0079782
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
158
</td>
<td style="text-align:right;">
0.0985636
</td>
<td style="text-align:right;">
126
</td>
<td style="text-align:right;">
-0.0267688
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
160
</td>
<td style="text-align:right;">
0.0999651
</td>
<td style="text-align:right;">
214
</td>
<td style="text-align:right;">
-0.0092980
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
248
</td>
<td style="text-align:right;">
0.1547220
</td>
<td style="text-align:right;">
190
</td>
<td style="text-align:right;">
-0.0141947
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
215
</td>
<td style="text-align:right;">
0.1307808
</td>
<td style="text-align:right;">
181
</td>
<td style="text-align:right;">
-0.0160961
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
376
</td>
<td style="text-align:right;">
0.8321814
</td>
<td style="text-align:right;">
382
</td>
<td style="text-align:right;">
0.6660796
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
350
</td>
<td style="text-align:right;">
0.3898976
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
-0.4525660
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
313
</td>
<td style="text-align:right;">
0.2342649
</td>
<td style="text-align:right;">
368
</td>
<td style="text-align:right;">
0.1057686
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
272
</td>
<td style="text-align:right;">
0.1743725
</td>
<td style="text-align:right;">
85
</td>
<td style="text-align:right;">
-0.0427650
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
311
</td>
<td style="text-align:right;">
0.2296696
</td>
<td style="text-align:right;">
349
</td>
<td style="text-align:right;">
0.0491620
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
127
</td>
<td style="text-align:right;">
0.0862682
</td>
<td style="text-align:right;">
93
</td>
<td style="text-align:right;">
-0.0398161
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
195
</td>
<td style="text-align:right;">
0.1184750
</td>
<td style="text-align:right;">
233
</td>
<td style="text-align:right;">
-0.0048342
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
381
</td>
<td style="text-align:right;">
1.0296271
</td>
<td style="text-align:right;">
28
</td>
<td style="text-align:right;">
-0.1258698
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
192
</td>
<td style="text-align:right;">
0.1147480
</td>
<td style="text-align:right;">
321
</td>
<td style="text-align:right;">
0.0191954
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
249
</td>
<td style="text-align:right;">
0.1553951
</td>
<td style="text-align:right;">
137
</td>
<td style="text-align:right;">
-0.0241175
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
221
</td>
<td style="text-align:right;">
0.1336327
</td>
<td style="text-align:right;">
205
</td>
<td style="text-align:right;">
-0.0110926
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
332
</td>
<td style="text-align:right;">
0.2756382
</td>
<td style="text-align:right;">
48
</td>
<td style="text-align:right;">
-0.0822060
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
125
</td>
<td style="text-align:right;">
0.0850925
</td>
<td style="text-align:right;">
268
</td>
<td style="text-align:right;">
0.0024664
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
177
</td>
<td style="text-align:right;">
0.1096407
</td>
<td style="text-align:right;">
21
</td>
<td style="text-align:right;">
-0.1525017
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
288
</td>
<td style="text-align:right;">
0.1882645
</td>
<td style="text-align:right;">
7
</td>
<td style="text-align:right;">
-0.4115195
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
297
</td>
<td style="text-align:right;">
0.2071035
</td>
<td style="text-align:right;">
330
</td>
<td style="text-align:right;">
0.0236950
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
159
</td>
<td style="text-align:right;">
0.0999227
</td>
<td style="text-align:right;">
211
</td>
<td style="text-align:right;">
-0.0097830
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
281
</td>
<td style="text-align:right;">
0.1825478
</td>
<td style="text-align:right;">
30
</td>
<td style="text-align:right;">
-0.1207327
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
323
</td>
<td style="text-align:right;">
0.2562816
</td>
<td style="text-align:right;">
18
</td>
<td style="text-align:right;">
-0.1743446
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
243
</td>
<td style="text-align:right;">
0.1503928
</td>
<td style="text-align:right;">
150
</td>
<td style="text-align:right;">
-0.0213769
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
217
</td>
<td style="text-align:right;">
0.1317748
</td>
<td style="text-align:right;">
81
</td>
<td style="text-align:right;">
-0.0439944
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
244
</td>
<td style="text-align:right;">
0.1511743
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
-0.4681097
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
213
</td>
<td style="text-align:right;">
0.1292766
</td>
<td style="text-align:right;">
26
</td>
<td style="text-align:right;">
-0.1308617
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
265
</td>
<td style="text-align:right;">
0.1663414
</td>
<td style="text-align:right;">
35
</td>
<td style="text-align:right;">
-0.1006191
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
205
</td>
<td style="text-align:right;">
0.1251474
</td>
<td style="text-align:right;">
345
</td>
<td style="text-align:right;">
0.0371172
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
276
</td>
<td style="text-align:right;">
0.1787793
</td>
<td style="text-align:right;">
9
</td>
<td style="text-align:right;">
-0.3524281
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
343
</td>
<td style="text-align:right;">
0.3643405
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
-0.4264187
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
367
</td>
<td style="text-align:right;">
0.5364626
</td>
<td style="text-align:right;">
25
</td>
<td style="text-align:right;">
-0.1383382
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
145
</td>
<td style="text-align:right;">
0.0931451
</td>
<td style="text-align:right;">
334
</td>
<td style="text-align:right;">
0.0262012
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
214
</td>
<td style="text-align:right;">
0.1307163
</td>
<td style="text-align:right;">
139
</td>
<td style="text-align:right;">
-0.0237936
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
204
</td>
<td style="text-align:right;">
0.1230095
</td>
<td style="text-align:right;">
140
</td>
<td style="text-align:right;">
-0.0237740
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
147
</td>
<td style="text-align:right;">
0.0945240
</td>
<td style="text-align:right;">
14
</td>
<td style="text-align:right;">
-0.1999988
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
166
</td>
<td style="text-align:right;">
0.1042584
</td>
<td style="text-align:right;">
154
</td>
<td style="text-align:right;">
-0.0204793
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
383
</td>
<td style="text-align:right;">
1.2410873
</td>
<td style="text-align:right;">
381
</td>
<td style="text-align:right;">
0.3762803
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
144
</td>
<td style="text-align:right;">
0.0922670
</td>
<td style="text-align:right;">
163
</td>
<td style="text-align:right;">
-0.0202297
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
283
</td>
<td style="text-align:right;">
0.1837465
</td>
<td style="text-align:right;">
363
</td>
<td style="text-align:right;">
0.0821653
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
371
</td>
<td style="text-align:right;">
0.6680973
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
-0.3737956
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
52
</td>
<td style="text-align:right;">
0.0540118
</td>
<td style="text-align:right;">
65
</td>
<td style="text-align:right;">
-0.0557060
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
269
</td>
<td style="text-align:right;">
0.1721212
</td>
<td style="text-align:right;">
121
</td>
<td style="text-align:right;">
-0.0284162
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
220
</td>
<td style="text-align:right;">
0.1334690
</td>
<td style="text-align:right;">
34
</td>
<td style="text-align:right;">
-0.1007219
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
168
</td>
<td style="text-align:right;">
0.1064441
</td>
<td style="text-align:right;">
193
</td>
<td style="text-align:right;">
-0.0138840
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
45
</td>
<td style="text-align:right;">
0.0520577
</td>
<td style="text-align:right;">
169
</td>
<td style="text-align:right;">
-0.0188438
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
341
</td>
<td style="text-align:right;">
0.3528762
</td>
<td style="text-align:right;">
32
</td>
<td style="text-align:right;">
-0.1070170
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
361
</td>
<td style="text-align:right;">
0.4720154
</td>
<td style="text-align:right;">
94
</td>
<td style="text-align:right;">
-0.0396632
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
360
</td>
<td style="text-align:right;">
0.4541230
</td>
<td style="text-align:right;">
148
</td>
<td style="text-align:right;">
-0.0219232
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
303
</td>
<td style="text-align:right;">
0.2147773
</td>
<td style="text-align:right;">
124
</td>
<td style="text-align:right;">
-0.0268472
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
80
</td>
<td style="text-align:right;">
0.0704678
</td>
<td style="text-align:right;">
217
</td>
<td style="text-align:right;">
-0.0089262
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
253
</td>
<td style="text-align:right;">
0.1585404
</td>
<td style="text-align:right;">
133
</td>
<td style="text-align:right;">
-0.0253167
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
271
</td>
<td style="text-align:right;">
0.1741554
</td>
<td style="text-align:right;">
260
</td>
<td style="text-align:right;">
0.0006911
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
164
</td>
<td style="text-align:right;">
0.1029235
</td>
<td style="text-align:right;">
225
</td>
<td style="text-align:right;">
-0.0077848
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
66
</td>
<td style="text-align:right;">
0.0595357
</td>
<td style="text-align:right;">
279
</td>
<td style="text-align:right;">
0.0043238
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
102
</td>
<td style="text-align:right;">
0.0751143
</td>
<td style="text-align:right;">
77
</td>
<td style="text-align:right;">
-0.0451859
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
22
</td>
<td style="text-align:right;">
0.0379837
</td>
<td style="text-align:right;">
171
</td>
<td style="text-align:right;">
-0.0181005
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
136
</td>
<td style="text-align:right;">
0.0907888
</td>
<td style="text-align:right;">
224
</td>
<td style="text-align:right;">
-0.0082096
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
54
</td>
<td style="text-align:right;">
0.0548538
</td>
<td style="text-align:right;">
102
</td>
<td style="text-align:right;">
-0.0353168
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
25
</td>
<td style="text-align:right;">
0.0424486
</td>
<td style="text-align:right;">
277
</td>
<td style="text-align:right;">
0.0039834
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
161
</td>
<td style="text-align:right;">
0.1008731
</td>
<td style="text-align:right;">
250
</td>
<td style="text-align:right;">
-0.0012609
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
142
</td>
<td style="text-align:right;">
0.0919178
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
-0.0327228
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
151
</td>
<td style="text-align:right;">
0.0956288
</td>
<td style="text-align:right;">
276
</td>
<td style="text-align:right;">
0.0038252
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
296
</td>
<td style="text-align:right;">
0.2008865
</td>
<td style="text-align:right;">
116
</td>
<td style="text-align:right;">
-0.0308517
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
17
</td>
<td style="text-align:right;">
0.0350036
</td>
<td style="text-align:right;">
198
</td>
<td style="text-align:right;">
-0.0123896
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
91
</td>
<td style="text-align:right;">
0.0729088
</td>
<td style="text-align:right;">
67
</td>
<td style="text-align:right;">
-0.0531274
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
227
</td>
<td style="text-align:right;">
0.1366878
</td>
<td style="text-align:right;">
262
</td>
<td style="text-align:right;">
0.0010088
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
12
</td>
<td style="text-align:right;">
0.0321525
</td>
<td style="text-align:right;">
97
</td>
<td style="text-align:right;">
-0.0391279
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
2
</td>
<td style="text-align:right;">
0.0229109
</td>
<td style="text-align:right;">
229
</td>
<td style="text-align:right;">
-0.0064748
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
242
</td>
<td style="text-align:right;">
0.1496074
</td>
<td style="text-align:right;">
43
</td>
<td style="text-align:right;">
-0.0882777
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
92
</td>
<td style="text-align:right;">
0.0729203
</td>
<td style="text-align:right;">
278
</td>
<td style="text-align:right;">
0.0042396
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
10
</td>
<td style="text-align:right;">
0.0301684
</td>
<td style="text-align:right;">
242
</td>
<td style="text-align:right;">
-0.0030473
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
9
</td>
<td style="text-align:right;">
0.0299680
</td>
<td style="text-align:right;">
103
</td>
<td style="text-align:right;">
-0.0348881
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
36
</td>
<td style="text-align:right;">
0.0488811
</td>
<td style="text-align:right;">
227
</td>
<td style="text-align:right;">
-0.0074535
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
71
</td>
<td style="text-align:right;">
0.0630403
</td>
<td style="text-align:right;">
218
</td>
<td style="text-align:right;">
-0.0089025
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
278
</td>
<td style="text-align:right;">
0.1793274
</td>
<td style="text-align:right;">
147
</td>
<td style="text-align:right;">
-0.0221760
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
184
</td>
<td style="text-align:right;">
0.1123721
</td>
<td style="text-align:right;">
204
</td>
<td style="text-align:right;">
-0.0113745
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
310
</td>
<td style="text-align:right;">
0.2287739
</td>
<td style="text-align:right;">
235
</td>
<td style="text-align:right;">
-0.0044858
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
8
</td>
<td style="text-align:right;">
0.0290636
</td>
<td style="text-align:right;">
258
</td>
<td style="text-align:right;">
0.0001730
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
69
</td>
<td style="text-align:right;">
0.0622562
</td>
<td style="text-align:right;">
128
</td>
<td style="text-align:right;">
-0.0263809
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
68
</td>
<td style="text-align:right;">
0.0620327
</td>
<td style="text-align:right;">
234
</td>
<td style="text-align:right;">
-0.0045397
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
201
</td>
<td style="text-align:right;">
0.1212615
</td>
<td style="text-align:right;">
69
</td>
<td style="text-align:right;">
-0.0510713
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
304
</td>
<td style="text-align:right;">
0.2176317
</td>
<td style="text-align:right;">
10
</td>
<td style="text-align:right;">
-0.2729133
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
55
</td>
<td style="text-align:right;">
0.0551546
</td>
<td style="text-align:right;">
179
</td>
<td style="text-align:right;">
-0.0164096
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
107
</td>
<td style="text-align:right;">
0.0775532
</td>
<td style="text-align:right;">
62
</td>
<td style="text-align:right;">
-0.0579064
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
237
</td>
<td style="text-align:right;">
0.1441010
</td>
<td style="text-align:right;">
37
</td>
<td style="text-align:right;">
-0.0961886
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
47
</td>
<td style="text-align:right;">
0.0526141
</td>
<td style="text-align:right;">
215
</td>
<td style="text-align:right;">
-0.0092848
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
14
</td>
<td style="text-align:right;">
0.0338562
</td>
<td style="text-align:right;">
200
</td>
<td style="text-align:right;">
-0.0118671
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
62
</td>
<td style="text-align:right;">
0.0575790
</td>
<td style="text-align:right;">
302
</td>
<td style="text-align:right;">
0.0117110
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
43
</td>
<td style="text-align:right;">
0.0517090
</td>
<td style="text-align:right;">
123
</td>
<td style="text-align:right;">
-0.0270685
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
379
</td>
<td style="text-align:right;">
0.9287429
</td>
<td style="text-align:right;">
337
</td>
<td style="text-align:right;">
0.0301676
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
382
</td>
<td style="text-align:right;">
1.1467543
</td>
<td style="text-align:right;">
383
</td>
<td style="text-align:right;">
0.7338795
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
241
</td>
<td style="text-align:right;">
0.1475084
</td>
<td style="text-align:right;">
213
</td>
<td style="text-align:right;">
-0.0094768
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
374
</td>
<td style="text-align:right;">
0.7194998
</td>
<td style="text-align:right;">
372
</td>
<td style="text-align:right;">
0.1448399
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
355
</td>
<td style="text-align:right;">
0.4302229
</td>
<td style="text-align:right;">
355
</td>
<td style="text-align:right;">
0.0631134
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
308
</td>
<td style="text-align:right;">
0.2268932
</td>
<td style="text-align:right;">
286
</td>
<td style="text-align:right;">
0.0068607
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
280
</td>
<td style="text-align:right;">
0.1809152
</td>
<td style="text-align:right;">
122
</td>
<td style="text-align:right;">
-0.0283462
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
373
</td>
<td style="text-align:right;">
0.7092841
</td>
<td style="text-align:right;">
378
</td>
<td style="text-align:right;">
0.1766416
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
365
</td>
<td style="text-align:right;">
0.5118707
</td>
<td style="text-align:right;">
292
</td>
<td style="text-align:right;">
0.0091243
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
202
</td>
<td style="text-align:right;">
0.1214972
</td>
<td style="text-align:right;">
29
</td>
<td style="text-align:right;">
-0.1253147
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
264
</td>
<td style="text-align:right;">
0.1653891
</td>
<td style="text-align:right;">
47
</td>
<td style="text-align:right;">
-0.0839084
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
354
</td>
<td style="text-align:right;">
0.4232293
</td>
<td style="text-align:right;">
332
</td>
<td style="text-align:right;">
0.0258204
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
301
</td>
<td style="text-align:right;">
0.2132945
</td>
<td style="text-align:right;">
23
</td>
<td style="text-align:right;">
-0.1490089
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
171
</td>
<td style="text-align:right;">
0.1071083
</td>
<td style="text-align:right;">
182
</td>
<td style="text-align:right;">
-0.0159863
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
57
</td>
<td style="text-align:right;">
0.0557897
</td>
<td style="text-align:right;">
237
</td>
<td style="text-align:right;">
-0.0037551
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
175
</td>
<td style="text-align:right;">
0.1088589
</td>
<td style="text-align:right;">
63
</td>
<td style="text-align:right;">
-0.0564964
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
352
</td>
<td style="text-align:right;">
0.4048126
</td>
<td style="text-align:right;">
212
</td>
<td style="text-align:right;">
-0.0095231
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
105
</td>
<td style="text-align:right;">
0.0758223
</td>
<td style="text-align:right;">
194
</td>
<td style="text-align:right;">
-0.0131691
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
75
</td>
<td style="text-align:right;">
0.0648713
</td>
<td style="text-align:right;">
240
</td>
<td style="text-align:right;">
-0.0031904
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
50
</td>
<td style="text-align:right;">
0.0537120
</td>
<td style="text-align:right;">
252
</td>
<td style="text-align:right;">
-0.0006394
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
141
</td>
<td style="text-align:right;">
0.0915047
</td>
<td style="text-align:right;">
327
</td>
<td style="text-align:right;">
0.0228158
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
165
</td>
<td style="text-align:right;">
0.1032059
</td>
<td style="text-align:right;">
336
</td>
<td style="text-align:right;">
0.0292317
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
206
</td>
<td style="text-align:right;">
0.1259889
</td>
<td style="text-align:right;">
57
</td>
<td style="text-align:right;">
-0.0644594
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
229
</td>
<td style="text-align:right;">
0.1371865
</td>
<td style="text-align:right;">
17
</td>
<td style="text-align:right;">
-0.1809634
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
211
</td>
<td style="text-align:right;">
0.1286870
</td>
<td style="text-align:right;">
335
</td>
<td style="text-align:right;">
0.0285066
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
40
</td>
<td style="text-align:right;">
0.0507769
</td>
<td style="text-align:right;">
285
</td>
<td style="text-align:right;">
0.0067703
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
120
</td>
<td style="text-align:right;">
0.0824132
</td>
<td style="text-align:right;">
317
</td>
<td style="text-align:right;">
0.0175347
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
218
</td>
<td style="text-align:right;">
0.1327800
</td>
<td style="text-align:right;">
353
</td>
<td style="text-align:right;">
0.0613857
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
261
</td>
<td style="text-align:right;">
0.1630802
</td>
<td style="text-align:right;">
136
</td>
<td style="text-align:right;">
-0.0245737
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
48
</td>
<td style="text-align:right;">
0.0529599
</td>
<td style="text-align:right;">
165
</td>
<td style="text-align:right;">
-0.0200538
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
118
</td>
<td style="text-align:right;">
0.0811686
</td>
<td style="text-align:right;">
232
</td>
<td style="text-align:right;">
-0.0049281
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
289
</td>
<td style="text-align:right;">
0.1890669
</td>
<td style="text-align:right;">
183
</td>
<td style="text-align:right;">
-0.0157806
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
59
</td>
<td style="text-align:right;">
0.0569422
</td>
<td style="text-align:right;">
98
</td>
<td style="text-align:right;">
-0.0385833
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
328
</td>
<td style="text-align:right;">
0.2613724
</td>
<td style="text-align:right;">
24
</td>
<td style="text-align:right;">
-0.1456830
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
1
</td>
<td style="text-align:right;">
0.0195478
</td>
<td style="text-align:right;">
144
</td>
<td style="text-align:right;">
-0.0226977
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
11
</td>
<td style="text-align:right;">
0.0312241
</td>
<td style="text-align:right;">
222
</td>
<td style="text-align:right;">
-0.0084421
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
15
</td>
<td style="text-align:right;">
0.0344098
</td>
<td style="text-align:right;">
244
</td>
<td style="text-align:right;">
-0.0024175
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
170
</td>
<td style="text-align:right;">
0.1067496
</td>
<td style="text-align:right;">
70
</td>
<td style="text-align:right;">
-0.0480129
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
188
</td>
<td style="text-align:right;">
0.1136589
</td>
<td style="text-align:right;">
206
</td>
<td style="text-align:right;">
-0.0110043
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
305
</td>
<td style="text-align:right;">
0.2176934
</td>
<td style="text-align:right;">
82
</td>
<td style="text-align:right;">
-0.0437691
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
239
</td>
<td style="text-align:right;">
0.1457706
</td>
<td style="text-align:right;">
239
</td>
<td style="text-align:right;">
-0.0034790
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
110
</td>
<td style="text-align:right;">
0.0778851
</td>
<td style="text-align:right;">
51
</td>
<td style="text-align:right;">
-0.0726375
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
284
</td>
<td style="text-align:right;">
0.1840937
</td>
<td style="text-align:right;">
314
</td>
<td style="text-align:right;">
0.0165014
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
196
</td>
<td style="text-align:right;">
0.1188493
</td>
<td style="text-align:right;">
151
</td>
<td style="text-align:right;">
-0.0213319
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
230
</td>
<td style="text-align:right;">
0.1372527
</td>
<td style="text-align:right;">
40
</td>
<td style="text-align:right;">
-0.0940327
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
140
</td>
<td style="text-align:right;">
0.0914196
</td>
<td style="text-align:right;">
195
</td>
<td style="text-align:right;">
-0.0130599
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
273
</td>
<td style="text-align:right;">
0.1753447
</td>
<td style="text-align:right;">
101
</td>
<td style="text-align:right;">
-0.0356633
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
233
</td>
<td style="text-align:right;">
0.1398424
</td>
<td style="text-align:right;">
311
</td>
<td style="text-align:right;">
0.0160585
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
143
</td>
<td style="text-align:right;">
0.0920070
</td>
<td style="text-align:right;">
12
</td>
<td style="text-align:right;">
-0.2459306
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
41
</td>
<td style="text-align:right;">
0.0508772
</td>
<td style="text-align:right;">
36
</td>
<td style="text-align:right;">
-0.0998700
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
35
</td>
<td style="text-align:right;">
0.0481049
</td>
<td style="text-align:right;">
138
</td>
<td style="text-align:right;">
-0.0240525
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
112
</td>
<td style="text-align:right;">
0.0787349
</td>
<td style="text-align:right;">
64
</td>
<td style="text-align:right;">
-0.0560899
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
183
</td>
<td style="text-align:right;">
0.1121870
</td>
<td style="text-align:right;">
238
</td>
<td style="text-align:right;">
-0.0036783
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
316
</td>
<td style="text-align:right;">
0.2468147
</td>
<td style="text-align:right;">
60
</td>
<td style="text-align:right;">
-0.0588161
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
329
</td>
<td style="text-align:right;">
0.2658477
</td>
<td style="text-align:right;">
191
</td>
<td style="text-align:right;">
-0.0141885
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
77
</td>
<td style="text-align:right;">
0.0692218
</td>
<td style="text-align:right;">
266
</td>
<td style="text-align:right;">
0.0020892
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
39
</td>
<td style="text-align:right;">
0.0494306
</td>
<td style="text-align:right;">
219
</td>
<td style="text-align:right;">
-0.0086998
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
86
</td>
<td style="text-align:right;">
0.0718747
</td>
<td style="text-align:right;">
44
</td>
<td style="text-align:right;">
-0.0878468
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
114
</td>
<td style="text-align:right;">
0.0799758
</td>
<td style="text-align:right;">
241
</td>
<td style="text-align:right;">
-0.0031497
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
257
</td>
<td style="text-align:right;">
0.1608274
</td>
<td style="text-align:right;">
187
</td>
<td style="text-align:right;">
-0.0146740
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
163
</td>
<td style="text-align:right;">
0.1021824
</td>
<td style="text-align:right;">
305
</td>
<td style="text-align:right;">
0.0132920
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
300
</td>
<td style="text-align:right;">
0.2122877
</td>
<td style="text-align:right;">
245
</td>
<td style="text-align:right;">
-0.0019980
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
3
</td>
<td style="text-align:right;">
0.0234630
</td>
<td style="text-align:right;">
87
</td>
<td style="text-align:right;">
-0.0415114
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
29
</td>
<td style="text-align:right;">
0.0450093
</td>
<td style="text-align:right;">
280
</td>
<td style="text-align:right;">
0.0048010
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
335
</td>
<td style="text-align:right;">
0.3020273
</td>
<td style="text-align:right;">
27
</td>
<td style="text-align:right;">
-0.1288947
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
185
</td>
<td style="text-align:right;">
0.1124341
</td>
<td style="text-align:right;">
50
</td>
<td style="text-align:right;">
-0.0769286
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
193
</td>
<td style="text-align:right;">
0.1173002
</td>
<td style="text-align:right;">
84
</td>
<td style="text-align:right;">
-0.0433447
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
250
</td>
<td style="text-align:right;">
0.1560080
</td>
<td style="text-align:right;">
145
</td>
<td style="text-align:right;">
-0.0226921
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
267
</td>
<td style="text-align:right;">
0.1710477
</td>
<td style="text-align:right;">
274
</td>
<td style="text-align:right;">
0.0033539
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
275
</td>
<td style="text-align:right;">
0.1784812
</td>
<td style="text-align:right;">
96
</td>
<td style="text-align:right;">
-0.0392103
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
38
</td>
<td style="text-align:right;">
0.0491207
</td>
<td style="text-align:right;">
228
</td>
<td style="text-align:right;">
-0.0066833
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
111
</td>
<td style="text-align:right;">
0.0779606
</td>
<td style="text-align:right;">
52
</td>
<td style="text-align:right;">
-0.0699198
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
7
</td>
<td style="text-align:right;">
0.0289672
</td>
<td style="text-align:right;">
158
</td>
<td style="text-align:right;">
-0.0203805
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
82
</td>
<td style="text-align:right;">
0.0713406
</td>
<td style="text-align:right;">
177
</td>
<td style="text-align:right;">
-0.0164949
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
226
</td>
<td style="text-align:right;">
0.1361325
</td>
<td style="text-align:right;">
108
</td>
<td style="text-align:right;">
-0.0329431
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
197
</td>
<td style="text-align:right;">
0.1196634
</td>
<td style="text-align:right;">
157
</td>
<td style="text-align:right;">
-0.0203972
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
306
</td>
<td style="text-align:right;">
0.2190693
</td>
<td style="text-align:right;">
296
</td>
<td style="text-align:right;">
0.0094904
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
186
</td>
<td style="text-align:right;">
0.1125095
</td>
<td style="text-align:right;">
20
</td>
<td style="text-align:right;">
-0.1574468
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
64
</td>
<td style="text-align:right;">
0.0589312
</td>
<td style="text-align:right;">
236
</td>
<td style="text-align:right;">
-0.0040194
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
208
</td>
<td style="text-align:right;">
0.1271120
</td>
<td style="text-align:right;">
74
</td>
<td style="text-align:right;">
-0.0464336
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
258
</td>
<td style="text-align:right;">
0.1614308
</td>
<td style="text-align:right;">
107
</td>
<td style="text-align:right;">
-0.0334862
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
121
</td>
<td style="text-align:right;">
0.0833069
</td>
<td style="text-align:right;">
271
</td>
<td style="text-align:right;">
0.0030020
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
154
</td>
<td style="text-align:right;">
0.0962656
</td>
<td style="text-align:right;">
170
</td>
<td style="text-align:right;">
-0.0183130
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
124
</td>
<td style="text-align:right;">
0.0847121
</td>
<td style="text-align:right;">
142
</td>
<td style="text-align:right;">
-0.0235454
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
190
</td>
<td style="text-align:right;">
0.1137340
</td>
<td style="text-align:right;">
46
</td>
<td style="text-align:right;">
-0.0859120
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
172
</td>
<td style="text-align:right;">
0.1078244
</td>
<td style="text-align:right;">
338
</td>
<td style="text-align:right;">
0.0312123
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
302
</td>
<td style="text-align:right;">
0.2136711
</td>
<td style="text-align:right;">
15
</td>
<td style="text-align:right;">
-0.1927323
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
89
</td>
<td style="text-align:right;">
0.0722008
</td>
<td style="text-align:right;">
39
</td>
<td style="text-align:right;">
-0.0953797
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
70
</td>
<td style="text-align:right;">
0.0624850
</td>
<td style="text-align:right;">
256
</td>
<td style="text-align:right;">
-0.0001118
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
270
</td>
<td style="text-align:right;">
0.1725441
</td>
<td style="text-align:right;">
125
</td>
<td style="text-align:right;">
-0.0267804
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
274
</td>
<td style="text-align:right;">
0.1780055
</td>
<td style="text-align:right;">
22
</td>
<td style="text-align:right;">
-0.1519559
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
116
</td>
<td style="text-align:right;">
0.0802265
</td>
<td style="text-align:right;">
282
</td>
<td style="text-align:right;">
0.0057305
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
349
</td>
<td style="text-align:right;">
0.3870453
</td>
<td style="text-align:right;">
320
</td>
<td style="text-align:right;">
0.0181286
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
150
</td>
<td style="text-align:right;">
0.0950606
</td>
<td style="text-align:right;">
259
</td>
<td style="text-align:right;">
0.0003383
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
256
</td>
<td style="text-align:right;">
0.1602635
</td>
<td style="text-align:right;">
95
</td>
<td style="text-align:right;">
-0.0392407
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
21
</td>
<td style="text-align:right;">
0.0378897
</td>
<td style="text-align:right;">
246
</td>
<td style="text-align:right;">
-0.0018196
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
285
</td>
<td style="text-align:right;">
0.1867015
</td>
<td style="text-align:right;">
91
</td>
<td style="text-align:right;">
-0.0400075
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
148
</td>
<td style="text-align:right;">
0.0949600
</td>
<td style="text-align:right;">
54
</td>
<td style="text-align:right;">
-0.0661583
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
333
</td>
<td style="text-align:right;">
0.2807591
</td>
<td style="text-align:right;">
364
</td>
<td style="text-align:right;">
0.0938804
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
210
</td>
<td style="text-align:right;">
0.1275145
</td>
<td style="text-align:right;">
283
</td>
<td style="text-align:right;">
0.0057826
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
83
</td>
<td style="text-align:right;">
0.0716339
</td>
<td style="text-align:right;">
135
</td>
<td style="text-align:right;">
-0.0245979
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
49
</td>
<td style="text-align:right;">
0.0535247
</td>
<td style="text-align:right;">
90
</td>
<td style="text-align:right;">
-0.0404231
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
113
</td>
<td style="text-align:right;">
0.0798815
</td>
<td style="text-align:right;">
264
</td>
<td style="text-align:right;">
0.0018064
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
67
</td>
<td style="text-align:right;">
0.0601139
</td>
<td style="text-align:right;">
75
</td>
<td style="text-align:right;">
-0.0463590
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
126
</td>
<td style="text-align:right;">
0.0856296
</td>
<td style="text-align:right;">
300
</td>
<td style="text-align:right;">
0.0114436
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
76
</td>
<td style="text-align:right;">
0.0655111
</td>
<td style="text-align:right;">
112
</td>
<td style="text-align:right;">
-0.0315535
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
212
</td>
<td style="text-align:right;">
0.1287669
</td>
<td style="text-align:right;">
88
</td>
<td style="text-align:right;">
-0.0411301
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
128
</td>
<td style="text-align:right;">
0.0865741
</td>
<td style="text-align:right;">
13
</td>
<td style="text-align:right;">
-0.2175220
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
133
</td>
<td style="text-align:right;">
0.0899922
</td>
<td style="text-align:right;">
310
</td>
<td style="text-align:right;">
0.0157087
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
322
</td>
<td style="text-align:right;">
0.2545922
</td>
<td style="text-align:right;">
312
</td>
<td style="text-align:right;">
0.0163395
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
109
</td>
<td style="text-align:right;">
0.0778834
</td>
<td style="text-align:right;">
172
</td>
<td style="text-align:right;">
-0.0180720
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
334
</td>
<td style="text-align:right;">
0.2890151
</td>
<td style="text-align:right;">
56
</td>
<td style="text-align:right;">
-0.0646162
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
330
</td>
<td style="text-align:right;">
0.2679802
</td>
<td style="text-align:right;">
365
</td>
<td style="text-align:right;">
0.0950970
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
119
</td>
<td style="text-align:right;">
0.0814744
</td>
<td style="text-align:right;">
118
</td>
<td style="text-align:right;">
-0.0305908
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
181
</td>
<td style="text-align:right;">
0.1114647
</td>
<td style="text-align:right;">
254
</td>
<td style="text-align:right;">
-0.0004005
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
96
</td>
<td style="text-align:right;">
0.0739943
</td>
<td style="text-align:right;">
42
</td>
<td style="text-align:right;">
-0.0886027
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
331
</td>
<td style="text-align:right;">
0.2708234
</td>
<td style="text-align:right;">
352
</td>
<td style="text-align:right;">
0.0600028
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
23
</td>
<td style="text-align:right;">
0.0422806
</td>
<td style="text-align:right;">
257
</td>
<td style="text-align:right;">
0.0000000
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
173
</td>
<td style="text-align:right;">
0.1084032
</td>
<td style="text-align:right;">
76
</td>
<td style="text-align:right;">
-0.0453432
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
319
</td>
<td style="text-align:right;">
0.2537219
</td>
<td style="text-align:right;">
366
</td>
<td style="text-align:right;">
0.0968404
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
103
</td>
<td style="text-align:right;">
0.0752143
</td>
<td style="text-align:right;">
209
</td>
<td style="text-align:right;">
-0.0102958
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
129
</td>
<td style="text-align:right;">
0.0869308
</td>
<td style="text-align:right;">
348
</td>
<td style="text-align:right;">
0.0420325
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
53
</td>
<td style="text-align:right;">
0.0542473
</td>
<td style="text-align:right;">
189
</td>
<td style="text-align:right;">
-0.0144511
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
179
</td>
<td style="text-align:right;">
0.1112375
</td>
<td style="text-align:right;">
141
</td>
<td style="text-align:right;">
-0.0237473
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
79
</td>
<td style="text-align:right;">
0.0697337
</td>
<td style="text-align:right;">
342
</td>
<td style="text-align:right;">
0.0344837
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
178
</td>
<td style="text-align:right;">
0.1108139
</td>
<td style="text-align:right;">
358
</td>
<td style="text-align:right;">
0.0703095
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
314
</td>
<td style="text-align:right;">
0.2422379
</td>
<td style="text-align:right;">
362
</td>
<td style="text-align:right;">
0.0786966
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
63
</td>
<td style="text-align:right;">
0.0579980
</td>
<td style="text-align:right;">
284
</td>
<td style="text-align:right;">
0.0061908
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
277
</td>
<td style="text-align:right;">
0.1792393
</td>
<td style="text-align:right;">
354
</td>
<td style="text-align:right;">
0.0621851
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
33
</td>
<td style="text-align:right;">
0.0471815
</td>
<td style="text-align:right;">
89
</td>
<td style="text-align:right;">
-0.0404413
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
20
</td>
<td style="text-align:right;">
0.0376291
</td>
<td style="text-align:right;">
152
</td>
<td style="text-align:right;">
-0.0207744
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
85
</td>
<td style="text-align:right;">
0.0718700
</td>
<td style="text-align:right;">
248
</td>
<td style="text-align:right;">
-0.0013982
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
378
</td>
<td style="text-align:right;">
0.9259073
</td>
<td style="text-align:right;">
371
</td>
<td style="text-align:right;">
0.1278777
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
223
</td>
<td style="text-align:right;">
0.1353084
</td>
<td style="text-align:right;">
249
</td>
<td style="text-align:right;">
-0.0013565
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
209
</td>
<td style="text-align:right;">
0.1272872
</td>
<td style="text-align:right;">
309
</td>
<td style="text-align:right;">
0.0156457
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
224
</td>
<td style="text-align:right;">
0.1355349
</td>
<td style="text-align:right;">
329
</td>
<td style="text-align:right;">
0.0231615
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
286
</td>
<td style="text-align:right;">
0.1875013
</td>
<td style="text-align:right;">
111
</td>
<td style="text-align:right;">
-0.0319173
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
56
</td>
<td style="text-align:right;">
0.0554535
</td>
<td style="text-align:right;">
316
</td>
<td style="text-align:right;">
0.0169441
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
317
</td>
<td style="text-align:right;">
0.2509760
</td>
<td style="text-align:right;">
360
</td>
<td style="text-align:right;">
0.0770191
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
324
</td>
<td style="text-align:right;">
0.2581938
</td>
<td style="text-align:right;">
356
</td>
<td style="text-align:right;">
0.0684436
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
231
</td>
<td style="text-align:right;">
0.1372641
</td>
<td style="text-align:right;">
290
</td>
<td style="text-align:right;">
0.0087484
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
246
</td>
<td style="text-align:right;">
0.1527672
</td>
<td style="text-align:right;">
105
</td>
<td style="text-align:right;">
-0.0339226
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
238
</td>
<td style="text-align:right;">
0.1441521
</td>
<td style="text-align:right;">
143
</td>
<td style="text-align:right;">
-0.0235204
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
234
</td>
<td style="text-align:right;">
0.1401527
</td>
<td style="text-align:right;">
307
</td>
<td style="text-align:right;">
0.0149693
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
108
</td>
<td style="text-align:right;">
0.0777605
</td>
<td style="text-align:right;">
109
</td>
<td style="text-align:right;">
-0.0328322
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
207
</td>
<td style="text-align:right;">
0.1268607
</td>
<td style="text-align:right;">
153
</td>
<td style="text-align:right;">
-0.0207081
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
174
</td>
<td style="text-align:right;">
0.1085234
</td>
<td style="text-align:right;">
68
</td>
<td style="text-align:right;">
-0.0523205
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
42
</td>
<td style="text-align:right;">
0.0511384
</td>
<td style="text-align:right;">
207
</td>
<td style="text-align:right;">
-0.0109850
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
97
</td>
<td style="text-align:right;">
0.0742234
</td>
<td style="text-align:right;">
53
</td>
<td style="text-align:right;">
-0.0675486
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
61
</td>
<td style="text-align:right;">
0.0575060
</td>
<td style="text-align:right;">
231
</td>
<td style="text-align:right;">
-0.0063542
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
251
</td>
<td style="text-align:right;">
0.1568906
</td>
<td style="text-align:right;">
299
</td>
<td style="text-align:right;">
0.0105753
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
287
</td>
<td style="text-align:right;">
0.1880204
</td>
<td style="text-align:right;">
72
</td>
<td style="text-align:right;">
-0.0473627
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
16
</td>
<td style="text-align:right;">
0.0348031
</td>
<td style="text-align:right;">
216
</td>
<td style="text-align:right;">
-0.0092609
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
279
</td>
<td style="text-align:right;">
0.1795651
</td>
<td style="text-align:right;">
369
</td>
<td style="text-align:right;">
0.1105016
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
130
</td>
<td style="text-align:right;">
0.0887323
</td>
<td style="text-align:right;">
265
</td>
<td style="text-align:right;">
0.0020372
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
32
</td>
<td style="text-align:right;">
0.0468259
</td>
<td style="text-align:right;">
202
</td>
<td style="text-align:right;">
-0.0117678
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
30
</td>
<td style="text-align:right;">
0.0451305
</td>
<td style="text-align:right;">
100
</td>
<td style="text-align:right;">
-0.0366223
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
359
</td>
<td style="text-align:right;">
0.4514617
</td>
<td style="text-align:right;">
104
</td>
<td style="text-align:right;">
-0.0346643
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
364
</td>
<td style="text-align:right;">
0.5100461
</td>
<td style="text-align:right;">
301
</td>
<td style="text-align:right;">
0.0116756
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
338
</td>
<td style="text-align:right;">
0.3429069
</td>
<td style="text-align:right;">
350
</td>
<td style="text-align:right;">
0.0501244
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
342
</td>
<td style="text-align:right;">
0.3589264
</td>
<td style="text-align:right;">
367
</td>
<td style="text-align:right;">
0.0998791
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
357
</td>
<td style="text-align:right;">
0.4352293
</td>
<td style="text-align:right;">
374
</td>
<td style="text-align:right;">
0.1545636
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
139
</td>
<td style="text-align:right;">
0.0912642
</td>
<td style="text-align:right;">
243
</td>
<td style="text-align:right;">
-0.0026225
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
152
</td>
<td style="text-align:right;">
0.0956314
</td>
<td style="text-align:right;">
61
</td>
<td style="text-align:right;">
-0.0586772
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
346
</td>
<td style="text-align:right;">
0.3698866
</td>
<td style="text-align:right;">
272
</td>
<td style="text-align:right;">
0.0031953
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
262
</td>
<td style="text-align:right;">
0.1631052
</td>
<td style="text-align:right;">
319
</td>
<td style="text-align:right;">
0.0179599
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
94
</td>
<td style="text-align:right;">
0.0735413
</td>
<td style="text-align:right;">
176
</td>
<td style="text-align:right;">
-0.0168754
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
44
</td>
<td style="text-align:right;">
0.0519294
</td>
<td style="text-align:right;">
221
</td>
<td style="text-align:right;">
-0.0084975
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
18
</td>
<td style="text-align:right;">
0.0355406
</td>
<td style="text-align:right;">
173
</td>
<td style="text-align:right;">
-0.0179535
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
187
</td>
<td style="text-align:right;">
0.1125892
</td>
<td style="text-align:right;">
168
</td>
<td style="text-align:right;">
-0.0194455
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
225
</td>
<td style="text-align:right;">
0.1356737
</td>
<td style="text-align:right;">
210
</td>
<td style="text-align:right;">
-0.0101393
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
99
</td>
<td style="text-align:right;">
0.0748049
</td>
<td style="text-align:right;">
59
</td>
<td style="text-align:right;">
-0.0602203
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
74
</td>
<td style="text-align:right;">
0.0643491
</td>
<td style="text-align:right;">
251
</td>
<td style="text-align:right;">
-0.0007408
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
104
</td>
<td style="text-align:right;">
0.0757457
</td>
<td style="text-align:right;">
175
</td>
<td style="text-align:right;">
-0.0171641
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
72
</td>
<td style="text-align:right;">
0.0634330
</td>
<td style="text-align:right;">
185
</td>
<td style="text-align:right;">
-0.0151792
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
93
</td>
<td style="text-align:right;">
0.0733782
</td>
<td style="text-align:right;">
281
</td>
<td style="text-align:right;">
0.0049825
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
73
</td>
<td style="text-align:right;">
0.0636805
</td>
<td style="text-align:right;">
58
</td>
<td style="text-align:right;">
-0.0642498
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
27
</td>
<td style="text-align:right;">
0.0433549
</td>
<td style="text-align:right;">
155
</td>
<td style="text-align:right;">
-0.0204603
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
78
</td>
<td style="text-align:right;">
0.0693847
</td>
<td style="text-align:right;">
304
</td>
<td style="text-align:right;">
0.0130467
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
200
</td>
<td style="text-align:right;">
0.1206862
</td>
<td style="text-align:right;">
131
</td>
<td style="text-align:right;">
-0.0258613
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
167
</td>
<td style="text-align:right;">
0.1043284
</td>
<td style="text-align:right;">
223
</td>
<td style="text-align:right;">
-0.0084335
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
28
</td>
<td style="text-align:right;">
0.0446876
</td>
<td style="text-align:right;">
230
</td>
<td style="text-align:right;">
-0.0064406
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
115
</td>
<td style="text-align:right;">
0.0800632
</td>
<td style="text-align:right;">
119
</td>
<td style="text-align:right;">
-0.0304713
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
117
</td>
<td style="text-align:right;">
0.0805053
</td>
<td style="text-align:right;">
132
</td>
<td style="text-align:right;">
-0.0255880
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
199
</td>
<td style="text-align:right;">
0.1205925
</td>
<td style="text-align:right;">
134
</td>
<td style="text-align:right;">
-0.0248474
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
222
</td>
<td style="text-align:right;">
0.1349360
</td>
<td style="text-align:right;">
339
</td>
<td style="text-align:right;">
0.0319003
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
137
</td>
<td style="text-align:right;">
0.0909874
</td>
<td style="text-align:right;">
253
</td>
<td style="text-align:right;">
-0.0005842
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
216
</td>
<td style="text-align:right;">
0.1309507
</td>
<td style="text-align:right;">
71
</td>
<td style="text-align:right;">
-0.0479583
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
263
</td>
<td style="text-align:right;">
0.1643878
</td>
<td style="text-align:right;">
129
</td>
<td style="text-align:right;">
-0.0261073
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
4
</td>
<td style="text-align:right;">
0.0234890
</td>
<td style="text-align:right;">
247
</td>
<td style="text-align:right;">
-0.0015776
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
337
</td>
<td style="text-align:right;">
0.3393064
</td>
<td style="text-align:right;">
295
</td>
<td style="text-align:right;">
0.0094498
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
31
</td>
<td style="text-align:right;">
0.0454329
</td>
<td style="text-align:right;">
186
</td>
<td style="text-align:right;">
-0.0147921
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
247
</td>
<td style="text-align:right;">
0.1534408
</td>
<td style="text-align:right;">
45
</td>
<td style="text-align:right;">
-0.0859926
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
81
</td>
<td style="text-align:right;">
0.0710097
</td>
<td style="text-align:right;">
73
</td>
<td style="text-align:right;">
-0.0469453
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
149
</td>
<td style="text-align:right;">
0.0949601
</td>
<td style="text-align:right;">
289
</td>
<td style="text-align:right;">
0.0083887
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
198
</td>
<td style="text-align:right;">
0.1202287
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
-0.0203394
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
255
</td>
<td style="text-align:right;">
0.1597002
</td>
<td style="text-align:right;">
291
</td>
<td style="text-align:right;">
0.0090632
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
268
</td>
<td style="text-align:right;">
0.1716377
</td>
<td style="text-align:right;">
303
</td>
<td style="text-align:right;">
0.0127909
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
182
</td>
<td style="text-align:right;">
0.1118605
</td>
<td style="text-align:right;">
313
</td>
<td style="text-align:right;">
0.0164764
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
156
</td>
<td style="text-align:right;">
0.0963746
</td>
<td style="text-align:right;">
167
</td>
<td style="text-align:right;">
-0.0196097
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
169
</td>
<td style="text-align:right;">
0.1066872
</td>
<td style="text-align:right;">
80
</td>
<td style="text-align:right;">
-0.0440145
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
46
</td>
<td style="text-align:right;">
0.0524722
</td>
<td style="text-align:right;">
180
</td>
<td style="text-align:right;">
-0.0161882
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
84
</td>
<td style="text-align:right;">
0.0718195
</td>
<td style="text-align:right;">
149
</td>
<td style="text-align:right;">
-0.0216737
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
340
</td>
<td style="text-align:right;">
0.3517030
</td>
<td style="text-align:right;">
370
</td>
<td style="text-align:right;">
0.1131796
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
87
</td>
<td style="text-align:right;">
0.0719631
</td>
<td style="text-align:right;">
196
</td>
<td style="text-align:right;">
-0.0130017
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
88
</td>
<td style="text-align:right;">
0.0720736
</td>
<td style="text-align:right;">
161
</td>
<td style="text-align:right;">
-0.0202669
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
65
</td>
<td style="text-align:right;">
0.0594810
</td>
<td style="text-align:right;">
269
</td>
<td style="text-align:right;">
0.0027174
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
259
</td>
<td style="text-align:right;">
0.1623007
</td>
<td style="text-align:right;">
115
</td>
<td style="text-align:right;">
-0.0311286
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
90
</td>
<td style="text-align:right;">
0.0723615
</td>
<td style="text-align:right;">
294
</td>
<td style="text-align:right;">
0.0094175
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
5
</td>
<td style="text-align:right;">
0.0270488
</td>
<td style="text-align:right;">
275
</td>
<td style="text-align:right;">
0.0037524
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
60
</td>
<td style="text-align:right;">
0.0573691
</td>
<td style="text-align:right;">
146
</td>
<td style="text-align:right;">
-0.0223259
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
203
</td>
<td style="text-align:right;">
0.1221988
</td>
<td style="text-align:right;">
315
</td>
<td style="text-align:right;">
0.0165988
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
189
</td>
<td style="text-align:right;">
0.1137191
</td>
<td style="text-align:right;">
79
</td>
<td style="text-align:right;">
-0.0441245
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
51
</td>
<td style="text-align:right;">
0.0538592
</td>
<td style="text-align:right;">
83
</td>
<td style="text-align:right;">
-0.0436637
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
98
</td>
<td style="text-align:right;">
0.0743039
</td>
<td style="text-align:right;">
220
</td>
<td style="text-align:right;">
-0.0085267
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
134
</td>
<td style="text-align:right;">
0.0902993
</td>
<td style="text-align:right;">
174
</td>
<td style="text-align:right;">
-0.0176896
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
235
</td>
<td style="text-align:right;">
0.1406147
</td>
<td style="text-align:right;">
130
</td>
<td style="text-align:right;">
-0.0260398
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
26
</td>
<td style="text-align:right;">
0.0432207
</td>
<td style="text-align:right;">
86
</td>
<td style="text-align:right;">
-0.0416771
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
122
</td>
<td style="text-align:right;">
0.0838426
</td>
<td style="text-align:right;">
308
</td>
<td style="text-align:right;">
0.0151689
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
58
</td>
<td style="text-align:right;">
0.0561087
</td>
<td style="text-align:right;">
255
</td>
<td style="text-align:right;">
-0.0002805
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
24
</td>
<td style="text-align:right;">
0.0423516
</td>
<td style="text-align:right;">
273
</td>
<td style="text-align:right;">
0.0033032
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
157
</td>
<td style="text-align:right;">
0.0968283
</td>
<td style="text-align:right;">
117
</td>
<td style="text-align:right;">
-0.0306696
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
123
</td>
<td style="text-align:right;">
0.0840160
</td>
<td style="text-align:right;">
162
</td>
<td style="text-align:right;">
-0.0202592
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
19
</td>
<td style="text-align:right;">
0.0358537
</td>
<td style="text-align:right;">
203
</td>
<td style="text-align:right;">
-0.0115053
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
240
</td>
<td style="text-align:right;">
0.1471057
</td>
<td style="text-align:right;">
127
</td>
<td style="text-align:right;">
-0.0266873
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
95
</td>
<td style="text-align:right;">
0.0736840
</td>
<td style="text-align:right;">
192
</td>
<td style="text-align:right;">
-0.0139881
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
295
</td>
<td style="text-align:right;">
0.2006091
</td>
<td style="text-align:right;">
156
</td>
<td style="text-align:right;">
-0.0204484
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
307
</td>
<td style="text-align:right;">
0.2225542
</td>
<td style="text-align:right;">
31
</td>
<td style="text-align:right;">
-0.1072476
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
369
</td>
<td style="text-align:right;">
0.5715283
</td>
<td style="text-align:right;">
373
</td>
<td style="text-align:right;">
0.1492523
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
321
</td>
<td style="text-align:right;">
0.2542412
</td>
<td style="text-align:right;">
322
</td>
<td style="text-align:right;">
0.0192947
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
318
</td>
<td style="text-align:right;">
0.2536230
</td>
<td style="text-align:right;">
323
</td>
<td style="text-align:right;">
0.0195565
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
292
</td>
<td style="text-align:right;">
0.1942827
</td>
<td style="text-align:right;">
324
</td>
<td style="text-align:right;">
0.0195715
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
180
</td>
<td style="text-align:right;">
0.1113353
</td>
<td style="text-align:right;">
201
</td>
<td style="text-align:right;">
-0.0118083
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
266
</td>
<td style="text-align:right;">
0.1707595
</td>
<td style="text-align:right;">
326
</td>
<td style="text-align:right;">
0.0214792
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
106
</td>
<td style="text-align:right;">
0.0768589
</td>
<td style="text-align:right;">
208
</td>
<td style="text-align:right;">
-0.0103065
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
138
</td>
<td style="text-align:right;">
0.0912354
</td>
<td style="text-align:right;">
55
</td>
<td style="text-align:right;">
-0.0657817
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
236
</td>
<td style="text-align:right;">
0.1411335
</td>
<td style="text-align:right;">
340
</td>
<td style="text-align:right;">
0.0333588
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
194
</td>
<td style="text-align:right;">
0.1173014
</td>
<td style="text-align:right;">
114
</td>
<td style="text-align:right;">
-0.0311403
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
100
</td>
<td style="text-align:right;">
0.0750240
</td>
<td style="text-align:right;">
287
</td>
<td style="text-align:right;">
0.0076413
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
232
</td>
<td style="text-align:right;">
0.1382854
</td>
<td style="text-align:right;">
159
</td>
<td style="text-align:right;">
-0.0203789
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
191
</td>
<td style="text-align:right;">
0.1141947
</td>
<td style="text-align:right;">
184
</td>
<td style="text-align:right;">
-0.0154901
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
37
</td>
<td style="text-align:right;">
0.0489930
</td>
<td style="text-align:right;">
66
</td>
<td style="text-align:right;">
-0.0553901
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
176
</td>
<td style="text-align:right;">
0.1089739
</td>
<td style="text-align:right;">
164
</td>
<td style="text-align:right;">
-0.0201235
</td>
</tr>
</tbody>
</table>
``` r
  # scroll_box(width = "100%", height = "500px")
```
