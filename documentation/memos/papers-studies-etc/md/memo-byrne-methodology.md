Memo - Byrne Methodology Paper
==============================

-   Paper name: “NEW PERSPECTIVES ON COMMUNITY-LEVEL DETERMINANTS OF
    HOMELESSNESS”, JOURNAL OF URBAN AFFAIRS I Vol. 35/No. 5/2013
-   [Source](https://github.com/shardsofblue/homelessness-project-fall2019/blob/master/documentation/byrne-methodology-paper.pdf)
-   Organization: U.S. Department of Veterans Affairs, et. al.
-   Authors:
    -   THOMAS BYRNE and ELLEN A. MUNLEY, U.S. Department of Veterans
        Affairs, National Center on Homelessness Among Veterans;
        University of Pennsylvania,
        <a href="mailto:tbyrne@bu.edu" class="email">tbyrne@bu.edu</a>
    -   JAMISON D. FARGO, U.S. Department of Veterans Affairs, National
        Center on Homelessness Among Veterans; Utah State University
    -   ANN E. MONTGOMERY and DENNIS P. CULHANE, U.S. Department of
        Veterans Affairs, National Center on Homelessness Among
        Veterans; University of Pennsylvania

Introduction
------------

-   “According to the most recent estimates, on any given night in the
    United States, there are roughly 645,000 persons residing in
    homeless shelters or in unsheltered street locations. Over the
    course of a year, approximately 1.6 million persons, or **about 1 in
    every 195 Americans** — and 1 in every 25 persons living below the
    poverty threshold — experience homelessness (U.S. Department of
    Housing and Urban Development, 2011).” p. 607
-   This was the first analysis of “community-level determinants of
    homelessness that **includes metropolitan and non-metropolitan
    communities**,” p. 608
-   **Ways of conceptualizing homelessness:**
    -   In the 1990s, many studies focused on **individual-level**
        causes, such as traumatic childhods, mental illness, substance
        abuse, massive disruptions to health and income, etc.
    -   **Structural models** consider “macro-level trends” such as
        “decreases in the availability of affordable housing, labor
        market conditions, cutbacks in safety net spending, prevalence
        of disabilities, and demographic factors,” p. 608

Findings in Other Studies
-------------------------

-   “At least one **housing market** factor, including rent levels and
    rental vacancy rates, regulation on housing construction, or
    presence of rent control, was associated with homelessness rates in
    each of the reviewed studies.” p. 609
-   “**poverty and unemployment** rates … have been found in numerous
    studies to be positively associated with the rate of homelessness,”
    p. 609
-   The relationship between **demographics** and homelessness is
    unclear due to inconsistent results. Cross-sectional studies at the
    *individual* level show the following, but when considering the
    *community* level, “specific demographic measures have not been
    consistently shown to be significant across studies,” p. 612
    -   “African Americans have been consistently shown to be
        overrepresented in the homeless population,” p. 612
    -   “the proportion of female-headed households with young children
        is positively associated with homelessness,” p. 612
    -   “the concentration of single-person households in a community
        may be an important determinant of homelessness,” p. 612
    -   “the latter half of the baby-boomer age cohort—born between 1946
        and 1964—make up a highly disproportionate share of the single
        adult homeless population,” p. 612
-   “studies have generally found that more extensive and more generous
    **social safety net** programs have a negative relationship with
    homelessness,” p. 612
-   Most studies have found a positive correlation between **temperate
    climates** and homelessness rates, p. 613
-   “**transience** as a possible determinant of homelessness, including
    the proportion of persons who have recently moved and the number of
    highways and railroads serving an area,” p. 613

The paper explains on p. 613 the challenges and **shortcomings inherent
in other available datasets**, which will be relevant if we decide to
use them.

The authors consider the **PIT counts conducted by HUD to be a vast
improvement on previous available data** because it utilizes
“computerized systems that must meet a set of standard criteria to
ensure accuracy in reporting (HUD, 2011). Enumeration of unsheltered
households also must meet HUD’s methodology standards (HUD, 2008). …
HUD’s ongoing and extensive technical support to communities has
resulted in marked improvement in the reliability of homeless counts
over the past several years (HUD, 2011).” p. 614

Methodology
-----------

The study conducted by the others conducts parallel analyses for
metropolitan and non-metropolitan communities, making this one of the
few available that **examines both city and rural homelessness**. p. 614

“While 54 mainly rural counties are not part of a CoC, **more than 99%
of the United States population lived within the boundaries of a CoC**
in 2009.” p. 615

**Rates of homelessness** were computed by: “We use the HUD PIT
estimates to construct two measures of the rate of homelessness, which
parallel those used by Lee and colleagues: (1) the number of homeless
adults per 10,000 adults in the general population, and (2) the number
of homeless adults per 10,000 adults in poverty.” p. 615

They conducted a two-level analysis, using CoCs as the first level and
state as the second. p. 617

### Constructing the CoC-to-County geography crosswalk

They used **Geographic Information System (GIS) software** to map CoCs
to corresponding counties. (That work is publically available on
[Byrne’s GitHub
repo](https://github.com/tomhbyrne/HUD-CoC-Geography-Crosswalk)).
"\[T\]here were three relationship types possible between county and CoC
boundaries:

1.  Boundary for a single CoC and a single county was identical;
2.  A single CoC may be comprised of an aggregation of two or more
    counties; and
3.  Multiple CoCs may fall within a single county." p. 615

“To complete the matches, we superimposed county centroids (i.e., points
representing the geographic center of counties) on a map of CoC
boundaries. Approximately **51% (N = 227) of CoCs matched directly to
one county while 38% (N = 171) of CoCs were comprised of multiple
counties.** The remaining 11% (N = 49) of CoCs fit the third type of
CoC-county relationship described earlier. In these cases, the multiple
CoCs that were fully encompassed by a single county were merged into a
single new CoC, with its boundaries being coterminous with the county.”
p. 617

Where multiple CoCs existed in a single county, they merged them
together, reducing **the number of CoCs from 447 to 414**.

“\[U\]sing the U.S. Department of Agriculture’s (USDA) Economic Research
Service definitions of rurality (USDA, 2003),” they then categorized the
CoCs as metropolitan or non-metropolitan. p. 617

Results
-------

"**Three primary points** can be drawn from the results of our study.

1.  *First*, our findings provide additional evidence that
    **homelessness has its roots in housing market dynamics**, and
    particularly in the difficulty in obtaining affordable housing.
2.  *Second*, both of our metropolitan area models find **the size of
    the baby-boomer cohort, the size of the Hispanic population, and the
    number of recently moved households to be positively associated with
    homelessness**.
3.  *Third*, and finally, our study points to the **great potential in
    using the newly available HUD PIT estimates of the homeless
    population** to build on prior research and arrive at a better
    understanding of the structural determinants of homelessness."
    p. 621 (numbered listing added)

Possible solutions
------------------

-   “Our findings on the importance of affordable housing stock for
    decreasing homelessness underscore the need for **policies that
    either increase the supply of affordable housing or provide
    additional safety net supports** to households to help them afford
    housing and decrease competition for a finite number of low-rent
    units.” p. 621
-   “\[A\]n **expansion of the Section 8** Housing Choice Voucher
    Program, which is the primary federal housing assistance program for
    low-income families, would be the most straightforward remedy to the
    affordable housing problems.” p. 621
-   “**overhauling the Section 8** program such that subsidies are
    targeted more directly to those individuals and jurisdictions at
    highest risk of or with the highest rates of homelessness,” p. 622
-   “a **tax credit to all low-income renters** similar to the existing
    Earned Income Tax Credit (EITC), an idea proposed by Landis and
    McClure (2010), would also go far in helping those at risk of
    homelessness maintain housing. It would also serve as an important
    counterbalance to the mortgage interest deduction, which almost
    exclusively benefits middle- and upper-income Americans.” p. 622
-   “The finding regarding the **baby-boomer age group** is consistent
    with evidence that baby boomers are highly overrepresented in the
    homeless population, and underscores the **need to develop targeted
    interventions** to address homelessness among members of this
    population.” p. 622
-   “The findings regarding Hispanic ethnicity and residential mobility
    suggest that **migration patterns may have a more important
    relationship with the rate of homelessness** than has been
    previously considered.” p. 622
-   “It is likely that community-level determinants of homelessness may
    operate differently for \[various\] **sub-populations** \[such as
    Veterans, families, people with serious mental illness, etc.\], and
    this should be investigated in future research.” pp. 622, 623
-   “\[T\]he dynamics operating at the macro level are important for
    understanding homelessness and that, correspondingly, **macro-level
    policy interventions are ultimately necessary** to prevent and end
    homelessness.” p. 623
