Initial Factfinding Memo
========================

Purpose of This Memo
--------------------

To understand:

1.  What datasets are available to us for this project
2.  The limitations of the datasets
3.  The meaning of the fields in the available data sets

Summary
-------

We have available databases of homeless beds grouped by project and
regional oversight body, as well as PDF reports grouped at the state and
national level. The HMIS program collects data about individuals (race,
ethnicity, gender, SSN, etc.), but that may not be available online due
to privacy issues (needs confirmation).

I still have a number of basic questions about the data that need to be
answered, listed below. Noteably, I am still uncertain which data
accounts for beds in use, beds available and individual people
experiencing homelessness.

The data and associated reports make use of a large number of acronyms.
I have collected some of the more commonly-used from various sources at
the end of this document.

### Limitations of the data:

-   Any census of people without homes will have a margin of error due
    to the difficulty of counting people without permenant residences.
    \[UNCONFIRMED\]
-   While there are overarching systems and rules in place to
    standardize data collection, data is collected by local agencies
    which may differ in their thoroughness and reliability.
    \[UNCONFIRMED\]
-   While data about people using shelters is collected every year, data
    about people living without shelter is only collected every two
    years.
-   *INCOMPLETE* What are the other limitations?

### Need to find out:

*Please mark \[DONE\] and incorporate into the above summary as each
item is understood.*

-   Which data accounts for “beds in use”, “beds available” and people
    experiencing homelessness?
-   What is the margin of error / expected number of people not counted
    for data collected about people without addresses?
-   How much does data collection (thoroughness or reliability) vary by
    local agency / CoC?
-   Is the un-aggregated, person-by-person data available (with
    personally-identifying information redacted)?
-   Is there a data dictionary specific to
    *2007-2018-HIC-Counts-by-CoC.xlsx*?
-   What is a “hard to serve individual” as mentioned in AHAR (see
    Available Data Dictionaries and Reports
    [below](https://github.com/shardsofblue/homelessness-project-fall2019/blob/master/documentation/memos/initial-factfinding-memo.md#existing-reports))
    in reference to Safe Havens (see Bed/Housing unit types
    [below](https://github.com/shardsofblue/homelessness-project-fall2019/blob/master/documentation/memos/initial-factfinding-memo.md#bedhousing-unit-types))?
-   Permanent Housing is split between Permanent Supportive Housing
    (requires disability) and Other Permanent Housing (does not require
    disability). In the data sets, is PH inclusive of both, or
    representative of one or the other?
-   *Please add to this list as more is discovered that we need to find
    out.*

Available Data and Sources
--------------------------

### Datasets

-   **2007-2018-HIC-Counts-by-CoC.xlsx**
    -   a spreadsheet of homeless bed counts aggregated by region, split
        into sheets by year
    -   [local
        copy](../data/input-data/2007-2018-HIC-Counts-by-CoC.xlsx)
    -   [data
        source](https://www.hudexchange.info/resource/3031/pit-and-hic-data-since-2007/)
-   **2018-Housing-Inventory-Count-Raw-File.xlsx**
    -   a spreadsheet of homeless bed counts less aggregated than the
        above. Appears to be aggregated by project, but with one other
        splitting factor I do not yet understand (see Anchorage CoC:
        Project ID: 101127, which has two entries, one each tagged
        Invetory Type C and N)
    -   [local
        copy](../data/input-data/2018-Housing-Inventory-Count-Raw-File.xlsx)
    -   [data
        source](https://www.hudexchange.info/resource/3031/pit-and-hic-data-since-2007/)

### Other useful websites and organizations:

-   [National Alliance to End Homelessness, an
    NGO](https://endhomelessness.org/)

Available Data Dictionaries and Reports
---------------------------------------

### Data Dictionaries

-   **HDX Reporting main page**, (HDX MP)
    -   [local copy](../hdx-reporting-main-page.pdf)
    -   [source](https://www.hudexchange.info/programs/hdx/hdx-reporting/)
-   **Sheltered PIT Count and HMIS Data Element Crosswalk**
    -   [local copy](../PIT-Count-Methodology-Guide.pdf)
    -   [source](https://files.hudexchange.info/resources/documents/Sheltered-PIT-Count-and-HMIS-Data-Element-Crosswalk.pdf)
-   **HMIS Data Standards Data Dictionary**, (HMIS DSD), March 2018, v
    1.3
    -   [local copy](../HMIS-Data-Dictionary-2018.pdf)
    -   [source](https://files.hudexchange.info/resources/documents/HMIS-Data-Dictionary-2018.pdf)
-   Names and numbers of **state CoC groupings**
    -   [local
        copy](../fy-2018-continuums-of-care-names-and-numbers.pdf)
    -   [source](https://files.hudexchange.info/resources/documents/fy-2018-continuums-of-care-names-and-numbers.pdf)

### Existing Reports

-   **Aggregate counts of homelessness prepared by HMIS**
    -   PDF tables showing homelessness counts at the state and national
        level
    -   [source](https://www.hudexchange.info/programs/coc/coc-housing-inventory-count-reports/)
-   **The 2018 Annual Homeless Assessment Report (AHAR) to Congress**,
    Part 1, Dec. 2018
    -   Includes definitions and overviews of the state of homelessness
        across the U.S., organized by category of person (individuals,
        families, youth, veterans, chronically homeless), each one
        further grouped at the national, state and CoC level.
    -   [local copy](../2018-AHAR-Part-1.pdf)
    -   [source](https://files.hudexchange.info/resources/documents/2018-AHAR-Part-1.pdf)

### Glossary

All definitions are pulled from the above sources (acronyms defined
above) to serve as quick references for reporters working on this
project. This list is not exhaustive; for further definitions, see the
sources listed above.

-   **McKinney–Vento**: refers to the [Stewart B. McKinney Homeless
    Assistance
    Act](https://www.govtrack.us/congress/bills/100/hr558/text), a U.S.
    federal law enacted in 1987 that provides federal money for homeless
    shelter programs.

#### System-wide acronyms

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 78%" />
<col style="width: 5%" />
</colgroup>
<thead>
<tr class="header">
<th>Acronym</th>
<th>Full Term</th>
<th>Definition</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>CoC</td>
<td>Continuum of Care</td>
<td>“A Continuum of Care (CoC) is a regional or local planning body that coordinates housing and services funding for homeless families and individuals,” AHAR p. 2**</td>
</tr>
<tr class="even">
<td>ESG</td>
<td>Emergency Solution Grant</td>
<td></td>
</tr>
<tr class="odd">
<td>HDX</td>
<td>Homelessness Data Exchange</td>
<td></td>
</tr>
<tr class="even">
<td>HIC</td>
<td>Housing Inventory Count</td>
<td></td>
</tr>
<tr class="odd">
<td>HMIS</td>
<td>Homeless Management Information System</td>
<td>“the information system designated by a local Continuum of Care (CoC) to comply with the requirements of CoC Program interim rule 24 CFR 578. [It] is a locally-administered data system used to record and analyze client, service, and housing data for individuals and families who are homeless or at risk of homelessness. It is administered by the U.S. Department of Housing and Urban Development (HUD) through the Office of Special Needs Assistance Programs (SNAPS) as its comprehensive data response to its congressional mandate to report to Congress on national homelessness. It is also used by the other federal partners from the U.S. Department of Health and Human Services (HHS) and the U.S. Department of Veterans Affairs and their respective programs to measure project performance, report to congress, and participate in benchmarking of the national effort to end homelessness,” HDX MP.</td>
</tr>
<tr class="even">
<td>PATH</td>
<td>Projects for Assistance in Transition from Homelessness</td>
<td></td>
</tr>
<tr class="odd">
<td>PIT</td>
<td>Point-in-Time</td>
<td>count of homeless persons; <em>sheltered</em> is taken yearly, <em>unsheltered</em> is taken every other year</td>
</tr>
<tr class="even">
<td>RHY</td>
<td>Runaway Homeless Youth</td>
<td></td>
</tr>
</tbody>
</table>

#### Bed/Housing unit types

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 78%" />
<col style="width: 5%" />
</colgroup>
<thead>
<tr class="header">
<th>Acronym</th>
<th>Full Term</th>
<th>Definition</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>ES</td>
<td>Emegency Shelter</td>
<td>“a facility with the primary purpose of providing temporary shelter for homeless people,” AHAR p. 2.</td>
</tr>
<tr class="even">
<td>PH</td>
<td>Permanent Housing</td>
<td>Housing for formerly homeless people, split between Permanent Supportive Housing (requires disability) and Other Permanent Housing (does not require disability)</td>
</tr>
<tr class="odd">
<td>PSH</td>
<td>Permanent Supportive Housing</td>
<td>“a housing model designed to provide housing assistance (project- and tenant-based) and supportive services on a long-term basis to formerly homeless people. HUD’s Continuum of Care program, authorized by the McKinney-Vento Act, funds PSH and requires that the client have a disability for eligibility,” AHAR p. 2</td>
</tr>
<tr class="even">
<td></td>
<td>Other Permanent Housing</td>
<td>“is housing with or without services that is specifically for formerly homeless people but that does not require people to have a disability.” AHAR p. 2</td>
</tr>
<tr class="odd">
<td>SH</td>
<td>Safe Havens</td>
<td>“provide temporary shelter and services to hard-to-serve individuals,” AHAR p. 2. , “beds and units that satisfy HUD’s standards, as identified in the 2009 NOFA,” HMIS DSD.</td>
</tr>
<tr class="even">
<td></td>
<td>Rapid Re-Housing</td>
<td>“a housing model designed to provide temporary housing assistance to people experiencing homelessness, moving them quickly out of homelessness and into permanent housing,” AHAR p. 2</td>
</tr>
<tr class="odd">
<td>TH</td>
<td>Transitional Housing</td>
<td>“provide people experiencing homelessness a place to stay combined with supportive services for up to 24 months,” AHAR p. 2.</td>
</tr>
</tbody>
</table>

\*\*The definition HMIS provides is: “\[A *state or region grouping*\]
organized to carry out the responsibilities required under the CoC
Program Interim Rule (24 CFR Part 578) and comprises representatives of
organizations, including nonprofit homeless providers, victim service
providers, faith-based organizations, governments, businesses,
advocates, public housing agencies, school districts, social service
providers, mental health agencies, hospitals, universities, affordable
housing developers, and law enforcement, and organizations that serve
homeless and formerly homeless persons to the extent that these groups
are represented within the geographic area and are available to
participate. … CoC *Program* refers to the federal funding source which
provides housing and/or service grant dollars.”
