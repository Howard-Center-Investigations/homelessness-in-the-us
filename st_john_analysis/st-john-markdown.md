St Augustine st John
================

``` r
final_homeless <- read_rds("final_homeless.rds")
```

\#\#CAVEATS

  - Sean’s approach so far is once homeless, always homeless, hence we
    add people, who’ve we’ve listed homeless once to the homeless data
    even if during appartment time

  - Same approach goes to NA-s

  - 
\#\#MOST COMMON CHARGES

We use initial statute, as this is the charge which is present the most

``` r
by_initial_statute <- final_homeless %>% 
  select(full_name, case_id, initial_statute) %>%
  unique() %>% 
  group_by(initial_statute) %>% 
  count() %>% 
  datatable()
```

\#\#LAWS

TO DO

1)  check people with 2970 Cabbage Road adresses whether they’re
    homeless, trespassing charges might refer to that
2)  get a list of homeless centers, charity places, churches and join
    them against the addresses in the data – DONE

CAVEATS

1)  For now, we’ve left people in the homeless addresses subset who have
    police dep address, as most of who have been charged with the most
    common charge – drinking in public – have also been charged with
    tresspassing, what is more, a lot of the top charges among these
    people refer to homeless as
well,

### State laws that we associate with criminalizing homelessness

| State Law                                                                                                                                                                           | Unconstitutional? | Description                                                                                                                                                             |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [316.130](http://www.leg.state.fl.us/statutes/index.cfm?mode=View%20Statutes&SubMenu=1&App_mode=Display_Statute&Search_String=316.130&URL=0300-0399/0316/Sections/0316.130.html)    | ?                 | A pedestrian shall obey the instructions of any official traffic control device specifically applicable to the pedestrian unless otherwise directed by a police officer |
| [316.2045](http://www.leg.state.fl.us/statutes/index.cfm?mode=View%20Statutes&SubMenu=1&App_mode=Display_Statute&Search_String=316.2045&URL=0300-0399/0316/Sections/0316.2045.html) | Yes               | Obstruction of public streets, highways, and roads.                                                                                                                     |
| [810.08(2a)](http://www.leg.state.fl.us/statutes/index.cfm?App_mode=Display_Statute&URL=0800-0899/0810/Sections/0810.08.html)                                                       | ?                 | Misdemeanor trespass in structure or conveyance                                                                                                                         |
| [810.08(2b)](http://www.leg.state.fl.us/statutes/index.cfm?App_mode=Display_Statute&URL=0800-0899/0810/Sections/0810.08.html)                                                       | ?                 | Misdemeanor trespass in occupied structure                                                                                                                              |
| [810.09(2a)](http://www.leg.state.fl.us/statutes/index.cfm?App_mode=Display_Statute&URL=0800-0899/0810/Sections/0810.09.html)                                                       | ?                 | Misdemeanor trespass on property other than structure or conveyance                                                                                                     |
| [810.09(2b)](http://www.leg.state.fl.us/statutes/index.cfm?App_mode=Display_Statute&URL=0800-0899/0810/Sections/0810.09.html)                                                       | ?                 | Misdemeanor trespass on curtilage (i.e. a yard or shed or some other structure near a building)                                                                         |
| [810.09(2d)](http://www.leg.state.fl.us/statutes/index.cfm?App_mode=Display_Statute&URL=0800-0899/0810/Sections/0810.09.html)                                                       | ?                 | Third degree felony trespass on a construction site of a certain size                                                                                                   |
| [810.097](http://www.leg.state.fl.us/statutes/index.cfm?App_mode=Display_Statute&URL=0800-0899/0810/Sections/0810.09.html)                                                          | ?                 | Tresspass from school property                                                                                                                                          |
| [856.011](http://www.leg.state.fl.us/statutes/index.cfm?App_mode=Display_Statute&URL=0800-0899/0856/Sections/0856.011.html)                                                         | ?                 | Disorderly intoxication                                                                                                                                                 |

### St Augustine City laws that we associate with criminalizing homelessness

| City Law                                                                                                                                           | Unconstitutional? | Description                                           |
| -------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- | ----------------------------------------------------- |
| [4-5](https://library.municode.com/fl/st._augustine/codes/code_of_ordinances?nodeId=PTIICOOR_CH4ALBE_S4-5DRPU)                                     | ?                 | Public drinking                                       |
| [13-4](https://library.municode.com/fl/st._augustine/codes/code_of_ordinances?nodeId=PTIICOOR_CH13TE_ARTICORI-W_S13-4REPLMACOFAPURI-W)             | ?                 | Sleeping in public                                    |
| [18-8](https://library.municode.com/fl/st._augustine/codes/code_of_ordinances?nodeId=PTIICOOR_CH18MIPROF)                                          | ?                 | Panhandling                                           |
| [22-12](https://library.municode.com/fl/st._augustine/codes/code_of_ordinances?nodeId=PTIICOOR_CH22STSIPAMIPUPL_ARTIINGE_S22-12SLCAHALEHUWAPUPLPR) | ?                 | Sleep/camp/habitation or leave human waste public     |
| [18-56](https://library.municode.com/fl/st._augustine/codes/code_of_ordinances?nodeId=PTIICOOR_CH18MIPROF_ARTIIIOFINPUPEOR_S18-56WIOBPUWAPA)       | ?                 | Wilful obstruction of public ways/passages            |
| [24-14](https://library.municode.com/fl/st._augustine/codes/code_of_ordinances?nodeId=PTIICOOR_CH24TR_ARTIINGE_S24-14PRSASOTRLA)                   | ?                 | Prohibiting sales and solicitations in traffic lanes. |
| \[99-50\]                                                                                                                                          | ?                 | Drinking in public                                    |
| \[91-11 \]                                                                                                                                         | ?                 | Drinking in public                                    |

### St John County Ordinances that we associate with criminalizing homelessness

County Law | Unconstitutional? | Description
[2007-19,3.04](https://stjohnsclerk.com/minrec/OrdinanceBooks/2007/ORD2007-19.pdf)
| ? | Over-night camping porhibited

\#watch disordelry conduct separately
